`timescale 1ns / 1ps

module uart_rx(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       uart_rx_pin,  
    output reg [7:0]  rx_data,      
    output reg        rx_valid      
);

    parameter CLK_FREQ  = 100_000_000;
    parameter BAUD_RATE = 9600;
    //localparam CNT_MAX = 520;  // 适配 5MHz 时钟 @ 9600bps
    localparam CNT_MAX = 10416; //匹配100MHz
    localparam CNT_MID = CNT_MAX / 2; 

    // 1. 三级同步器
    reg rx_d1, rx_d2, rx_d3;
    wire rx_neg_edge;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_d1 <= 1'b1; rx_d2 <= 1'b1; rx_d3 <= 1'b1;
        end else begin
            rx_d1 <= uart_rx_pin;
            rx_d2 <= rx_d1;
            rx_d3 <= rx_d2;
        end
    end
    assign rx_neg_edge = rx_d3 & ~rx_d2;

    // 2. 内部寄存器定义 (不再赋初值，由 always 块统一控制)
    reg [3:0] bit_idx;      
    reg [15:0] cnt;
    reg [7:0] data_buf;
    reg state_idle, state_recv;

    // 3. 【核心修复】单 Always 块逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_idle <= 1'b1;
            state_recv <= 1'b0;
            bit_idx <= 0;
            cnt <= 0;
            data_buf <= 0;
            rx_data <= 0;
            rx_valid <= 0;
        end else begin
            rx_valid <= 0; // 默认拉低

            if (state_idle) begin
                if (rx_neg_edge) begin
                    state_idle <= 0;
                    state_recv <= 1;
                    cnt <= 0;
                    bit_idx <= 0;
                end
            end else if (state_recv) begin
                cnt <= cnt + 1;
                
                case (bit_idx)
                    0: begin // 起始位
                        if (cnt == CNT_MID) begin
                            if (rx_d2 != 1'b0) begin state_idle <= 1; state_recv <= 0; end
                        end else if (cnt == CNT_MAX + CNT_MID) begin
                            data_buf[0] <= rx_d2;
                            bit_idx <= 1;
                            cnt <= 0;
                        end
                    end
                    1,2,3,4,5,6,7: begin // 数据位 D1-D7
                        if (cnt == CNT_MAX) begin
                            data_buf[bit_idx] <= rx_d2;
                            bit_idx <= bit_idx + 1;
                            cnt <= 0;
                        end
                    end
                    8: begin // 停止位
                        if (cnt == CNT_MAX) begin
                            if (rx_d2 == 1'b1) begin
                                rx_data <= data_buf;
                                rx_valid <= 1'b1;
                            end
                            state_idle <= 1;
                            state_recv <= 0;
                            cnt <= 0;
                        end
                    end
                endcase
            end
        end
    end
endmodule