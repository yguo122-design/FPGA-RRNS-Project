`timescale 1ns / 1ps

module uart_hex_printer (
    input wire clk,
    input wire rst_n,
    input wire send_req,          // 脉冲触发
    input wire is_error,          // 1=错误模式，0=成功模式
    input wire [15:0] err_in,     // 错误输入值
    input wire [19:0] err_out,    // 错误输出值
    output wire tx_pin
);

    parameter CLK_FREQ = 100_000_000;
    parameter BAUD_RATE = 115200;
    localparam TICKS_PER_BIT = (CLK_FREQ / BAUD_RATE) - 1;

    // 状态机定义
    typedef enum logic [3:0] {IDLE, GET_CHAR, SHIFT, STOP} state_t;
    state_t state;
    
    reg [9:0] tick_cnt;
    reg [3:0] bit_cnt;
    reg [7:0] tx_reg_data;
    reg tx_pin_reg;
    reg busy;
    
    assign tx_pin = tx_pin_reg;

    // 字符生成逻辑 (组合逻辑)
    // 我们定义一个序列：
    // Error: "ERR:In=0x", then 4 hex chars of err_in, then ",Out=0x", then 5 hex chars of err_out, then "\n"
    // Pass:  "PASS: 65536 OK.\n"
    
    reg [7:0] current_char;
    reg end_of_stream;
    reg [6:0] step_ptr; // 步骤指针

    always @(*) begin
        current_char = 8'h00;
        end_of_stream = 1'b0;
        
        if (is_error) begin
            case (step_ptr)
                0: current_char = "E";
                1: current_char = "R";
                2: current_char = "R";
                3: current_char = ":";
                4: current_char = "I";
                5: current_char = "n";
                6: current_char = "=";
                7: current_char = "0";
                8: current_char = "x";
                // 9-12: err_in[15:12] ... err_in[3:0]
                9:  current_char = hex_to_ascii(err_in[15:12]);
                10: current_char = hex_to_ascii(err_in[11:8]);
                11: current_char = hex_to_ascii(err_in[7:4]);
                12: current_char = hex_to_ascii(err_in[3:0]);
                13: current_char = ",";
                14: current_char = "O";
                15: current_char = "u";
                16: current_char = "t";
                17: current_char = "=";
                18: current_char = "0";
                19: current_char = "x";
                // 20-24: err_out[19:16] ... err_out[3:0]
                20: current_char = hex_to_ascii(err_out[19:16]);
                21: current_char = hex_to_ascii(err_out[15:12]);
                22: current_char = hex_to_ascii(err_out[11:8]);
                23: current_char = hex_to_ascii(err_out[7:4]);
                24: current_char = hex_to_ascii(err_out[3:0]);
                25: current_char = "\n";
                default: end_of_stream = 1'b1;
            endcase
        end else begin
            case (step_ptr)
                0: current_char = "P";
                1: current_char = "A";
                2: current_char = "S";
                3: current_char = "S";
                4: current_char = ":";
                5: current_char = " ";
                6: current_char = "6";
                7: current_char = "5";
                8: current_char = "5";
                9: current_char = "3";
                10: current_char = "6";
                11: current_char = " ";
                12: current_char = "O";
                13: current_char = "K";
                14: current_char = ".";
                15: current_char = "\n";
                default: end_of_stream = 1'b1;
            endcase
        end
    end

    // Hex 转 ASCII 函数
    function [7:0] hex_to_ascii;
        input [3:0] hex;
        begin
            if (hex < 10) hex_to_ascii = hex + 8"h30"; // '0'-'9'
            else          hex_to_ascii = hex + 8"h37"; // 'A'-'F'
        end
    endfunction

    // 时序逻辑
    reg [7:0] charLatch;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tx_pin_reg <= 1'b1;
            tick_cnt <= 10'd0;
            bit_cnt <= 4'd0;
            step_ptr <= 7'd0;
            busy <= 1'b0;
            charLatch <= 8'h00;
        end else if (send_req && state == IDLE) begin
            step_ptr <= 7'd0;
            state <= GET_CHAR;
            busy <= 1'b1;
        end else begin
            case (state)
                GET_CHAR: begin
                    charLatch <= current_char;
                    state <= SHIFT;
                    bit_cnt <= 4'd0;
                    tick_cnt <= 10'd0;
                    tx_pin_reg <= 1'b0; // Start Bit
                end
                SHIFT: begin
                    if (tick_cnt >= TICKS_PER_BIT) begin
                        tick_cnt <= 10'd0;
                        if (bit_cnt >= 4'd7) begin
                            state <= STOP;
                            tx_pin_reg <= 1'b1; // Stop Bit
                        end else begin
                            bit_cnt <= bit_cnt + 1'b1;
                            tx_pin_reg <= charLatch[bit_cnt];
                        end
                    end else begin
                        tick_cnt <= tick_cnt + 1'b1;
                    end
                end
                STOP: begin
                    if (tick_cnt >= TICKS_PER_BIT) begin
                        tick_cnt <= 10'd0;
                        step_ptr <= step_ptr + 1'b1;
                        if (end_of_stream) begin
                            state <= IDLE;
                            busy <= 1'b0;
                        end else begin
                            state <= GET_CHAR;
                        end
                    end else begin
                        tick_cnt <= tick_cnt + 1'b1;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule