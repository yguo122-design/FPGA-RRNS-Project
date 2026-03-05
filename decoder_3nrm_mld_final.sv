`timescale 1ns / 1ps

module decoder_3nrm_mld_final (
    input wire clk,
    input wire rst_n,          
    input wire start,           
    input wire [63:0] residues_in, 
    
    output reg [15:0] data_out,   
    output reg valid,
    output reg uncorrectable      
);

    // ------------------------------------------------------------------
    // 1. 参数定义与余数提取
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
    // 2. 84 个候选值生成 (Projection Cores)
    // ------------------------------------------------------------------
    wire [17:0] candidates [0:83];
    integer idx_map [0:83][0:2];
    integer count, a, b, c;
    
    initial begin
        count = 0;
        for(a=0; a<7; a=a+1)
            for(b=a+1; b<8; b=b+1)
                for(c=b+1; c<9; c=c+1) begin
                    idx_map[count][0] = a;
                    idx_map[count][1] = b;
                    idx_map[count][2] = c;
                    count = count + 1;
                end
    end

    genvar g;
    generate
        for(g=0; g<84; g=g+1) begin : core_gen
            wire [6:0] r_a = r[idx_map[g][0]];
            wire [6:0] r_b = r[idx_map[g][1]];
            wire [6:0] r_c = r[idx_map[g][2]];
            wire [6:0] m_a = MODS[idx_map[g][0]];
            wire [6:0] m_b = MODS[idx_map[g][1]];
            wire [6:0] m_c = MODS[idx_map[g][2]];
            
            mrc_unit u_mrc (
                .r1(r_a), .m1(m_a),
                .r2(r_b), .m2(m_b),
                .r3(r_c), .m3(m_c),
                .x_out(candidates[g])
            );
        end
    endgenerate

    // ------------------------------------------------------------------
    // 3. MRC 单元 (含 Python 生成的逆元表)
    // ------------------------------------------------------------------
    module mrc_unit (
        input wire [6:0] r1, m1,
        input wire [6:0] r2, m2,
        input wire [6:0] r3, m3,
        output wire [17:0] x_out
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

        // --- Python 生成的逆元表 ---
        function automatic [6:0] get_mod_inv(input [6:0] mx, input [6:0] my);
            begin
                case ({mx, my})
                    {7'd64, 7'd63}: return 7'd1;   {7'd64, 7'd65}: return 7'd64;
                    {7'd64, 7'd31}: return 7'd16;  {7'd64, 7'd29}: return 7'd5;
                    {7'd64, 7'd23}: return 7'd9;   {7'd64, 7'd19}: return 7'd11;
                    {7'd64, 7'd17}: return 7'd4;   {7'd64, 7'd11}: return 7'd5;
                    {7'd63, 7'd64}: return 7'd63;  {7'd63, 7'd65}: return 7'd32;
                    {7'd63, 7'd31}: return 7'd1;   {7'd63, 7'd29}: return 7'd6;
                    {7'd63, 7'd23}: return 7'd19;  {7'd63, 7'd19}: return 7'd16;
                    {7'd63, 7'd17}: return 7'd10;  {7'd63, 7'd11}: return 7'd7;
                    {7'd65, 7'd64}: return 7'd1;   {7'd65, 7'd63}: return 7'd32;
                    {7'd65, 7'd31}: return 7'd21;  {7'd65, 7'd29}: return 7'd25;
                    {7'd65, 7'd23}: return 7'd17;  {7'd65, 7'd19}: return 7'd12;
                    {7'd65, 7'd17}: return 7'd11;  {7'd65, 7'd11}: return 7'd10;
                    {7'd31, 7'd64}: return 7'd39;  {7'd31, 7'd63}: return 7'd47;
                    {7'd31, 7'd65}: return 7'd44;  {7'd31, 7'd29}: return 7'd15;
                    {7'd31, 7'd23}: return 7'd3;   {7'd31, 7'd19}: return 7'd8;
                    {7'd31, 7'd17}: return 7'd11;  {7'd31, 7'd11}: return 7'd5;
                    {7'd29, 7'd64}: return 7'd55;  {7'd29, 7'd63}: return 7'd58;
                    {7'd29, 7'd65}: return 7'd56;  {7'd29, 7'd31}: return 7'd15;
                    {7'd29, 7'd23}: return 7'd4;   {7'd29, 7'd19}: return 7'd2;
                    {7'd29, 7'd17}: return 7'd10;  {7'd29, 7'd11}: return 7'd8;
                    {7'd23, 7'd64}: return 7'd47;  {7'd23, 7'd63}: return 7'd44;
                    {7'd23, 7'd65}: return 7'd47;  {7'd23, 7'd31}: return 7'd27;
                    {7'd23, 7'd29}: return 7'd24;  {7'd23, 7'd19}: return 7'd5;
                    {7'd23, 7'd17}: return 7'd3;   {7'd23, 7'd11}: return 7'd1;
                    {7'd19, 7'd64}: return 7'd51;  {7'd19, 7'd63}: return 7'd10;
                    {7'd19, 7'd65}: return 7'd51;  {7'd19, 7'd31}: return 7'd18;
                    {7'd19, 7'd29}: return 7'd26;  {7'd19, 7'd23}: return 7'd17;
                    {7'd19, 7'd17}: return 7'd9;   {7'd19, 7'd11}: return 7'd7;
                    {7'd17, 7'd64}: return 7'd49;  {7'd17, 7'd63}: return 7'd26;
                    {7'd17, 7'd65}: return 7'd38;  {7'd17, 7'd31}: return 7'd11;
                    {7'd17, 7'd29}: return 7'd12;  {7'd17, 7'd23}: return 7'd19;
                    {7'd17, 7'd19}: return 7'd9;   {7'd17, 7'd11}: return 7'd2;
                    {7'd11, 7'd64}: return 7'd35;  {7'd11, 7'd63}: return 7'd23;
                    {7'd11, 7'd65}: return 7'd6;   {7'd11, 7'd31}: return 7'd17;
                    {7'd11, 7'd29}: return 7'd8;   {7'd11, 7'd23}: return 7'd21;
                    {7'd11, 7'd19}: return 7'd7;   {7'd11, 7'd17}: return 7'd14;
                    default: return 7'd1;
                endcase
            end
        endfunction
    endmodule

    // ------------------------------------------------------------------
    // 4. MLD 度量计算 (Hamming Distance)
    // ------------------------------------------------------------------
    wire [3:0] distances [0:83];
    
    genvar h;
    generate
        for(h=0; h<84; h=h+1) begin : metric_gen
            wire [6:0] calc_r [0:8];
            wire [3:0] dist_sum;
            
            // 重计算 9 个余数 (Gemini 建议的关键步骤)
            assign calc_r[0] = candidates[h] % MODS[0];
            assign calc_r[1] = candidates[h] % MODS[1];
            assign calc_r[2] = candidates[h] % MODS[2];
            assign calc_r[3] = candidates[h] % MODS[3];
            assign calc_r[4] = candidates[h] % MODS[4];
            assign calc_r[5] = candidates[h] % MODS[5];
            assign calc_r[6] = candidates[h] % MODS[6];
            assign calc_r[7] = candidates[h] % MODS[7];
            assign calc_r[8] = candidates[h] % MODS[8];
            
            // 计算汉明距离
            assign dist_sum = (calc_r[0]!=r[0]) + (calc_r[1]!=r[1]) + (calc_r[2]!=r[2]) +
                              (calc_r[3]!=r[3]) + (calc_r[4]!=r[4]) + (calc_r[5]!=r[5]) +
                              (calc_r[6]!=r[6]) + (calc_r[7]!=r[7]) + (calc_r[8]!=r[8]);
            
            assign distances[h] = dist_sum;
        end
    endgenerate

    // ------------------------------------------------------------------
    // 5. 投票与决策 (Voting & Decision)
    // ------------------------------------------------------------------
    reg [17:0] best_val;
    reg [3:0] min_dist;
    integer k;
    
    always @(*) begin
        min_dist = 4'd10; 
        best_val = 18'd0;
        
        for(k=0; k<84; k=k+1) begin
            // 寻找最小距离
            if (distances[k] < min_dist) begin
                min_dist = distances[k];
                best_val = candidates[k];
            end
        end
    end

    // ------------------------------------------------------------------
    // 6. 输出注册与严格检查 (Gemini 建议的溢出检查)
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 0;
            valid <= 0;
            uncorrectable <= 0;
        end else begin
            valid <= 0;
            uncorrectable <= 0;
            
            if (start) begin
                // 双重检查：
                // 1. 汉明距离必须 <= 3 (理论纠错上限)
                // 2. 数值必须在 16 位范围内 (< 65536)
                if (min_dist <= 3 && best_val < 18'd65536) begin
                    data_out <= best_val[15:0];
                    valid <= 1;
                end else begin
                    uncorrectable <= 1;
                    valid <= 1; // 标记为无效/错误
                    data_out <= 0;
                end
            end
        end
    end

endmodule