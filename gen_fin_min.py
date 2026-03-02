# 追加生成 find_min 逻辑
with open('find_min_logic.v', 'w') as f:
    f.write("// --- Part 4: Static Unrolled Min Finder (No Loops, No Dynamic Slicing) ---\n")
    f.write("always @(*) begin : find_min_static\n")
    f.write("    min_dist = 16'hFFFF;\n")
    f.write("    min_idx = 7'd0;\n\n")
    
    # 生成 84 个 if 判断
    for idx in range(84):
        f.write(f"    if (chan_dist_{idx} < min_dist) begin\n")
        f.write(f"        min_dist = chan_dist_{idx};\n")
        f.write(f"        min_idx = 7'd{idx};\n")
        f.write(f"    end\n")
    
    f.write("end\n")
    
    # 同样处理 data_out 的选择
    f.write("\n// --- Part 5: Static Output Mux ---\n")
    f.write("always @(posedge clk or negedge rst_n) begin\n")
    f.write("    if (!rst_n) begin\n")
    f.write("        data_out <= 20'd0;\n")
    f.write("        valid <= 1'b0;\n")
    f.write("        uncorrectable <= 1'b0;\n")
    f.write("    end else if (start) begin\n")
    f.write("        // Static Mux for data_out\n")
    f.write("        case(min_idx)\n")
    for idx in range(84):
        f.write(f"            7'd{idx}: data_out <= chan_x_{idx};\n")
    f.write("            default: data_out <= 20'd0;\n")
    f.write("        endcase\n")
    f.write("        valid <= 1'b1;\n")
    f.write("        uncorrectable <= (min_dist > 16'd100) ? 1'b1 : 1'b0;\n")
    f.write("    end\n")
    f.write("end\n")

print("✅ find_min 逻辑已生成到 find_min_logic.v")