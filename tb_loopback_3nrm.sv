`timescale 1ns / 1ps

module tb_loopback_3nrm;

    // Inputs
    reg clk;
    reg rst_n;
    reg start;
    reg [62:0] residues_in;

    // Outputs
    wire [19:0] data_out;
    wire valid;
    wire uncorrectable;

    // Instantiate the Unit Under Test (UUT)
    decoder_3nrm_mld  uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .start(start), 
        .residues_in(residues_in), 
        .data_out(data_out), 
        .valid(valid), 
        .uncorrectable(uncorrectable)
    );

    // Clock generation (50MHz -> 20ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Test Sequence
    integer i;
    reg [19:0] expected_data;
    
    // Helper task to pack residues into the 63-bit vector
    // Mapping: [62:57]r0, [55:50]r1, [48:42]r2, [41:37]r3, [36:32]r4, [31:27]r5, [26:22]r6, [21:17]r7, [16:13]r8
    function [62:0] pack_residues;
        input [5:0] r0; input [5:0] r1; input [6:0] r2;
        input [4:0] r3; input [4:0] r4; input [4:0] r5;
        input [4:0] r6; input [4:0] r7; input [3:0] r8;
        begin
            pack_residues = {
                1'd0,       // [63] unused padding if needed, but we use [62:0]
                r0,         // [62:57]
                1'd0,       // [56] gap
                r1,         // [55:50]
                1'd0,       // [49] gap
                r2,         // [48:42]
                1'd0,       // [41] gap (Wait, mapping needs to be exact)
                // Let's stick to the EXACT mapping defined in decoder to avoid confusion
                // decoder: [62:57]r0, [55:50]r1, [48:42]r2, [41:37]r3...
                // So bits 56, 49, 36? No, let's re-calculate based on decoder definition
                // decoder_3nrm_mld.v:
                // r0 = residues_in[62:57] (6 bits) -> bits 62-57
                // r1 = residues_in[55:50] (6 bits) -> bits 55-50 (bit 56 skipped)
                // r2 = residues_in[48:42] (7 bits) -> bits 48-42 (bit 49 skipped)
                // r3 = residues_in[41:37] (5 bits) -> bits 41-37
                // r4 = residues_in[36:32] (5 bits) -> bits 36-32
                // r5 = residues_in[31:27] (5 bits) -> bits 31-27
                // r6 = residues_in[26:22] (5 bits) -> bits 26-22
                // r7 = residues_in[21:17] (5 bits) -> bits 21-17
                // r8 = residues_in[16:13] (4 bits) -> bits 16-13
                // Bits 12:0 are unused.
                
                // Constructing strictly:
                {
                    r0,               // [62:57]
                    1'b0,             // [56]
                    r1,               // [55:50]
                    1'b0,             // [49]
                    r2,               // [48:42]
                    r3,               // [41:37] - Wait, 42-1=41, so continuous? 
                    // Let's look at decoder again:
                    // r2 = [48:42], r3 = [41:37]. Yes, 42 and 41 are adjacent. No gap between r2 and r3.
                    // r3 = [41:37], r4 = [36:32]. Adjacent.
                    // r4 = [36:32], r5 = [31:27]. Adjacent.
                    // r5 = [31:27], r6 = [26:22]. Adjacent.
                    // r6 = [26:22], r7 = [21:17]. Adjacent.
                    // r7 = [21:17], r8 = [16:13]. Adjacent.
                    // So gaps are ONLY before r1 (bit 56) and before r2 (bit 49)?
                    // Let's re-read decoder carefully:
                    // wire [5:0] r0 = residues_in[62:57]; 
                    // wire [5:0] r1 = residues_in[55:50]; -> Gap at 56
                    // wire [6:0] r2 = residues_in[48:42]; -> Gap at 49
                    // wire [4:0] r3 = residues_in[41:37]; -> Continuous from 42
                    // ... all others continuous down to 13.
                    
                    r3, r4, r5, r6, r7, r8,
                    13'b0             // [12:0] Unused
                }
            };
        end
    endfunction

    initial begin
        // Initialize Inputs
        rst_n = 0;
        start = 0;
        residues_in = 0;

        // Wait 100 ns for Global Reset
        #100;
        rst_n = 1;
        #20;

        $display("========================================");
        $display("Starting RRNS 3NRM Loopback Simulation");
        $display("========================================");

        // --- Test Case 1: Zero Input ---
        expected_data = 0;
        // Pack residues: all 0
        residues_in = pack_residues(6'd0, 6'd0, 7'd0, 5'd0, 5'd0, 5'd0, 5'd0, 5'd0, 4'd0);
        
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // Wait for result (Single cycle logic + output reg, so 1-2 cycles)
        @(posedge clk); 
        if (valid && (data_out == expected_data))
            $display("[PASS] Test 1: Input 0 -> Output %d", data_out);
        else
            $display("[FAIL] Test 1: Expected %d, Got %d (Valid=%b)", expected_data, data_out, valid);

        // --- Test Case 2: Max Value (65535) ---
        // We need to calculate what residues 65535 produces for mods: 64, 63, 65, 31, 29, 23, 19, 17, 11
        // 65535 % 64 = 63
        // 65535 % 63 = 65535 - (63*1040) = 65535 - 65520 = 15
        // 65535 % 65 = 65535 - (65*1008) = 65535 - 65520 = 15
        // 65535 % 31 = 20
        // 65535 % 29 = 10
        // 65535 % 23 = 4
        // 65535 % 19 = 11
        // 65535 % 17 = 13
        // 65535 % 11 = 5
        
        expected_data = 20'd65535;
        residues_in = pack_residues(6'd63, 6'd15, 7'd15, 5'd20, 5'd10, 5'd4, 5'd11, 5'd13, 4'd5);

        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        
        @(posedge clk);
        if (valid && (data_out == expected_data))
            $display("[PASS] Test 2: Input 65535 -> Output %d", data_out);
        else
            $display("[FAIL] Test 2: Expected %d, Got %d (Valid=%b)", expected_data, data_out, valid);

        // --- Test Case 3: Random Value (e.g., 1234) ---
        // 1234 % 64 = 18
        // 1234 % 63 = 37
        // 1234 % 65 = 59
        // 1234 % 31 = 25
        // 1234 % 29 = 16
        // 1234 % 23 = 18
        // 1234 % 19 = 9
        // 1234 % 17 = 13
        // 1234 % 11 = 3
        
        expected_data = 20'd1234;
        residues_in = pack_residues(6'd18, 6'd37, 7'd59, 5'd25, 5'd16, 5'd18, 5'd9, 5'd13, 4'd3);

        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        @(posedge clk);
        if (valid && (data_out == expected_data))
            $display("[PASS] Test 3: Input 1234 -> Output %d", data_out);
        else
            $display("[FAIL] Test 3: Expected %d, Got %d (Valid=%b)", expected_data, data_out, valid);

        $display("========================================");
        $display("Simulation Finished.");
        $display("========================================");
        
        #100;
        $finish;
    end
      
endmodule