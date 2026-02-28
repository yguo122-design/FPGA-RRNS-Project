`timescale 1ns / 1ps

module encoder_rrns (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       start,          // Start pulse
    input  wire [15:0] data_in,       // Input data (0-65535), 16-bit
    
    // Output residues (9 channels)
    output reg [5:0]  rem_64,         // Modulo 64 (m1)
    output reg [5:0]  rem_63,         // Modulo 63 (m2)
    output reg [6:0]  rem_65,         // Modulo 65 (m3)
    output reg [6:0]  rem_67,         // Modulo 67 (m4)
    output reg [6:0]  rem_71,         // Modulo 71 (m5)
    output reg [6:0]  rem_73,         // Modulo 73 (m6)
    output reg [6:0]  rem_79,         // Modulo 79 (m7)
    output reg [6:0]  rem_83,         // Modulo 83 (m8)
    output reg [6:0]  rem_89,         // Modulo 89 (m9)
    output reg        done            // Done flag
);

    // --- Combinational Logic: Modulo Calculations ---
    // Vivado synthesizer optimizes constant modulo operations into efficient circuits
    wire [5:0] w_r64 = data_in % 64;
    wire [5:0] w_r63 = data_in % 63;
    wire [6:0] w_r65 = data_in % 65;
    wire [6:0] w_r67 = data_in % 67;
    wire [6:0] w_r71 = data_in % 71;
    wire [6:0] w_r73 = data_in % 73;
    wire [6:0] w_r79 = data_in % 79;
    wire [6:0] w_r83 = data_in % 83;
    wire [6:0] w_r89 = data_in % 89;

    // --- Sequential Logic: Register Outputs ---
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done   <= 0;
            rem_64 <= 0;
            rem_63 <= 0;
            rem_65 <= 0;
            rem_67 <= 0;
            rem_71 <= 0;
            rem_73 <= 0;
            rem_79 <= 0;
            rem_83 <= 0;
            rem_89 <= 0;
        end else begin
            done <= 0; // Default low
            if (start) begin
                // Latch calculated residues on start pulse
                rem_64 <= w_r64;
                rem_63 <= w_r63;
                rem_65 <= w_r65;
                rem_67 <= w_r67;
                rem_71 <= w_r71;
                rem_73 <= w_r73;
                rem_79 <= w_r79;
                rem_83 <= w_r83;
                rem_89 <= w_r89;
                done   <= 1; // Assert done for one cycle
            end
        end
    end

endmodule