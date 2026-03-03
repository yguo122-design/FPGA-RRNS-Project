import math

# 模数定义
mods = [64, 63, 65, 31, 29, 23, 19, 17, 11]

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
        raise Exception('Modular inverse does not exist')
    else:
        return (x % m + m) % m

print("// 复制以下内容替换 decoder_3nrm_mld.sv 中的 case (calc_idx) 块")
print("case (calc_idx)")

indices = []
for i in range(9):
    for j in range(i+1, 9):
        for k in range(j+1, 9):
            indices.append((i, j, k))

for idx, (i, j, k) in enumerate(indices):
    m0, m1, m2 = mods[i], mods[j], mods[k]
    M_total = m0 * m1 * m2
    
    mi0 = m1 * m2
    mi1 = m0 * m2
    mi2 = m0 * m1
    
    inv0 = mod_inverse(mi0, m0)
    inv1 = mod_inverse(mi1, m1)
    inv2 = mod_inverse(mi2, m2)
    
    print(f"            {idx}: begin // Indices: {i}, {j}, {k} (Mods: {m0}, {m1}, {m2})")
    print(f"                {{idx_a, idx_b, idx_c}} = {{2'd{i}, 2'd{j}, 2'd{k}}};")
    print(f"                cur_mi0   = 20'd{mi0}; cur_inv0 = 20'd{inv0};")
    print(f"                cur_mi1   = 20'd{mi1}; cur_inv1 = 20'd{inv1};")
    print(f"                cur_mi2   = 20'd{mi2}; cur_inv2 = 20'd{inv2};")
    print(f"                cur_m_total = 20'd{M_total};")
    print(f"            end")
    if idx < 83:
        print("")

print("            default: begin")
print("                {idx_a, idx_b, idx_c} = {2'd0, 2'd1, 2'd2};")
print("                cur_mi0 = 20'd4095; cur_inv0 = 20'd63;")
print("                cur_mi1 = 20'd4160; cur_inv1 = 20'd2;")
print("                cur_mi2 = 20'd4032; cur_inv2 = 20'd33;")
print("                cur_m_total = 20'd262080;")
print("            end")
print("        endcase")