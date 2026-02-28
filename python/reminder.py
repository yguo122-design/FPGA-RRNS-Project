vals = [0, 1, 100, 65535, 12345]
moduli = [64, 63, 65, 67, 71, 73, 79, 83, 89]

for v in vals:
    res = [v % m for m in moduli]
    # 格式化输出，方便直接复制到 Verilog
    print(f"apply_and_check(16'd{v}, ", end="")
    parts = []
    # 注意位宽分配：前两个是 6'd，后面都是 7'd
    for i, r in enumerate(res):
        width = "6" if i < 2 else "7"
        parts.append(f"{width}'d{r}")
    print(", ".join(parts) + ");")