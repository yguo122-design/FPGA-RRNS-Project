import itertools

# ==========================================
# 1. 定义辅助函数 (保持不变)
# ==========================================
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

# ==========================================
# 2. 定义模数与组合
# ==========================================
mods = [64, 63, 65, 31, 29, 23, 19, 17, 11]
n = len(mods)
combinations = list(itertools.combinations(range(n), 3))

output_filename = 'channel_instantiations_flat.v'

with open(output_filename, 'w') as f:
    f.write("// --- Auto-generated Channel Instantiations (FLAT BUS VERSION) ---\n")
    f.write("// Connects to chan_x_bus and chan_dist_bus using bit-slicing\n\n")
    
    for idx, (i, j, k) in enumerate(combinations):
        m1, m2, m3 = mods[i], mods[j], mods[k]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]: 
            raise ValueError(f"Inverse calculation error at index {idx}")

        # 计算位切片的起始位置
        # chan_x: 每个通道 20 位
        # chan_dist: 每个通道 16 位
        x_start = idx * 20
        d_start = idx * 16

        # 生成实例化代码
        f.write(f"        channel_unit #(\n")
        f.write(f"            .P_MI0(20'd{Mi1}), .P_MI1(20'd{Mi2}), .P_MI2(20'd{Mi3}),\n")
        f.write(f"            .P_INV0(20'd{inv1}), .P_INV1(20'd{inv2}), .P_INV2(20'd{inv3}),\n")
        f.write(f"            .P_M_TOTAL(20'd{M_total}),\n")
        f.write(f"            .P_IDX1(4'd{i}), .P_IDX2(4'd{j}), .P_IDX3(4'd{k})\n")
        f.write(f"        ) u_channel_{idx} (\n")
        f.write(f"            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        # 【关键修改】使用位切片语法 [start +: width] 连接到大总线
        f.write(f"            .x_out(chan_x_bus[{x_start} +: 20]),\n")
        f.write(f"            .dist_out(chan_dist_bus[{d_start} +: 16])\n")
        f.write(f"        );\n\n")

print(f"✅ 成功！扁平化实例化代码已生成到 '{output_filename}'")
print(f"   请复制内容替换 decoder_3nrm_mld.v 中 generate 块的内容。")