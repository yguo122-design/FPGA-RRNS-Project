`timescale 1ns / 1ps

module top_benchmark (
    input  wire       clk,          // 100MHz System Clock
    input  wire       rst_n,        // Active Low Reset
    input  wire       btn_start,    // Start Button (Active High)
    input  wire [7:0] sw,           // Dip Switches
    // sw[1:0]: Algorithm Select (00:C-RNNS, 01:3NRM, 10:2NRM, 11:RS)
    // sw[5:2]: BER Level (1-10 %)
    // sw[7:6]: Reserved
    
    output reg [7:0]  led,          // Status LEDs
    output wire       uart_tx       // UART TX Pin
);

    // ========================================================================
    // 1. Parameters & Constants
    // ========================================================================
    localparam TEST_DEPTH = 10000;
    localparam CLK_FREQ_HZ = 100_000_000;
    
    // Algorithm IDs
    localparam ALG_CRNNS = 2'd0;
    localparam ALG_3NRM  = 2'd1;
    localparam ALG_2NRM  = 2'd2;
    localparam ALG_RS    = 2'd3;

    // Memory Widths (Padded to 64-bit for uniformity)
    localparam WIDTH_CRNNS = 64; // Actual 61 bits
    localparam WIDTH_3NRM  = 64; // Actual 48 bits
    localparam WIDTH_2NRM  = 64; // Actual 41 bits
    localparam WIDTH_RS    = 64; // Actual 48 bits

    // ========================================================================
    // 2. Control Signals & Registers
    // ========================================================================
    wire [1:0] alg_sel = sw[1:0];
    wire [3:0] ber_lvl = sw[5:2];
    wire       start_pulse; // Debounced button signal (simplified here)
    
    // Sync button to clock domain
    reg btn_sync1, btn_sync2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin btn_sync1 <= 0; btn_sync2 <= 0; end
        else begin btn_sync1 <= btn_start; btn_sync2 <= btn_sync1; end
    end
    assign start_pulse = btn_sync1 && !btn_sync2; // Rising edge detect

    // Statistics
    reg [31:0] cycle_count;
    reg [31:0] error_count;
    reg        test_done;
    reg        test_running;

    // ========================================================================
    // 3. Memory Interfaces (Internal Signals)
    // ========================================================================
    // Address Counters
    reg [13:0] addr_enc; // Up to 10000
    reg [13:0] addr_dec;
    
    // Data Buses
    wire [15:0] rom_data;         // Original data from ROM
    wire [63:0] ram_crnns_dout, ram_3nrm_dout, ram_2nrm_dout, ram_rs_dout;
    wire [63:0] selected_residues;
    wire [15:0] decoded_data;
    wire        decode_valid;
    wire        decode_uncorrectable;

    // Write Enable for Initialization Phase
    reg         ram_we;
    reg [63:0]  ram_din_crnns, ram_din_3nrm, ram_din_2nrm, ram_din_rs;

    // ========================================================================
    // 4. Main Test Engine FSM
    // ========================================================================
    localparam ST_IDLE      = 3'd0;
    localparam ST_INIT_ENC  = 3'd1; // Encode all 4 algorithms and store to RAMs
    localparam ST_INJECT    = 3'd2; // Inject errors into selected RAM based on BER
    localparam ST_DECODE    = 3'd3; // Decode and Compare
    localparam ST_REPORT    = 3'd4;

    reg [2:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
            addr_enc <= 0;
            addr_dec <= 0;
            cycle_count <= 0;
            error_count <= 0;
            test_done <= 0;
            test_running <= 0;
            ram_we <= 0;
            led <= 0;
        end else begin
            test_done <= 0;
            ram_we <= 0;
            
            case (state)
                ST_IDLE: begin
                    led <= 8'b0000_0001;
                    if (start_pulse) begin
                        addr_enc <= 0;
                        addr_dec <= 0;
                        cycle_count <= 0;
                        error_count <= 0;
                        test_running <= 1;
                        state <= ST_INIT_ENC;
                    end
                end

                ST_INIT_ENC: begin
                    led <= 8'b0000_0010;
                    cycle_count <= cycle_count + 1;
                    ram_we <= 1;
                    // TODO: Instantiate Encoders here and pack results to ram_din_xxx
                    // For brevity, assuming encoders produce data combinationally
                    // ram_din_crnns <= {encoder_crnns_out, 3'd0}; 
                    // ...
                    
                    if (addr_enc == TEST_DEPTH - 1) begin
                        state <= ST_INJECT;
                        addr_enc <= 0;
                    end else begin
                        addr_enc <= addr_enc + 1;
                    end
                end

                ST_INJECT: begin
                    led <= 8'b0000_0100;
                    cycle_count <= cycle_count + 1;
                    // TODO: Read RAM, Apply Bit Flip based on LFSR & BER, Write Back
                    // This requires a Read-Modify-Write cycle (2 cycles per addr) or dual-port trick
                    // Simplified: Assume injection happens in 1 cycle per addr for this template
                    
                    if (addr_enc == TEST_DEPTH - 1) begin
                        state <= ST_DECODE;
                        addr_enc <= 0;
                    end else begin
                        addr_enc <= addr_enc + 1;
                    end
                end

                ST_DECODE: begin
                    led <= 8'b0000_1000;
                    cycle_count <= cycle_count + 1;
                    
                    // Trigger Decoder
                    // Wait for decode_valid
                    if (decode_valid) begin
                        // Compare with ROM data
                        if (decoded_data != rom_data || decode_uncorrectable) begin
                            error_count <= error_count + 1;
                        end
                        
                        if (addr_dec == TEST_DEPTH - 1) begin
                            state <= ST_REPORT;
                            test_running <= 0;
                        end else begin
                            addr_dec <= addr_dec + 1;
                        end
                    end
                end

                ST_REPORT: begin
                    led <= 8'b1000_0000;
                    test_done <= 1;
                    // Stay here until reset
                end
            endcase
        end
    end

    // ========================================================================
    // 5. Memory Instances (Block Memory Generator Placeholders)
    // ========================================================================
    // Note: In Vivado, create 4 IP cores: 
    // 1. ROM (16-bit, Depth 10000) initialized with COE
    // 2. RAM_CRNNS (64-bit, Depth 10000)
    // 3. RAM_3NRM (64-bit, Depth 10000)
    // 4. RAM_2NRM (64-bit, Depth 10000)
    // 5. RAM_RS (64-bit, Depth 10000)
    
    // Example Instantiation (Replace with your generated IP names)
    /*
    blk_mem_gen_rom u_rom (.addra(addr_enc), .clka(clk), .douta(rom_data));
    
    blk_mem_gen_ram u_ram_crnns (
        .addra(addr_enc), .clka(clk), .dina(ram_din_crnns), .wea(ram_we),
        .addrb(addr_dec), .clkb(clk), .doutb(ram_crnns_dout)
    );
    // ... Repeat for others
    */
    
    // Dummy assignment for compilation if IPs are missing
    assign rom_data = 16'd0; 
    assign ram_crnns_dout = 64'd0;
    assign ram_3nrm_dout = 64'd0;
    assign ram_2nrm_dout = 64'd0;
    assign ram_rs_dout = 64'd0;

    // ========================================================================
    // 6. Algorithm Selection Mux
    // ========================================================================
    always @(*) begin
        case (alg_sel)
            ALG_CRNNS: selected_residues = ram_crnns_dout;
            ALG_3NRM:  selected_residues = ram_3nrm_dout;
            ALG_2NRM:  selected_residues = ram_2nrm_dout;
            ALG_RS:    selected_residues = ram_rs_dout;
            default:   selected_residues = 64'd0;
        endcase
    end

    // ========================================================================
    // 7. Decoder Instances
    // ========================================================================
    
    // --- 2NRM-RRNS (Full MLD) ---
    decoder_2nrm_mld u_dec_2nrm (
        .clk(clk),
        .rst_n(rst_n),
        .start(state == ST_DECODE && addr_dec < TEST_DEPTH), // Simple trigger
        .residues_in(selected_residues[40:0]), // Map 41 bits
        .data_out(decoded_data),
        .valid(decode_valid),
        .uncorrectable(decode_uncorrectable)
    );

    // --- 3NRM-RRNS (Full MLD - Placeholder) ---
    // decoder_3nrm_mld u_dec_3nrm (...);

    // --- C-RNNS (MRC - Placeholder) ---
    // decoder_c_rnns_mrc u_dec_c_rnns (...);

    // --- RS Code (Placeholder) ---
    // decoder_rs u_dec_rs (...);

    // NOTE: In a real design, you would instantiate ALL decoders and use the MUX 
    // to select their OUTPUTS, or gate their START signals to save power.
    // For timing closure, gating START is better.
    // Here, for simplicity, we assume the active decoder drives the shared outputs.
    // To avoid bus contention, you MUST gate the 'valid' signal or use a MUX on outputs.
    
    // Correct Output MUXing Strategy:
    wire [15:0] out_crnns, out_3nrm, out_2nrm, out_rs;
    wire        val_crnns, val_3nrm, val_2nrm, val_rs;
    wire        err_crnns, err_3nrm, err_2nrm, err_rs;

    // Re-instantiate with separate outputs (Conceptual)
    // decoder_2nrm_mld u_dec_2nrm (.data_out(out_2nrm), .valid(val_2nrm), ...);
    // ... others ...

    // Final Mux
    /*
    always @(*) begin
        case(alg_sel)
            ALG_2NRM: begin decoded_data = out_2nrm; decode_valid = val_2nrm; decode_uncorrectable = err_2nrm; end
            // ...
        endcase
    end
    */

    // ========================================================================
    // 8. UART Reporter
    // ========================================================================
    uart_reporter u_reporter (
        .clk(clk),
        .rst_n(rst_n),
        .trigger(test_done),
        .alg_id(alg_sel),
        .ber_val(ber_lvl),
        .total_vecs(TEST_DEPTH),
        .err_count(error_count),
        .cycle_count(cycle_count),
        .uart_tx(uart_tx)
    );

endmodule