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
    // 100,000,000 / 9600 = 10416.66 -> 取 10416 或 10417 均可，误差极小
    localparam CNT_MAX = 10416; //适配100MHz
    // localparam CNT_MAX = 520;  // 适配 5MHz 时钟 @ 9600bps

    reg [15:0] cnt;
    reg [3:0] bit_idx; // 0-7: 数据位，8: 停止位
    reg [7:0] data_buf;
    
    // 状态定义
    reg state_idle, state_send;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            uart_tx_pin <= 1'b1;      // 空闲态为高
            cnt <= 0; 
            bit_idx <= 0; 
            data_buf <= 0;
            tx_busy <= 0;
            state_idle <= 1'b1; 
            state_send <= 1'b0;
        end else begin
            if(state_idle) begin
                uart_tx_pin <= 1'b1;
                tx_busy <= 0;
                if(tx_start) begin
                    state_idle <= 1'b0; 
                    state_send <= 1'b1;
                    data_buf <= tx_data;
                    bit_idx <= 0;
                    cnt <= 0;
                    uart_tx_pin <= 1'b0; // 起始位 (低电平)
                    tx_busy <= 1'b1;     // 拉高忙信号
                end
            end else if(state_send) begin
                // 在 uart_tx.v 的 state_send 状态中
                if(cnt == CNT_MAX) begin
                    cnt <= 0;
                    if(bit_idx < 8) begin
                        uart_tx_pin <= data_buf[bit_idx]; 
                        bit_idx <= bit_idx + 1;
                    end else if(bit_idx == 8) begin 
                        // 【关键】必须显式处理停止位，并停留一个完整周期
                        uart_tx_pin <= 1'b1; 
                        bit_idx <= bit_idx + 1; // 变为 9
                    end else begin 
                        // bit_idx == 9, 彻底结束
                        state_idle <= 1; 
                        state_send <= 0;
                        tx_busy <= 0; 
                    end
                end else begin
                    cnt <= cnt + 1;
                end
            end
        end
    end
endmodule