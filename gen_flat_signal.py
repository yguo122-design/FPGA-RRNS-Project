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

output_filename = 'decoder_flat_signals.v'

with open(output_filename, 'w') as f:
    f.write("// --- Part 1: Signal Declarations (84 Independent Wires) ---\n")
    
    # 生成声明：wire [19:0] chan_x_0, chan_x_1, ...;
    f.write("wire [19:0] ")
    for idx in range(84):
        f.write(f"chan_x_{idx}" + (", " if idx < 83 else ";\n"))
        
    f.write("wire [15:0] ")
    for idx in range(84):
        f.write(f"chan_dist_{idx}" + (", " if idx < 83 else ";\n"))
    
    f.write("\n// --- Part 2: Module Instantiations ---\n")
    
    for idx, (i, j, k) in enumerate(combinations):
        m1, m2, m3 = mods[i], mods[j], mods[k]
        Mi1, Mi2, Mi3 = m2*m3, m1*m3, m1*m2
        M_total = m1*m2*m3
        inv1 = mod_inverse(Mi1 % m1, m1)
        inv2 = mod_inverse(Mi2 % m2, m2)
        inv3 = mod_inverse(Mi3 % m3, m3)
        
        if None in [inv1, inv2, inv3]: raise ValueError(f"Inv error at {idx}")

        f.write(f"        channel_unit #(\n")
        f.write(f"            .P_MI0(20'd{Mi1}), .P_MI1(20'd{Mi2}), .P_MI2(20'd{Mi3}),\n")
        f.write(f"            .P_INV0(20'd{inv1}), .P_INV1(20'd{inv2}), .P_INV2(20'd{inv3}),\n")
        f.write(f"            .P_M_TOTAL(20'd{M_total}),\n")
        f.write(f"            .P_IDX1(4'd{i}), .P_IDX2(4'd{j}), .P_IDX3(4'd{k})\n")
        f.write(f"        ) u_channel_{idx} (\n")
        f.write(f"            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),\n")
        # 【关键修改】直接连接独立信号，不使用位切片
        f.write(f"            .x_out(chan_x_{idx}),\n")
        f.write(f"            .dist_out(chan_dist_{idx})\n")
        f.write(f"        );\n\n")

    f.write("// --- Part 3: Concatenation for Logic (Optional but recommended for uniform logic) ---\n")
    f.write("// Construct flat buses from independent wires for easier processing in find_min logic\n")
    f.write("wire [1679:0] chan_x_bus = {")
    for idx in range(83, -1, -1): # 高位在前，所以从 83 倒序到 0
        f.write(f"chan_x_{idx}" + (", " if idx > 0 else "};\n"))
        
    f.write("wire [1343:0] chan_dist_bus = {")
    for idx in range(83, -1, -1):
        f.write(f"chan_dist_{idx}" + (", " if idx > 0 else "};\n"))

print(f"✅ 生成完毕：{output_filename}")
print("请将生成的内容分别复制到 decoder_3nrm_mld.v 的对应位置。")