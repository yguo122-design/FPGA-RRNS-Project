`timescale 1ns / 1ps

// Module: decoder_group_0 (Verification Version)
// Channels: 0 to 20

module decoder_group_0 (
    input wire [6:0] r0, input wire [6:0] r1, input wire [6:0] r2,
    input wire [6:0] r3, input wire [6:0] r4, input wire [6:0] r5,
    input wire [6:0] r6, input wire [6:0] r7, input wire [6:0] r8,
    output wire [15:0] min_dist_out,
    output wire [6:0] min_idx_out,
    output wire [19:0] best_x_out
);

    wire [19:0] chan_x_0, chan_x_1, chan_x_2, chan_x_3, chan_x_4, chan_x_5, chan_x_6, chan_x_7, chan_x_8, chan_x_9, chan_x_10, chan_x_11, chan_x_12, chan_x_13, chan_x_14, chan_x_15, chan_x_16, chan_x_17, chan_x_18, chan_x_19, chan_x_20;
    wire [15:0] chan_dist_0, chan_dist_1, chan_dist_2, chan_dist_3, chan_dist_4, chan_dist_5, chan_dist_6, chan_dist_7, chan_dist_8, chan_dist_9, chan_dist_10, chan_dist_11, chan_dist_12, chan_dist_13, chan_dist_14, chan_dist_15, chan_dist_16, chan_dist_17, chan_dist_18, chan_dist_19, chan_dist_20;

    channel_unit #(
        .P_MI0(20'd4095), .P_MI1(20'd4160), .P_MI2(20'd4032),
        .P_INV0(20'd63), .P_INV1(20'd32), .P_INV2(20'd33),
        .P_M_TOTAL(20'd262080),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd2)
    ) u_channel_0 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_0),
        .dist_out(chan_dist_0)
    );

    channel_unit #(
        .P_MI0(20'd1953), .P_MI1(20'd1984), .P_MI2(20'd4032),
        .P_INV0(20'd33), .P_INV1(20'd61), .P_INV2(20'd16),
        .P_M_TOTAL(20'd124992),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd3)
    ) u_channel_1 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_1),
        .dist_out(chan_dist_1)
    );

    channel_unit #(
        .P_MI0(20'd1827), .P_MI1(20'd1856), .P_MI2(20'd4032),
        .P_INV0(20'd11), .P_INV1(20'd50), .P_INV2(20'd1),
        .P_M_TOTAL(20'd116928),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd4)
    ) u_channel_2 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_2),
        .dist_out(chan_dist_2)
    );

    channel_unit #(
        .P_MI0(20'd1449), .P_MI1(20'd1472), .P_MI2(20'd4032),
        .P_INV0(20'd25), .P_INV1(20'd11), .P_INV2(20'd10),
        .P_M_TOTAL(20'd92736),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd5)
    ) u_channel_3 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_3),
        .dist_out(chan_dist_3)
    );

    channel_unit #(
        .P_MI0(20'd1197), .P_MI1(20'd1216), .P_MI2(20'd4032),
        .P_INV0(20'd37), .P_INV1(20'd10), .P_INV2(20'd5),
        .P_M_TOTAL(20'd76608),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd6)
    ) u_channel_4 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_4),
        .dist_out(chan_dist_4)
    );

    channel_unit #(
        .P_MI0(20'd1071), .P_MI1(20'd1088), .P_MI2(20'd4032),
        .P_INV0(20'd15), .P_INV1(20'd26), .P_INV2(20'd6),
        .P_M_TOTAL(20'd68544),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd7)
    ) u_channel_5 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_5),
        .dist_out(chan_dist_5)
    );

    channel_unit #(
        .P_MI0(20'd693), .P_MI1(20'd704), .P_MI2(20'd4032),
        .P_INV0(20'd29), .P_INV1(20'd23), .P_INV2(20'd2),
        .P_M_TOTAL(20'd44352),
        .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd8)
    ) u_channel_6 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_6),
        .dist_out(chan_dist_6)
    );

    channel_unit #(
        .P_MI0(20'd2015), .P_MI1(20'd1984), .P_MI2(20'd4160),
        .P_INV0(20'd31), .P_INV1(20'd44), .P_INV2(20'd26),
        .P_M_TOTAL(20'd128960),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd3)
    ) u_channel_7 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_7),
        .dist_out(chan_dist_7)
    );

    channel_unit #(
        .P_MI0(20'd1885), .P_MI1(20'd1856), .P_MI2(20'd4160),
        .P_INV0(20'd53), .P_INV1(20'd56), .P_INV2(20'd9),
        .P_M_TOTAL(20'd120640),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd4)
    ) u_channel_8 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_8),
        .dist_out(chan_dist_8)
    );

    channel_unit #(
        .P_MI0(20'd1495), .P_MI1(20'd1472), .P_MI2(20'd4160),
        .P_INV0(20'd39), .P_INV1(20'd48), .P_INV2(20'd15),
        .P_M_TOTAL(20'd95680),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd5)
    ) u_channel_9 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_9),
        .dist_out(chan_dist_9)
    );

    channel_unit #(
        .P_MI0(20'd1235), .P_MI1(20'd1216), .P_MI2(20'd4160),
        .P_INV0(20'd27), .P_INV1(20'd41), .P_INV2(20'd18),
        .P_M_TOTAL(20'd79040),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd6)
    ) u_channel_10 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_10),
        .dist_out(chan_dist_10)
    );

    channel_unit #(
        .P_MI0(20'd1105), .P_MI1(20'd1088), .P_MI2(20'd4160),
        .P_INV0(20'd49), .P_INV1(20'd42), .P_INV2(20'd10),
        .P_M_TOTAL(20'd70720),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd7)
    ) u_channel_11 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_11),
        .dist_out(chan_dist_11)
    );

    channel_unit #(
        .P_MI0(20'd715), .P_MI1(20'd704), .P_MI2(20'd4160),
        .P_INV0(20'd35), .P_INV1(20'd59), .P_INV2(20'd6),
        .P_M_TOTAL(20'd45760),
        .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd8)
    ) u_channel_12 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_12),
        .dist_out(chan_dist_12)
    );

    channel_unit #(
        .P_MI0(20'd899), .P_MI1(20'd1856), .P_MI2(20'd1984),
        .P_INV0(20'd43), .P_INV1(20'd23), .P_INV2(20'd17),
        .P_M_TOTAL(20'd57536),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd4)
    ) u_channel_13 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_13),
        .dist_out(chan_dist_13)
    );

    channel_unit #(
        .P_MI0(20'd713), .P_MI1(20'd1472), .P_MI2(20'd1984),
        .P_INV0(20'd57), .P_INV1(20'd29), .P_INV2(20'd4),
        .P_M_TOTAL(20'd45632),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd5)
    ) u_channel_14 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_14),
        .dist_out(chan_dist_14)
    );

    channel_unit #(
        .P_MI0(20'd589), .P_MI1(20'd1216), .P_MI2(20'd1984),
        .P_INV0(20'd5), .P_INV1(20'd9), .P_INV2(20'd12),
        .P_M_TOTAL(20'd37696),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd6)
    ) u_channel_15 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_15),
        .dist_out(chan_dist_15)
    );

    channel_unit #(
        .P_MI0(20'd527), .P_MI1(20'd1088), .P_MI2(20'd1984),
        .P_INV0(20'd47), .P_INV1(20'd21), .P_INV2(20'd10),
        .P_M_TOTAL(20'd33728),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd7)
    ) u_channel_16 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_16),
        .dist_out(chan_dist_16)
    );

    channel_unit #(
        .P_MI0(20'd341), .P_MI1(20'd704), .P_MI2(20'd1984),
        .P_INV0(20'd61), .P_INV1(20'd24), .P_INV2(20'd3),
        .P_M_TOTAL(20'd21824),
        .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd8)
    ) u_channel_17 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_17),
        .dist_out(chan_dist_17)
    );

    channel_unit #(
        .P_MI0(20'd667), .P_MI1(20'd1472), .P_MI2(20'd1856),
        .P_INV0(20'd19), .P_INV1(20'd4), .P_INV2(20'd13),
        .P_M_TOTAL(20'd42688),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd5)
    ) u_channel_18 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_18),
        .dist_out(chan_dist_18)
    );

    channel_unit #(
        .P_MI0(20'd551), .P_MI1(20'd1216), .P_MI2(20'd1856),
        .P_INV0(20'd23), .P_INV1(20'd14), .P_INV2(20'd3),
        .P_M_TOTAL(20'd35264),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd6)
    ) u_channel_19 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_19),
        .dist_out(chan_dist_19)
    );

    channel_unit #(
        .P_MI0(20'd493), .P_MI1(20'd1088), .P_MI2(20'd1856),
        .P_INV0(20'd37), .P_INV1(20'd2), .P_INV2(20'd6),
        .P_M_TOTAL(20'd31552),
        .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd7)
    ) u_channel_20 (
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .x_out(chan_x_20),
        .dist_out(chan_dist_20)
    );

    reg [15:0] min_dist_reg;
    reg [6:0] min_idx_reg;
    always @(*) begin
        min_dist_reg = 16'hFFFF;
        min_idx_reg = 7'd0;
        if (chan_dist_0 < min_dist_reg) begin
            min_dist_reg = chan_dist_0;
            min_idx_reg = 7'd0;
        end
        if (chan_dist_1 < min_dist_reg) begin
            min_dist_reg = chan_dist_1;
            min_idx_reg = 7'd1;
        end
        if (chan_dist_2 < min_dist_reg) begin
            min_dist_reg = chan_dist_2;
            min_idx_reg = 7'd2;
        end
        if (chan_dist_3 < min_dist_reg) begin
            min_dist_reg = chan_dist_3;
            min_idx_reg = 7'd3;
        end
        if (chan_dist_4 < min_dist_reg) begin
            min_dist_reg = chan_dist_4;
            min_idx_reg = 7'd4;
        end
        if (chan_dist_5 < min_dist_reg) begin
            min_dist_reg = chan_dist_5;
            min_idx_reg = 7'd5;
        end
        if (chan_dist_6 < min_dist_reg) begin
            min_dist_reg = chan_dist_6;
            min_idx_reg = 7'd6;
        end
        if (chan_dist_7 < min_dist_reg) begin
            min_dist_reg = chan_dist_7;
            min_idx_reg = 7'd7;
        end
        if (chan_dist_8 < min_dist_reg) begin
            min_dist_reg = chan_dist_8;
            min_idx_reg = 7'd8;
        end
        if (chan_dist_9 < min_dist_reg) begin
            min_dist_reg = chan_dist_9;
            min_idx_reg = 7'd9;
        end
        if (chan_dist_10 < min_dist_reg) begin
            min_dist_reg = chan_dist_10;
            min_idx_reg = 7'd10;
        end
        if (chan_dist_11 < min_dist_reg) begin
            min_dist_reg = chan_dist_11;
            min_idx_reg = 7'd11;
        end
        if (chan_dist_12 < min_dist_reg) begin
            min_dist_reg = chan_dist_12;
            min_idx_reg = 7'd12;
        end
        if (chan_dist_13 < min_dist_reg) begin
            min_dist_reg = chan_dist_13;
            min_idx_reg = 7'd13;
        end
        if (chan_dist_14 < min_dist_reg) begin
            min_dist_reg = chan_dist_14;
            min_idx_reg = 7'd14;
        end
        if (chan_dist_15 < min_dist_reg) begin
            min_dist_reg = chan_dist_15;
            min_idx_reg = 7'd15;
        end
        if (chan_dist_16 < min_dist_reg) begin
            min_dist_reg = chan_dist_16;
            min_idx_reg = 7'd16;
        end
        if (chan_dist_17 < min_dist_reg) begin
            min_dist_reg = chan_dist_17;
            min_idx_reg = 7'd17;
        end
        if (chan_dist_18 < min_dist_reg) begin
            min_dist_reg = chan_dist_18;
            min_idx_reg = 7'd18;
        end
        if (chan_dist_19 < min_dist_reg) begin
            min_dist_reg = chan_dist_19;
            min_idx_reg = 7'd19;
        end
        if (chan_dist_20 < min_dist_reg) begin
            min_dist_reg = chan_dist_20;
            min_idx_reg = 7'd20;
        end
    end
    assign min_dist_out = min_dist_reg;
    assign min_idx_out = min_idx_reg;
    reg [19:0] best_x_reg;
    always @(*) begin
        case(min_idx_reg)
            7'd0: best_x_reg = chan_x_0;
            7'd1: best_x_reg = chan_x_1;
            7'd2: best_x_reg = chan_x_2;
            7'd3: best_x_reg = chan_x_3;
            7'd4: best_x_reg = chan_x_4;
            7'd5: best_x_reg = chan_x_5;
            7'd6: best_x_reg = chan_x_6;
            7'd7: best_x_reg = chan_x_7;
            7'd8: best_x_reg = chan_x_8;
            7'd9: best_x_reg = chan_x_9;
            7'd10: best_x_reg = chan_x_10;
            7'd11: best_x_reg = chan_x_11;
            7'd12: best_x_reg = chan_x_12;
            7'd13: best_x_reg = chan_x_13;
            7'd14: best_x_reg = chan_x_14;
            7'd15: best_x_reg = chan_x_15;
            7'd16: best_x_reg = chan_x_16;
            7'd17: best_x_reg = chan_x_17;
            7'd18: best_x_reg = chan_x_18;
            7'd19: best_x_reg = chan_x_19;
            7'd20: best_x_reg = chan_x_20;
            default: best_x_reg = 20'd0;
        endcase
    end
    assign best_x_out = best_x_reg;

endmodule
