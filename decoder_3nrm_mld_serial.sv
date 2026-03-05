`timescale 1ns / 1ps

module decoder_3nrm_mld_serial (
    input wire clk,
    input wire rst_n,          
    input wire start,           // 启动信号
    input wire [63:0] residues_in, 
    
    output reg [15:0] data_out,   
    output reg valid,
    output reg uncorrectable      
);

    // ------------------------------------------------------------------
    // 1. 参数与余数提取 (保持不变)
    // ------------------------------------------------------------------
    localparam logic [6:0] MODS [0:8] = '{7'd64, 7'd63, 7'd65, 7'd31, 7'd29, 7'd23, 7'd19, 7'd17, 7'd11};
    
    wire [6:0] r [0:8];
    assign r[0] = {1'b0, residues_in[63:58]};
    assign r[1] = {1'b0, residues_in[57:52]};
    assign r[2] =        residues_in[51:45];
    assign r[3] = {2'b0, residues_in[44:40]};
    assign r[4] = {2'b0, residues_in[39:35]};
    assign r[5] = {2'b0, residues_in[34:30]};
    assign r[6] = {2'b0, residues_in[29:25]};
    assign r[7] = {2'b0, residues_in[24:20]};
    assign r[8] = {3'b0, residues_in[19:16]};

    // ------------------------------------------------------------------
    // 2. 组合索引生成器 (FSM 控制)
    // ------------------------------------------------------------------
    // C(9,3) = 84. 我们需要一个计数器 idx (0-83)
    // 并在每个周期解码出对应的三个下标 (i, j, k)
    
    reg [6:0] idx; // 0 to 83
    reg [2:0] i_idx, j_idx, k_idx; // 解码后的下标 0-8
    reg calc_done; // 单次计算完成标志
    
    // 组合查找表 (将 0-83 映射到 i,j,k)
    // 为了节省资源，我们用组合逻辑实时解码，而不是存 ROM
    function automatic void decode_comb(input [6:0] val, output reg [2:0] a, output reg [2:0] b, output reg [2:0] c);
        integer count, x, y, z;
        begin
            count = 0;
            for(x=0; x<7; x=x+1)
                for(y=x+1; y<8; y=y+1)
                    for(z=y+1; z<9; z=z+1) begin
                        if (count == val) begin
                            a = x; b = y; c = z;
                            return;
                        end
                        count = count + 1;
                    end
            a=0; b=1; c=2; // Default
        end
    endfunction

    // ------------------------------------------------------------------
    // 3. 单通道 MRC 计算单元 (复用)
    // ------------------------------------------------------------------
    wire [6:0] m1 = MODS[i_idx];
    wire [6:0] m2 = MODS[j_idx];
    wire [6:0] m3 = MODS[k_idx];
    wire [6:0] r1 = r[i_idx];
    wire [6:0] r2 = r[j_idx];
    wire [6:0] r3 = r[k_idx];
    
    wire [17:0] current_x;
    wire mrc_ready; // MRC 计算完成标志 (此处设为组合逻辑，1 周期完成)
    
    mrc_unit u_mrc_single (
        .r1(r1), .m1(m1),
        .r2(r2), .m2(m2),
        .r3(r3), .m3(m3),
        .x_out(current_x),
        .ready(mrc_ready)
    );

    // ------------------------------------------------------------------
    // 4. 距离计算单元 (复用)
    // ------------------------------------------------------------------
    wire [6:0] calc_r0 = current_x % MODS[0];
    wire [6:0] calc_r1 = current_x % MODS[1];
    wire [6:0] calc_r2 = current_x % MODS[2];
    wire [6:0] calc_r3 = current_x % MODS[3];
    wire [6:0] calc_r4 = current_x % MODS[4];
    wire [6:0] calc_r5 = current_x % MODS[5];
    wire [6:0] calc_r6 = current_x % MODS[6];
    wire [6:0] calc_r7 = current_x % MODS[7];
    wire [6:0] calc_r8 = current_x % MODS[8];
    
    wire [3:0] current_dist = 
        (calc_r0!=r[0]) + (calc_r1!=r[1]) + (calc_r2!=r[2]) +
        (calc_r3!=r[3]) + (calc_r4!=r[4]) + (calc_r5!=r[5]) +
        (calc_r6!=r[6]) + (calc_r7!=r[7]) + (calc_r8!=r[8]);

    // ------------------------------------------------------------------
    // 5. 主控制 FSM 与 最小值更新
    // ------------------------------------------------------------------
    reg [3:0] min_dist_reg;
    reg [17:0] best_val_reg;
    reg running;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            idx <= 0;
            running <= 0;
            min_dist_reg <= 4'd10;
            best_val_reg <= 0;
            valid <= 0;
            uncorrectable <= 0;
            data_out <= 0;
        end else begin
            valid <= 0;
            uncorrectable <= 0;
            
            if (start && !running) begin
                running <= 1;
                idx <= 0;
                min_dist_reg <= 4'd10;
                best_val_reg <= 0;
            end else if (running) begin
                // 1. 解码当前组合
                decode_comb(idx, i_idx, j_idx, k_idx);
                
                // 2. 计算 MRC 和 距离 (组合逻辑，当前周期即刻可用)
                // current_x 和 current_dist 在此处已更新
                
                // 3. 更新最小值
                if (current_dist < min_dist_reg) begin
                    min_dist_reg <= current_dist;
                    best_val_reg <= current_x;
                end
                
                // 4. 推进索引
                if (idx == 7'd83) begin
                    // 遍历结束
                    running <= 0;
                    // 输出判决
                    if (min_dist_reg <= 3 && best_val_reg < 18'd65536) begin
                        data_out <= best_val_reg[15:0];
                        valid <= 1;
                    end else begin
                        uncorrectable <= 1;
                        valid <= 1;
                        data_out <= 0;
                    end
                end else begin
                    idx <= idx + 1;
                end
            end
        end
    end

    // ------------------------------------------------------------------
    // 6. MRC 子模块 (单例)
    // ------------------------------------------------------------------
    module mrc_unit (
        input wire [6:0] r1, m1,
        input wire [6:0] r2, m2,
        input wire [6:0] r3, m3,
        output wire [17:0] x_out,
        output wire ready
    );
        wire [6:0] a1 = r1;
        wire [6:0] a2, a3;
        
        wire [6:0] inv_12 = get_mod_inv(m1, m2);
        wire [7:0] diff2 = (r2 >= a1) ? (r2 - a1) : (r2 + m2 - a1);
        assign a2 = (diff2 * inv_12) % m2;
        
        wire [6:0] inv_13 = get_mod_inv(m1, m3);
        wire [6:0] inv_23 = get_mod_inv(m2, m3);
        
        wire [8:0] diff3_raw = (r3 >= a1) ? (r3 - a1) : (r3 + m3 - a1);
        wire [14:0] term1 = diff3_raw * inv_13;
        wire [6:0] term1_mod = term1 % m3;
        
        wire [8:0] diff3_final = (term1_mod >= a2) ? (term1_mod - a2) : (term1_mod + m3 - a2);
        wire [14:0] term2 = diff3_final * inv_23;
        assign a3 = term2 % m3;
        
        assign x_out = a1 + (a2 * m1) + (a3 * m1 * m2);
        assign ready = 1'b1; // 组合逻辑，即时完成

        // --- 逆元查找表 (同上，省略具体 case 以节省篇幅，请填入之前的 Python 生成代码) ---
        function automatic [6:0] get_mod_inv(input [6:0] mx, input [6:0] my);
            begin
                case ({mx, my})
                    {7'd64, 7'd63}: return 7'd1; // 64^-1 mod 63
                    {7'd64, 7'd65}: return 7'd64; // 64^-1 mod 65
                    {7'd64, 7'd31}: return 7'd16; // 64^-1 mod 31
                    {7'd64, 7'd29}: return 7'd5; // 64^-1 mod 29
                    {7'd64, 7'd23}: return 7'd9; // 64^-1 mod 23
                    {7'd64, 7'd19}: return 7'd11; // 64^-1 mod 19
                    {7'd64, 7'd17}: return 7'd4; // 64^-1 mod 17
                    {7'd64, 7'd11}: return 7'd5; // 64^-1 mod 11
                    {7'd63, 7'd64}: return 7'd63; // 63^-1 mod 64
                    {7'd63, 7'd65}: return 7'd32; // 63^-1 mod 65
                    {7'd63, 7'd31}: return 7'd1; // 63^-1 mod 31
                    {7'd63, 7'd29}: return 7'd6; // 63^-1 mod 29
                    {7'd63, 7'd23}: return 7'd19; // 63^-1 mod 23
                    {7'd63, 7'd19}: return 7'd16; // 63^-1 mod 19
                    {7'd63, 7'd17}: return 7'd10; // 63^-1 mod 17
                    {7'd63, 7'd11}: return 7'd7; // 63^-1 mod 11
                    {7'd65, 7'd64}: return 7'd1; // 65^-1 mod 64
                    {7'd65, 7'd63}: return 7'd32; // 65^-1 mod 63
                    {7'd65, 7'd31}: return 7'd21; // 65^-1 mod 31
                    {7'd65, 7'd29}: return 7'd25; // 65^-1 mod 29
                    {7'd65, 7'd23}: return 7'd17; // 65^-1 mod 23
                    {7'd65, 7'd19}: return 7'd12; // 65^-1 mod 19
                    {7'd65, 7'd17}: return 7'd11; // 65^-1 mod 17
                    {7'd65, 7'd11}: return 7'd10; // 65^-1 mod 11
                    {7'd31, 7'd64}: return 7'd31; // 31^-1 mod 64
                    {7'd31, 7'd63}: return 7'd61; // 31^-1 mod 63
                    {7'd31, 7'd65}: return 7'd21; // 31^-1 mod 65
                    {7'd31, 7'd29}: return 7'd15; // 31^-1 mod 29
                    {7'd31, 7'd23}: return 7'd3; // 31^-1 mod 23
                    {7'd31, 7'd19}: return 7'd8; // 31^-1 mod 19
                    {7'd31, 7'd17}: return 7'd11; // 31^-1 mod 17
                    {7'd31, 7'd11}: return 7'd5; // 31^-1 mod 11
                    {7'd29, 7'd64}: return 7'd53; // 29^-1 mod 64
                    {7'd29, 7'd63}: return 7'd50; // 29^-1 mod 63
                    {7'd29, 7'd65}: return 7'd9; // 29^-1 mod 65
                    {7'd29, 7'd31}: return 7'd15; // 29^-1 mod 31
                    {7'd29, 7'd23}: return 7'd4; // 29^-1 mod 23
                    {7'd29, 7'd19}: return 7'd2; // 29^-1 mod 19
                    {7'd29, 7'd17}: return 7'd10; // 29^-1 mod 17
                    {7'd29, 7'd11}: return 7'd8; // 29^-1 mod 11
                    {7'd23, 7'd64}: return 7'd39; // 23^-1 mod 64
                    {7'd23, 7'd63}: return 7'd11; // 23^-1 mod 63
                    {7'd23, 7'd65}: return 7'd17; // 23^-1 mod 65
                    {7'd23, 7'd31}: return 7'd27; // 23^-1 mod 31
                    {7'd23, 7'd29}: return 7'd24; // 23^-1 mod 29
                    {7'd23, 7'd19}: return 7'd5; // 23^-1 mod 19
                    {7'd23, 7'd17}: return 7'd3; // 23^-1 mod 17
                    {7'd23, 7'd11}: return 7'd1; // 23^-1 mod 11
                    {7'd19, 7'd64}: return 7'd27; // 19^-1 mod 64
                    {7'd19, 7'd63}: return 7'd10; // 19^-1 mod 63
                    {7'd19, 7'd65}: return 7'd24; // 19^-1 mod 65
                    {7'd19, 7'd31}: return 7'd18; // 19^-1 mod 31
                    {7'd19, 7'd29}: return 7'd26; // 19^-1 mod 29
                    {7'd19, 7'd23}: return 7'd17; // 19^-1 mod 23
                    {7'd19, 7'd17}: return 7'd9; // 19^-1 mod 17
                    {7'd19, 7'd11}: return 7'd7; // 19^-1 mod 11
                    {7'd17, 7'd64}: return 7'd49; // 17^-1 mod 64
                    {7'd17, 7'd63}: return 7'd26; // 17^-1 mod 63
                    {7'd17, 7'd65}: return 7'd23; // 17^-1 mod 65
                    {7'd17, 7'd31}: return 7'd11; // 17^-1 mod 31
                    {7'd17, 7'd29}: return 7'd12; // 17^-1 mod 29
                    {7'd17, 7'd23}: return 7'd19; // 17^-1 mod 23
                    {7'd17, 7'd19}: return 7'd9; // 17^-1 mod 19
                    {7'd17, 7'd11}: return 7'd2; // 17^-1 mod 11
                    {7'd11, 7'd64}: return 7'd35; // 11^-1 mod 64
                    {7'd11, 7'd63}: return 7'd23; // 11^-1 mod 63
                    {7'd11, 7'd65}: return 7'd6; // 11^-1 mod 65
                    {7'd11, 7'd31}: return 7'd17; // 11^-1 mod 31
                    {7'd11, 7'd29}: return 7'd8; // 11^-1 mod 29
                    {7'd11, 7'd23}: return 7'd21; // 11^-1 mod 23
                    {7'd11, 7'd19}: return 7'd7; // 11^-1 mod 19
                    {7'd11, 7'd17}: return 7'd14; // 11^-1 mod 17
                    default: return 7'd1; // Should not happen
                endcase
            end
        endfunction
    endmodule

endmodule