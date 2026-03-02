`timescale 1ns / 1ps

// =============================================================================
// Module: decoder_3nrm_mld
// Format: SystemVerilog (.sv)
// Strategy: Flat instantiation connecting to SV Unpacked Arrays
//           NO generate loop for instances (due to unique parameters)
// =============================================================================

module decoder_3nrm_mld (
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [62:0] residues_in,
    output logic [19:0] data_out,
    output logic valid,
    output logic uncorrectable
);

    // --- Input Unpacking ---
    // --- Input Unpacking (FIXED: All mapped to [6:0] to match channel_unit) ---
    // 原始数据位宽：r0(6), r1(6), r2(7), r3(5), r4(5), r5(5), r6(5), r7(5), r8(4)
    // 目标端口位宽：全部 [6:0] (7 bits)
    
    logic [6:0] r0 = {1'b0, residues_in[62:57]}; // 6位 -> 补1个0 -> 7位
    logic [6:0] r1 = {1'b0, residues_in[55:50]}; // 6位 -> 补1个0 -> 7位
    logic [6:0] r2 = residues_in[48:42];         // 7位 -> 刚好
    logic [6:0] r3 = {2'b00, residues_in[41:37]}; // 5位 -> 补2个0 -> 7位
    logic [6:0] r4 = {2'b00, residues_in[36:32]}; // 5位 -> 补2个0 -> 7位
    logic [6:0] r5 = {2'b00, residues_in[31:27]}; // 5位 -> 补2个0 -> 7位
    logic [6:0] r6 = {2'b00, residues_in[26:22]}; // 5位 -> 补2个0 -> 7位
    logic [6:0] r7 = {2'b00, residues_in[21:17]}; // 5位 -> 补2个0 -> 7位
    logic [6:0] r8 = {3'b000, residues_in[16:13]}; // 4位 -> 补3个0 -> 7位

    // --- Channel Signal Arrays (SystemVerilog Unpacked Arrays) ---
    logic [19:0] chan_x [0:83];
    logic [15:0] chan_dist [0:83];

    // --- 84 Channel Instances (Unique Parameters, Array Connections) ---
    channel_unit #(
        .P_MI0(20'd4095), .P_MI1(20'd4160), .P_MI2(20'd4032),
        .P_INV0(20'd63), .P_INV1(20'd32), .P_INV2(20'd33),
        .P_M_TOTAL(20'd262080),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd2)
    ) u_channel_0 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[0]),
        .dist_out(chan_dist[0])
    );

    channel_unit #(
        .P_MI0(20'd1953), .P_MI1(20'd1984), .P_MI2(20'd4032),
        .P_INV0(20'd33), .P_INV1(20'd61), .P_INV2(20'd16),
        .P_M_TOTAL(20'd124992),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd3)
    ) u_channel_1 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[1]),
        .dist_out(chan_dist[1])
    );

    channel_unit #(
        .P_MI0(20'd1827), .P_MI1(20'd1856), .P_MI2(20'd4032),
        .P_INV0(20'd11), .P_INV1(20'd50), .P_INV2(20'd1),
        .P_M_TOTAL(20'd116928),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd4)
    ) u_channel_2 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[2]),
        .dist_out(chan_dist[2])
    );

    channel_unit #(
        .P_MI0(20'd1449), .P_MI1(20'd1472), .P_MI2(20'd4032),
        .P_INV0(20'd25), .P_INV1(20'd11), .P_INV2(20'd10),
        .P_M_TOTAL(20'd92736),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd5)
    ) u_channel_3 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[3]),
        .dist_out(chan_dist[3])
    );

    channel_unit #(
        .P_MI0(20'd1197), .P_MI1(20'd1216), .P_MI2(20'd4032),
        .P_INV0(20'd37), .P_INV1(20'd10), .P_INV2(20'd5),
        .P_M_TOTAL(20'd76608),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd6)
    ) u_channel_4 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[4]),
        .dist_out(chan_dist[4])
    );

    channel_unit #(
        .P_MI0(20'd1071), .P_MI1(20'd1088), .P_MI2(20'd4032),
        .P_INV0(20'd15), .P_INV1(20'd26), .P_INV2(20'd6),
        .P_M_TOTAL(20'd68544),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd7)
    ) u_channel_5 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[5]),
        .dist_out(chan_dist[5])
    );

    channel_unit #(
        .P_MI0(20'd693), .P_MI1(20'd704), .P_MI2(20'd4032),
        .P_INV0(20'd29), .P_INV1(20'd23), .P_INV2(20'd2),
        .P_M_TOTAL(20'd44352),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd8)
    ) u_channel_6 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[6]),
        .dist_out(chan_dist[6])
    );

    channel_unit #(
        .P_MI0(20'd2015), .P_MI1(20'd1984), .P_MI2(20'd4160),
        .P_INV0(20'd31), .P_INV1(20'd44), .P_INV2(20'd26),
        .P_M_TOTAL(20'd128960),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd3)
    ) u_channel_7 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[7]),
        .dist_out(chan_dist[7])
    );

    channel_unit #(
        .P_MI0(20'd1885), .P_MI1(20'd1856), .P_MI2(20'd4160),
        .P_INV0(20'd53), .P_INV1(20'd56), .P_INV2(20'd9),
        .P_M_TOTAL(20'd120640),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd4)
    ) u_channel_8 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[8]),
        .dist_out(chan_dist[8])
    );

    channel_unit #(
        .P_MI0(20'd1495), .P_MI1(20'd1472), .P_MI2(20'd4160),
        .P_INV0(20'd39), .P_INV1(20'd48), .P_INV2(20'd15),
        .P_M_TOTAL(20'd95680),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd5)
    ) u_channel_9 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[9]),
        .dist_out(chan_dist[9])
    );

    channel_unit #(
        .P_MI0(20'd1235), .P_MI1(20'd1216), .P_MI2(20'd4160),
        .P_INV0(20'd27), .P_INV1(20'd41), .P_INV2(20'd18),
        .P_M_TOTAL(20'd79040),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd6)
    ) u_channel_10 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[10]),
        .dist_out(chan_dist[10])
    );

    channel_unit #(
        .P_MI0(20'd1105), .P_MI1(20'd1088), .P_MI2(20'd4160),
        .P_INV0(20'd49), .P_INV1(20'd42), .P_INV2(20'd10),
        .P_M_TOTAL(20'd70720),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd7)
    ) u_channel_11 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[11]),
        .dist_out(chan_dist[11])
    );

    channel_unit #(
        .P_MI0(20'd715), .P_MI1(20'd704), .P_MI2(20'd4160),
        .P_INV0(20'd35), .P_INV1(20'd59), .P_INV2(20'd6),
        .P_M_TOTAL(20'd45760),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd8)
    ) u_channel_12 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[12]),
        .dist_out(chan_dist[12])
    );

    channel_unit #(
        .P_MI0(20'd899), .P_MI1(20'd1856), .P_MI2(20'd1984),
        .P_INV0(20'd43), .P_INV1(20'd23), .P_INV2(20'd17),
        .P_M_TOTAL(20'd57536),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd4)
    ) u_channel_13 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[13]),
        .dist_out(chan_dist[13])
    );

    channel_unit #(
        .P_MI0(20'd713), .P_MI1(20'd1472), .P_MI2(20'd1984),
        .P_INV0(20'd57), .P_INV1(20'd29), .P_INV2(20'd4),
        .P_M_TOTAL(20'd45632),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd5)
    ) u_channel_14 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[14]),
        .dist_out(chan_dist[14])
    );

    channel_unit #(
        .P_MI0(20'd589), .P_MI1(20'd1216), .P_MI2(20'd1984),
        .P_INV0(20'd5), .P_INV1(20'd9), .P_INV2(20'd12),
        .P_M_TOTAL(20'd37696),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd6)
    ) u_channel_15 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[15]),
        .dist_out(chan_dist[15])
    );

    channel_unit #(
        .P_MI0(20'd527), .P_MI1(20'd1088), .P_MI2(20'd1984),
        .P_INV0(20'd47), .P_INV1(20'd21), .P_INV2(20'd10),
        .P_M_TOTAL(20'd33728),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd7)
    ) u_channel_16 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[16]),
        .dist_out(chan_dist[16])
    );

    channel_unit #(
        .P_MI0(20'd341), .P_MI1(20'd704), .P_MI2(20'd1984),
        .P_INV0(20'd61), .P_INV1(20'd24), .P_INV2(20'd3),
        .P_M_TOTAL(20'd21824),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd8)
    ) u_channel_17 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[17]),
        .dist_out(chan_dist[17])
    );

    channel_unit #(
        .P_MI0(20'd667), .P_MI1(20'd1472), .P_MI2(20'd1856),
        .P_INV0(20'd19), .P_INV1(20'd4), .P_INV2(20'd13),
        .P_M_TOTAL(20'd42688),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd5)
    ) u_channel_18 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[18]),
        .dist_out(chan_dist[18])
    );

    channel_unit #(
        .P_MI0(20'd551), .P_MI1(20'd1216), .P_MI2(20'd1856),
        .P_INV0(20'd23), .P_INV1(20'd14), .P_INV2(20'd3),
        .P_M_TOTAL(20'd35264),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd6)
    ) u_channel_19 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[19]),
        .dist_out(chan_dist[19])
    );

    channel_unit #(
        .P_MI0(20'd493), .P_MI1(20'd1088), .P_MI2(20'd1856),
        .P_INV0(20'd37), .P_INV1(20'd2), .P_INV2(20'd6),
        .P_M_TOTAL(20'd31552),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd7)
    ) u_channel_20 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[20]),
        .dist_out(chan_dist[20])
    );

    channel_unit #(
        .P_MI0(20'd319), .P_MI1(20'd704), .P_MI2(20'd1856),
        .P_INV0(20'd63), .P_INV1(20'd11), .P_INV2(20'd7),
        .P_M_TOTAL(20'd20416),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd8)
    ) u_channel_21 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[21]),
        .dist_out(chan_dist[21])
    );

    channel_unit #(
        .P_MI0(20'd437), .P_MI1(20'd1216), .P_MI2(20'd1472),
        .P_INV0(20'd29), .P_INV1(20'd15), .P_INV2(20'd17),
        .P_M_TOTAL(20'd27968),
        .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd6)
    ) u_channel_22 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[22]),
        .dist_out(chan_dist[22])
    );

    channel_unit #(
        .P_MI0(20'd391), .P_MI1(20'd1088), .P_MI2(20'd1472),
        .P_INV0(20'd55), .P_INV1(20'd10), .P_INV2(20'd12),
        .P_M_TOTAL(20'd25024),
        .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd7)
    ) u_channel_23 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[23]),
        .dist_out(chan_dist[23])
    );

    channel_unit #(
        .P_MI0(20'd253), .P_MI1(20'd704), .P_MI2(20'd1472),
        .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd5),
        .P_M_TOTAL(20'd16192),
        .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd8)
    ) u_channel_24 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[24]),
        .dist_out(chan_dist[24])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd1088), .P_MI2(20'd1216),
        .P_INV0(20'd43), .P_INV1(20'd4), .P_INV2(20'd2),
        .P_M_TOTAL(20'd20672),
        .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_25 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[25]),
        .dist_out(chan_dist[25])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd704), .P_MI2(20'd1216),
        .P_INV0(20'd49), .P_INV1(20'd1), .P_INV2(20'd2),
        .P_M_TOTAL(20'd13376),
        .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_26 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[26]),
        .dist_out(chan_dist[26])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd704), .P_MI2(20'd1088),
        .P_INV0(20'd51), .P_INV1(20'd5), .P_INV2(20'd10),
        .P_M_TOTAL(20'd11968),
        .P_IDX1(4'd0), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_27 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[27]),
        .dist_out(chan_dist[27])
    );

    channel_unit #(
        .P_MI0(20'd2015), .P_MI1(20'd1953), .P_MI2(20'd4095),
        .P_INV0(20'd62), .P_INV1(20'd22), .P_INV2(20'd21),
        .P_M_TOTAL(20'd126945),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd3)
    ) u_channel_28 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[28]),
        .dist_out(chan_dist[28])
    );

    channel_unit #(
        .P_MI0(20'd1885), .P_MI1(20'd1827), .P_MI2(20'd4095),
        .P_INV0(20'd25), .P_INV1(20'd28), .P_INV2(20'd5),
        .P_M_TOTAL(20'd118755),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd4)
    ) u_channel_29 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[29]),
        .dist_out(chan_dist[29])
    );

    channel_unit #(
        .P_MI0(20'd1495), .P_MI1(20'd1449), .P_MI2(20'd4095),
        .P_INV0(20'd37), .P_INV1(20'd24), .P_INV2(20'd1),
        .P_M_TOTAL(20'd94185),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd5)
    ) u_channel_30 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[30]),
        .dist_out(chan_dist[30])
    );

    channel_unit #(
        .P_MI0(20'd1235), .P_MI1(20'd1197), .P_MI2(20'd4095),
        .P_INV0(20'd5), .P_INV1(20'd53), .P_INV2(20'd2),
        .P_M_TOTAL(20'd77805),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd6)
    ) u_channel_31 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[31]),
        .dist_out(chan_dist[31])
    );

    channel_unit #(
        .P_MI0(20'd1105), .P_MI1(20'd1071), .P_MI2(20'd4095),
        .P_INV0(20'd13), .P_INV1(20'd21), .P_INV2(20'd8),
        .P_M_TOTAL(20'd69615),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd7)
    ) u_channel_32 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[32]),
        .dist_out(chan_dist[32])
    );

    channel_unit #(
        .P_MI0(20'd715), .P_MI1(20'd693), .P_MI2(20'd4095),
        .P_INV0(20'd43), .P_INV1(20'd62), .P_INV2(20'd4),
        .P_M_TOTAL(20'd45045),
        .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd8)
    ) u_channel_33 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[33]),
        .dist_out(chan_dist[33])
    );

    channel_unit #(
        .P_MI0(20'd899), .P_MI1(20'd1827), .P_MI2(20'd1953),
        .P_INV0(20'd26), .P_INV1(20'd15), .P_INV2(20'd3),
        .P_M_TOTAL(20'd56637),
        .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd4)
    ) u_channel_34 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[34]),
        .dist_out(chan_dist[34])
    );

    channel_unit #(
        .P_MI0(20'd713), .P_MI1(20'd1449), .P_MI2(20'd1953),
        .P_INV0(20'd41), .P_INV1(20'd27), .P_INV2(20'd11),
        .P_M_TOTAL(20'd44919),
        .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd5)
    ) u_channel_35 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[35]),
        .dist_out(chan_dist[35])
    );

    channel_unit #(
        .P_MI0(20'd589), .P_MI1(20'd1197), .P_MI2(20'd1953),
        .P_INV0(20'd43), .P_INV1(20'd18), .P_INV2(20'd14),
        .P_M_TOTAL(20'd37107),
        .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd6)
    ) u_channel_36 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[36]),
        .dist_out(chan_dist[36])
    );

    channel_unit #(
        .P_MI0(20'd527), .P_MI1(20'd1071), .P_MI2(20'd1953),
        .P_INV0(20'd11), .P_INV1(20'd11), .P_INV2(20'd8),
        .P_M_TOTAL(20'd33201),
        .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd7)
    ) u_channel_37 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[37]),
        .dist_out(chan_dist[37])
    );

    channel_unit #(
        .P_MI0(20'd341), .P_MI1(20'd693), .P_MI2(20'd1953),
        .P_INV0(20'd17), .P_INV1(20'd17), .P_INV2(20'd2),
        .P_M_TOTAL(20'd21483),
        .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd8)
    ) u_channel_38 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[38]),
        .dist_out(chan_dist[38])
    );

    channel_unit #(
        .P_MI0(20'd667), .P_MI1(20'd1449), .P_MI2(20'd1827),
        .P_INV0(20'd46), .P_INV1(20'd28), .P_INV2(20'd7),
        .P_M_TOTAL(20'd42021),
        .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd5)
    ) u_channel_39 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[39]),
        .dist_out(chan_dist[39])
    );

    channel_unit #(
        .P_MI0(20'd551), .P_MI1(20'd1197), .P_MI2(20'd1827),
        .P_INV0(20'd59), .P_INV1(20'd11), .P_INV2(20'd13),
        .P_M_TOTAL(20'd34713),
        .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd6)
    ) u_channel_40 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[40]),
        .dist_out(chan_dist[40])
    );

    channel_unit #(
        .P_MI0(20'd493), .P_MI1(20'd1071), .P_MI2(20'd1827),
        .P_INV0(20'd40), .P_INV1(20'd14), .P_INV2(20'd15),
        .P_M_TOTAL(20'd31059),
        .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd7)
    ) u_channel_41 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[41]),
        .dist_out(chan_dist[41])
    );

    channel_unit #(
        .P_MI0(20'd319), .P_MI1(20'd693), .P_MI2(20'd1827),
        .P_INV0(20'd16), .P_INV1(20'd19), .P_INV2(20'd1),
        .P_M_TOTAL(20'd20097),
        .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd8)
    ) u_channel_42 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[42]),
        .dist_out(chan_dist[42])
    );

    channel_unit #(
        .P_MI0(20'd437), .P_MI1(20'd1197), .P_MI2(20'd1449),
        .P_INV0(20'd47), .P_INV1(20'd1), .P_INV2(20'd4),
        .P_M_TOTAL(20'd27531),
        .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd6)
    ) u_channel_43 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[43]),
        .dist_out(chan_dist[43])
    );

    channel_unit #(
        .P_MI0(20'd391), .P_MI1(20'd1071), .P_MI2(20'd1449),
        .P_INV0(20'd34), .P_INV1(20'd16), .P_INV2(20'd13),
        .P_M_TOTAL(20'd24633),
        .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd7)
    ) u_channel_44 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[44]),
        .dist_out(chan_dist[44])
    );

    channel_unit #(
        .P_MI0(20'd253), .P_MI1(20'd693), .P_MI2(20'd1449),
        .P_INV0(20'd1), .P_INV1(20'd8), .P_INV2(20'd7),
        .P_M_TOTAL(20'd15939),
        .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd8)
    ) u_channel_45 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[45]),
        .dist_out(chan_dist[45])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd1071), .P_MI2(20'd1197),
        .P_INV0(20'd8), .P_INV1(20'd11), .P_INV2(20'd5),
        .P_M_TOTAL(20'd20349),
        .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_46 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[46]),
        .dist_out(chan_dist[46])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd693), .P_MI2(20'd1197),
        .P_INV0(20'd41), .P_INV1(20'd17), .P_INV2(20'd5),
        .P_M_TOTAL(20'd13167),
        .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_47 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[47]),
        .dist_out(chan_dist[47])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd693), .P_MI2(20'd1071),
        .P_INV0(20'd31), .P_INV1(20'd4), .P_INV2(20'd3),
        .P_M_TOTAL(20'd11781),
        .P_IDX1(4'd1), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_48 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[48]),
        .dist_out(chan_dist[48])
    );

    channel_unit #(
        .P_MI0(20'd899), .P_MI1(20'd1885), .P_MI2(20'd2015),
        .P_INV0(20'd59), .P_INV1(20'd5), .P_INV2(20'd27),
        .P_M_TOTAL(20'd58435),
        .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd4)
    ) u_channel_49 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[49]),
        .dist_out(chan_dist[49])
    );

    channel_unit #(
        .P_MI0(20'd713), .P_MI1(20'd1495), .P_MI2(20'd2015),
        .P_INV0(20'd32), .P_INV1(20'd9), .P_INV2(20'd5),
        .P_M_TOTAL(20'd46345),
        .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd5)
    ) u_channel_50 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[50]),
        .dist_out(chan_dist[50])
    );

    channel_unit #(
        .P_MI0(20'd589), .P_MI1(20'd1235), .P_MI2(20'd2015),
        .P_INV0(20'd49), .P_INV1(20'd6), .P_INV2(20'd1),
        .P_M_TOTAL(20'd38285),
        .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd6)
    ) u_channel_51 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[51]),
        .dist_out(chan_dist[51])
    );

    channel_unit #(
        .P_MI0(20'd527), .P_MI1(20'd1105), .P_MI2(20'd2015),
        .P_INV0(20'd28), .P_INV1(20'd14), .P_INV2(20'd2),
        .P_M_TOTAL(20'd34255),
        .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd7)
    ) u_channel_52 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[52]),
        .dist_out(chan_dist[52])
    );

    channel_unit #(
        .P_MI0(20'd341), .P_MI1(20'd715), .P_MI2(20'd2015),
        .P_INV0(20'd61), .P_INV1(20'd16), .P_INV2(20'd6),
        .P_M_TOTAL(20'd22165),
        .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd8)
    ) u_channel_53 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[53]),
        .dist_out(chan_dist[53])
    );

    channel_unit #(
        .P_MI0(20'd667), .P_MI1(20'd1495), .P_MI2(20'd1885),
        .P_INV0(20'd23), .P_INV1(20'd20), .P_INV2(20'd22),
        .P_M_TOTAL(20'd43355),
        .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd5)
    ) u_channel_54 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[54]),
        .dist_out(chan_dist[54])
    );

    channel_unit #(
        .P_MI0(20'd551), .P_MI1(20'd1235), .P_MI2(20'd1885),
        .P_INV0(20'd21), .P_INV1(20'd12), .P_INV2(20'd5),
        .P_M_TOTAL(20'd35815),
        .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd6)
    ) u_channel_55 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[55]),
        .dist_out(chan_dist[55])
    );

    channel_unit #(
        .P_MI0(20'd493), .P_MI1(20'd1105), .P_MI2(20'd1885),
        .P_INV0(20'd12), .P_INV1(20'd10), .P_INV2(20'd8),
        .P_M_TOTAL(20'd32045),
        .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd7)
    ) u_channel_56 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[56]),
        .dist_out(chan_dist[56])
    );

    channel_unit #(
        .P_MI0(20'd319), .P_MI1(20'd715), .P_MI2(20'd1885),
        .P_INV0(20'd54), .P_INV1(20'd26), .P_INV2(20'd3),
        .P_M_TOTAL(20'd20735),
        .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd8)
    ) u_channel_57 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[57]),
        .dist_out(chan_dist[57])
    );

    channel_unit #(
        .P_MI0(20'd437), .P_MI1(20'd1235), .P_MI2(20'd1495),
        .P_INV0(20'd18), .P_INV1(20'd13), .P_INV2(20'd3),
        .P_M_TOTAL(20'd28405),
        .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd6)
    ) u_channel_58 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[58]),
        .dist_out(chan_dist[58])
    );

    channel_unit #(
        .P_MI0(20'd391), .P_MI1(20'd1105), .P_MI2(20'd1495),
        .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd16),
        .P_M_TOTAL(20'd25415),
        .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd7)
    ) u_channel_59 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[59]),
        .dist_out(chan_dist[59])
    );

    channel_unit #(
        .P_MI0(20'd253), .P_MI1(20'd715), .P_MI2(20'd1495),
        .P_INV0(20'd37), .P_INV1(20'd12), .P_INV2(20'd10),
        .P_M_TOTAL(20'd16445),
        .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd8)
    ) u_channel_60 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[60]),
        .dist_out(chan_dist[60])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd1105), .P_MI2(20'd1235),
        .P_INV0(20'd32), .P_INV1(20'd13), .P_INV2(20'd14),
        .P_M_TOTAL(20'd20995),
        .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_61 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[61]),
        .dist_out(chan_dist[61])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd715), .P_MI2(20'd1235),
        .P_INV0(20'd14), .P_INV1(20'd8), .P_INV2(20'd4),
        .P_M_TOTAL(20'd13585),
        .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_62 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[62]),
        .dist_out(chan_dist[62])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd715), .P_MI2(20'd1105),
        .P_INV0(20'd8), .P_INV1(20'd1), .P_INV2(20'd9),
        .P_M_TOTAL(20'd12155),
        .P_IDX1(4'd2), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_63 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[63]),
        .dist_out(chan_dist[63])
    );

    channel_unit #(
        .P_MI0(20'd667), .P_MI1(20'd713), .P_MI2(20'd899),
        .P_INV0(20'd2), .P_INV1(20'd12), .P_INV2(20'd12),
        .P_M_TOTAL(20'd20677),
        .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd5)
    ) u_channel_64 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[64]),
        .dist_out(chan_dist[64])
    );

    channel_unit #(
        .P_MI0(20'd551), .P_MI1(20'd589), .P_MI2(20'd899),
        .P_INV0(20'd22), .P_INV1(20'd13), .P_INV2(20'd16),
        .P_M_TOTAL(20'd17081),
        .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd6)
    ) u_channel_65 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[65]),
        .dist_out(chan_dist[65])
    );

    channel_unit #(
        .P_MI0(20'd493), .P_MI1(20'd527), .P_MI2(20'd899),
        .P_INV0(20'd10), .P_INV1(20'd6), .P_INV2(20'd8),
        .P_M_TOTAL(20'd15283),
        .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd7)
    ) u_channel_66 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[66]),
        .dist_out(chan_dist[66])
    );

    channel_unit #(
        .P_MI0(20'd319), .P_MI1(20'd341), .P_MI2(20'd899),
        .P_INV0(20'd7), .P_INV1(20'd4), .P_INV2(20'd7),
        .P_M_TOTAL(20'd9889),
        .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd8)
    ) u_channel_67 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[67]),
        .dist_out(chan_dist[67])
    );

    channel_unit #(
        .P_MI0(20'd437), .P_MI1(20'd589), .P_MI2(20'd713),
        .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd2),
        .P_M_TOTAL(20'd13547),
        .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd6)
    ) u_channel_68 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[68]),
        .dist_out(chan_dist[68])
    );

    channel_unit #(
        .P_MI0(20'd391), .P_MI1(20'd527), .P_MI2(20'd713),
        .P_INV0(20'd18), .P_INV1(20'd11), .P_INV2(20'd16),
        .P_M_TOTAL(20'd12121),
        .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd7)
    ) u_channel_69 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[69]),
        .dist_out(chan_dist[69])
    );

    channel_unit #(
        .P_MI0(20'd253), .P_MI1(20'd341), .P_MI2(20'd713),
        .P_INV0(20'd25), .P_INV1(20'd17), .P_INV2(20'd5),
        .P_M_TOTAL(20'd7843),
        .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd8)
    ) u_channel_70 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[70]),
        .dist_out(chan_dist[70])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd527), .P_MI2(20'd589),
        .P_INV0(20'd12), .P_INV1(20'd15), .P_INV2(20'd14),
        .P_M_TOTAL(20'd10013),
        .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_71 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[71]),
        .dist_out(chan_dist[71])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd341), .P_MI2(20'd589),
        .P_INV0(20'd27), .P_INV1(20'd18), .P_INV2(20'd2),
        .P_M_TOTAL(20'd6479),
        .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_72 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[72]),
        .dist_out(chan_dist[72])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd341), .P_MI2(20'd527),
        .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd10),
        .P_M_TOTAL(20'd5797),
        .P_IDX1(4'd3), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_73 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[73]),
        .dist_out(chan_dist[73])
    );

    channel_unit #(
        .P_MI0(20'd437), .P_MI1(20'd551), .P_MI2(20'd667),
        .P_INV0(20'd15), .P_INV1(20'd22), .P_INV2(20'd10),
        .P_M_TOTAL(20'd12673),
        .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd6)
    ) u_channel_74 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[74]),
        .dist_out(chan_dist[74])
    );

    channel_unit #(
        .P_MI0(20'd391), .P_MI1(20'd493), .P_MI2(20'd667),
        .P_INV0(20'd27), .P_INV1(20'd7), .P_INV2(20'd13),
        .P_M_TOTAL(20'd11339),
        .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd7)
    ) u_channel_75 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[75]),
        .dist_out(chan_dist[75])
    );

    channel_unit #(
        .P_MI0(20'd253), .P_MI1(20'd319), .P_MI2(20'd667),
        .P_INV0(20'd18), .P_INV1(20'd15), .P_INV2(20'd8),
        .P_M_TOTAL(20'd7337),
        .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd8)
    ) u_channel_76 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[76]),
        .dist_out(chan_dist[76])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd493), .P_MI2(20'd551),
        .P_INV0(20'd22), .P_INV1(20'd18), .P_INV2(20'd5),
        .P_M_TOTAL(20'd9367),
        .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_77 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[77]),
        .dist_out(chan_dist[77])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd319), .P_MI2(20'd551),
        .P_INV0(20'd5), .P_INV1(20'd14), .P_INV2(20'd1),
        .P_M_TOTAL(20'd6061),
        .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_78 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[78]),
        .dist_out(chan_dist[78])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd319), .P_MI2(20'd493),
        .P_INV0(20'd9), .P_INV1(20'd4), .P_INV2(20'd5),
        .P_M_TOTAL(20'd5423),
        .P_IDX1(4'd4), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_79 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[79]),
        .dist_out(chan_dist[79])
    );

    channel_unit #(
        .P_MI0(20'd323), .P_MI1(20'd391), .P_MI2(20'd437),
        .P_INV0(20'd1), .P_INV1(20'd7), .P_INV2(20'd10),
        .P_M_TOTAL(20'd7429),
        .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd7)
    ) u_channel_80 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[80]),
        .dist_out(chan_dist[80])
    );

    channel_unit #(
        .P_MI0(20'd209), .P_MI1(20'd253), .P_MI2(20'd437),
        .P_INV0(20'd12), .P_INV1(20'd16), .P_INV2(20'd7),
        .P_M_TOTAL(20'd4807),
        .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd8)
    ) u_channel_81 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[81]),
        .dist_out(chan_dist[81])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd253), .P_MI2(20'd391),
        .P_INV0(20'd8), .P_INV1(20'd8), .P_INV2(20'd2),
        .P_M_TOTAL(20'd4301),
        .P_IDX1(4'd5), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_82 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[82]),
        .dist_out(chan_dist[82])
    );

    channel_unit #(
        .P_MI0(20'd187), .P_MI1(20'd209), .P_MI2(20'd323),
        .P_INV0(20'd6), .P_INV1(20'd7), .P_INV2(20'd3),
        .P_M_TOTAL(20'd3553),
        .P_IDX1(4'd6), .P_IDX2(4'd7), .P_IDX3(4'd8)
    ) u_channel_83 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x[83]),
        .dist_out(chan_dist[83])
    );

    // --- Min Distance Finder (Native SV For-Loop) ---
    logic [15:0] min_dist;
    logic [6:0]  min_idx;

    always_comb begin
        min_dist = 16'hFFFF;
        min_idx  = 7'd0;
        for (int k = 0; k < 84; k++) begin
            if (chan_dist[k] < min_dist) begin
                min_dist = chan_dist[k];
                min_idx  = k[6:0];
            end
        end
    end

    // --- Output Register ---
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out      <= 20'd0;
            valid         <= 1'b0;
            uncorrectable <= 1'b0;
        end else if (start) begin
            data_out      <= chan_x[min_idx];
            valid         <= 1'b1;
            uncorrectable <= (min_dist > 16'd100);
        end
    end

endmodule
