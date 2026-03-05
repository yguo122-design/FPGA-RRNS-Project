`timescale 1ns / 1ps

module top_3nrm_loopback(
    input  wire       clk,
    input  wire [3:0] btn,
    output wire [3:0] led,
    output wire led0_r, led0_g, led0_b,
    output wire led1_r, led1_g, led1_b,
    output wire led2_r, led2_g, led2_b,
    output wire led3_r, led3_g, led3_b,
    output wire uart_tx_pin,
    input  wire uart_rx_pin
);

    // ------------------------------------------------------------------
    // 1. 系统信号定义
    // ------------------------------------------------------------------
    wire rst_n = ~btn[0]; // SW0 复位
    
    // UART 信号
    wire [7:0] rx_byte;
    wire rx_valid;
    wire tx_busy;
    reg [7:0] tx_data;
    reg tx_start;
    
    // 算法中间信号
    reg [15:0] parsed_number;       // 解析后的 0-65535 数字
    reg number_ready;               // 数字解析完成标志
    wire [63:0] encoder_out;        // Encoder 64-bit 输出
    wire encoder_done;
    reg [19:0] decoder_out;        // Decoder 20-bit 输出
    wire decoder_valid;
    wire decoder_uncorrectable;

    //控制指示灯心跳
    reg [27:0] div_cnt;
    reg slow_clk;

    // 【新增】用于十六进制发送的状态变量
    reg [1:0] hex_idx;       // 计数器 (0-3)
    // reg [15:0] send_val;     // 暂存要发送的数值

    // 内部状态机定义
    // 0: IDLE (接收字符)
    // 1: PROCESS (启动编解码)
    // 2: SEND_RESULT (发送解码结果)
    // 3: SEND_NEWLINE (发送换行符)
    reg [1:0] main_state;
    
    // ASCII 解析器信号
    reg [15:0] ascii_accumulator;   // 累加器
    reg [3:0] digit_count;          // 位数计数 (防止溢出)
    reg parsing_active;             // 正在解析标志

    // wire [15:0] current_val;
    reg [3:0] nibble;
    reg encoder_done_sync;      // 同步 encoder_done
    reg decoder_valid_sync;     // 同步 decoder_valid
    // ------------------------------------------------------------------
    // 2. 实例化子模块
    // ------------------------------------------------------------------
    
    // UART RX
    uart_rx u_rx (
        .clk(clk),
        .rst_n(rst_n),
        .uart_rx_pin(uart_rx_pin),
        .rx_data(rx_byte),
        .rx_valid(rx_valid)
    );

    // UART TX
    uart_tx u_tx (
        .clk(clk),
        .rst_n(rst_n),
        .uart_tx_pin(uart_tx_pin),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_busy(tx_busy)
    );

    // 3NRM Encoder
    encoder_3nrm u_encoder (
        .clk(clk),
        .rst_n(rst_n),
        .start(number_ready),      // 当数字解析完成后启动
        .data_in(parsed_number),
        .residues_out(encoder_out),
        .done(encoder_done)
    );


    
    wire [63:0] decoder_input_bus;
    
    // 适配 Encoder 输出到 Decoder 输入
    assign decoder_input_bus =  encoder_out;

    wire decoder_start_wire;
    assign decoder_start_wire = encoder_done; // 直接连线，0延迟

/* 先调试目的，把decoder注释掉
    decoder_3nrm_mld_final_v3 u_decoder (
        .clk(clk),
        .rst_n(rst_n),
        .start(decoder_start_wire), 
        .residues_in(decoder_input_bus),
        .data_out(decoder_out),
        .valid(decoder_valid),
        .uncorrectable(decoder_uncorrectable)
    );
*/ 

    // ------------------------------------------------------------------
    // 主逻辑进程
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            main_state <= 0;
            hex_idx <= 0;
            parsed_number <= 0;
            ascii_accumulator <= 0;
            parsing_active <= 0;
            digit_count <= 0;
            number_ready <= 0;
            tx_start <= 0;
            tx_data <= 0;
            encoder_done_sync <= 0;
            decoder_valid_sync <= 0;
        end else begin
            // --------------------------------------------------------------
            // 1. 同步握手信号 (防止跨时钟域或组合逻辑毛刺)
            // --------------------------------------------------------------
            encoder_done_sync <= encoder_done;
            decoder_valid_sync <= decoder_valid;

            // --------------------------------------------------------------
            // 2. 串口接收与解析逻辑 (State 0 的一部分，始终运行)
            // --------------------------------------------------------------
            if (rx_valid) begin
                if (rx_byte == 8'd13 || rx_byte == 8'd10) begin // 回车或换行
                    if (parsing_active) begin
                        // 解析完成，保存数据
                        parsed_number <= ascii_accumulator;
                        parsing_active <= 0;
                        // 注意：这里不清零 ascii_accumulator，等到发送彻底结束再清，防止干扰
                        
                        // 启动处理流程
                        main_state <= 1; 
                        number_ready <= 1; // 拉高启动 Encoder (电平信号)
                    end
                    // 如果没在解析中收到回车，忽略 (防抖)
                end else if (rx_byte >= 8'd48 && rx_byte <= 8'd57) begin // 数字 0-9
                    if (!parsing_active) begin
                        ascii_accumulator <= 0;
                        digit_count <= 0;
                    end
                    
                    if (digit_count < 5) begin // 限制最大5位，防止溢出
                        ascii_accumulator <= ascii_accumulator * 10 + (rx_byte - 8'd48);
                        digit_count <= digit_count + 1;
                        parsing_active <= 1;
                    end
                end else begin
                    // 其他字符，重置解析状态 (可选策略)
                    parsing_active <= 0;
                    ascii_accumulator <= 0;
                end
            end

            // --------------------------------------------------------------
            // 3. 状态机逻辑
            // --------------------------------------------------------------
            case (main_state)
                // State 0: IDLE (等待输入)
                0: begin
                    number_ready <= 0; // 确保启动信号拉低
                    tx_start <= 0;
                end

/*调试用途，暂时注释掉，更换为调试代码
                // State 1: PROCESS (等待 RNS 计算完成)
                1: begin
                    // 只要在做计算，number_ready 就保持高电平 (Fix: 持续启动信号)
                    number_ready <= 1; 

                    if (encoder_done_sync) begin
                        // Encoder 完成，启动 Decoder (假设 Decoder 是组合逻辑或立即响应)
                        // 如果 Decoder 也需要 start 信号，请在这里拉高
                    end

                    if (decoder_valid_sync) begin
                        // Decoder 数据准备好了，准备发送
                        main_state <= 2;
                        hex_idx <= 0;
                        number_ready <= 0; // 计算结束，拉低启动信号
                    end
                end
*/

                // State 1: PROCESS (修改为直通模式)
                1: begin
                    // 不再等待 encoder_done 和 decoder_valid
                    // 直接认为计算完成，且结果就是输入的值
                    main_state <= 2;
                    hex_idx <= 0;
                    number_ready <= 0;
                    
                    // 【核心调试】把解析到的数直接赋给 decoder_out
                    // 确保 decoder_out 是 reg 类型！
                //    decoder_out <= parsed_number; 
                decoder_out <= 16'h12C; // 强制赋值为 300 (0x12C)
                end

                // State 2: SEND_HEX (发送 4 位十六进制 + 换行)
                2: begin
                    if (!tx_busy && !tx_start) begin // UART 空闲且当前没有启动发送
                        tx_start <= 0; // 清除启动脉冲

                        if (hex_idx < 4) begin
                            // 【核心修复】直接操作 decoder_out，不经过 send_val 中间寄存器的时序陷阱

                            
                            
                            // 根据 idx 提取对应的 4 位
                            case (hex_idx)
                                0: nibble = decoder_out[15:12];
                                1: nibble = decoder_out[11:8];
                                2: nibble = decoder_out[7:4];
                                3: nibble = decoder_out[3:0];
                                default: nibble = 0;
                            endcase

                            // 转换为 ASCII
                            if (nibble < 10)
                                tx_data <= nibble + 8'd48;
                            else
                                tx_data <= nibble - 10 + 8'd65; // A-F

                            tx_start <= 1; // 启动发送
                            hex_idx <= hex_idx + 1;
                        end else if (hex_idx == 4) begin
                            // 发送换行符
                            tx_data <= 8'd10; // \n
                            tx_start <= 1;
                            hex_idx <= hex_idx + 1;
                        end else begin
                            // 发送完成 (hex_idx == 5)
                            // 【关键修复】彻底清零解析器，防止死循环和重复输出
                            main_state <= 0;
                            hex_idx <= 0;
                            ascii_accumulator <= 0;
                            digit_count <= 0;
                            parsing_active <= 0;
                            // parsed_number 可以保留用于调试，或者也清零
                        end
                    end
                end
                
                default: main_state <= 0;
            endcase
        end
    end

    // ------------------------------------------------------------------
    // 4. LED 指示
    // ------------------------------------------------------------------
    assign led[0] = parsing_active;       // 正在输入
    assign led[1] = (main_state == 1);    // 正在计算
    assign led[2] = (main_state == 2);    // 正在发送
    assign led[3] = decoder_uncorrectable;// 不可纠正错误
    
    // 心跳 LED， 5MHz下0.5s闪烁一次
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            div_cnt <= 0; slow_clk <= 0;
        end else begin
            div_cnt <= div_cnt + 1;
            if(div_cnt == 2_500_000) begin  
                div_cnt <= 0; slow_clk <= ~slow_clk;
            end
        end
    end

    // RGB LED 显示状态
    assign led0_g = (main_state == 0);
    assign led0_r = (main_state == 1);
    assign led0_b = (main_state == 2);
    
    assign led1_r = 0; assign led1_g = 0; assign led1_b = 0;
    assign led2_r = 0; assign led2_g = 0; assign led2_b = 0;
    assign led3_r = 0; assign led3_g = 0; assign led3_b = 0;

endmodule