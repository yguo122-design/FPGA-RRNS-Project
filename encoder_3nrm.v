`timescale 1ns / 1ps

module encoder_3nrm (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       start,          // Start pulse
    input  wire [15:0] data_in,       // Input data (0-65535)
    
    // Packed Output: 64-bit bus
    // Bit Map (Matching decoder_3nrm_mld input):
    // [63:58] : r_64  (6 bits)
    // [57:52] : r_63  (6 bits)
    // [51:45] : r_65  (7 bits)
    // [44:40] : r_31  (5 bits)
    // [39:35] : r_29  (5 bits)
    // [34:30] : r_23  (5 bits)
    // [29:25] : r_19  (5 bits)
    // [24:20] : r_17  (5 bits)
    // [19:0]  : Unused (0)
    output reg [63:0] residues_out,
    
    output reg        done            // Done flag
);

    // --- 1. Modulo Constants ---
    localparam M1 = 17'd64;
    localparam M2 = 17'd63;
    localparam M3 = 17'd65;
    localparam M4 = 17'd31;
    localparam M5 = 17'd29;
    localparam M6 = 17'd23;
    localparam M7 = 17'd19;
    localparam M8 = 17'd17;

    // --- 2. Combinational Modulo Calculations ---
    // Vivado synthesizes constant modulo into efficient logic
    wire [5:0] r1 = data_in % M1; // 0-63  (6 bits)
    wire [5:0] r2 = data_in % M2; // 0-62  (6 bits)
    wire [6:0] r3 = data_in % M3; // 0-64  (7 bits)
    wire [4:0] r4 = data_in % M4; // 0-30  (5 bits)
    wire [4:0] r5 = data_in % M5; // 0-28  (5 bits)
    wire [4:0] r6 = data_in % M6; // 0-22  (5 bits)
    wire [4:0] r7 = data_in % M7; // 0-18  (5 bits)
    wire [4:0] r8 = data_in % M8; // 0-16  (5 bits)

    // --- 3. Packing Logic ---
    // Strictly matching the bit order in decoder_3nrm_mld.v
    wire [63:0] packed_data;
    assign packed_data = {
        r1,         // [63:58] r_64
        r2,         // [57:52] r_63
        r3,         // [51:45] r_65
        r4,         // [44:40] r_31
        r5,         // [39:35] r_29
        r6,         // [34:30] r_23
        r7,         // [29:25] r_19
        r8,         // [24:20] r_17
        20'd0       // [19:0]  Unused
    };

    // --- 4. Sequential Output Register ---
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            residues_out <= 64'd0;
            done <= 1'b0;
        end else begin
            done <= 1'b0; // Default low
            if (start) begin
                residues_out <= packed_data;
                done <= 1'b1; // Assert for one cycle
            end
        end
    end

endmodule