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

print(f"正在生成 SystemVerilog 顶层模块 (包含 {len(combinations)} 个通道)...")

with open(output_filename, 'w') as f:
    f.write("`timescale 1ns / 1ps\n\n")
    f.write("// =============================================================================\n")
    f.write("// Module: decoder_3nrm_mld\n")
    f.write("// Format: SystemVerilog (.sv)\n")
    f.write("// Strategy: Use native SV arrays and loops to bypass XSim Verific bugs\n")
    f.write("// =============================================================================\n\n")

    # 1. 模块端口定义
    f.write("module decoder_3nrm_mld (\n")
    f.write("    input wire clk,\n")
    f.write("    input wire rst_n,\n")
    f.write("    input wire start,\n")
    f.write("    input wire [62:0] residues_in,\n")
    f.write("    output logic [19:0] data_out,\n")
    f.write("    output logic valid,\n")
    f.write("    output logic uncorrectable\n")
    f.write(");\n\n")

    # 2. 输入解包逻辑
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

    # 3. 定义 Unpacked Arrays (SV 核心特性)
    f.write("    // --- Channel Arrays (Native SystemVerilog Unpacked Arrays) ---\n")
    f.write("    logic [19:0] chan_x [0:83];\n")
    f.write("    logic [15:0] chan_dist [0:83];\n\n")

    # 4. Generate 块实例化
    f.write("    // --- Channel Instantiations (Generate Loop) ---\n")
    f.write("    genvar i;\n")
    f.write("    generate\n")
    f.write("        for (i = 0; i < 84; i = i + 1) begin : gen_channels\n")
    
    for idx, (i_idx, j_idx, k_idx) in enumerate(combinations):
        m1, m2, m3 = mods[i_idx], mods[j_idx], mods[k_idx]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]: 
            raise ValueError(f"Inverse error at index {idx}")

        # 注意：这里我们只生成参数部分，连接部分写在循环外面或者用宏？
        # 不，Python 直接生成完整的 84 个 if 分支或者 84 行代码是不对的，因为我们在 generate for 循环里。
        # 正确的做法是：generate for 循环只能用于结构相同的实例。
        # 但是我们的参数 (P_MI0 等) 每个都不同！
        # 所以：我们不能用简单的 generate for (i=0; i<84) 除非我们在循环内部用 case 或者巨大的参数映射。
        # 修正策略：由于每个实例参数不同，我们必须显式写出 84 行实例化代码，但连接到数组。
        # 或者：放弃 generate for 循环，直接平铺 84 行代码（这在 SV 中是完全合法的）。
        pass 

    # 修正：由于参数各不相同，无法使用单一的 generate for 循环体。
    # 我们必须让 Python 生成 84 行独立的实例化代码，直接放在 module 内部。
    # 这样最稳妥，也符合 SV 规范。
    
    f.write("        // Note: Parameters vary per instance, so we unroll manually but connect to arrays\n")
    
    # 重新生成：直接平铺 84 行
    # 删除刚才写的 generate for 开头
    # 实际上，我们可以保留 generate 块作为命名空间，但不写循环变量控制实例化
    
    # 让我们重写这部分逻辑：直接输出 84 行实例化
    pass

# 重新打开文件写入正确的逻辑
with open(output_filename, 'w') as f:
    f.write("`timescale 1ns / 1ps\n\n")
    f.write("// =============================================================================\n")
    f.write("// Module: decoder_3nrm_mld (SystemVerilog Version)\n")
    f.write("// =============================================================================\n\n")

    f.write("module decoder_3nrm_mld (\n")
    f.write("    input wire clk,\n")
    f.write("    input wire rst_n,\n")
    f.write("    input wire start,\n")
    f.write("    input wire [62:0] residues_in,\n")
    f.write("    output logic [19:0] data_out,\n")
    f.write("    output logic valid,\n")
    f.write("    output logic uncorrectable\n")
    f.write(");\n\n")

    # Inputs
    f.write("    logic [5:0] r0 = residues_in[62:57];\n")
    f.write("    logic [5:0] r1 = residues_in[55:50];\n")
    f.write("    logic [6:0] r2 = residues_in[48:42];\n")
    f.write("    logic [4:0] r3 = residues_in[41:37];\n")
    f.write("    logic [4:0] r4 = residues_in[36:32];\n")
    f.write("    logic [4:0] r5 = residues_in[31:27];\n")
    f.write("    logic [4:0] r6 = residues_in[26:22];\n")
    f.write("    logic [4:0] r7 = residues_in[21:17];\n")
    f.write("    logic [3:0] r8 = residues_in[16:13];\n\n")

    # Arrays
    f.write("    logic [19:0] chan_x [0:83];\n")
    f.write("    logic [15:0] chan_dist [0:83];\n\n")

    # Instances
    f.write("    // --- 84 Channel Instances (Connected to Arrays) ---\n")
    for idx, (i_idx, j_idx, k_idx) in enumerate(combinations):
        m1, m2, m3 = mods[i_idx], mods[j_idx], mods[k_idx]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        f.write(f"    channel_unit #(\n")
        f.write(f"        .P_MI0(20'd{Mi1}), .P_MI1(20'd{Mi2}), .P_MI2(20'd{Mi3}),\n")
        f.write(f"        .P_INV0(20'd{inv1}), .P_INV1(20'd{inv2}), .P_INV2(20'd{inv3}),\n")
        f.write(f"        .P_M_TOTAL(20'd{M_total}),\n")
        f.write(f"        .P_IDX1(4'd{i_idx}), .P_IDX2(4'd{j_idx}), .P_IDX3(4'd{k_idx})\n")
        f.write(f"    ) u_channel_{idx} (\n")
        f.write(f"        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        f.write(f"        .x_out(chan_x[{idx}]),\n")       # 关键：连接数组元素
        f.write(f"        .dist_out(chan_dist[{idx}])\n")  # 关键：连接数组元素
        f.write(f"    );\n\n")

    # Min Finder Logic (Simple For Loop)
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

    # Output Logic
    f.write("    // --- Output Register ---\n")
    f.write("    always_ff @(posedge clk or negedge rst_n) begin\n")
    f.write("        if (!rst_n) begin\n")
    f.write("            data_out      <= 20'd0;\n")
    f.write("            valid         <= 1'b0;\n")
    f.write("            uncorrectable <= 1'b0;\n")
    f.write("        end else if (start) begin\n")
    f.write("            data_out      <= chan_x[min_idx];  // Native SV Array Indexing\n")
    f.write("            valid         <= 1'b1;\n")
    f.write("            uncorrectable <= (min_dist > 16'd100);\n")
    f.write("        end\n")
    f.write("    end\n\n")

    f.write("endmodule\n")

print(f"✅ 成功！SystemVerilog 顶层代码已生成到 '{output_filename}'")
print("\n👉 下一步操作:")
print("1. 将 decoder_3nrm_mld.sv, channel_unit.sv, tb_loopback_3nrm.sv 加入工程。")
print("2. 确保所有 .sv 文件的 File Type 设置为 'SystemVerilog'。")
print("3. 删除旧的 .v 文件。")
print("4. 删除 .sim 文件夹，重新运行仿真。")