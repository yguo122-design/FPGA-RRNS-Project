`timescale 1ns / 1ps

module tb_loopback_3nrm;

    // --- 1. Signals Declaration ---
    reg         clk;
    reg         rst_n;
    
    // Encoder Inputs
    reg         enc_start;
    reg [15:0]  data_in;
    
    // Interconnect (Encoder Output -> Decoder Input)
    wire [63:0] residues_bus;
    wire        enc_done;
    
    // Decoder Inputs/Outputs
    reg         dec_start;
    wire [15:0] data_out;
    wire        dec_valid;
    wire        dec_uncorrectable;

    // --- 2. DUT Instantiation ---
    
    // A. Encoder Instance
    encoder_3nrm u_encoder (
        .clk(clk),
        .rst_n(rst_n),
        .start(enc_start),
        .data_in(data_in),
        .residues_out(residues_bus),
        .done(enc_done)
    );

    // B. Decoder Instance
    decoder_3nrm_mld u_decoder (
        .clk(clk),
        .rst_n(rst_n),
        .start(dec_start),
        .residues_in(residues_bus), // Direct connection from Encoder output
        .data_out(data_out),
        .valid(dec_valid),
        .uncorrectable(dec_uncorrectable)
    );

    // --- 3. Clock Generation (100MHz) ---
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // --- 4. Control Logic (Handshake State Machine) ---
    // State Machine Flow:
    // IDLE -> Start Encoder -> Wait for Encoder Done -> Start Decoder -> Wait for Decoder Valid -> Check Data -> Return to IDLE
    reg [1:0] state;
    localparam IDLE = 0, WAIT_ENC = 1, WAIT_DEC = 2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            enc_start <= 1'b0;
            dec_start <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    enc_start <= 1'b1; 
                    dec_start <= 1'b0;
                    state <= WAIT_ENC;
                end
                WAIT_ENC: begin
                    enc_start <= 1'b0;
                    if (enc_done) begin
                        dec_start <= 1'b1; // Encoder done, immediately start Decoder
                        state <= WAIT_DEC;
                    end
                end
                WAIT_DEC: begin
                    dec_start <= 1'b0;
                    if (dec_valid) begin
                        state <= IDLE; // Decoder done, ready for next test vector
                    end
                end
            endcase
        end
    end

    // --- 5. Task for Stimulus & Verification ---
    // --- 5. Task for Stimulus & Verification (With Debug) ---
    task run_loopback_test;
        input [15:0] val;
        begin
            data_in = val;
            $display("------------------------------------------------");
            $display("[TEST] Input Data: %d (0x%04X)", val, val);
            
            @(posedge dec_valid);
            #2;
            
            if (dec_uncorrectable) begin
                $error("[FAIL] Decoder reported UNCORRECTABLE error!");
                // --- DEBUG: Print top 5 channels ---
                $display("  >> DEBUG: Dumping channel info (Simulated internal signals not directly accessible here)");
                $display("  >> Suggestion: Check waveform for 'chan_x' and 'chan_dist' arrays.");
                // Since we can't access internal genvars easily from task, 
                // let's just rely on the fact that we will look at the waveform.
                $display("  >> ACTION: Open Waveform, add 'u_decoder.gen_channels[*].chan_x' and 'chan_dist'.");
            end else if (data_in === data_out) begin
                $display("[PASS] Output Data: %d (0x%04X) - MATCH!", data_out, data_out);
            end else begin
                $error("[FAIL] Output Data: %d (0x%04X) - MISMATCH!", data_out, data_out);
            end
        end
    endtask

    // --- 6. Test Sequence ---
    initial begin
        rst_n = 0;
        #20 rst_n = 1;
        #10;

        $display("========================================");
        $display("Starting RRNS 3NRM Loopback Simulation");
        $display("Encoder -> Decoder (No Error Injection)");
        $display("========================================");

        // Test 1: Zero
        run_loopback_test(16'd0);

        // Test 2: Max Value (65535)
        run_loopback_test(16'd65535);

        // Test 3: Random Values
        run_loopback_test(16'd12345);
        run_loopback_test(16'd54321);
        run_loopback_test(16'd100);
        run_loopback_test(16'd255);
        run_loopback_test(16'd1024);
        run_loopback_test(16'd30000);

        // Test 4: Boundary Values (Near Moduli)
        run_loopback_test(16'd64);
        run_loopback_test(16'd65);
        run_loopback_test(16'd63);
        run_loopback_test(16'd31);
        run_loopback_test(16'd17);

        $display("========================================");
        $display("Loopback Simulation Finished.");
        $display("========================================");
        
        #50 $finish;
    end

endmodule