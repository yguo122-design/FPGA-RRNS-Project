`timescale 1ns / 1ps

module decoder_3nrm_mld_final_v2 (
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
    // 注意：这里只用于输入解包，不参与模运算
    wire [6:0] r [0:8];
    assign r[0] = {1'b0, residues_in[63:58]}; // Mod 64
    assign r[1] = {1'b0, residues_in[57:52]}; // Mod 63
    assign r[2] =        residues_in[51:45];  // Mod 65
    assign r[3] = {2'b0, residues_in[44:40]}; // Mod 31
    assign r[4] = {2'b0, residues_in[39:35]}; // Mod 29
    assign r[5] = {2'b0, residues_in[34:30]}; // Mod 23
    assign r[6] = {2'b0, residues_in[29:25]}; // Mod 19
    assign r[7] = {2'b0, residues_in[24:20]}; // Mod 17
    assign r[8] = {3'b0, residues_in[19:16]}; // Mod 11

    // ------------------------------------------------------------------
    // 2. 状态机定义
    // ------------------------------------------------------------------
    typedef enum logic [3:0] {
        ST_IDLE,      
        ST_LOAD,      
        ST_MRC,       
        ST_DIST_INIT, 
        ST_DIST_CALC, 
        ST_UPDATE,    
        ST_NEXT,      
        ST_DONE       
    } state_t;

    state_t state, next_state;

    // 控制信号
    reg [6:0] combo_idx;      // 0-83
    reg [2:0] i_idx, j_idx, k_idx; 
    reg [3:0] dist_idx;       // 0-8 (当前计算第几个模的距离)
    
    // 数据寄存器
    reg [17:0] current_x_reg; // 锁存 MRC 结果
    reg [3:0] current_dist_acc; 
    reg [3:0] min_dist_reg;   
    reg [17:0] best_val_reg;  
    
    wire [17:0] mrc_result;
    wire [6:0]  mod_result;   // 来自 mod_unit 的结果

    // ------------------------------------------------------------------
    // 3. 组合索引解码 (纯组合逻辑)
    // ------------------------------------------------------------------
    always @(*) begin
        integer count, x, y, z;
        count = 0;
        i_idx = 0; j_idx = 1; k_idx = 2; 
        for(x=0; x<7; x=x+1) begin
            for(y=x+1; y<8; y=y+1) begin
                for(z=y+1; z<9; z=z+1) begin
                    if (count == combo_idx) begin
                        i_idx = x; j_idx = y; k_idx = z;
                        return; 
                    end
                    count = count + 1;
                end
            end
        end
    end

    // ------------------------------------------------------------------
    // 4. 单通道 MRC 计算单元 (保持不变，含逆元表)
    // ------------------------------------------------------------------
    // 模数常量 (仅供 MRC 使用)
    localparam logic [6:0] MODS [0:8] = '{7'd64, 7'd63, 7'd65, 7'd31, 7'd29, 7'd23, 7'd19, 7'd17, 7'd11};

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
    // 5. 优化的模运算单元 (无除法，无 DSP)
    // ------------------------------------------------------------------
    // 输入：current_x_reg (候选值)
    // 选择：dist_idx (0-8 对应 9 个模数)
    mod_unit u_mod_calc (
        .x({14'd0, current_x_reg}), // 扩展到 32 位以匹配 mod_unit
        .mod_sel(dist_idx),
        .mod_out(mod_result)
    );

    // 距离比较逻辑
    wire [3:0] diff_step = (mod_result != r[dist_idx]) ? 4'd1 : 4'd0;
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
                        min_dist_reg <= 4'd10; 
                        best_val_reg <= 0;
                        state <= ST_LOAD;
                    end
                end

                ST_LOAD: begin
                    state <= ST_MRC;
                end

                ST_MRC: begin
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
                    // 累加距离
                    current_dist_acc <= next_dist_acc;
                    
                    if (dist_idx == 3'd8) begin
                        state <= ST_UPDATE;
                    end else begin
                        dist_idx <= dist_idx + 1;
                        // 保持在 ST_DIST_CALC
                    end
                end

                ST_UPDATE: begin
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
    
    // 次态逻辑
    always @(*) begin
        next_state = state; 
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

        // --- 逆元表 (请填入完整的 72 项) ---
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

    // ------------------------------------------------------------------
    // 8. 优化的模运算单元 (Mod Unit - 无除法)
    // ------------------------------------------------------------------
    module mod_unit (
        input  logic [31:0] x,
        input  logic [3:0]  mod_sel,   // 0~8
        output logic [6:0]  mod_out
    );
    
        // --- 内部函数声明 (基于 ChatGPT 优化版) ---

        function automatic [6:0] mod64(input logic [31:0] x);
            begin mod64 = x[5:0]; end
        endfunction

        function automatic [6:0] mod63(input logic [31:0] x);
            logic [11:0] sum1;
            logic [6:0]  sum2;
            begin
                sum1 = x[5:0]+x[11:6]+x[17:12]+x[23:18]+x[29:24]+{4'b0,x[31:30]};
                sum2 = sum1[5:0] + sum1[11:6];
                if (sum2 >= 63) mod63 = sum2 - 63;
                else            mod63 = sum2;
            end
        endfunction

        function automatic [6:0] mod65(input logic [31:0] x);
            logic signed [12:0] sum1;
            logic signed [7:0]  sum2;
            begin
                sum1 =  x[5:0] - x[11:6] + x[17:12]
                      - x[23:18] + x[29:24] - {4'b0,x[31:30]};
                sum2 = sum1[5:0] - sum1[11:6];
                if (sum2 < 0)    sum2 = sum2 + 65;
                if (sum2 >= 65)  mod65 = sum2 - 65;
                else             mod65 = sum2[6:0];
            end
        endfunction

        function automatic [5:0] mod31(input logic [31:0] x);
            logic [11:0] sum1;
            logic [5:0]  sum2;
            begin
                sum1 = x[4:0]+x[9:5]+x[14:10]+x[19:15]+
                       x[24:20]+x[29:25]+{3'b0,x[31:30]};
                sum2 = sum1[4:0] + sum1[9:5];
                if (sum2 >= 31) mod31 = sum2 - 31;
                else            mod31 = sum2;
            end
        endfunction

        function automatic [5:0] mod29(input logic [31:0] x);
            logic [10:0] temp;
            logic [6:0]  t2;
            begin
                temp = x[4:0] + 3*x[9:5] + 9*x[14:10] +
                       27*x[19:15] + 23*x[24:20] +
                       11*x[29:25] + 4*x[31:30];
                t2 = temp[6:0] + temp[10:7];
                if (t2 >= 29) t2 = t2 - 29;
                if (t2 >= 29) t2 = t2 - 29;
                mod29 = t2;
            end
        endfunction

        function automatic [5:0] mod23(input logic [31:0] x);
            logic [10:0] temp;
            logic [6:0]  t2;
            begin
                temp = x[4:0] + 9*x[9:5] + 12*x[14:10] +
                       16*x[19:15] + 6*x[24:20] +
                       8*x[29:25] + 3*x[31:30];
                t2 = temp[6:0] + temp[10:7];
                if (t2 >= 23) t2 = t2 - 23;
                if (t2 >= 23) t2 = t2 - 23;
                mod23 = t2;
            end
        endfunction

        function automatic [5:0] mod19(input logic [31:0] x);
            logic [10:0] temp;
            logic [6:0]  t2;
            begin
                temp = x[4:0] + 13*x[9:5] + 17*x[14:10] +
                       12*x[19:15] + 4*x[24:20] +
                       14*x[29:25] + 11*x[31:30];
                t2 = temp[6:0] + temp[10:7];
                if (t2 >= 19) t2 = t2 - 19;
                if (t2 >= 19) t2 = t2 - 19;
                mod19 = t2;
            end
        endfunction

        function automatic [4:0] mod17(input logic [31:0] x);
            logic signed [8:0] temp;
            begin
                temp = x[3:0] - x[7:4] + x[11:8] -
                       x[15:12] + x[19:16] -
                       x[23:20] + x[27:24] -
                       x[31:28];
                if (temp < 0) temp = temp + 17;
                if (temp >= 17) temp = temp - 17;
                mod17 = temp[4:0];
            end
        endfunction

        function automatic [3:0] mod11(input logic [31:0] x);
            logic signed [7:0] temp;
            begin
                temp = x[4:0]-x[9:5]+x[14:10]-x[19:15]
                      +x[24:20]-x[29:25]+x[31:30]; // 注意这里最高位处理，x[31:30] 可能需调整，但 x 只有 18 位有效，高位为 0，所以没问题
                if (temp < 0) temp = temp + 11;
                if (temp >= 11) temp = temp - 11;
                mod11 = temp[3:0];
            end
        endfunction

        // --- 主选择逻辑 ---
        always_comb begin
            case (mod_sel)
                4'd0: mod_out = {1'b0, mod64(x)};       // 输出 7 位，实际有效 6 位
                4'd1: mod_out = mod63(x);
                4'd2: mod_out = mod65(x);
                4'd3: mod_out = {1'b0, mod31(x)};       // 输出 7 位，实际有效 5 位
                4'd4: mod_out = {1'b0, mod29(x)};
                4'd5: mod_out = {1'b0, mod23(x)};
                4'd6: mod_out = {1'b0, mod19(x)};
                4'd7: mod_out = {2'b0, mod17(x)};       // 输出 7 位，实际有效 4 位
                4'd8: mod_out = {3'b0, mod11(x)};       // 输出 7 位，实际有效 4 位
                default: mod_out = 7'd0;
            endcase
        end
    endmodule

endmodule