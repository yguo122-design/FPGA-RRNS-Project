`timescale 1ns / 1ps

module test_controller (
    input wire clk,
    input wire rst_n,         
    output reg led_pass,      
    output reg led_fail,      
    output wire uart_tx       
); 

    // ------------------------------------------------------------------
    // 1. 内部信号定义
    // ------------------------------------------------------------------
    reg uart_tx_start;          
    reg [7:0] uart_tx_data;     
    wire uart_tx_busy;          

    // 其他内部信号
    reg [15:0] current_input;
    wire [63:0] residues_bus; 
    wire encoder_done;
    
    reg decoder_start;
    wire [19:0] decoder_out;
    wire decoder_valid;
    wire decoder_uncorrectable;
    
    reg testing_done;
    reg error_found;
    reg [15:0] err_in_val;
    reg [19:0] err_out_val;

    // ------------------------------------------------------------------
    // [新增] 2. LED 闪烁计数器信号
    // ------------------------------------------------------------------
    reg [25:0] blink_cnt;       // 100MHz 下，2^25 ≈ 33M cycles ≈ 0.33秒翻转一次

    // ------------------------------------------------------------------
    // 3. 实例化 UART 发送模块
    // ------------------------------------------------------------------
    uart_tx u_uart_tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .uart_tx_pin(uart_tx),      
        .tx_data(uart_tx_data),     
        .tx_start(uart_tx_start),   
        .tx_busy(uart_tx_busy)      
    );

    // ------------------------------------------------------------------
    // 4. 状态机定义
    // ------------------------------------------------------------------
    typedef enum logic [2:0] {
        S_IDLE, 
        S_LAUNCH_ENC, 
        S_WAIT_ENC, 
        S_LAUNCH_DEC, 
        S_WAIT_DEC
    } state_t;
    
    state_t state, next_state;
    reg enc_start_pulse;

    // ------------------------------------------------------------------
    // 5. 实例化 Encoder & Decoder
    // ------------------------------------------------------------------
    encoder_3nrm u_enc_inst (
        .clk(clk), .rst_n(rst_n), .start(enc_start_pulse),
        .data_in(current_input), .residues_out(residues_bus), .done(encoder_done)
    );

    decoder_3nrm_mld u_dec_inst (
        .clk(clk), .rst_n(rst_n), .start(decoder_start),
        .residues_in(residues_bus), .data_out(decoder_out),
        .valid(decoder_valid), .uncorrectable(decoder_uncorrectable)
    );

    // ------------------------------------------------------------------
    // [新增/修改] 6. LED 闪烁逻辑 (独立于主业务逻辑)
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blink_cnt <= 0;
        end else begin
            blink_cnt <= blink_cnt + 1;
        end
    end

    // ------------------------------------------------------------------
    // 7. 主控制逻辑
    // ------------------------------------------------------------------
    always @(*) begin
        next_state = state;

        case (state)
            S_IDLE: if (!testing_done && !error_found) next_state = S_LAUNCH_ENC;
            S_LAUNCH_ENC: begin  next_state = S_WAIT_ENC; end
            S_WAIT_ENC: if (encoder_done) next_state = S_LAUNCH_DEC;
            S_LAUNCH_DEC: begin  next_state = S_WAIT_DEC; end
            S_WAIT_DEC: begin
                if (decoder_valid) begin
                    if (decoder_out != current_input) next_state = S_IDLE;
                    else if (current_input == 16'd65535) next_state = S_IDLE;
                    else next_state = S_LAUNCH_ENC;
                end else next_state = S_WAIT_DEC;
            end
            default: next_state = S_IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE; current_input <= 0; testing_done <= 0; error_found <= 0;
            // [修改] 初始化时让 led_pass 为 0，后续由闪烁逻辑或业务逻辑接管
            led_pass <= 0; led_fail <= 0; enc_start_pulse <= 0; decoder_start <= 0;
        end else begin
            state <= next_state;
            enc_start_pulse <= 0; decoder_start <= 0;
            if (next_state == S_LAUNCH_ENC) enc_start_pulse <= 1'b1;
            if (next_state == S_LAUNCH_DEC) decoder_start <= 1'b1;

            if (state == S_WAIT_DEC && decoder_valid) begin
                if (decoder_out != current_input) begin
                    error_found <= 1; testing_done <= 1;
                    err_in_val <= current_input; err_out_val <= decoder_out;
                    led_fail <= 1; 
                    // [修改] 如果出错，LED 常亮，不再闪烁
                    led_pass <= 0; 
                end else if (current_input == 65535) begin
                    testing_done <= 1; 
                    // [修改] 如果成功，LED 常亮，不再闪烁
                    led_pass <= 1; 
                    led_fail <= 0;
                end else begin
                    current_input <= current_input + 1;
                    // [修改] 测试进行中，让 led_pass 闪烁，证明时钟在跑
                    led_pass <= blink_cnt[25]; 
                    led_fail <= 0;
                end
            end else if (!testing_done && !error_found) begin
                // [新增] 在初始阶段 (S_IDLE 等) 也让灯闪烁，证明一上电就在跑
                led_pass <= blink_cnt[25];
                led_fail <= 0;
            end
            // 注意：如果 testing_done 或 error_found 为真，上面的 if-else 会锁定 LED 状态
        end
    end

    // ------------------------------------------------------------------
    // 8. UART 发送逻辑 (数值化修复版)
    // ------------------------------------------------------------------
    typedef enum logic [3:0] {U_IDLE, U_SEND, U_DONE} uart_state_t;
    uart_state_t u_state;
    reg [6:0] char_idx;
    reg [7:0] next_char;
    reg u_done_flag;

    // Hex 转 ASCII 函数 (使用纯数字运算)
    function [7:0] hex2ascii;
        input [3:0] h;
        begin
            if (h < 4'd10) 
                hex2ascii = h + 8'd48;      // '0' is 48
            else          
                hex2ascii = h + 8'd55;      // 'A' is 65 (55+10)
        end
    endfunction

    // 组合逻辑：生成字符 (全部使用数字常量)
    always @(*) begin
        next_char = 8'd0;
        u_done_flag = 1'b0;
        
        if (error_found) begin
            case (char_idx)
                0: next_char = 8'd69;  // 'E'
                1: next_char = 8'd82;  // 'R'
                2: next_char = 8'd82;  // 'R'
                3: next_char = 8'd58;  // ':'
                4: next_char = 8'd73;  // 'I'
                5: next_char = 8'd110; // 'n'
                6: next_char = 8'd61;  // '='
                7: next_char = 8'd48;  // '0'
                8: next_char = 8'd120; // 'x'
                9:  next_char = hex2ascii(err_in_val[15:12]);
                10: next_char = hex2ascii(err_in_val[11:8]);
                11: next_char = hex2ascii(err_in_val[7:4]);
                12: next_char = hex2ascii(err_in_val[3:0]);
                13: next_char = 8'd44; // ','
                14: next_char = 8'd79; // 'O'
                15: next_char = 8'd117;// 'u'
                16: next_char = 8'd116;// 't'
                17: next_char = 8'd61; // '='
                18: next_char = 8'd48; // '0'
                19: next_char = 8'd120;// 'x'
                20: next_char = hex2ascii(err_out_val[19:16]);
                21: next_char = hex2ascii(err_out_val[15:12]);
                22: next_char = hex2ascii(err_out_val[11:8]);
                23: next_char = hex2ascii(err_out_val[7:4]);
                24: next_char = hex2ascii(err_out_val[3:0]);
                25: next_char = 8'd10; // '\n'
                default: u_done_flag = 1'b1;
            endcase
        end else if (testing_done && !error_found) begin
            case (char_idx)
                0: next_char = 8'd80;  // 'P'
                1: next_char = 8'd65;  // 'A'
                2: next_char = 8'd83;  // 'S'
                3: next_char = 8'd83;  // 'S'
                4: next_char = 8'd58;  // ':'
                5: next_char = 8'd32;  // ' '
                6: next_char = 8'd54;  // '6'
                7: next_char = 8'd53;  // '5'
                8: next_char = 8'd53;  // '5'
                9: next_char = 8'd51;  // '3'
                10: next_char = 8'd54; // '6'
                11: next_char = 8'd32; // ' '
                12: next_char = 8'd79; // 'O'
                13: next_char = 8'd75; // 'K'
                14: next_char = 8'd46; // '.'
                15: next_char = 8'd10; // '\n'
                default: u_done_flag = 1'b1;
            endcase
        end else begin
            u_done_flag = 1'b1;
        end
    end

    // 时序逻辑：发送控制
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            u_state <= U_IDLE; char_idx <= 0; uart_tx_start <= 0; uart_tx_data <= 0;
        end else begin
            uart_tx_start <= 0;
            if (u_state == U_IDLE) begin
                if ((testing_done || error_found) && !u_done_flag) begin
                    u_state <= U_SEND; char_idx <= 0;
                end
            end else if (u_state == U_SEND) begin
                if (!uart_tx_busy) begin
                    uart_tx_data <= next_char;
                    uart_tx_start <= 1;
                    if (!u_done_flag) char_idx <= char_idx + 1;
                    else u_state <= U_DONE;
                end
            end
        end
    end

endmodule