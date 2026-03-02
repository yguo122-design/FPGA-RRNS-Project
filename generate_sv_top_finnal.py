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

output_filename = 'decoder_3nrm_mld.sv'

print(f"正在生成最终的 SystemVerilog 顶层模块 (包含 {len(combinations)} 个独立实例)...")

with open(output_filename, 'w') as f:
    f.write("`timescale 1ns / 1ps\n\n")
    f.write("// =============================================================================\n")
    f.write("// Module: decoder_3nrm_mld\n")
    f.write("// Format: SystemVerilog (.sv)\n")
    f.write("// Strategy: Flat instantiation connecting to SV Unpacked Arrays\n")
    f.write("//           NO generate loop for instances (due to unique parameters)\n")
    f.write("// =============================================================================\n\n")

    # 1. 模块端口
    f.write("module decoder_3nrm_mld (\n")
    f.write("    input wire clk,\n")
    f.write("    input wire rst_n,\n")
    f.write("    input wire start,\n")
    f.write("    input wire [62:0] residues_in,\n")
    f.write("    output logic [19:0] data_out,\n")
    f.write("    output logic valid,\n")
    f.write("    output logic uncorrectable\n")
    f.write(");\n\n")

    # 2. 输入解包
    f.write("    // --- Input Unpacking ---\n")
    f.write("    logic [5:0] r0 = residues_in[62:57];\n")
    f.write("    logic [5:0] r1 = residues_in[55:50];\n")
    f.write("    logic [6:0] r2 = residues_in[48:42];\n")
    f.write("    logic [4:0] r3 = residues_in[41:37];\n")
    f.write("    logic [4:0] r4 = residues_in[36:32];\n")
    f.write("    logic [4:0] r5 = residues_in[31:27];\n")
    f.write("    logic [4:0] r6 = residues_in[26:22];\n")
    f.write("    logic [4:0] r7 = residues_in[21:17];\n")
    f.write("    logic [3:0] r8 = residues_in[16:13];\n\n")

    # 3. 定义 Unpacked Arrays
    f.write("    // --- Channel Signal Arrays (SystemVerilog Unpacked Arrays) ---\n")
    f.write("    logic [19:0] chan_x [0:83];\n")
    f.write("    logic [15:0] chan_dist [0:83];\n\n")

    # 4. 实例化 84 个通道 (平铺展开，无 generate 循环)
    f.write("    // --- 84 Channel Instances (Unique Parameters, Array Connections) ---\n")
    
    for idx, (i_idx, j_idx, k_idx) in enumerate(combinations):
        m1, m2, m3 = mods[i_idx], mods[j_idx], mods[k_idx]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]: 
            raise ValueError(f"Inverse calculation error at index {idx}")

        f.write(f"    channel_unit #(\n")
        f.write(f"        .P_MI0(20'd{Mi1}), .P_MI1(20'd{Mi2}), .P_MI2(20'd{Mi3}),\n")
        f.write(f"        .P_INV0(20'd{inv1}), .P_INV1(20'd{inv2}), .P_INV2(20'd{inv3}),\n")
        f.write(f"        .P_M_TOTAL(20'd{M_total}),\n")
        f.write(f"        .P_IDX1(4'd{i_idx}), .P_IDX2(4'd{j_idx}), .P_IDX3(4'd{k_idx})\n")
        f.write(f"    ) u_channel_{idx} (\n")
        f.write(f"        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        # 关键：直接连接数组的第 idx 个元素
        f.write(f"        .x_out(chan_x[{idx}]),\n")
        f.write(f"        .dist_out(chan_dist[{idx}])\n")
        f.write(f"    );\n\n")

    # 5. 最小值查找 (使用 SV for 循环)
    f.write("    // --- Min Distance Finder (Native SV For-Loop) ---\n")
    f.write("    logic [15:0] min_dist;\n")
    f.write("    logic [6:0]  min_idx;\n\n")
    
    f.write("    always_comb begin\n")
    f.write("        min_dist = 16'hFFFF;\n")
    f.write("        min_idx  = 7'd0;\n")
    f.write("        for (int k = 0; k < 84; k++) begin\n")
    f.write("            if (chan_dist[k] < min_dist) begin\n")
    f.write("                min_dist = chan_dist[k];\n")
    f.write("                min_idx  = k[6:0];\n")
    f.write("            end\n")
    f.write("        end\n")
    f.write("    end\n\n")

    # 6. 输出逻辑
    f.write("    // --- Output Register ---\n")
    f.write("    always_ff @(posedge clk or negedge rst_n) begin\n")
    f.write("        if (!rst_n) begin\n")
    f.write("            data_out      <= 20'd0;\n")
    f.write("            valid         <= 1'b0;\n")
    f.write("            uncorrectable <= 1'b0;\n")
    f.write("        end else if (start) begin\n")
        # 关键：SV 支持直接用变量索引访问数组
    f.write("            data_out      <= chan_x[min_idx];\n")
    f.write("            valid         <= 1'b1;\n")
    f.write("            uncorrectable <= (min_dist > 16'd100);\n")
    f.write("        end\n")
    f.write("    end\n\n")

    f.write("endmodule\n")

print(f"✅ 成功！完整的 SystemVerilog 代码已生成到 '{output_filename}'")
print("\n👉 关键检查清单:")
print("1. 确保项目中只有 .sv 文件 (decoder_3nrm_mld.sv, channel_unit.sv, tb_loopback_3nrm.sv)。")
print("2. 在 Vivado 中右键这些文件 -> File Properties -> File Type 选 'SystemVerilog'。")
print("3. 删除旧的 .v 文件和 .sim 文件夹。")
print("4. 运行仿真。")