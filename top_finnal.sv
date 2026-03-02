`timescale 1ns / 1ps

module top_final (
    input wire clk,
    input wire sw0,           // 用作 rst_n (注意逻辑反转)
    output wire led0,         // LD4 -> Fail (Red)
    output wire led1,         // LD5 -> Pass (Green)
    output wire uart_tx_pin
);

    // 信号定义
    wire rst_n_internal;
    wire uart_start;
    wire [7:0] uart_data;
    wire uart_busy;
    
    // 逻辑反转：Switch ON(1) = 正常工作，OFF(0) = 复位
    // 您的代码需要 rst_n (低电平复位)，所以 sw0=0 时 rst_n=0
    assign rst_n_internal = sw0; 

    // 实例化测试控制器
    test_controller u_ctrl (
        .clk(clk),
        .rst_n(rst_n_internal),
        .led_pass(led1),      // LD5 (Green)
        .led_fail(led0),      // LD4 (Red)
        .uart_tx_start(uart_start),
        .uart_tx_data(uart_data),
        .uart_tx_busy(uart_busy)
    );

    // 实例化已有的 UART 发送模块
    uart_tx u_uart (
        .clk(clk),
        .rst_n(rst_n_internal),
        .uart_tx_pin(uart_tx_pin),
        .tx_data(uart_data),
        .tx_start(uart_start),
        .tx_busy(uart_busy)
    );

endmodule