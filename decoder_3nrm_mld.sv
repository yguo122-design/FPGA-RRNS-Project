`timescale 1ns / 1ps

module decoder_3nrm_mld (
    input wire clk,
    input wire rst_n,
    input wire start,             // 启动脉冲
    input wire [63:0] residues_in,// 64-bit 输入总线
    output reg [19:0] data_out,   // 最终解码结果
    output reg valid,             // 输出有效标志
    output reg uncorrectable      // 无法纠错标志
);

    // ------------------------------------------------------------------
    // 1. 参数定义
    // ------------------------------------------------------------------
    localparam NUM_COMBINATIONS = 84;
    localparam CNT_WIDTH = 7; 

    // ------------------------------------------------------------------
    // 2. 输入解包 (9 个余数)
    // ------------------------------------------------------------------
    // 对应模数：64, 63, 65, 31, 29, 23, 19, 17, 11
    wire [6:0] r_all [0:8];
    
    assign r_all[0] = {1'b0, residues_in[63:58]}; // mod 64
    assign r_all[1] = {1'b0, residues_in[57:52]}; // mod 63
    assign r_all[2] =       residues_in[51:45];   // mod 65
    assign r_all[3] = {2'b0, residues_in[44:40]}; // mod 31
    assign r_all[4] = {2'b0, residues_in[39:35]}; // mod 29
    assign r_all[5] = {2'b0, residues_in[34:30]}; // mod 23
    assign r_all[6] = {2'b0, residues_in[29:25]}; // mod 19
    assign r_all[7] = {2'b0, residues_in[24:20]}; // mod 17
    assign r_all[8] = {3'b0, residues_in[19:16]}; // mod 11

    // ------------------------------------------------------------------
    // 3. 内部信号
    // ------------------------------------------------------------------
    typedef enum logic [1:0] {S_IDLE, S_COMPUTE, S_COMPARE, S_DONE} state_t;
    state_t state, next_state;
    
    reg [CNT_WIDTH-1:0] calc_idx;       // 计算计数器 (0-83)
    reg [CNT_WIDTH-1:0] comp_idx;       // 比较计数器 (0-83)
    
    // 结果存储 (距离用 16-bit 足够)
    reg [19:0] results_mem [0:NUM_COMBINATIONS-1];
    reg [15:0] distances_mem [0:NUM_COMBINATIONS-1];
    
    // 动态参数选择信号
    reg [19:0] cur_mi0, cur_mi1, cur_mi2;
    reg [19:0] cur_inv0, cur_inv1, cur_inv2;
    reg [19:0] cur_m_total;
    reg [6:0]  cur_r_a, cur_r_b, cur_r_c;
    reg [3:0]  idx_a, idx_b, idx_c;

    // 计算结果临时寄存器
    reg [19:0] calc_x;
    reg [15:0] calc_dist;

    // 最小值寄存器
    reg [15:0] min_dist_reg;

    // ------------------------------------------------------------------
    // 4. 动态路由与参数查找表 (由 Python 脚本生成的 84 组数据)
    // ------------------------------------------------------------------
    always @(*) begin
        // 默认值防止锁存器
        {idx_a, idx_b, idx_c} = {0, 1, 2};
        {cur_mi0, cur_mi1, cur_mi2} = {20'd0, 20'd0, 20'd0};
        {cur_inv0, cur_inv1, cur_inv2} = {20'd0, 20'd0, 20'd0};
        cur_m_total = 20'd0;

    case (calc_idx)
            0: begin // Indices: 0, 1, 2 (Mods: 64, 63, 65)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd2};
                cur_mi0   = 20'd4095; cur_inv0 = 20'd63;
                cur_mi1   = 20'd4160; cur_inv1 = 20'd32;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd33;
                cur_m_total = 20'd262080;
            end

            1: begin // Indices: 0, 1, 3 (Mods: 64, 63, 31)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd3};
                cur_mi0   = 20'd1953; cur_inv0 = 20'd33;
                cur_mi1   = 20'd1984; cur_inv1 = 20'd61;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd16;
                cur_m_total = 20'd124992;
            end

            2: begin // Indices: 0, 1, 4 (Mods: 64, 63, 29)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd4};
                cur_mi0   = 20'd1827; cur_inv0 = 20'd11;
                cur_mi1   = 20'd1856; cur_inv1 = 20'd50;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd1;
                cur_m_total = 20'd116928;
            end

            3: begin // Indices: 0, 1, 5 (Mods: 64, 63, 23)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd5};
                cur_mi0   = 20'd1449; cur_inv0 = 20'd25;
                cur_mi1   = 20'd1472; cur_inv1 = 20'd11;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd10;
                cur_m_total = 20'd92736;
            end

            4: begin // Indices: 0, 1, 6 (Mods: 64, 63, 19)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd6};
                cur_mi0   = 20'd1197; cur_inv0 = 20'd37;
                cur_mi1   = 20'd1216; cur_inv1 = 20'd10;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd5;
                cur_m_total = 20'd76608;
            end

            5: begin // Indices: 0, 1, 7 (Mods: 64, 63, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd7};
                cur_mi0   = 20'd1071; cur_inv0 = 20'd15;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd26;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd6;
                cur_m_total = 20'd68544;
            end

            6: begin // Indices: 0, 1, 8 (Mods: 64, 63, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd8};
                cur_mi0   = 20'd693; cur_inv0 = 20'd29;
                cur_mi1   = 20'd704; cur_inv1 = 20'd23;
                cur_mi2   = 20'd4032; cur_inv2 = 20'd2;
                cur_m_total = 20'd44352;
            end

            7: begin // Indices: 0, 2, 3 (Mods: 64, 65, 31)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd3};
                cur_mi0   = 20'd2015; cur_inv0 = 20'd31;
                cur_mi1   = 20'd1984; cur_inv1 = 20'd44;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd26;
                cur_m_total = 20'd128960;
            end

            8: begin // Indices: 0, 2, 4 (Mods: 64, 65, 29)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd4};
                cur_mi0   = 20'd1885; cur_inv0 = 20'd53;
                cur_mi1   = 20'd1856; cur_inv1 = 20'd56;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd9;
                cur_m_total = 20'd120640;
            end

            9: begin // Indices: 0, 2, 5 (Mods: 64, 65, 23)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd5};
                cur_mi0   = 20'd1495; cur_inv0 = 20'd39;
                cur_mi1   = 20'd1472; cur_inv1 = 20'd48;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd15;
                cur_m_total = 20'd95680;
            end

            10: begin // Indices: 0, 2, 6 (Mods: 64, 65, 19)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd6};
                cur_mi0   = 20'd1235; cur_inv0 = 20'd27;
                cur_mi1   = 20'd1216; cur_inv1 = 20'd41;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd18;
                cur_m_total = 20'd79040;
            end

            11: begin // Indices: 0, 2, 7 (Mods: 64, 65, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd7};
                cur_mi0   = 20'd1105; cur_inv0 = 20'd49;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd42;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd10;
                cur_m_total = 20'd70720;
            end

            12: begin // Indices: 0, 2, 8 (Mods: 64, 65, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd2, 2'd8};
                cur_mi0   = 20'd715; cur_inv0 = 20'd35;
                cur_mi1   = 20'd704; cur_inv1 = 20'd59;
                cur_mi2   = 20'd4160; cur_inv2 = 20'd6;
                cur_m_total = 20'd45760;
            end

            13: begin // Indices: 0, 3, 4 (Mods: 64, 31, 29)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd3, 2'd4};
                cur_mi0   = 20'd899; cur_inv0 = 20'd43;
                cur_mi1   = 20'd1856; cur_inv1 = 20'd23;
                cur_mi2   = 20'd1984; cur_inv2 = 20'd17;
                cur_m_total = 20'd57536;
            end

            14: begin // Indices: 0, 3, 5 (Mods: 64, 31, 23)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd3, 2'd5};
                cur_mi0   = 20'd713; cur_inv0 = 20'd57;
                cur_mi1   = 20'd1472; cur_inv1 = 20'd29;
                cur_mi2   = 20'd1984; cur_inv2 = 20'd4;
                cur_m_total = 20'd45632;
            end

            15: begin // Indices: 0, 3, 6 (Mods: 64, 31, 19)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd3, 2'd6};
                cur_mi0   = 20'd589; cur_inv0 = 20'd5;
                cur_mi1   = 20'd1216; cur_inv1 = 20'd9;
                cur_mi2   = 20'd1984; cur_inv2 = 20'd12;
                cur_m_total = 20'd37696;
            end

            16: begin // Indices: 0, 3, 7 (Mods: 64, 31, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd3, 2'd7};
                cur_mi0   = 20'd527; cur_inv0 = 20'd47;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd21;
                cur_mi2   = 20'd1984; cur_inv2 = 20'd10;
                cur_m_total = 20'd33728;
            end

            17: begin // Indices: 0, 3, 8 (Mods: 64, 31, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd3, 2'd8};
                cur_mi0   = 20'd341; cur_inv0 = 20'd61;
                cur_mi1   = 20'd704; cur_inv1 = 20'd24;
                cur_mi2   = 20'd1984; cur_inv2 = 20'd3;
                cur_m_total = 20'd21824;
            end

            18: begin // Indices: 0, 4, 5 (Mods: 64, 29, 23)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd4, 2'd5};
                cur_mi0   = 20'd667; cur_inv0 = 20'd19;
                cur_mi1   = 20'd1472; cur_inv1 = 20'd4;
                cur_mi2   = 20'd1856; cur_inv2 = 20'd13;
                cur_m_total = 20'd42688;
            end

            19: begin // Indices: 0, 4, 6 (Mods: 64, 29, 19)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd4, 2'd6};
                cur_mi0   = 20'd551; cur_inv0 = 20'd23;
                cur_mi1   = 20'd1216; cur_inv1 = 20'd14;
                cur_mi2   = 20'd1856; cur_inv2 = 20'd3;
                cur_m_total = 20'd35264;
            end

            20: begin // Indices: 0, 4, 7 (Mods: 64, 29, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd4, 2'd7};
                cur_mi0   = 20'd493; cur_inv0 = 20'd37;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd2;
                cur_mi2   = 20'd1856; cur_inv2 = 20'd6;
                cur_m_total = 20'd31552;
            end

            21: begin // Indices: 0, 4, 8 (Mods: 64, 29, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd4, 2'd8};
                cur_mi0   = 20'd319; cur_inv0 = 20'd63;
                cur_mi1   = 20'd704; cur_inv1 = 20'd11;
                cur_mi2   = 20'd1856; cur_inv2 = 20'd7;
                cur_m_total = 20'd20416;
            end

            22: begin // Indices: 0, 5, 6 (Mods: 64, 23, 19)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd5, 2'd6};
                cur_mi0   = 20'd437; cur_inv0 = 20'd29;
                cur_mi1   = 20'd1216; cur_inv1 = 20'd15;
                cur_mi2   = 20'd1472; cur_inv2 = 20'd17;
                cur_m_total = 20'd27968;
            end

            23: begin // Indices: 0, 5, 7 (Mods: 64, 23, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd5, 2'd7};
                cur_mi0   = 20'd391; cur_inv0 = 20'd55;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd10;
                cur_mi2   = 20'd1472; cur_inv2 = 20'd12;
                cur_m_total = 20'd25024;
            end

            24: begin // Indices: 0, 5, 8 (Mods: 64, 23, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd5, 2'd8};
                cur_mi0   = 20'd253; cur_inv0 = 20'd21;
                cur_mi1   = 20'd704; cur_inv1 = 20'd5;
                cur_mi2   = 20'd1472; cur_inv2 = 20'd5;
                cur_m_total = 20'd16192;
            end

            25: begin // Indices: 0, 6, 7 (Mods: 64, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd43;
                cur_mi1   = 20'd1088; cur_inv1 = 20'd4;
                cur_mi2   = 20'd1216; cur_inv2 = 20'd2;
                cur_m_total = 20'd20672;
            end

            26: begin // Indices: 0, 6, 8 (Mods: 64, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd49;
                cur_mi1   = 20'd704; cur_inv1 = 20'd1;
                cur_mi2   = 20'd1216; cur_inv2 = 20'd2;
                cur_m_total = 20'd13376;
            end

            27: begin // Indices: 0, 7, 8 (Mods: 64, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd0, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd51;
                cur_mi1   = 20'd704; cur_inv1 = 20'd5;
                cur_mi2   = 20'd1088; cur_inv2 = 20'd10;
                cur_m_total = 20'd11968;
            end

            28: begin // Indices: 1, 2, 3 (Mods: 63, 65, 31)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd3};
                cur_mi0   = 20'd2015; cur_inv0 = 20'd62;
                cur_mi1   = 20'd1953; cur_inv1 = 20'd22;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd21;
                cur_m_total = 20'd126945;
            end

            29: begin // Indices: 1, 2, 4 (Mods: 63, 65, 29)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd4};
                cur_mi0   = 20'd1885; cur_inv0 = 20'd25;
                cur_mi1   = 20'd1827; cur_inv1 = 20'd28;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd5;
                cur_m_total = 20'd118755;
            end

            30: begin // Indices: 1, 2, 5 (Mods: 63, 65, 23)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd5};
                cur_mi0   = 20'd1495; cur_inv0 = 20'd37;
                cur_mi1   = 20'd1449; cur_inv1 = 20'd24;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd1;
                cur_m_total = 20'd94185;
            end

            31: begin // Indices: 1, 2, 6 (Mods: 63, 65, 19)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd6};
                cur_mi0   = 20'd1235; cur_inv0 = 20'd5;
                cur_mi1   = 20'd1197; cur_inv1 = 20'd53;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd2;
                cur_m_total = 20'd77805;
            end

            32: begin // Indices: 1, 2, 7 (Mods: 63, 65, 17)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd7};
                cur_mi0   = 20'd1105; cur_inv0 = 20'd13;
                cur_mi1   = 20'd1071; cur_inv1 = 20'd21;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd8;
                cur_m_total = 20'd69615;
            end

            33: begin // Indices: 1, 2, 8 (Mods: 63, 65, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd2, 2'd8};
                cur_mi0   = 20'd715; cur_inv0 = 20'd43;
                cur_mi1   = 20'd693; cur_inv1 = 20'd62;
                cur_mi2   = 20'd4095; cur_inv2 = 20'd4;
                cur_m_total = 20'd45045;
            end

            34: begin // Indices: 1, 3, 4 (Mods: 63, 31, 29)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd3, 2'd4};
                cur_mi0   = 20'd899; cur_inv0 = 20'd26;
                cur_mi1   = 20'd1827; cur_inv1 = 20'd15;
                cur_mi2   = 20'd1953; cur_inv2 = 20'd3;
                cur_m_total = 20'd56637;
            end

            35: begin // Indices: 1, 3, 5 (Mods: 63, 31, 23)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd3, 2'd5};
                cur_mi0   = 20'd713; cur_inv0 = 20'd41;
                cur_mi1   = 20'd1449; cur_inv1 = 20'd27;
                cur_mi2   = 20'd1953; cur_inv2 = 20'd11;
                cur_m_total = 20'd44919;
            end

            36: begin // Indices: 1, 3, 6 (Mods: 63, 31, 19)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd3, 2'd6};
                cur_mi0   = 20'd589; cur_inv0 = 20'd43;
                cur_mi1   = 20'd1197; cur_inv1 = 20'd18;
                cur_mi2   = 20'd1953; cur_inv2 = 20'd14;
                cur_m_total = 20'd37107;
            end

            37: begin // Indices: 1, 3, 7 (Mods: 63, 31, 17)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd3, 2'd7};
                cur_mi0   = 20'd527; cur_inv0 = 20'd11;
                cur_mi1   = 20'd1071; cur_inv1 = 20'd11;
                cur_mi2   = 20'd1953; cur_inv2 = 20'd8;
                cur_m_total = 20'd33201;
            end

            38: begin // Indices: 1, 3, 8 (Mods: 63, 31, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd3, 2'd8};
                cur_mi0   = 20'd341; cur_inv0 = 20'd17;
                cur_mi1   = 20'd693; cur_inv1 = 20'd17;
                cur_mi2   = 20'd1953; cur_inv2 = 20'd2;
                cur_m_total = 20'd21483;
            end

            39: begin // Indices: 1, 4, 5 (Mods: 63, 29, 23)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd4, 2'd5};
                cur_mi0   = 20'd667; cur_inv0 = 20'd46;
                cur_mi1   = 20'd1449; cur_inv1 = 20'd28;
                cur_mi2   = 20'd1827; cur_inv2 = 20'd7;
                cur_m_total = 20'd42021;
            end

            40: begin // Indices: 1, 4, 6 (Mods: 63, 29, 19)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd4, 2'd6};
                cur_mi0   = 20'd551; cur_inv0 = 20'd59;
                cur_mi1   = 20'd1197; cur_inv1 = 20'd11;
                cur_mi2   = 20'd1827; cur_inv2 = 20'd13;
                cur_m_total = 20'd34713;
            end

            41: begin // Indices: 1, 4, 7 (Mods: 63, 29, 17)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd4, 2'd7};
                cur_mi0   = 20'd493; cur_inv0 = 20'd40;
                cur_mi1   = 20'd1071; cur_inv1 = 20'd14;
                cur_mi2   = 20'd1827; cur_inv2 = 20'd15;
                cur_m_total = 20'd31059;
            end

            42: begin // Indices: 1, 4, 8 (Mods: 63, 29, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd4, 2'd8};
                cur_mi0   = 20'd319; cur_inv0 = 20'd16;
                cur_mi1   = 20'd693; cur_inv1 = 20'd19;
                cur_mi2   = 20'd1827; cur_inv2 = 20'd1;
                cur_m_total = 20'd20097;
            end

            43: begin // Indices: 1, 5, 6 (Mods: 63, 23, 19)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd5, 2'd6};
                cur_mi0   = 20'd437; cur_inv0 = 20'd47;
                cur_mi1   = 20'd1197; cur_inv1 = 20'd1;
                cur_mi2   = 20'd1449; cur_inv2 = 20'd4;
                cur_m_total = 20'd27531;
            end

            44: begin // Indices: 1, 5, 7 (Mods: 63, 23, 17)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd5, 2'd7};
                cur_mi0   = 20'd391; cur_inv0 = 20'd34;
                cur_mi1   = 20'd1071; cur_inv1 = 20'd16;
                cur_mi2   = 20'd1449; cur_inv2 = 20'd13;
                cur_m_total = 20'd24633;
            end

            45: begin // Indices: 1, 5, 8 (Mods: 63, 23, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd5, 2'd8};
                cur_mi0   = 20'd253; cur_inv0 = 20'd1;
                cur_mi1   = 20'd693; cur_inv1 = 20'd8;
                cur_mi2   = 20'd1449; cur_inv2 = 20'd7;
                cur_m_total = 20'd15939;
            end

            46: begin // Indices: 1, 6, 7 (Mods: 63, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd8;
                cur_mi1   = 20'd1071; cur_inv1 = 20'd11;
                cur_mi2   = 20'd1197; cur_inv2 = 20'd5;
                cur_m_total = 20'd20349;
            end

            47: begin // Indices: 1, 6, 8 (Mods: 63, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd41;
                cur_mi1   = 20'd693; cur_inv1 = 20'd17;
                cur_mi2   = 20'd1197; cur_inv2 = 20'd5;
                cur_m_total = 20'd13167;
            end

            48: begin // Indices: 1, 7, 8 (Mods: 63, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd1, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd31;
                cur_mi1   = 20'd693; cur_inv1 = 20'd4;
                cur_mi2   = 20'd1071; cur_inv2 = 20'd3;
                cur_m_total = 20'd11781;
            end

            49: begin // Indices: 2, 3, 4 (Mods: 65, 31, 29)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd3, 2'd4};
                cur_mi0   = 20'd899; cur_inv0 = 20'd59;
                cur_mi1   = 20'd1885; cur_inv1 = 20'd5;
                cur_mi2   = 20'd2015; cur_inv2 = 20'd27;
                cur_m_total = 20'd58435;
            end

            50: begin // Indices: 2, 3, 5 (Mods: 65, 31, 23)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd3, 2'd5};
                cur_mi0   = 20'd713; cur_inv0 = 20'd32;
                cur_mi1   = 20'd1495; cur_inv1 = 20'd9;
                cur_mi2   = 20'd2015; cur_inv2 = 20'd5;
                cur_m_total = 20'd46345;
            end

            51: begin // Indices: 2, 3, 6 (Mods: 65, 31, 19)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd3, 2'd6};
                cur_mi0   = 20'd589; cur_inv0 = 20'd49;
                cur_mi1   = 20'd1235; cur_inv1 = 20'd6;
                cur_mi2   = 20'd2015; cur_inv2 = 20'd1;
                cur_m_total = 20'd38285;
            end

            52: begin // Indices: 2, 3, 7 (Mods: 65, 31, 17)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd3, 2'd7};
                cur_mi0   = 20'd527; cur_inv0 = 20'd28;
                cur_mi1   = 20'd1105; cur_inv1 = 20'd14;
                cur_mi2   = 20'd2015; cur_inv2 = 20'd2;
                cur_m_total = 20'd34255;
            end

            53: begin // Indices: 2, 3, 8 (Mods: 65, 31, 11)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd3, 2'd8};
                cur_mi0   = 20'd341; cur_inv0 = 20'd61;
                cur_mi1   = 20'd715; cur_inv1 = 20'd16;
                cur_mi2   = 20'd2015; cur_inv2 = 20'd6;
                cur_m_total = 20'd22165;
            end

            54: begin // Indices: 2, 4, 5 (Mods: 65, 29, 23)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd4, 2'd5};
                cur_mi0   = 20'd667; cur_inv0 = 20'd23;
                cur_mi1   = 20'd1495; cur_inv1 = 20'd20;
                cur_mi2   = 20'd1885; cur_inv2 = 20'd22;
                cur_m_total = 20'd43355;
            end

            55: begin // Indices: 2, 4, 6 (Mods: 65, 29, 19)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd4, 2'd6};
                cur_mi0   = 20'd551; cur_inv0 = 20'd21;
                cur_mi1   = 20'd1235; cur_inv1 = 20'd12;
                cur_mi2   = 20'd1885; cur_inv2 = 20'd5;
                cur_m_total = 20'd35815;
            end

            56: begin // Indices: 2, 4, 7 (Mods: 65, 29, 17)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd4, 2'd7};
                cur_mi0   = 20'd493; cur_inv0 = 20'd12;
                cur_mi1   = 20'd1105; cur_inv1 = 20'd10;
                cur_mi2   = 20'd1885; cur_inv2 = 20'd8;
                cur_m_total = 20'd32045;
            end

            57: begin // Indices: 2, 4, 8 (Mods: 65, 29, 11)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd4, 2'd8};
                cur_mi0   = 20'd319; cur_inv0 = 20'd54;
                cur_mi1   = 20'd715; cur_inv1 = 20'd26;
                cur_mi2   = 20'd1885; cur_inv2 = 20'd3;
                cur_m_total = 20'd20735;
            end

            58: begin // Indices: 2, 5, 6 (Mods: 65, 23, 19)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd5, 2'd6};
                cur_mi0   = 20'd437; cur_inv0 = 20'd18;
                cur_mi1   = 20'd1235; cur_inv1 = 20'd13;
                cur_mi2   = 20'd1495; cur_inv2 = 20'd3;
                cur_m_total = 20'd28405;
            end

            59: begin // Indices: 2, 5, 7 (Mods: 65, 23, 17)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd5, 2'd7};
                cur_mi0   = 20'd391; cur_inv0 = 20'd1;
                cur_mi1   = 20'd1105; cur_inv1 = 20'd1;
                cur_mi2   = 20'd1495; cur_inv2 = 20'd16;
                cur_m_total = 20'd25415;
            end

            60: begin // Indices: 2, 5, 8 (Mods: 65, 23, 11)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd5, 2'd8};
                cur_mi0   = 20'd253; cur_inv0 = 20'd37;
                cur_mi1   = 20'd715; cur_inv1 = 20'd12;
                cur_mi2   = 20'd1495; cur_inv2 = 20'd10;
                cur_m_total = 20'd16445;
            end

            61: begin // Indices: 2, 6, 7 (Mods: 65, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd32;
                cur_mi1   = 20'd1105; cur_inv1 = 20'd13;
                cur_mi2   = 20'd1235; cur_inv2 = 20'd14;
                cur_m_total = 20'd20995;
            end

            62: begin // Indices: 2, 6, 8 (Mods: 65, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd14;
                cur_mi1   = 20'd715; cur_inv1 = 20'd8;
                cur_mi2   = 20'd1235; cur_inv2 = 20'd4;
                cur_m_total = 20'd13585;
            end

            63: begin // Indices: 2, 7, 8 (Mods: 65, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd2, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd8;
                cur_mi1   = 20'd715; cur_inv1 = 20'd1;
                cur_mi2   = 20'd1105; cur_inv2 = 20'd9;
                cur_m_total = 20'd12155;
            end

            64: begin // Indices: 3, 4, 5 (Mods: 31, 29, 23)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd4, 2'd5};
                cur_mi0   = 20'd667; cur_inv0 = 20'd2;
                cur_mi1   = 20'd713; cur_inv1 = 20'd12;
                cur_mi2   = 20'd899; cur_inv2 = 20'd12;
                cur_m_total = 20'd20677;
            end

            65: begin // Indices: 3, 4, 6 (Mods: 31, 29, 19)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd4, 2'd6};
                cur_mi0   = 20'd551; cur_inv0 = 20'd22;
                cur_mi1   = 20'd589; cur_inv1 = 20'd13;
                cur_mi2   = 20'd899; cur_inv2 = 20'd16;
                cur_m_total = 20'd17081;
            end

            66: begin // Indices: 3, 4, 7 (Mods: 31, 29, 17)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd4, 2'd7};
                cur_mi0   = 20'd493; cur_inv0 = 20'd10;
                cur_mi1   = 20'd527; cur_inv1 = 20'd6;
                cur_mi2   = 20'd899; cur_inv2 = 20'd8;
                cur_m_total = 20'd15283;
            end

            67: begin // Indices: 3, 4, 8 (Mods: 31, 29, 11)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd4, 2'd8};
                cur_mi0   = 20'd319; cur_inv0 = 20'd7;
                cur_mi1   = 20'd341; cur_inv1 = 20'd4;
                cur_mi2   = 20'd899; cur_inv2 = 20'd7;
                cur_m_total = 20'd9889;
            end

            68: begin // Indices: 3, 5, 6 (Mods: 31, 23, 19)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd5, 2'd6};
                cur_mi0   = 20'd437; cur_inv0 = 20'd21;
                cur_mi1   = 20'd589; cur_inv1 = 20'd5;
                cur_mi2   = 20'd713; cur_inv2 = 20'd2;
                cur_m_total = 20'd13547;
            end

            69: begin // Indices: 3, 5, 7 (Mods: 31, 23, 17)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd5, 2'd7};
                cur_mi0   = 20'd391; cur_inv0 = 20'd18;
                cur_mi1   = 20'd527; cur_inv1 = 20'd11;
                cur_mi2   = 20'd713; cur_inv2 = 20'd16;
                cur_m_total = 20'd12121;
            end

            70: begin // Indices: 3, 5, 8 (Mods: 31, 23, 11)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd5, 2'd8};
                cur_mi0   = 20'd253; cur_inv0 = 20'd25;
                cur_mi1   = 20'd341; cur_inv1 = 20'd17;
                cur_mi2   = 20'd713; cur_inv2 = 20'd5;
                cur_m_total = 20'd7843;
            end

            71: begin // Indices: 3, 6, 7 (Mods: 31, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd12;
                cur_mi1   = 20'd527; cur_inv1 = 20'd15;
                cur_mi2   = 20'd589; cur_inv2 = 20'd14;
                cur_m_total = 20'd10013;
            end

            72: begin // Indices: 3, 6, 8 (Mods: 31, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd27;
                cur_mi1   = 20'd341; cur_inv1 = 20'd18;
                cur_mi2   = 20'd589; cur_inv2 = 20'd2;
                cur_m_total = 20'd6479;
            end

            73: begin // Indices: 3, 7, 8 (Mods: 31, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd3, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd1;
                cur_mi1   = 20'd341; cur_inv1 = 20'd1;
                cur_mi2   = 20'd527; cur_inv2 = 20'd10;
                cur_m_total = 20'd5797;
            end

            74: begin // Indices: 4, 5, 6 (Mods: 29, 23, 19)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd5, 2'd6};
                cur_mi0   = 20'd437; cur_inv0 = 20'd15;
                cur_mi1   = 20'd551; cur_inv1 = 20'd22;
                cur_mi2   = 20'd667; cur_inv2 = 20'd10;
                cur_m_total = 20'd12673;
            end

            75: begin // Indices: 4, 5, 7 (Mods: 29, 23, 17)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd5, 2'd7};
                cur_mi0   = 20'd391; cur_inv0 = 20'd27;
                cur_mi1   = 20'd493; cur_inv1 = 20'd7;
                cur_mi2   = 20'd667; cur_inv2 = 20'd13;
                cur_m_total = 20'd11339;
            end

            76: begin // Indices: 4, 5, 8 (Mods: 29, 23, 11)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd5, 2'd8};
                cur_mi0   = 20'd253; cur_inv0 = 20'd18;
                cur_mi1   = 20'd319; cur_inv1 = 20'd15;
                cur_mi2   = 20'd667; cur_inv2 = 20'd8;
                cur_m_total = 20'd7337;
            end

            77: begin // Indices: 4, 6, 7 (Mods: 29, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd22;
                cur_mi1   = 20'd493; cur_inv1 = 20'd18;
                cur_mi2   = 20'd551; cur_inv2 = 20'd5;
                cur_m_total = 20'd9367;
            end

            78: begin // Indices: 4, 6, 8 (Mods: 29, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd5;
                cur_mi1   = 20'd319; cur_inv1 = 20'd14;
                cur_mi2   = 20'd551; cur_inv2 = 20'd1;
                cur_m_total = 20'd6061;
            end

            79: begin // Indices: 4, 7, 8 (Mods: 29, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd4, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd9;
                cur_mi1   = 20'd319; cur_inv1 = 20'd4;
                cur_mi2   = 20'd493; cur_inv2 = 20'd5;
                cur_m_total = 20'd5423;
            end

            80: begin // Indices: 5, 6, 7 (Mods: 23, 19, 17)
                {idx_a, idx_b, idx_c} = {2'd5, 2'd6, 2'd7};
                cur_mi0   = 20'd323; cur_inv0 = 20'd1;
                cur_mi1   = 20'd391; cur_inv1 = 20'd7;
                cur_mi2   = 20'd437; cur_inv2 = 20'd10;
                cur_m_total = 20'd7429;
            end

            81: begin // Indices: 5, 6, 8 (Mods: 23, 19, 11)
                {idx_a, idx_b, idx_c} = {2'd5, 2'd6, 2'd8};
                cur_mi0   = 20'd209; cur_inv0 = 20'd12;
                cur_mi1   = 20'd253; cur_inv1 = 20'd16;
                cur_mi2   = 20'd437; cur_inv2 = 20'd7;
                cur_m_total = 20'd4807;
            end

            82: begin // Indices: 5, 7, 8 (Mods: 23, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd5, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd8;
                cur_mi1   = 20'd253; cur_inv1 = 20'd8;
                cur_mi2   = 20'd391; cur_inv2 = 20'd2;
                cur_m_total = 20'd4301;
            end

            83: begin // Indices: 6, 7, 8 (Mods: 19, 17, 11)
                {idx_a, idx_b, idx_c} = {2'd6, 2'd7, 2'd8};
                cur_mi0   = 20'd187; cur_inv0 = 20'd6;
                cur_mi1   = 20'd209; cur_inv1 = 20'd7;
                cur_mi2   = 20'd323; cur_inv2 = 20'd3;
                cur_m_total = 20'd3553;
            end
            default: begin
                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd2};
                cur_mi0 = 20'd4095; cur_inv0 = 20'd63;
                cur_mi1 = 20'd4160; cur_inv1 = 20'd2;
                cur_mi2 = 20'd4032; cur_inv2 = 20'd33;
                cur_m_total = 20'd262080;
            end
        endcase
        
        cur_r_a = r_all[idx_a];
        cur_r_b = r_all[idx_b];
        cur_r_c = r_all[idx_c];
    end
    


    // ------------------------------------------------------------------
    // 5. 核心计算逻辑 (CRT 重构 + MLD 距离计算)
    // ------------------------------------------------------------------
    always @(*) begin
        logic [39:0] sum_temp;
        logic [19:0] x_temp;
        logic [3:0]  dist_temp; // 距离定义为不匹配的个数 (0-9)，4-bit 足够
        integer      k;             // 移到这里
        logic [6:0]  expected_r;    // 移到这里

        // 1. CRT 求和重构 X
        sum_temp = ({20'd0, cur_r_a} * cur_mi0 * cur_inv0) +
                   ({20'd0, cur_r_b} * cur_mi1 * cur_inv1) +
                   ({20'd0, cur_r_c} * cur_mi2 * cur_inv2);
        
        x_temp = sum_temp % cur_m_total; 
        
        // 2. 【MLD 核心】重计算余数并比较 (Re-calculation & Comparison)
        // 我们不需要真的做 9 次除法，只需要对当前用到的 3 个模数做取模验证即可？
        // 不，论文说要对比 "chosen moduli" (所有 9 个)。
        // 但为了节省资源，我们可以只对比那 3 个吗？
        // 不行，因为那 3 个是用来生成 X 的，必然匹配 (距离为 0)。
        // 关键在于对比那些 **没用到的 6 个冗余模数**！
        // 如果 X 是正确的，它模剩下的 6 个模数，结果应该等于输入的对应余数。
        
        // 优化策略：只计算未使用的 6 个模数的余数并比较
        // 这里为了代码简洁且通用，我们直接硬编码比较逻辑
        // 假设 idx_a, idx_b, idx_c 是当前使用的三个索引
        
        dist_temp = 4'd0; // 初始化为 0 (表示当前这 3 个肯定匹配)
        
        // 遍历所有 9 个模数索引
        for (integer k = 0; k < 9; k = k + 1) begin
            // 跳过当前正在使用的 3 个模数 (因为它们必然匹配)
            if ((k == idx_a) || (k == idx_b) || (k == idx_c)) 
                continue;
            
            // 计算 X_temp 模第 k 个模数的理论余数
            // 注意：这里需要做除法/取模运算，综合器会生成除法器
            // 模数列表：64, 63, 65, 31, 29, 23, 19, 17, 11
            case (k)
                0: expected_r = x_temp % 7'd64;
                1: expected_r = x_temp % 7'd63;
                2: expected_r = x_temp % 7'd65;
                3: expected_r = x_temp % 7'd31;
                4: expected_r = x_temp % 7'd29;
                5: expected_r = x_temp % 7'd23;
                6: expected_r = x_temp % 7'd19;
                7: expected_r = x_temp % 7'd17;
                8: expected_r = x_temp % 7'd11;
                default: expected_r = 7'd0;
            endcase
            
            // 比较理论余数和实际输入余数
            if (expected_r != r_all[k]) begin
                dist_temp = dist_temp + 1'b1; // 不匹配，距离 +1
            end
        end

        calc_x    = x_temp;
        calc_dist = {12'd0, dist_temp}; // 扩展到 16-bit 以匹配内存定义
    end

    // ------------------------------------------------------------------
    // 6. 状态机控制
    // ------------------------------------------------------------------
    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: if (start) next_state = S_COMPUTE;
            S_COMPUTE: if (calc_idx == NUM_COMBINATIONS - 1) next_state = S_COMPARE;
            S_COMPARE: if (comp_idx == NUM_COMBINATIONS - 1) next_state = S_DONE;
            S_DONE: next_state = S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

    // ------------------------------------------------------------------
    // 7. 时序逻辑 (包含复位初始化和最终可信度判断)
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // --- 复位逻辑在这里 ---
            state <= S_IDLE;
            calc_idx <= 0;
            comp_idx <= 0;
            valid <= 0;
            data_out <= 0;
            uncorrectable <= 1;       // 复位时默认不可纠错
            min_dist_reg <= 16'd10;   // 初始化为一个较大的值 (大于最大可能距离 6)
        end else begin
            valid <= 0; // 默认拉低 valid
            
            case (state)
                S_IDLE: begin
                    if (start) begin
                        calc_idx <= 0;
                        comp_idx <= 0;
                        uncorrectable <= 1; // 新一轮开始，先标记为不可信
                        min_dist_reg <= 16'd10; // 重置最小距离为大值
                    end
                end
                
                S_COMPUTE: begin
                    results_mem[calc_idx] <= calc_x;
                    distances_mem[calc_idx] <= calc_dist;
                    if (calc_idx < NUM_COMBINATIONS - 1) 
                        calc_idx <= calc_idx + 1;
                end
                
                S_COMPARE: begin
                    // 策略：寻找最小距离
                    // 注意：因为我们在 S_IDLE 已经把 min_dist_reg 初始化为 10 了
                    // 所以这里可以直接比较，不需要判断 comp_idx == 0
                    
                    if (distances_mem[comp_idx] < min_dist_reg) begin
                        min_dist_reg <= distances_mem[comp_idx];
                        data_out <= results_mem[comp_idx];
                    end
                    
                    if (comp_idx < NUM_COMBINATIONS - 1) 
                        comp_idx <= comp_idx + 1;
                end
                
                S_DONE: begin
                    valid <= 1;
                    // --- 关键修改：最终可信度判断 ---
                    // 如果找到的最小距离仍然很大 (比如 > 2)，说明没有可靠的组合
                    // 对于 3NRM，通常距离为 0 或 1 是可接受的
                    if (min_dist_reg > 16'd2) 
                        uncorrectable <= 1;
                    else 
                        uncorrectable <= 0;
                end
            endcase
        end
    end
    endmodule