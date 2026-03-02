import itertools

# ==========================================
# 1. 定义辅助函数
# ==========================================
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
# 2. 定义模数
# ==========================================
mods = [64, 63, 65, 31, 29, 23, 19, 17, 11]
n = len(mods)
combinations = list(itertools.combinations(range(n), 3))

output_filename = 'channel_instantiations.v'

with open(output_filename, 'w') as f:
    f.write("// --- Auto-generated Channel Instantiations ---\n")
    f.write("// Copy this content into the generate block of decoder_3nrm_mld.v\n\n")
    
    for idx, (i, j, k) in enumerate(combinations):
        m1, m2, m3 = mods[i], mods[j], mods[k]
        
        Mi1 = m2 * m3
        Mi2 = m1 * m3
        Mi3 = m1 * m2
        M_total = m1 * m2 * m3
        
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]:
            raise ValueError(f"Inverse error at idx {idx}")

        # 生成实例化代码
        # 注意：这里直接填入数值，避开数组索引问题
        f.write(f"        channel_unit #(\n")
        f.write(f"            .P_MI0      (20'd{Mi1}),\n")
        f.write(f"            .P_MI1      (20'd{Mi2}),\n")
        f.write(f"            .P_MI2      (20'd{Mi3}),\n")
        f.write(f"            .P_INV0     (20'd{inv1}),\n")
        f.write(f"            .P_INV1     (20'd{inv2}),\n")
        f.write(f"            .P_INV2     (20'd{inv3}),\n")
        f.write(f"            .P_M_TOTAL  (20'd{M_total}),\n")
        f.write(f"            .P_IDX1     (4'd{i}),\n")
        f.write(f"            .P_IDX2     (4'd{j}),\n")
        f.write(f"            .P_IDX3     (4'd{k})\n")
        f.write(f"        ) u_channel_{idx} (\n")
        f.write(f"            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        f.write(f"            .x_out(chan_x[{idx}]),\n")
        f.write(f"            .dist_out(chan_dist[{idx}])\n")
        f.write(f"        );\n\n")

print(f"✅ 成功！实例化代码已生成到 '{output_filename}'")
print(f"   请打开该文件，复制所有内容，替换 decoder_3nrm_mld.v 中 generate 块内的旧代码。")