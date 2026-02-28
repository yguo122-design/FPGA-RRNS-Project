import random

# 配置参数
DEPTH = 10000       # 测试向量数量
WIDTH = 16          # 数据位宽
MAX_VAL = 65535     # 2^16 - 1 (Full range supported by 2NRM-RRNS per paper)
FILENAME = "test_vectors.coe"
REF_FILENAME = "golden_reference.txt"

print(f"Generating {DEPTH} random vectors in range [0, {MAX_VAL}]...")

# 生成随机数 (包含边界值 65532-65535)
vectors = [random.randint(0, MAX_VAL) for _ in range(DEPTH)]

# 确保包含一些边界测试用例 (可选，增加覆盖率)
# 强制插入几个最大值，防止纯随机没抽到
vectors[0] = 0
vectors[1] = 65535
vectors[2] = 65532
vectors[3] = 65533

# 1. 生成 Golden Reference
with open(REF_FILENAME, "w") as f:
    for v in vectors:
        f.write(f"{v}\n")

# 2. 生成 Xilinx COE 文件
with open(FILENAME, "w") as f:
    f.write("memory_initialization_radix=10;\n")
    f.write("memory_initialization_vector=\n")
    coe_content = ",".join(map(str, vectors))
    f.write(coe_content)
    f.write(";\n")

print(f"✅ Success! Created '{FILENAME}' and '{REF_FILENAME}'.")
print(f"💡 Note: Includes full 16-bit range (0-65535).")