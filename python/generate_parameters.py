import itertools

def extended_gcd(a, b):
    if a == 0:
        return b, 0, 1
    gcd, x1, y1 = extended_gcd(b % a, a)
    x = y1 - (b // a) * x1
    y = x1
    return gcd, x, y

def mod_inverse(a, m):
    gcd, x, y = extended_gcd(a % m, m)
    if gcd != 1:
        return None
    else:
        return (x % m + m) % m

# ==========================================
# 1. 定义模数
# ==========================================
mods = [64, 63, 65, 31, 29, 23, 19, 17, 11]
n = len(mods)

# ==========================================
# 2. 生成所有组合 C(9,3)
# ==========================================
combinations = list(itertools.combinations(range(n), 3))

# ==========================================
# 3. 将输出重定向到文件
# ==========================================
# 这会生成一个名为 'generated_params.v' 的文件
with open('generated_params.v', 'w') as f:
    
    # 写入头部定义
    f.write(f"// --- 自动生成的参数和Case语句 ---\n")
    f.write(f"// --- 共 {len(combinations)} 组组合 ---\n")
    f.write(f"`define COMB_COUNT 84\n")
    f.write("\n")
    
    # ==========================================
    # 4. 生成 Verilog Parameters (第一部分)
    # ==========================================
    f.write("// --- 1. CRT 常量定义 (复制到这里) ---\n")
    for idx, (i, j, k) in enumerate(combinations):
        m1, m2, m3 = mods[i], mods[j], mods[k]
        M = m1 * m2 * m3
        Mi1 = m2 * m3
        Mi2 = m1 * m3
        Mi3 = m1 * m2
        
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]:
            raise ValueError(f"Inverse calculation error for combination {idx}")

        # 写入文件而不是打印到屏幕
        f.write(f"    localparam [19:0] MI1_{idx} = {Mi1};\n")
        f.write(f"    localparam [19:0] MI2_{idx} = {Mi2};\n")
        f.write(f"    localparam [19:0] MI3_{idx} = {Mi3};\n")
        f.write(f"    localparam [19:0] INV1_{idx} = {inv1};\n")
        f.write(f"    localparam [19:0] INV2_{idx} = {inv2};\n")
        f.write(f"    localparam [19:0] INV3_{idx} = {inv3};\n")
        f.write(f"    localparam [6:0] M1_{idx} = {m1};\n")
        f.write(f"    localparam [6:0] M2_{idx} = {m2};\n")
        f.write(f"    localparam [6:0] M3_{idx} = {m3};\n")
        f.write(f"    localparam [3:0] IDX1_{idx} = {i};\n")
        f.write(f"    localparam [3:0] IDX2_{idx} = {j};\n")
        f.write(f"    localparam [3:0] IDX3_{idx} = {k};\n")
        f.write("\n") # 每组参数后空一行便于阅读

    # ==========================================
    # 5. 生成 Verilog Case Statements (第二部分)
    # ==========================================
    f.write("// --- 2. Case 语句生成 (复制到这里) ---\n")
    for idx, (i, j, k) in enumerate(combinations):
        case_block = f"""                {idx}: begin
                    Mi0 = MI1_{idx}; Mi1 = MI2_{idx}; Mi2 = MI3_{idx};
                    inv0 = INV1_{idx}; inv1 = INV2_{idx}; inv2 = INV3_{idx};
                    r_a = get_residue(IDX1_{idx});
                    r_b = get_residue(IDX2_{idx});
                    r_c = get_residue(IDX3_{idx});
                    M_total = M1_{idx} * M2_{idx} * M3_{idx};
                end"""
        f.write(case_block)
        
        if idx < len(combinations) - 1:
            f.write("\n")

    f.write("\n// --- 生成完毕 ---\n")

print("✅ 参数生成完成！请打开 'generated_params.v' 文件并复制内容。")