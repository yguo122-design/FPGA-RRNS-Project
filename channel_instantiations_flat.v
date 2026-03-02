// --- Auto-generated Channel Instantiations (FLAT BUS VERSION) ---
// Connects to chan_x_bus and chan_dist_bus using bit-slicing

        channel_unit #(
            .P_MI0(20'd4095), .P_MI1(20'd4160), .P_MI2(20'd4032),
            .P_INV0(20'd63), .P_INV1(20'd32), .P_INV2(20'd33),
            .P_M_TOTAL(20'd262080),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd2)
        ) u_channel_0 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[0 +: 20]),
            .dist_out(chan_dist_bus[0 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1953), .P_MI1(20'd1984), .P_MI2(20'd4032),
            .P_INV0(20'd33), .P_INV1(20'd61), .P_INV2(20'd16),
            .P_M_TOTAL(20'd124992),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd3)
        ) u_channel_1 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[20 +: 20]),
            .dist_out(chan_dist_bus[16 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1827), .P_MI1(20'd1856), .P_MI2(20'd4032),
            .P_INV0(20'd11), .P_INV1(20'd50), .P_INV2(20'd1),
            .P_M_TOTAL(20'd116928),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd4)
        ) u_channel_2 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[40 +: 20]),
            .dist_out(chan_dist_bus[32 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1449), .P_MI1(20'd1472), .P_MI2(20'd4032),
            .P_INV0(20'd25), .P_INV1(20'd11), .P_INV2(20'd10),
            .P_M_TOTAL(20'd92736),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd5)
        ) u_channel_3 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[60 +: 20]),
            .dist_out(chan_dist_bus[48 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1197), .P_MI1(20'd1216), .P_MI2(20'd4032),
            .P_INV0(20'd37), .P_INV1(20'd10), .P_INV2(20'd5),
            .P_M_TOTAL(20'd76608),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd6)
        ) u_channel_4 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[80 +: 20]),
            .dist_out(chan_dist_bus[64 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1071), .P_MI1(20'd1088), .P_MI2(20'd4032),
            .P_INV0(20'd15), .P_INV1(20'd26), .P_INV2(20'd6),
            .P_M_TOTAL(20'd68544),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd7)
        ) u_channel_5 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[100 +: 20]),
            .dist_out(chan_dist_bus[80 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd693), .P_MI1(20'd704), .P_MI2(20'd4032),
            .P_INV0(20'd29), .P_INV1(20'd23), .P_INV2(20'd2),
            .P_M_TOTAL(20'd44352),
            .P_IDX1(4'd0), .P_IDX2(4'd1), .P_IDX3(4'd8)
        ) u_channel_6 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[120 +: 20]),
            .dist_out(chan_dist_bus[96 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd2015), .P_MI1(20'd1984), .P_MI2(20'd4160),
            .P_INV0(20'd31), .P_INV1(20'd44), .P_INV2(20'd26),
            .P_M_TOTAL(20'd128960),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd3)
        ) u_channel_7 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[140 +: 20]),
            .dist_out(chan_dist_bus[112 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1885), .P_MI1(20'd1856), .P_MI2(20'd4160),
            .P_INV0(20'd53), .P_INV1(20'd56), .P_INV2(20'd9),
            .P_M_TOTAL(20'd120640),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd4)
        ) u_channel_8 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[160 +: 20]),
            .dist_out(chan_dist_bus[128 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1495), .P_MI1(20'd1472), .P_MI2(20'd4160),
            .P_INV0(20'd39), .P_INV1(20'd48), .P_INV2(20'd15),
            .P_M_TOTAL(20'd95680),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd5)
        ) u_channel_9 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[180 +: 20]),
            .dist_out(chan_dist_bus[144 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1235), .P_MI1(20'd1216), .P_MI2(20'd4160),
            .P_INV0(20'd27), .P_INV1(20'd41), .P_INV2(20'd18),
            .P_M_TOTAL(20'd79040),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd6)
        ) u_channel_10 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[200 +: 20]),
            .dist_out(chan_dist_bus[160 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1105), .P_MI1(20'd1088), .P_MI2(20'd4160),
            .P_INV0(20'd49), .P_INV1(20'd42), .P_INV2(20'd10),
            .P_M_TOTAL(20'd70720),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd7)
        ) u_channel_11 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[220 +: 20]),
            .dist_out(chan_dist_bus[176 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd715), .P_MI1(20'd704), .P_MI2(20'd4160),
            .P_INV0(20'd35), .P_INV1(20'd59), .P_INV2(20'd6),
            .P_M_TOTAL(20'd45760),
            .P_IDX1(4'd0), .P_IDX2(4'd2), .P_IDX3(4'd8)
        ) u_channel_12 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[240 +: 20]),
            .dist_out(chan_dist_bus[192 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd899), .P_MI1(20'd1856), .P_MI2(20'd1984),
            .P_INV0(20'd43), .P_INV1(20'd23), .P_INV2(20'd17),
            .P_M_TOTAL(20'd57536),
            .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd4)
        ) u_channel_13 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[260 +: 20]),
            .dist_out(chan_dist_bus[208 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd713), .P_MI1(20'd1472), .P_MI2(20'd1984),
            .P_INV0(20'd57), .P_INV1(20'd29), .P_INV2(20'd4),
            .P_M_TOTAL(20'd45632),
            .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd5)
        ) u_channel_14 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[280 +: 20]),
            .dist_out(chan_dist_bus[224 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd589), .P_MI1(20'd1216), .P_MI2(20'd1984),
            .P_INV0(20'd5), .P_INV1(20'd9), .P_INV2(20'd12),
            .P_M_TOTAL(20'd37696),
            .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd6)
        ) u_channel_15 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[300 +: 20]),
            .dist_out(chan_dist_bus[240 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd527), .P_MI1(20'd1088), .P_MI2(20'd1984),
            .P_INV0(20'd47), .P_INV1(20'd21), .P_INV2(20'd10),
            .P_M_TOTAL(20'd33728),
            .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd7)
        ) u_channel_16 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[320 +: 20]),
            .dist_out(chan_dist_bus[256 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd341), .P_MI1(20'd704), .P_MI2(20'd1984),
            .P_INV0(20'd61), .P_INV1(20'd24), .P_INV2(20'd3),
            .P_M_TOTAL(20'd21824),
            .P_IDX1(4'd0), .P_IDX2(4'd3), .P_IDX3(4'd8)
        ) u_channel_17 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[340 +: 20]),
            .dist_out(chan_dist_bus[272 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd1472), .P_MI2(20'd1856),
            .P_INV0(20'd19), .P_INV1(20'd4), .P_INV2(20'd13),
            .P_M_TOTAL(20'd42688),
            .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_18 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[360 +: 20]),
            .dist_out(chan_dist_bus[288 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd1216), .P_MI2(20'd1856),
            .P_INV0(20'd23), .P_INV1(20'd14), .P_INV2(20'd3),
            .P_M_TOTAL(20'd35264),
            .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_19 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[380 +: 20]),
            .dist_out(chan_dist_bus[304 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd1088), .P_MI2(20'd1856),
            .P_INV0(20'd37), .P_INV1(20'd2), .P_INV2(20'd6),
            .P_M_TOTAL(20'd31552),
            .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_20 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[400 +: 20]),
            .dist_out(chan_dist_bus[320 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd704), .P_MI2(20'd1856),
            .P_INV0(20'd63), .P_INV1(20'd11), .P_INV2(20'd7),
            .P_M_TOTAL(20'd20416),
            .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_21 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[420 +: 20]),
            .dist_out(chan_dist_bus[336 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1216), .P_MI2(20'd1472),
            .P_INV0(20'd29), .P_INV1(20'd15), .P_INV2(20'd17),
            .P_M_TOTAL(20'd27968),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_22 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[440 +: 20]),
            .dist_out(chan_dist_bus[352 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1088), .P_MI2(20'd1472),
            .P_INV0(20'd55), .P_INV1(20'd10), .P_INV2(20'd12),
            .P_M_TOTAL(20'd25024),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_23 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[460 +: 20]),
            .dist_out(chan_dist_bus[368 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd704), .P_MI2(20'd1472),
            .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd5),
            .P_M_TOTAL(20'd16192),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_24 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[480 +: 20]),
            .dist_out(chan_dist_bus[384 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1088), .P_MI2(20'd1216),
            .P_INV0(20'd43), .P_INV1(20'd4), .P_INV2(20'd2),
            .P_M_TOTAL(20'd20672),
            .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_25 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[500 +: 20]),
            .dist_out(chan_dist_bus[400 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd704), .P_MI2(20'd1216),
            .P_INV0(20'd49), .P_INV1(20'd1), .P_INV2(20'd2),
            .P_M_TOTAL(20'd13376),
            .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_26 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[520 +: 20]),
            .dist_out(chan_dist_bus[416 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd704), .P_MI2(20'd1088),
            .P_INV0(20'd51), .P_INV1(20'd5), .P_INV2(20'd10),
            .P_M_TOTAL(20'd11968),
            .P_IDX1(4'd0), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_27 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[540 +: 20]),
            .dist_out(chan_dist_bus[432 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd2015), .P_MI1(20'd1953), .P_MI2(20'd4095),
            .P_INV0(20'd62), .P_INV1(20'd22), .P_INV2(20'd21),
            .P_M_TOTAL(20'd126945),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd3)
        ) u_channel_28 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[560 +: 20]),
            .dist_out(chan_dist_bus[448 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1885), .P_MI1(20'd1827), .P_MI2(20'd4095),
            .P_INV0(20'd25), .P_INV1(20'd28), .P_INV2(20'd5),
            .P_M_TOTAL(20'd118755),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd4)
        ) u_channel_29 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[580 +: 20]),
            .dist_out(chan_dist_bus[464 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1495), .P_MI1(20'd1449), .P_MI2(20'd4095),
            .P_INV0(20'd37), .P_INV1(20'd24), .P_INV2(20'd1),
            .P_M_TOTAL(20'd94185),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd5)
        ) u_channel_30 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[600 +: 20]),
            .dist_out(chan_dist_bus[480 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1235), .P_MI1(20'd1197), .P_MI2(20'd4095),
            .P_INV0(20'd5), .P_INV1(20'd53), .P_INV2(20'd2),
            .P_M_TOTAL(20'd77805),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd6)
        ) u_channel_31 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[620 +: 20]),
            .dist_out(chan_dist_bus[496 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd1105), .P_MI1(20'd1071), .P_MI2(20'd4095),
            .P_INV0(20'd13), .P_INV1(20'd21), .P_INV2(20'd8),
            .P_M_TOTAL(20'd69615),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd7)
        ) u_channel_32 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[640 +: 20]),
            .dist_out(chan_dist_bus[512 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd715), .P_MI1(20'd693), .P_MI2(20'd4095),
            .P_INV0(20'd43), .P_INV1(20'd62), .P_INV2(20'd4),
            .P_M_TOTAL(20'd45045),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd8)
        ) u_channel_33 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[660 +: 20]),
            .dist_out(chan_dist_bus[528 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd899), .P_MI1(20'd1827), .P_MI2(20'd1953),
            .P_INV0(20'd26), .P_INV1(20'd15), .P_INV2(20'd3),
            .P_M_TOTAL(20'd56637),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd4)
        ) u_channel_34 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[680 +: 20]),
            .dist_out(chan_dist_bus[544 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd713), .P_MI1(20'd1449), .P_MI2(20'd1953),
            .P_INV0(20'd41), .P_INV1(20'd27), .P_INV2(20'd11),
            .P_M_TOTAL(20'd44919),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd5)
        ) u_channel_35 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[700 +: 20]),
            .dist_out(chan_dist_bus[560 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd589), .P_MI1(20'd1197), .P_MI2(20'd1953),
            .P_INV0(20'd43), .P_INV1(20'd18), .P_INV2(20'd14),
            .P_M_TOTAL(20'd37107),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd6)
        ) u_channel_36 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[720 +: 20]),
            .dist_out(chan_dist_bus[576 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd527), .P_MI1(20'd1071), .P_MI2(20'd1953),
            .P_INV0(20'd11), .P_INV1(20'd11), .P_INV2(20'd8),
            .P_M_TOTAL(20'd33201),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd7)
        ) u_channel_37 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[740 +: 20]),
            .dist_out(chan_dist_bus[592 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd341), .P_MI1(20'd693), .P_MI2(20'd1953),
            .P_INV0(20'd17), .P_INV1(20'd17), .P_INV2(20'd2),
            .P_M_TOTAL(20'd21483),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd8)
        ) u_channel_38 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[760 +: 20]),
            .dist_out(chan_dist_bus[608 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd1449), .P_MI2(20'd1827),
            .P_INV0(20'd46), .P_INV1(20'd28), .P_INV2(20'd7),
            .P_M_TOTAL(20'd42021),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_39 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[780 +: 20]),
            .dist_out(chan_dist_bus[624 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd1197), .P_MI2(20'd1827),
            .P_INV0(20'd59), .P_INV1(20'd11), .P_INV2(20'd13),
            .P_M_TOTAL(20'd34713),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_40 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[800 +: 20]),
            .dist_out(chan_dist_bus[640 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd1071), .P_MI2(20'd1827),
            .P_INV0(20'd40), .P_INV1(20'd14), .P_INV2(20'd15),
            .P_M_TOTAL(20'd31059),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_41 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[820 +: 20]),
            .dist_out(chan_dist_bus[656 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd693), .P_MI2(20'd1827),
            .P_INV0(20'd16), .P_INV1(20'd19), .P_INV2(20'd1),
            .P_M_TOTAL(20'd20097),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_42 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[840 +: 20]),
            .dist_out(chan_dist_bus[672 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1197), .P_MI2(20'd1449),
            .P_INV0(20'd47), .P_INV1(20'd1), .P_INV2(20'd4),
            .P_M_TOTAL(20'd27531),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_43 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[860 +: 20]),
            .dist_out(chan_dist_bus[688 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1071), .P_MI2(20'd1449),
            .P_INV0(20'd34), .P_INV1(20'd16), .P_INV2(20'd13),
            .P_M_TOTAL(20'd24633),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_44 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[880 +: 20]),
            .dist_out(chan_dist_bus[704 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd693), .P_MI2(20'd1449),
            .P_INV0(20'd1), .P_INV1(20'd8), .P_INV2(20'd7),
            .P_M_TOTAL(20'd15939),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_45 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[900 +: 20]),
            .dist_out(chan_dist_bus[720 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1071), .P_MI2(20'd1197),
            .P_INV0(20'd8), .P_INV1(20'd11), .P_INV2(20'd5),
            .P_M_TOTAL(20'd20349),
            .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_46 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[920 +: 20]),
            .dist_out(chan_dist_bus[736 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd693), .P_MI2(20'd1197),
            .P_INV0(20'd41), .P_INV1(20'd17), .P_INV2(20'd5),
            .P_M_TOTAL(20'd13167),
            .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_47 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[940 +: 20]),
            .dist_out(chan_dist_bus[752 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd693), .P_MI2(20'd1071),
            .P_INV0(20'd31), .P_INV1(20'd4), .P_INV2(20'd3),
            .P_M_TOTAL(20'd11781),
            .P_IDX1(4'd1), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_48 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[960 +: 20]),
            .dist_out(chan_dist_bus[768 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd899), .P_MI1(20'd1885), .P_MI2(20'd2015),
            .P_INV0(20'd59), .P_INV1(20'd5), .P_INV2(20'd27),
            .P_M_TOTAL(20'd58435),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd4)
        ) u_channel_49 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[980 +: 20]),
            .dist_out(chan_dist_bus[784 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd713), .P_MI1(20'd1495), .P_MI2(20'd2015),
            .P_INV0(20'd32), .P_INV1(20'd9), .P_INV2(20'd5),
            .P_M_TOTAL(20'd46345),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd5)
        ) u_channel_50 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1000 +: 20]),
            .dist_out(chan_dist_bus[800 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd589), .P_MI1(20'd1235), .P_MI2(20'd2015),
            .P_INV0(20'd49), .P_INV1(20'd6), .P_INV2(20'd1),
            .P_M_TOTAL(20'd38285),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd6)
        ) u_channel_51 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1020 +: 20]),
            .dist_out(chan_dist_bus[816 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd527), .P_MI1(20'd1105), .P_MI2(20'd2015),
            .P_INV0(20'd28), .P_INV1(20'd14), .P_INV2(20'd2),
            .P_M_TOTAL(20'd34255),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd7)
        ) u_channel_52 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1040 +: 20]),
            .dist_out(chan_dist_bus[832 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd341), .P_MI1(20'd715), .P_MI2(20'd2015),
            .P_INV0(20'd61), .P_INV1(20'd16), .P_INV2(20'd6),
            .P_M_TOTAL(20'd22165),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd8)
        ) u_channel_53 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1060 +: 20]),
            .dist_out(chan_dist_bus[848 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd1495), .P_MI2(20'd1885),
            .P_INV0(20'd23), .P_INV1(20'd20), .P_INV2(20'd22),
            .P_M_TOTAL(20'd43355),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_54 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1080 +: 20]),
            .dist_out(chan_dist_bus[864 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd1235), .P_MI2(20'd1885),
            .P_INV0(20'd21), .P_INV1(20'd12), .P_INV2(20'd5),
            .P_M_TOTAL(20'd35815),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_55 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1100 +: 20]),
            .dist_out(chan_dist_bus[880 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd1105), .P_MI2(20'd1885),
            .P_INV0(20'd12), .P_INV1(20'd10), .P_INV2(20'd8),
            .P_M_TOTAL(20'd32045),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_56 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1120 +: 20]),
            .dist_out(chan_dist_bus[896 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd715), .P_MI2(20'd1885),
            .P_INV0(20'd54), .P_INV1(20'd26), .P_INV2(20'd3),
            .P_M_TOTAL(20'd20735),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_57 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1140 +: 20]),
            .dist_out(chan_dist_bus[912 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1235), .P_MI2(20'd1495),
            .P_INV0(20'd18), .P_INV1(20'd13), .P_INV2(20'd3),
            .P_M_TOTAL(20'd28405),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_58 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1160 +: 20]),
            .dist_out(chan_dist_bus[928 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1105), .P_MI2(20'd1495),
            .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd16),
            .P_M_TOTAL(20'd25415),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_59 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1180 +: 20]),
            .dist_out(chan_dist_bus[944 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd715), .P_MI2(20'd1495),
            .P_INV0(20'd37), .P_INV1(20'd12), .P_INV2(20'd10),
            .P_M_TOTAL(20'd16445),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_60 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1200 +: 20]),
            .dist_out(chan_dist_bus[960 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1105), .P_MI2(20'd1235),
            .P_INV0(20'd32), .P_INV1(20'd13), .P_INV2(20'd14),
            .P_M_TOTAL(20'd20995),
            .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_61 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1220 +: 20]),
            .dist_out(chan_dist_bus[976 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd715), .P_MI2(20'd1235),
            .P_INV0(20'd14), .P_INV1(20'd8), .P_INV2(20'd4),
            .P_M_TOTAL(20'd13585),
            .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_62 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1240 +: 20]),
            .dist_out(chan_dist_bus[992 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd715), .P_MI2(20'd1105),
            .P_INV0(20'd8), .P_INV1(20'd1), .P_INV2(20'd9),
            .P_M_TOTAL(20'd12155),
            .P_IDX1(4'd2), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_63 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1260 +: 20]),
            .dist_out(chan_dist_bus[1008 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd713), .P_MI2(20'd899),
            .P_INV0(20'd2), .P_INV1(20'd12), .P_INV2(20'd12),
            .P_M_TOTAL(20'd20677),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_64 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1280 +: 20]),
            .dist_out(chan_dist_bus[1024 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd589), .P_MI2(20'd899),
            .P_INV0(20'd22), .P_INV1(20'd13), .P_INV2(20'd16),
            .P_M_TOTAL(20'd17081),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_65 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1300 +: 20]),
            .dist_out(chan_dist_bus[1040 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd527), .P_MI2(20'd899),
            .P_INV0(20'd10), .P_INV1(20'd6), .P_INV2(20'd8),
            .P_M_TOTAL(20'd15283),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_66 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1320 +: 20]),
            .dist_out(chan_dist_bus[1056 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd341), .P_MI2(20'd899),
            .P_INV0(20'd7), .P_INV1(20'd4), .P_INV2(20'd7),
            .P_M_TOTAL(20'd9889),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_67 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1340 +: 20]),
            .dist_out(chan_dist_bus[1072 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd589), .P_MI2(20'd713),
            .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd2),
            .P_M_TOTAL(20'd13547),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_68 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1360 +: 20]),
            .dist_out(chan_dist_bus[1088 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd527), .P_MI2(20'd713),
            .P_INV0(20'd18), .P_INV1(20'd11), .P_INV2(20'd16),
            .P_M_TOTAL(20'd12121),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_69 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1380 +: 20]),
            .dist_out(chan_dist_bus[1104 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd341), .P_MI2(20'd713),
            .P_INV0(20'd25), .P_INV1(20'd17), .P_INV2(20'd5),
            .P_M_TOTAL(20'd7843),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_70 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1400 +: 20]),
            .dist_out(chan_dist_bus[1120 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd527), .P_MI2(20'd589),
            .P_INV0(20'd12), .P_INV1(20'd15), .P_INV2(20'd14),
            .P_M_TOTAL(20'd10013),
            .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_71 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1420 +: 20]),
            .dist_out(chan_dist_bus[1136 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd341), .P_MI2(20'd589),
            .P_INV0(20'd27), .P_INV1(20'd18), .P_INV2(20'd2),
            .P_M_TOTAL(20'd6479),
            .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_72 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1440 +: 20]),
            .dist_out(chan_dist_bus[1152 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd341), .P_MI2(20'd527),
            .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd10),
            .P_M_TOTAL(20'd5797),
            .P_IDX1(4'd3), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_73 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1460 +: 20]),
            .dist_out(chan_dist_bus[1168 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd551), .P_MI2(20'd667),
            .P_INV0(20'd15), .P_INV1(20'd22), .P_INV2(20'd10),
            .P_M_TOTAL(20'd12673),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_74 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1480 +: 20]),
            .dist_out(chan_dist_bus[1184 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd493), .P_MI2(20'd667),
            .P_INV0(20'd27), .P_INV1(20'd7), .P_INV2(20'd13),
            .P_M_TOTAL(20'd11339),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_75 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1500 +: 20]),
            .dist_out(chan_dist_bus[1200 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd319), .P_MI2(20'd667),
            .P_INV0(20'd18), .P_INV1(20'd15), .P_INV2(20'd8),
            .P_M_TOTAL(20'd7337),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_76 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1520 +: 20]),
            .dist_out(chan_dist_bus[1216 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd493), .P_MI2(20'd551),
            .P_INV0(20'd22), .P_INV1(20'd18), .P_INV2(20'd5),
            .P_M_TOTAL(20'd9367),
            .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_77 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1540 +: 20]),
            .dist_out(chan_dist_bus[1232 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd319), .P_MI2(20'd551),
            .P_INV0(20'd5), .P_INV1(20'd14), .P_INV2(20'd1),
            .P_M_TOTAL(20'd6061),
            .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_78 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1560 +: 20]),
            .dist_out(chan_dist_bus[1248 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd319), .P_MI2(20'd493),
            .P_INV0(20'd9), .P_INV1(20'd4), .P_INV2(20'd5),
            .P_M_TOTAL(20'd5423),
            .P_IDX1(4'd4), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_79 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1580 +: 20]),
            .dist_out(chan_dist_bus[1264 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd391), .P_MI2(20'd437),
            .P_INV0(20'd1), .P_INV1(20'd7), .P_INV2(20'd10),
            .P_M_TOTAL(20'd7429),
            .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_80 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1600 +: 20]),
            .dist_out(chan_dist_bus[1280 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd253), .P_MI2(20'd437),
            .P_INV0(20'd12), .P_INV1(20'd16), .P_INV2(20'd7),
            .P_M_TOTAL(20'd4807),
            .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_81 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1620 +: 20]),
            .dist_out(chan_dist_bus[1296 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd253), .P_MI2(20'd391),
            .P_INV0(20'd8), .P_INV1(20'd8), .P_INV2(20'd2),
            .P_M_TOTAL(20'd4301),
            .P_IDX1(4'd5), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_82 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1640 +: 20]),
            .dist_out(chan_dist_bus[1312 +: 16])
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd209), .P_MI2(20'd323),
            .P_INV0(20'd6), .P_INV1(20'd7), .P_INV2(20'd3),
            .P_M_TOTAL(20'd3553),
            .P_IDX1(4'd6), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_83 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_bus[1660 +: 20]),
            .dist_out(chan_dist_bus[1328 +: 16])
        );

