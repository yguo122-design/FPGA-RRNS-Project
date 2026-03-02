import itertools

def extended_gcd(a, b):
    if a == 0: return b, 0, 1
    gcd, x1, y1 = extended_gcd(b % a, a)
    x = y1 - (b // a) * x1
    y = x1
    return gcd, x, y

def mod_inverse(a, m):
    gcd, x, y = extended_gcd(a % m, m)
    if gcd != 1: return None
    else: return (x % m + m) % m

mods = [64, 63, 65, 31, 29, 23, 19, 17, 11]
n = len(mods)
combinations = list(itertools.combinations(range(n), 3))

# --- 配置：只取前 21 个通道进行验证 ---
group_size = 21
group_data = combinations[:group_size]
print(f"正在生成验证用的单组模块 (包含 {len(group_data)} 个通道)...")

# 1. 生成 decoder_group_0.v
filename = 'decoder_group_0.v'
with open(filename, 'w') as f:
    f.write("`timescale 1ns / 1ps\n\n")
    f.write(f"// Module: decoder_group_0 (Verification Version)\n")
    f.write(f"// Channels: 0 to {len(group_data)-1}\n\n")
    
    f.write(f"module decoder_group_0 (\n")
    f.write(f"    input wire [6:0] r0, input wire [6:0] r1, input wire [6:0] r2,\n")
    f.write(f"    input wire [6:0] r3, input wire [6:0] r4, input wire [6:0] r5,\n")
    f.write(f"    input wire [6:0] r6, input wire [6:0] r7, input wire [6:0] r8,\n")
    f.write(f"    output wire [15:0] min_dist_out,\n")
    f.write(f"    output wire [6:0] min_idx_out,\n")
    f.write(f"    output wire [19:0] best_x_out\n")
    f.write(f");\n\n")
    
    # 信号声明
    f.write("    wire [19:0] ")
    for i in range(len(group_data)):
        f.write(f"chan_x_{i}" + (", " if i < len(group_data)-1 else ";\n"))
    f.write("    wire [15:0] ")
    for i in range(len(group_data)):
        f.write(f"chan_dist_{i}" + (", " if i < len(group_data)-1 else ";\n"))
    f.write("\n")
    
    # 实例化
    for local_idx, (i, j, k) in enumerate(group_data):
        m1, m2, m3 = mods[i], mods[j], mods[k]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        f.write(f"    channel_unit #(\n")
        f.write(f"        .P_MI0(20'd{Mi1}), .P_MI1(20'd{Mi2}), .P_MI2(20'd{Mi3}),\n")
        f.write(f"        .P_INV0(20'd{inv1}), .P_INV1(20'd{inv2}), .P_INV2(20'd{inv3}),\n")
        f.write(f"        .P_M_TOTAL(20'd{M_total}),\n")
        f.write(f"        .P_IDX1(4'd{i}), .P_IDX2(4'd{j}), .P_IDX3(4'd{k})\n")
        f.write(f"    ) u_channel_{local_idx} (\n")
        f.write(f"        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        f.write(f"        .x_out(chan_x_{local_idx}),\n")
        f.write(f"        .dist_out(chan_dist_{local_idx})\n")
        f.write(f"    );\n\n")
    
    # 局部最小值查找
    f.write("    reg [15:0] min_dist_reg;\n")
    f.write("    reg [6:0] min_idx_reg;\n")
    f.write("    always @(*) begin\n")
    f.write("        min_dist_reg = 16'hFFFF;\n")
    f.write("        min_idx_reg = 7'd0;\n")
    for local_idx in range(len(group_data)):
        f.write(f"        if (chan_dist_{local_idx} < min_dist_reg) begin\n")
        f.write(f"            min_dist_reg = chan_dist_{local_idx};\n")
        f.write(f"            min_idx_reg = 7'd{local_idx};\n")
        f.write(f"        end\n")
    f.write("    end\n")
    f.write("    assign min_dist_out = min_dist_reg;\n")
    f.write("    assign min_idx_out = min_idx_reg;\n")
    
    # 输出最佳 X
    f.write("    reg [19:0] best_x_reg;\n")
    f.write("    always @(*) begin\n")
    f.write("        case(min_idx_reg)\n")
    for local_idx in range(len(group_data)):
        f.write(f"            7'd{local_idx}: best_x_reg = chan_x_{local_idx};\n")
    f.write("            default: best_x_reg = 20'd0;\n")
    f.write("        endcase\n")
    f.write("    end\n")
    f.write("    assign best_x_out = best_x_reg;\n")
    f.write("\nendmodule\n")

print(f"✅ 生成：{filename}")

# 2. 生成临时顶层 decoder_top_test.v (用于快速验证)
top_filename = 'decoder_top_test.v'
with open(top_filename, 'w') as f:
    f.write("`timescale 1ns / 1ps\n\n")
    f.write("// Temporary Top Module for Verification (Only Group 0)\n")
    f.write("module decoder_top_test (\n")
    f.write("    input wire clk, input wire rst_n, input wire start,\n")
    f.write("    input wire [62:0] residues_in,\n")
    f.write("    output reg [19:0] data_out, output reg valid, output reg uncorrectable\n")
    f.write(");\n\n")
    
    # 解包逻辑 (简化版，复用之前的逻辑)
    f.write("    wire [6:0] r0 = {1'd0, residues_in[62:57]};\n")
    f.write("    wire [6:0] r1 = {1'd0, residues_in[55:50]};\n")
    f.write("    wire [6:0] r2 = residues_in[48:42];\n")
    f.write("    wire [6:0] r3 = {2'd0, residues_in[41:37]};\n")
    f.write("    wire [6:0] r4 = {2'd0, residues_in[36:32]};\n")
    f.write("    wire [6:0] r5 = {2'd0, residues_in[31:27]};\n")
    f.write("    wire [6:0] r6 = {2'd0, residues_in[26:22]};\n")
    f.write("    wire [6:0] r7 = {2'd0, residues_in[21:17]};\n")
    f.write("    wire [6:0] r8 = {3'd0, residues_in[16:13]};\n\n")
    
    # 实例化单个组
    f.write("    wire [15:0] g0_dist;\n")
    f.write("    wire [6:0] g0_idx;\n")
    f.write("    wire [19:0] g0_x;\n")
    f.write("    decoder_group_0 u_group0 (\n")
    f.write("        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
    f.write("        .min_dist_out(g0_dist), .min_idx_out(g0_idx), .best_x_out(g0_x)\n")
    f.write("    );\n\n")
    
    # 输出逻辑
    f.write("    always @(posedge clk or negedge rst_n) begin\n")
    f.write("        if (!rst_n) begin\n")
    f.write("            data_out <= 20'd0; valid <= 1'b0; uncorrectable <= 1'b0;\n")
    f.write("        end else if (start) begin\n")
    f.write("            data_out <= g0_x;\n")
    f.write("            valid <= 1'b1;\n")
    f.write("            uncorrectable <= (g0_dist > 16'd100) ? 1'b1 : 1'b0;\n")
    f.write("        end\n")
    f.write("    end\n")
    f.write("endmodule\n")

print(f"✅ 生成：{top_filename}")
print("\n👉 下一步操作:")
print("1. 将 decoder_group_0.v 和 decoder_top_test.v 加入 Vivado 工程。")
print("2. 修改仿真文件 tb_loopback_3nrm.v 的实例化对象为 decoder_top_test。")
print("3. 运行仿真。如果通过，说明 21 通道方案可行！我们将立即生成完整版。")