`timescale 1ns / 1ps

module tb_encoder_3nrm;

    // --- 1. Signals Declaration ---
    reg         clk;
    reg         rst_n;
    reg         start;
    reg [15:0]  data_in;
    
    wire [63:0] residues_out;
    wire        done;

    // --- 2. DUT Instantiation ---
    encoder_3nrm u_enc_3nrm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .data_in(data_in),
        .residues_out(residues_out),
        .done(done)
    );

    // --- 3. Clock Generation (100MHz) ---
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // --- 4. Task for Stimulus ---
    task apply_test_vector;
        input [15:0] val;
        reg [5:0] r1_exp, r2_exp;
        reg [6:0] r3_exp;
        reg [4:0] r4_exp, r5_exp, r6_exp, r7_exp, r8_exp;
        begin
            data_in = val;
            #2; 
            @(posedge clk);
            start <= 1'b1;
            @(posedge clk);
            start <= 1'b0;
            @(posedge clk); // Wait for output
            
            // Calculate Expected Values (Software Model in TB)
            r1_exp = val % 64;
            r2_exp = val % 63;
            r3_exp = val % 65;
            r4_exp = val % 31;
            r5_exp = val % 29;
            r6_exp = val % 23;
            r7_exp = val % 19;
            r8_exp = val % 17;
            
            $display("Time: %0t | In: %5d | Out: 0x%016H | Done: %b", $time, val, residues_out, done);
            $display("  Check: r64=%d(%d) r63=%d(%d) r65=%d(%d) r31=%d(%d)", 
                     residues_out[63:58], r1_exp,
                     residues_out[57:52], r2_exp,
                     residues_out[51:45], r3_exp,
                     residues_out[44:40], r4_exp);
            $display("         r29=%d(%d) r23=%d(%d) r19=%d(%d) r17=%d(%d)",
                     residues_out[39:35], r5_exp,
                     residues_out[34:30], r6_exp,
                     residues_out[29:25], r7_exp,
                     residues_out[24:20], r8_exp);

            // Simple Assertion
            if ({residues_out[63:58], residues_out[57:52], residues_out[51:45], residues_out[44:40],
                 residues_out[39:35], residues_out[34:30], residues_out[29:25], residues_out[24:20]} !== 
                {r1_exp, r2_exp, r3_exp, r4_exp, r5_exp, r6_exp, r7_exp, r8_exp}) begin
                $error("MISMATCH at Input %d!", val);
            end else begin
                $display("  >> PASS");
            end
            #1;
        end
    endtask

    // --- 5. Test Sequence ---
    initial begin
        rst_n = 0; start = 0; data_in = 0;
        $display("========================================");
        $display("Starting Encoder 3NRM Simulation...");
        $display("========================================");

        #20 rst_n = 1; #10;

        // Test 1: Zero
        $display("\n[Test 1] Input = 0");
        apply_test_vector(16'd0);

        // Test 2: Max 16-bit
        $display("\n[Test 2] Input = 65535");
        apply_test_vector(16'd65535);

        // Test 3: Small Value
        $display("\n[Test 3] Input = 100");
        apply_test_vector(16'd100);

        // Test 4: Boundary Checks (Near Moduli)
        $display("\n[Test 4] Input = 64 (Boundary for M1)");
        apply_test_vector(16'd64);
        
        $display("\n[Test 5] Input = 65 (Boundary for M3)");
        apply_test_vector(16'd65);

        $display("\n[Test 6] Input = 63 (Boundary for M2)");
        apply_test_vector(16'd63);

        // Test 5: Random
        $display("\n[Test 7] Random Values");
        apply_test_vector(16'd12345);
        apply_test_vector(16'd54321);

        $display("\n========================================");
        $display("Simulation Finished.");
        $display("========================================");
        #50 $finish;
    end

endmodule