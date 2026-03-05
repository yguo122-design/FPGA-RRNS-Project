`timescale 1ns / 1ps

module test_controller (
    input wire clk,
    input wire rst_n,         
    output reg led_pass,      
    output reg led_fail,      
    output wire uart_tx_pin,      
    input wire uart_rx_pin        
); 

    // ------------------------------------------------------------------
    // 1. 清理未使用信号 (避免 ASSIGN-6 警告)
    // 暂时注释掉内部信号，因为我们下面不实例化模块了
    // ------------------------------------------------------------------
    /*
    reg tx_start;          
    reg [7:0] tx_data;     
    wire tx_busy;           
    wire [7:0] rx_byte;
    wire rx_valid;
    */

    // ------------------------------------------------------------------
    // 2. LED 心跳
    // ------------------------------------------------------------------
    reg [25:0] blink_cnt;       
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blink_cnt <= 0;
            led_pass <= 0;
        end else begin
            blink_cnt <= blink_cnt + 1;
            led_pass <= blink_cnt[25]; 
        end
    end
    
    // ------------------------------------------------------------------
    // 3. [核心测试] 物理链路验证
    // 直接将 uart_rx_pin 引脚电平映射到 led_fail
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            led_fail <= 0;
        else 
            led_fail <= uart_rx_pin; 
    end

    // ------------------------------------------------------------------
    // 4. TX 保持空闲
    // ------------------------------------------------------------------
    assign uart_tx_pin = 1'b1; 

    // ------------------------------------------------------------------
    // 5. [注释掉] 模块实例化
    // 当前只测物理链路，不需要协议解析，避免 ASSIGN-6 警告和逻辑干扰
    // 等 LD5 能随按键闪烁后，再取消注释进行下一步
    // ------------------------------------------------------------------
    /*
    uart_rx u_uart_rx_inst (
        .clk(clk), .rst_n(rst_n), .uart_rx_pin(uart_rx_pin),
        .rx_data(rx_byte), .rx_valid(rx_valid)
    );

    uart_tx u_uart_tx_inst (
        .clk(clk), .rst_n(rst_n), .uart_tx_pin(uart_tx_pin),
        .tx_data(tx_data), .tx_start(tx_start), .tx_busy(tx_busy)
    );
    */

endmodule