`timescale 1ns / 1ps

module test_controller (
    input wire clk,
    input wire rst_n,         
    output reg led_pass,      
    output reg led_fail,      
    output wire uart_tx,
    input wire uart_rx        
); 

    // ------------------------------------------------------------------
    // 1. 内部信号定义
    // ------------------------------------------------------------------
    // TX 信号
    reg uart_tx_start;          
    reg [7:0] uart_tx_data;     
    wire uart_tx_busy;          
    
    // RX 信号
    wire [7:0] rx_byte;
    wire rx_valid;

    // 其他内部信号 (预留用于后续算法集成)
    reg [15:0] current_input;
    wire [63:0] residues_bus; 
    wire encoder_done;
    reg decoder_start;
    wire [19:0] decoder_out;
    wire decoder_valid;

    // ------------------------------------------------------------------
    // 2. LED 闪烁计数器 (心跳指示)
    // ------------------------------------------------------------------
    reg [25:0] blink_cnt;       
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) blink_cnt <= 0;
        else blink_cnt <= blink_cnt + 1;
    end
    
    // LED Pass: 系统心跳 (闪烁) - 证明时钟和复位正常
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) led_pass <= 0;
        else led_pass <= blink_cnt[25]; 
    end
    
    // LED Fail: 
    // [诊断模式] 初始化为 0，将在下方逻辑中随 rx_valid 翻转
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) led_fail <= 0;
        // 具体逻辑在下方的主 always 块中控制
    end

    // ------------------------------------------------------------------
    // 3. 实例化 UART TX & RX
    // ------------------------------------------------------------------
    uart_tx u_uart_tx_inst (
        .clk(clk), 
        .rst_n(rst_n), 
        .uart_tx_pin(uart_tx),      
        .tx_data(uart_tx_data), 
        .tx_start(uart_tx_start),   
        .tx_busy(uart_tx_busy)
    );

    uart_rx u_uart_rx_inst (
        .clk(clk), 
        .rst_n(rst_n), 
        .uart_rx_pin(uart_rx),
        .rx_data(rx_byte), 
        .rx_valid(rx_valid)
    );

    // ------------------------------------------------------------------
    // 4. [诊断模式] 纯接收测试逻辑
    // ------------------------------------------------------------------
    // 策略：
    // 1. 强制关闭发送 (uart_tx_start = 0)，排除发送干扰。
    // 2. 只要 rx_valid 变高，led_fail 就翻转。
    // 现象预测：
    // - 如果敲键盘时 LD5 (led_fail) 快速闪烁/变化 -> RX 链路完美通畅。
    // - 如果敲键盘时 LD5 毫无反应 -> RX 链路断路 (约束错/波特率错/流控没关)。
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 复位时初始化
            uart_tx_start <= 0;
            uart_tx_data  <= 0;
            led_fail      <= 0;
        end else begin
            // [关键] 强制拉低发送启动信号，暂时不测试回显
            uart_tx_start <= 1'b0; 
            
            // [诊断核心] 监听 rx_valid
            if (rx_valid) begin
                led_fail <= ~led_fail; // 翻转 LED 状态
            end
            // 注意：这里没有清空 led_fail，让它保持翻转后的状态，直到下一次 rx_valid
        end
    end

    // ------------------------------------------------------------------
    // 5. [注释掉] 原有的 Echo 逻辑
    // 等诊断模式测试通过 (LD5 会闪) 后，再取消注释恢复此部分
    // ------------------------------------------------------------------
    /*
    reg [7:0] tx_fifo_data;     
    reg tx_fifo_has_data;       
    reg [1:0] send_state;       // 0:IDLE, 1:START_PULSE, 2:WAIT_BUSY_LOW
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            send_state <= 0;
            uart_tx_start <= 0;
            uart_tx_data <= 0;
            tx_fifo_has_data <= 0;
            tx_fifo_data <= 0;
            led_fail <= 0;
        end else begin
            uart_tx_start <= 0; 
            
            // --- 接收逻辑 ---
            if (rx_valid && !tx_fifo_has_data) begin
                tx_fifo_data <= rx_byte;
                tx_fifo_has_data <= 1'b1;
                led_fail <= 1'b1; 
            end
            
            // --- 发送逻辑 ---
            case (send_state)
                0: begin 
                    if (tx_fifo_has_data && !uart_tx_busy) begin
                        uart_tx_data <= tx_fifo_data;
                        uart_tx_start <= 1'b1;
                        send_state <= 1;
                    end
                end
                1: begin 
                    uart_tx_start <= 1'b1;
                    if (uart_tx_busy) begin
                        uart_tx_start <= 0;
                        send_state <= 2;
                    end
                end
                2: begin 
                    if (!uart_tx_busy) begin
                        tx_fifo_has_data <= 0; 
                        led_fail <= 0;         
                        send_state <= 0;
                    end
                end
                default: send_state <= 0;
            endcase
        end
    end
    */

endmodule