`timescale 1ns / 1ps

module tb_rrns_encoder;

    // 1. Signal Declarations
    reg clk;
    reg rst_n;
    reg start;
    reg [15:0] data_in;

    wire [5:0]  rem_64;
    wire [5:0]  rem_63;
    wire [6:0]  rem_65;
    wire [6:0]  rem_67;
    wire [6:0]  rem_71;
    wire [6:0]  rem_73;
    wire [6:0]  rem_79;
    wire [6:0]  rem_83;
    wire [6:0]  rem_89;
    wire        done;

    // 2. Instantiate Device Under Test (DUT)
    rrns_encoder u_dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .data_in(data_in),
        .rem_64(rem_64),
        .rem_63(rem_63),
        .rem_65(rem_65),
        .rem_67(rem_67),
        .rem_71(rem_71),
        .rem_73(rem_73),
        .rem_79(rem_79),
        .rem_83(rem_83),
        .rem_89(rem_89),
        .done(done)
    );

    // 3. Clock Generation (100MHz -> Period 10ns)
    initial clk = 0;
    always #5 clk = ~clk; 

    // 4. Test Task: Apply input data and verify all 9 residues
    task apply_and_check;
        input [15:0] val;
        input [5:0]  exp_r64;
        input [5:0]  exp_r63;
        input [6:0]  exp_r65;
        input [6:0]  exp_r67;
        input [6:0]  exp_r71;
        input [6:0]  exp_r73;
        input [6:0]  exp_r79;
        input [6:0]  exp_r83;
        input [6:0]  exp_r89;

        begin
            @(posedge clk);
            data_in <= val;
            start   <= 1;
            
            @(posedge clk);
            start <= 0;
            
            // Wait for done signal
            wait(done);
            
            // Print results to Vivado Tcl Console
            $display("--------------------------------------------------");
            $display("Input: %d", val);
            
            // Print Got values (split into two lines for readability)
            $display("Got  : r64=%d, r63=%d, r65=%d, r67=%d, r71=%d", 
                     rem_64, rem_63, rem_65, rem_67, rem_71);
            $display("       r73=%d, r79=%d, r83=%d, r89=%d", 
                     rem_73, rem_79, rem_83, rem_89);
             
            // Print Expected values
            $display("Exp  : r64=%d, r63=%d, r65=%d, r67=%d, r71=%d", 
                     exp_r64, exp_r63, exp_r65, exp_r67, exp_r71);
            $display("       r73=%d, r79=%d, r83=%d, r89=%d", 
                     exp_r73, exp_r79, exp_r83, exp_r89);
            
            // Verification Logic
            if (rem_64 != exp_r64 || rem_63 != exp_r63 || rem_65 != exp_r65 || rem_67 != exp_r67 || 
                rem_71 != exp_r71 || rem_73 != exp_r73 || rem_79 != exp_r79 || rem_83 != exp_r83 || 
                rem_89 != exp_r89) begin
                $display("[ERROR] Mismatch detected for Input %d!", val);
                $stop; // Stop simulation on error
            end else begin
                $display("[PASS] Correct!");
            end
        end
    endtask

    // 5. Test Sequence
    initial begin
        // Initialization
        rst_n = 0;
        data_in = 0;
        start = 0;
        
        // Reset Sequence
        #20;
        rst_n = 1;
        #20;

        $display("STARTING RRNS Encoder Simulation (All 9 Moduli)...");

        // --- Test Case 1: 0 ---
        // 0 % any = 0
        apply_and_check(16'd0, 6'd0, 6'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0);

        // --- Test Case 2: 1 ---
        // 1 % any = 1
        apply_and_check(16'd1, 6'd1, 6'd1, 7'd1, 7'd1, 7'd1, 7'd1, 7'd1, 7'd1, 7'd1);

        // --- Test Case 3: 100 (Manual Verification) ---
        // 100 % 64 = 36, % 63 = 37, % 65 = 35, % 67 = 33
        // 100 % 71 = 29, % 73 = 27, % 79 = 21, % 83 = 17, % 89 = 11
        apply_and_check(16'd100, 6'd36, 6'd37, 7'd35, 7'd33, 7'd29, 7'd27, 7'd21, 7'd17, 7'd11);

        // --- Test Case 4: 65535 (Max Value) ---
        // 65535 % 64 = 63, % 63 = 15, % 65 = 15, % 67 = 9
        // 65535 % 71 = 2, % 73 = 54, % 79 = 44, % 83 = 48, % 89 = 31
        apply_and_check(16'd65535, 6'd63, 6'd15, 7'd15, 7'd9, 7'd2, 7'd54, 7'd44, 7'd48, 7'd31);

        // --- Test Case 5: Random Value 12345 ---
        // 12345 % 64 = 57, % 63 = 60, % 65 = 60, % 67 = 17
        // 12345 % 71 = 62, % 73 = 8, % 79 = 21, % 83 = 61, % 89 = 63
        apply_and_check(16'd12345, 6'd57, 6'd60, 7'd60, 7'd17, 7'd62, 7'd8, 7'd21, 7'd61, 7'd63);

        $display("SUCCESS: All Tests Passed! Simulation Finished.");
        $stop;
    end

endmodule