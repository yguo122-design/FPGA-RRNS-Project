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
    localparam CNT_MAX = 10416; // 10415 (1T - 1)
    localparam CNT_MID = CNT_MAX / 2;              // 5207 (0.5T)

    // 1. 三级同步器 (消除亚稳态)
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

    // 2. 接收状态机
    reg [3:0] bit_idx;      // 0: 起始位, 1-8: 数据位 (对应 D0-D7), 9: 停止位
    reg [15:0] cnt;
    reg [7:0] data_buf;
    reg state_idle, state_recv;

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

                // --- 核心逻辑：在每位中心 (CNT_MID 相对偏移) 采样 ---
                
                // 情况 A: 起始位处理 (bit_idx == 0)
                if (bit_idx == 0) begin
                    if (cnt == CNT_MID) begin
                        // 0.5T 时刻：验证起始位是否仍为低 (抗噪)
                        if (rx_d2 != 1'b0) begin
                            state_idle <= 1; state_recv <= 0; // 噪声，退出
                        end
                    end else if (cnt == CNT_MAX + CNT_MID) begin
                        // 1.5T 时刻：起始位验证通过。
                        // 注意：这里不采样数据，只是准备进入数据位阶段。
                        // 为了对齐后续逻辑，我们在这里直接切换到 bit_idx=1，并清零计数器？
                        // 不，为了逻辑统一，我们让 bit_idx=1 代表 "准备采 D0"。
                        // 当 cnt 到达 1.5T 时，我们其实已经错过了 "从 0 开始计 1.5T" 的机会。
                        
                        // 【修正策略】：
                        // 在 1.5T 时刻，直接采样 D0！然后清零计数器，bit_idx 变为 2 (代表下次采 D1)。
                        data_buf[0] <= rx_d2; // 采样 D0
                        bit_idx <= 1;         // 标记已采 1 位
                        cnt <= 0;             // 清零，准备计下一个 1T
                    end
                end 
                // 情况 B: 数据位处理 (bit_idx 1-7, 代表已采位数，下一次采 bit_idx)
                else if (bit_idx >= 1 && bit_idx <= 7) begin
                    if (cnt == CNT_MAX) begin
                        // 计数器从 0 计到 CNT_MAX (历时 1T)
                        // 此时距离上一次采样正好过了 1T。
                        // 上次采的是 D(bit_idx-1)，这次采 D(bit_idx)
                        // 例如：bit_idx=1, 上次采 D0 (1.5T), 现在计满 1T (2.5T), 采 D1
                        data_buf[bit_idx] <= rx_d2;
                        bit_idx <= bit_idx + 1;
                        cnt <= 0;
                    end
                end
                // 情况 C: 最后一个数据位 D7 处理 (bit_idx == 8, 意味着已采 8 位？不，逻辑需微调)
                // 让我们简化索引定义：
                // bit_idx = 0: 起始位
                // bit_idx = 1: 刚采完 D0, 等待采 D1
                // ...
                // bit_idx = 8: 刚采完 D7, 等待验停止位
                
                // 上面的逻辑有点绕，重新梳理一个更清晰的索引流：
                // bit_idx: 0(Start), 1(D0), 2(D1)... 8(D7), 9(Stop)
                // 当 bit_idx=N 时，目标是采样第 N 位的数据 (对于 N>=1)
            end
        end
    end
    
    // ---------------------------------------------------------
    // 【重写】更清晰的状态机逻辑，确保 1.5T, 2.5T... 采样
    // ---------------------------------------------------------
    /* 
       逻辑流：
       1. Idle -> 检测到下降沿 -> bit_idx=0, cnt=0
       2. bit_idx=0 (起始位):
          - cnt==CNT_MID (0.5T): 验低电平。
          - cnt==CNT_MAX+CNT_MID (1.5T): 采样 D0, bit_idx=1, cnt=0.
       3. bit_idx=1..7 (数据位 D1..D7):
          - cnt==CNT_MAX (1T): 采样 D(bit_idx), bit_idx++, cnt=0.
          (注意：当 bit_idx=1 时，计满 1T 即 2.5T，采 D1。正确。)
       4. bit_idx=8 (刚采完 D7? 不，上面的逻辑只采到了 D7 吗？)
          - 当 bit_idx=7 时，采 D7。然后 bit_idx 变为 8。
       5. bit_idx=8 (停止位前奏):
          - cnt==CNT_MAX (1T): 此时是 9.5T。验高电平。成功则输出。
    */
   
   // 上面注释里的逻辑有个小漏洞：bit_idx=1 时采的是 D1，那 D0 呢？
   // 在步骤 2 里已经采了 D0。
   // 所以：
   // bit_idx=1 表示 "已采 D0，下次采 D1"。
   // ...
   // bit_idx=7 表示 "已采 D6，下次采 D7"。
   // 当 bit_idx=7 且计满 1T -> 采 D7，bit_idx 变为 8。
   // 当 bit_idx=8 且计满 1T -> 验停止位。
   
   // 完美。只需修改 always 块内部逻辑。
   
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_idle <= 1'b1; state_recv <= 1'b0;
            bit_idx <= 0; cnt <= 0; data_buf <= 0;
            rx_data <= 0; rx_valid <= 0;
        end else begin
            rx_valid <= 0;
            if (state_idle) begin
                if (rx_neg_edge) begin
                    state_idle <= 0; state_recv <= 1;
                    cnt <= 0; bit_idx <= 0;
                end
            end else if (state_recv) begin
                cnt <= cnt + 1;
                
                case (bit_idx)
                    0: begin // 处理起始位
                        if (cnt == CNT_MID) begin
                            if (rx_d2 != 1'b0) begin state_idle <= 1; state_recv <= 0; end
                        end else if (cnt == CNT_MAX + CNT_MID) begin
                            // 1.5T: 采样 D0
                            data_buf[0] <= rx_d2;
                            bit_idx <= 1;
                            cnt <= 0;
                        end
                    end
                    1,2,3,4,5,6,7: begin // 处理 D1 - D7
                        if (cnt == CNT_MAX) begin
                            data_buf[bit_idx] <= rx_d2; // 采 D1...D7
                            bit_idx <= bit_idx + 1;
                            cnt <= 0;
                        end
                    end
                    8: begin // 处理停止位 (此时已采完 D0-D7)
                        if (cnt == CNT_MAX) begin
                            // 9.5T: 验停止位
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