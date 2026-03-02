`timescale 1ns / 1ps

// Temporary Top Module for Verification (Only Group 0)
module decoder_top_test (
    input wire clk, input wire rst_n, input wire start,
    input wire [62:0] residues_in,
    output reg [19:0] data_out, output reg valid, output reg uncorrectable
);

    wire [6:0] r0 = {1'd0, residues_in[62:57]};
    wire [6:0] r1 = {1'd0, residues_in[55:50]};
    wire [6:0] r2 = residues_in[48:42];
    wire [6:0] r3 = {2'd0, residues_in[41:37]};
    wire [6:0] r4 = {2'd0, residues_in[36:32]};
    wire [6:0] r5 = {2'd0, residues_in[31:27]};
    wire [6:0] r6 = {2'd0, residues_in[26:22]};
    wire [6:0] r7 = {2'd0, residues_in[21:17]};
    wire [6:0] r8 = {3'd0, residues_in[16:13]};

    wire [15:0] g0_dist;
    wire [6:0] g0_idx;
    wire [19:0] g0_x;
    decoder_group_0 u_group0 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .min_dist_out(g0_dist), .min_idx_out(g0_idx), .best_x_out(g0_x)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 20'd0; valid <= 1'b0; uncorrectable <= 1'b0;
        end else if (start) begin
            data_out <= g0_x;
            valid <= 1'b1;
            uncorrectable <= (g0_dist > 16'd100) ? 1'b1 : 1'b0;
        end
    end
endmodule
