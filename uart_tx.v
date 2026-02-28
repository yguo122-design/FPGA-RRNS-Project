`timescale 1ns / 1ps
module uart_tx(
    input  wire       clk,
    input  wire       rst_n,
    output reg        uart_tx_pin,
    input  wire [7:0] tx_data,
    input  wire       tx_start,
    output reg        tx_busy
);

    parameter CLK_FREQ  = 100_000_000;
    parameter BAUD_RATE = 9600;
    localparam CNT_MAX = CLK_FREQ / BAUD_RATE - 1;

    reg [15:0] cnt;
    reg [3:0] bit_idx;
    reg [7:0] data_buf;
    reg state_idle, state_send;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            uart_tx_pin <= 1'b1;
            cnt <= 0; bit_idx <= 0; data_buf <= 0;
            tx_busy <= 0;
            state_idle <= 1; state_send <= 0;
        end else begin
            if(state_idle) begin
                uart_tx_pin <= 1'b1;
                tx_busy <= 0;
                if(tx_start) begin
                    state_idle <= 0; state_send <= 1;
                    data_buf <= tx_data;
                    bit_idx <= 0;
                    cnt <= 0;
                    uart_tx_pin <= 0; // 起始位
                    tx_busy <= 1;
                end
            end else if(state_send) begin
                if(cnt == CNT_MAX) begin
                    cnt <= 0;
                    if(bit_idx < 8) begin
                        uart_tx_pin <= data_buf[bit_idx]; // 低位先发
                        bit_idx <= bit_idx + 1;
                    end else begin
                        uart_tx_pin <= 1'b1; // 停止位
                        state_idle <= 1; state_send <= 0;
                    end
                end else begin
                    cnt <= cnt + 1;
                end
            end
        end
    end
endmodule