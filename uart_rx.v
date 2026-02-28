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

    localparam integer CNT_INT  = CLK_FREQ / BAUD_RATE;  // 10416
    localparam integer CNT_FRAC = CLK_FREQ % BAUD_RATE;  // 6400 (余数用于微调)

    // 同步输入
    reg rx_d1, rx_d2;
    always @(posedge clk or negedge rst_n)
        if(!rst_n) {rx_d2, rx_d1} <= 2'b11;
        else {rx_d2, rx_d1} <= {uart_rx_pin, rx_d2};
    
    wire rx_sync = rx_d2;

    // 状态机
    reg state_idle, state_recv;
    reg [3:0] bit_idx;      // 0:起始位检查, 1-8:数据位, 9:结束
    reg [15:0] cnt;
    reg [31:0] frac_acc;
    reg [7:0] data_buf;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state_idle <= 1;
            state_recv <= 0;
            cnt <= 0;
            frac_acc <= 0;
            bit_idx <= 0;
            data_buf <= 0;
            rx_data <= 0;
            rx_valid <= 0;
        end else begin
            rx_valid <= 0;

            if(state_idle) begin
                // 检测下降沿 (起始位开始)
                if(!rx_sync && rx_d1) begin 
                    state_idle <= 0;
                    state_recv <= 1;
                    cnt <= 0;
                    frac_acc <= 0;
                    bit_idx <= 0;
                    data_buf <= 0;
                end
            end else if(state_recv) begin
                // 处理分数累加 (波特率发生器微调)
                if(cnt == CNT_INT) begin
                    cnt <= 0;
                    if(frac_acc + CNT_FRAC >= BAUD_RATE) begin
                        cnt <= 1; // 借位，多计一个周期
                        frac_acc <= frac_acc + CNT_FRAC - BAUD_RATE;
                    end else begin
                        frac_acc <= frac_acc + CNT_FRAC;
                    end
                end else begin
                    cnt <= cnt + 1;
                end

                // 采样逻辑
                // 目标采样点：1.5T (D0), 2.5T (D1), ..., 8.5T (D7)
                // bit_idx=0: 0T -> 1T (起始位时段)
                // bit_idx=1: 1T -> 2T (D0 时段，应在 1.5T 采样)
                
                if(cnt == (CNT_INT >> 1)) begin 
                    // 每个位周期的中间点 (0.5T, 1.5T, 2.5T...)
                    
                    if(bit_idx == 0) begin
                        // 0.5T 时刻：验证起始位是否为 0
                        if(rx_sync !== 1'b0) begin
                            state_idle <= 1; // 错误帧，复位
                            state_recv <= 0;
                        end
                        // 继续计数，等待进入数据位
                    end 
                    else if(bit_idx >= 1 && bit_idx <= 8) begin
                        // 1.5T ~ 8.5T 时刻：采样数据位 D0 ~ D7
                        data_buf[bit_idx - 1] <= rx_sync; 
                        bit_idx <= bit_idx + 1;
                    end 
                    else if(bit_idx == 9) begin
                        // 9.5T 时刻：停止位 (可选验证)，直接结束
                        rx_data <= data_buf;
                        rx_valid <= 1;
                        state_idle <= 1;
                        state_recv <= 0;
                    end
                end
                
                // 状态推进：当计数器走完一个完整周期 (考虑借位后)
                if(cnt == CNT_INT || cnt == CNT_INT + 1) begin
                     if(bit_idx == 0) bit_idx <= 1; // 起始位检查完毕，准备进数据位
                     // 其他情况在上面的半周期点已经推进了 bit_idx
                end
            end
        end
    end
endmodule