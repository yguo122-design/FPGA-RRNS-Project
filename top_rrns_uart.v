`timescale 1ns / 1ps
module top_rrns_uart(
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

    wire rst_n = ~btn[0];
    wire [7:0] rx_data;
    wire rx_valid;
    wire tx_busy;

    reg [7:0] tx_data;
    reg tx_start;
    reg data_received_flag;
    reg [27:0] led_timer;
    reg [27:0] div_cnt;
    reg slow_clk;

    uart_rx u_rx (
        .clk(clk),
        .rst_n(rst_n),
        .uart_rx_pin(uart_rx_pin),
        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

    uart_tx u_tx (
        .clk(clk),
        .rst_n(rst_n),
        .uart_tx_pin(uart_tx_pin),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_busy(tx_busy)
    );

    // 控制逻辑：接收回显 + LED
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            tx_start <= 0;
            tx_data <= 0;
            data_received_flag <= 0;
            led_timer <= 0;
        end else begin
            tx_start <= rx_valid; // 单周期脉冲
            if(rx_valid) begin
                tx_data <= rx_data;
                data_received_flag <= 1;
                led_timer <= 50_000_000; // LED 亮 0.5 秒
            end

            if(led_timer > 0) led_timer <= led_timer - 1;
            if(led_timer == 0) data_received_flag <= 0;
        end
    end

    // 心跳 LED
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            div_cnt <= 0; slow_clk <= 0;
        end else begin
            div_cnt <= div_cnt + 1;
            if(div_cnt == 50_000_000) begin
                div_cnt <= 0; slow_clk <= ~slow_clk;
            end
        end
    end

    // LED 输出
    assign led[0] = slow_clk;
    assign led[1] = rx_valid;
    assign led[2] = 0;
    assign led[3] = 0;

    assign led0_r = 0;
    assign led0_g = data_received_flag;
    assign led0_b = !data_received_flag;

    assign led1_r = 0; assign led1_g = 0; assign led1_b = 0;
    assign led2_r = 0; assign led2_g = 0; assign led2_b = 0;
    assign led3_r = 0; assign led3_g = 0; assign led3_b = 0;

endmodule