#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
生成 3NRM Decoder 所需的模逆查找表 (Modular Inverse Lookup Table)
算法：扩展欧几里得或直接遍历 (因为模数很小)
目标：找到 x 使得 (a * x) % m == 1
"""

# 定义 9 个模数
moduli = [64, 63, 65, 31, 29, 23, 19, 17, 11]
names = ["64", "63", "65", "31", "29", "23", "19", "17", "11"]

def get_mod_inv(a, m):
    """计算 a 在模 m 下的逆元"""
    for x in range(1, m):
        if (a * x) % m == 1:
            return x
    return None

print("// ================================================================")
print("// 自动生成的模逆查找表 (Modular Inverse Lookup Table)")
print("// 格式：{{mx, my}}: result  (满足 mx * result ≡ 1 (mod my))")
print("// ================================================================")
print("case ({mx, my})")

count = 0
for i, mx in enumerate(moduli):
    for j, my in enumerate(moduli):
        if i == j:
            continue  # 跳过相同模数
        
        inv = get_mod_inv(mx, my)
        if inv is None:
            print(f"    // ERROR: No inverse for {mx} mod {my} (Not co-prime!)")
        else:
            # 输出 SystemVerilog case 项
            # 使用 7'd 格式以匹配 wire [6:0]
            print(f"    {{7'd{mx}, 7'd{my}}}: return 7'd{inv}; // {mx}^-1 mod {my}")
            count += 1

print("    default: return 7'd1; // Should not happen")
print("endcase")
print(f"// 总共生成 {count} 个查找项")