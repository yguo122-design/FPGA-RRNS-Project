`timescale 1ns / 1ps

module decoder_3nrm_mld_optimized (
    input wire clk,
    input wire rst_n,          
    input wire start,           
    input wire [63:0] residues_in, 
    
    output reg [15:0] data_out,   
    output reg valid,
    output reg uncorrectable      
);

    // ------------------------------------------------------------------
    // 1. 参数与余数提取
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
    // 2. 状态机定义
    // ------------------------------------------------------------------
    typedef enum logic [3:0] {
        ST_IDLE,      // 等待启动
        ST_LOAD,      // 加载当前组合索引
        ST_MRC,       // 计算 MRC (组合逻辑，结果存入寄存器)
        ST_DIST_INIT, // 初始化距离累加器
        ST_DIST_CALC, // 循环计算 9 个距离 (9 个周期)
        ST_UPDATE,    // 更新最小值
        ST_NEXT,      // 准备下一个组合
        ST_DONE       // 完成所有 84 组，输出结果
    } state_t;

    state_t state, next_state;

    // 计数器与寄存器
    reg [6:0] combo_idx;      // 0-83
    reg [2:0] i_idx, j_idx, k_idx; // 当前组合的三个下标
    reg [3:0] dist_idx;       // 0-8 (距离计算进度)
    
    reg [17:0] current_x_reg; // 锁存 MRC 结果
    reg [3:0] current_dist_acc; // 累加的距离
    reg [3:0] min_dist_reg;   // 全局最小距离
    reg [17:0] best_val_reg;  // 全局最佳值
    
    wire [17:0] mrc_result;   // MRC 单元实时输出

    // ------------------------------------------------------------------
    // 3. 组合索引解码 (纯组合逻辑，将 0-83 映射为 i,j,k)
    // ------------------------------------------------------------------
    // 为了时序安全，这里使用简单的组合逻辑解码
    always @(*) begin
        integer count, x, y, z;
        count = 0;
        i_idx = 0; j_idx = 1; k_idx = 2; // Default
        for(x=0; x<7; x=x+1) begin
            for(y=x+1; y<8; y=y+1) begin
                for(z=y+1; z<9; z=z+1) begin
                    if (count == combo_idx) begin
                        i_idx = x; j_idx = y; k_idx = z;
                        return; // 找到即返回
                    end
                    count = count + 1;
                end
            end
        end
    end

    // ------------------------------------------------------------------
    // 4. 单通道 MRC 计算单元 (组合逻辑)
    // ------------------------------------------------------------------
    wire [6:0] m1 = MODS[i_idx];
    wire [6:0] m2 = MODS[j_idx];
    wire [6:0] m3 = MODS[k_idx];
    wire [6:0] r1 = r[i_idx];
    wire [6:0] r2 = r[j_idx];
    wire [6:0] r3 = r[k_idx];
    
    mrc_unit u_mrc_single (
        .r1(r1), .m1(m1),
        .r2(r2), .m2(m2),
        .r3(r3), .m3(m3),
        .x_out(mrc_result)
    );

    // ------------------------------------------------------------------
    // 5. 单步距离计算逻辑 (每个周期算 1 个模)
    // ------------------------------------------------------------------
    wire [6:0] calc_r_step = current_x_reg % MODS[dist_idx];
    wire [3:0] diff_step = (calc_r_step != r[dist_idx]) ? 4'd1 : 4'd0;
    wire [3:0] next_dist_acc = current_dist_acc + diff_step;

    // ------------------------------------------------------------------
    // 6. 主状态机 (时序逻辑)
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
            combo_idx <= 0;
            min_dist_reg <= 4'd10;
            best_val_reg <= 0;
            valid <= 0;
            uncorrectable <= 0;
            data_out <= 0;
            current_dist_acc <= 0;
            dist_idx <= 0;
        end else begin
            state <= next_state;
            valid <= 0;
            uncorrectable <= 0;

            case (state)
                ST_IDLE: begin
                    if (start) begin
                        combo_idx <= 0;
                        min_dist_reg <= 4'd10; // 【修复】每次启动重置最小值
                        best_val_reg <= 0;
                        state <= ST_LOAD;
                    end
                end

                ST_LOAD: begin
                    // 索引已在组合逻辑解码好，直接进入 MRC 计算
                    state <= ST_MRC;
                end

                ST_MRC: begin
                    // 锁存 MRC 结果，避免组合逻辑毛刺
                    current_x_reg <= mrc_result;
                    current_dist_acc <= 0;
                    dist_idx <= 0;
                    state <= ST_DIST_INIT;
                end

                ST_DIST_INIT: begin
                    dist_idx <= 0;
                    current_dist_acc <= 0;
                    state <= ST_DIST_CALC;
                end

                ST_DIST_CALC: begin
                    // 累加当前位的距离
                    current_dist_acc <= next_dist_acc;
                    
                    if (dist_idx == 3'd8) begin
                        // 9 个模都算完了
                        state <= ST_UPDATE;
                    end else begin
                        dist_idx <= dist_idx + 1;
                        // 保持在 ST_DIST_CALC 继续算下一位
                    end
                end

                ST_UPDATE: begin
                    // 比较并更新最小值
                    if (current_dist_acc < min_dist_reg) begin
                        min_dist_reg <= current_dist_acc;
                        best_val_reg <= current_x_reg;
                    end
                    state <= ST_NEXT;
                end

                ST_NEXT: begin
                    if (combo_idx == 7'd83) begin
                        state <= ST_DONE;
                    end else begin
                        combo_idx <= combo_idx + 1;
                        state <= ST_LOAD;
                    end
                end

                ST_DONE: begin
                    // 输出判决
                    if (min_dist_reg <= 3 && best_val_reg < 18'd65536) begin
                        data_out <= best_val_reg[15:0];
                        valid <= 1;
                    end else begin
                        uncorrectable <= 1;
                        valid <= 1;
                        data_out <= 0;
                    end
                    state <= ST_IDLE;
                end
                
                default: state <= ST_IDLE;
            endcase
        end
    end
    
    // 次态逻辑 (可选，也可合并到上面)
    always @(*) begin
        next_state = state; // Default
        case (state)
            ST_IDLE: if (start) next_state = ST_LOAD;
            ST_LOAD: next_state = ST_MRC;
            ST_MRC: next_state = ST_DIST_INIT;
            ST_DIST_INIT: next_state = ST_DIST_CALC;
            ST_DIST_CALC: if (dist_idx == 3'd8) next_state = ST_UPDATE;
            ST_UPDATE: next_state = ST_NEXT;
            ST_NEXT: if (combo_idx == 7'd83) next_state = ST_DONE; else next_state = ST_LOAD;
            ST_DONE: next_state = ST_IDLE;
        endcase
    end

    // ------------------------------------------------------------------
    // 7. MRC 子模块 (含逆元表)
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

        // --- Python 生成的逆元表 (请确保填入完整的 72 项) ---
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