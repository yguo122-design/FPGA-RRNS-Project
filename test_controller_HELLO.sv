// 该程序只集成进去了uart_tx并持续发送HELLO，验证uart_tx发送功能正常
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

    // 其他内部信号 (保留原有定义，为了后续恢复方便)
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
    // 2. LED 闪烁计数器信号 (用于证明时钟在跑)
    // ------------------------------------------------------------------
    reg [25:0] blink_cnt;       

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) blink_cnt <= 0;
        else blink_cnt <= blink_cnt + 1;
    end
    
    // 让 LED 闪烁，证明 FPGA 活着
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) led_pass <= 0;
        else led_pass <= blink_cnt[25]; 
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) led_fail <= 0;
        else led_fail <= 0; 
    end

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
    // 4. 简化版状态机 (仅用于保持信号不悬空)
    // ------------------------------------------------------------------
    assign encoder_done = 1'b0;
    assign decoder_valid = 1'b0;
    assign decoder_out = 20'd0;
    
    // ------------------------------------------------------------------
    // 5. [最终修复] 无限循环发送 "HELLO\r\n" 逻辑
    // 修复点 1: 增加 \r (回车) 解决对角线问题
    // 修复点 2: 三段式状态机解决竞争冒险，确保字符不丢失
    // ------------------------------------------------------------------
    reg [2:0] tx_index;       // 索引: 0='H' ... 4='O', 5='\r', 6='\n' (共 7 个字符)
    reg [7:0] tx_char;        // 当前要发的字符
    
    // 发送控制状态机: 0=IDLE, 1=WAIT_ACK, 2=WAIT_DONE
    reg [1:0] tx_state;       

    // 组合逻辑：根据索引选择字符 (包含 \r\n)
    always @(*) begin
        case (tx_index)
            0: tx_char = 8'd72;  // 'H'
            1: tx_char = 8'd69;  // 'E'
            2: tx_char = 8'd76;  // 'L'
            3: tx_char = 8'd76;  // 'L'
            4: tx_char = 8'd79;  // 'O'
            5: tx_char = 8'd13;  // '\r' (Carriage Return, 回车) <--- 新增
            6: tx_char = 8'd10;  // '\n' (Line Feed, 换行)
            default: tx_char = 8'd0;
        endcase
    end

    // 时序逻辑：发送控制状态机 (三段式握手)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_index <= 0;
            uart_tx_start <= 0;
            uart_tx_data <= 0;
            tx_state <= 2'd0; // IDLE
        end else begin
            uart_tx_start <= 0; // 默认拉低启动脉冲
            
            case (tx_state)
                2'd0: begin // IDLE: 等待 UART 空闲
                    if (!uart_tx_busy) begin
                        uart_tx_data <= tx_char; // 准备数据
                        uart_tx_start <= 1'b1;   // 发出启动脉冲
                        tx_state <= 2'd1;        // 进入 WAIT_ACK
                    end
                end
                
                2'd1: begin // WAIT_ACK: 等待 tx_busy 变高 (确认模块已锁存)
                    // 一旦检测到 busy 变高，说明发送器已经开始工作
                    if (uart_tx_busy) begin
                        uart_tx_start <= 1'b0; // 撤销启动脉冲
                        tx_state <= 2'd2;      // 进入 WAIT_DONE
                    end
                end
                
                2'd2: begin // WAIT_DONE: 等待 tx_busy 变低 (发送完成)
                    // 只有当 busy 变低，说明一个完整的字符 (含停止位) 发完了
                    if (!uart_tx_busy) begin
                        // 递增索引
                        if (tx_index >= 3'd6) // 注意这里改成了 6 (因为现在有 7 个字符 0-6)
                            tx_index <= 0;
                        else 
                            tx_index <= tx_index + 1;
                        
                        tx_state <= 2'd0; // 回到 IDLE，准备发下一个
                    end
                end
                
                default: tx_state <= 2'd0;
            endcase
        end
    end

    // ------------------------------------------------------------------
    // 6. [注释掉] 原有的复杂业务逻辑
    // ------------------------------------------------------------------
    /* 
    // 原有的状态机定义...
    // 原有的 Encoder/Decoder 实例化...
    // 原有的复杂 UART 状态机...
    */

endmodule