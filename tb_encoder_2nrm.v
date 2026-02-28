// FORCE_RECOMPILE_20260228_1830

`timescale 1ns / 1ps

module tb_encoder_2nrm;

    // --- 1. Signals Declaration ---
    reg         clk;
    reg         rst_n;
    reg         start;
    reg [15:0]  data_in;
    
    wire [63:0] residues_out;
    wire        done;

    //--- 2. DUT Instantiation (Device Under Test) ---
    encoder_2nrm u_enc_2nrm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .data_in(data_in),
        .residues_out(residues_out),
        .done(done)
    );


    // --- 3. Clock Generation (100MHz -> 10ns period) ---
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // --- 4. Task for Stimulus ---
    // Task: Apply a test vector and wait for completion
    // --- 4. Task for Stimulus (FIXED VERSION) ---
    // --- 4. Task for Stimulus (ABSOLUTE TIMING FIX) ---
task apply_test_vector;
    input [15:0] val;
    begin
        // Step 1: Drive Data Immediately (Asynchronous)
        data_in = val;
        
        // Step 2: Wait 2ns to ensure Setup Time
        #2; 
        
        // Step 3: Wait for Clock Edge
        @(posedge clk);
        
        // Step 4: Assert Start
        start <= 1'b1;
        
        // Step 5: Wait 1 Cycle
        @(posedge clk);
        start <= 1'b0;
        
        // Step 6: Wait 1 Cycle for Output to be Valid
        @(posedge clk);
        
        // Step 7: Display Result
        $display("Time: %0t | Input: %5d (0x%04X) | Output: 0x%016H | Done: %b", 
                 $time, val, val, residues_out, done);
        
        #1; // Small gap
    end
endtask

    // --- 5. Test Sequence ---
    initial begin
        // Initialize signals
        rst_n   = 0;
        start   = 0;
        data_in = 0;
        
        $display("========================================");
        $display("Starting Encoder 2NRM Simulation...");
        $display("========================================");

        // Release Reset
        #20 rst_n = 1;
        #10;

        // --- Test Case 1: Zero ---
        $display("\n[Test 1] Input = 0");
        apply_test_vector(16'd0);
        // Expected: 0%257=0, 0%256=0, 0%61=0, ... -> All zeros

        // --- Test Case 2: Max Value (65535) ---
        $display("\n[Test 2] Input = 65535 (Max 16-bit)");
        apply_test_vector(16'd65535);
        // Expected: 
        // 65535 % 257 = 3
        // 65535 % 256 = 255
        // 65535 % 61  = 21
        // ... (Let Vivado calculate)

        // --- Test Case 3: Modulo Boundaries ---
        $display("\n[Test 3] Input = 256 (Boundary for m2)");
        apply_test_vector(16'd256);
        // Expected: 256%257=256, 256%256=0

        $display("\n[Test 4] Input = 257 (Boundary for m1)");
        apply_test_vector(16'd257);
        // Expected: 257%257=0, 257%256=1

        $display("\n[Test 5] Input = 61 (Boundary for m3)");
        apply_test_vector(16'd61);
        
        // --- Test Case 4: Random Values ---
        $display("\n[Test 6] Random Values");
        apply_test_vector(16'd12345);
        apply_test_vector(16'd54321);
        apply_test_vector(16'd100);
        apply_test_vector(16'd65532); // Critical value near dynamic range limit

        $display("\n========================================");
        $display("Simulation Finished.");
        $display("========================================");
        
        // End Simulation
        #50 $finish;
    end

    // --- 6. Assertions (Optional but Recommended) ---
    // Simple check: When done is high, output should not be all zeros unless input is 0
    // always @(posedge clk) begin
    //     if (done && data_in != 0) begin
    //        if (residues_out === 64'd0) begin
    //            $error("ERROR: Output is all zeros for non-zero input %d!", data_in);
    //        end
    //    end
    // end

endmodule