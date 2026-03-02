// --- Part 1: Signal Declarations (84 Independent Wires) ---
wire [19:0] chan_x_0, chan_x_1, chan_x_2, chan_x_3, chan_x_4, chan_x_5, chan_x_6, chan_x_7, chan_x_8, chan_x_9, chan_x_10, chan_x_11, chan_x_12, chan_x_13, chan_x_14, chan_x_15, chan_x_16, chan_x_17, chan_x_18, chan_x_19, chan_x_20, chan_x_21, chan_x_22, chan_x_23, chan_x_24, chan_x_25, chan_x_26, chan_x_27, chan_x_28, chan_x_29, chan_x_30, chan_x_31, chan_x_32, chan_x_33, chan_x_34, chan_x_35, chan_x_36, chan_x_37, chan_x_38, chan_x_39, chan_x_40, chan_x_41, chan_x_42, chan_x_43, chan_x_44, chan_x_45, chan_x_46, chan_x_47, chan_x_48, chan_x_49, chan_x_50, chan_x_51, chan_x_52, chan_x_53, chan_x_54, chan_x_55, chan_x_56, chan_x_57, chan_x_58, chan_x_59, chan_x_60, chan_x_61, chan_x_62, chan_x_63, chan_x_64, chan_x_65, chan_x_66, chan_x_67, chan_x_68, chan_x_69, chan_x_70, chan_x_71, chan_x_72, chan_x_73, chan_x_74, chan_x_75, chan_x_76, chan_x_77, chan_x_78, chan_x_79, chan_x_80, chan_x_81, chan_x_82, chan_x_83;
wire [15:0] chan_dist_0, chan_dist_1, chan_dist_2, chan_dist_3, chan_dist_4, chan_dist_5, chan_dist_6, chan_dist_7, chan_dist_8, chan_dist_9, chan_dist_10, chan_dist_11, chan_dist_12, chan_dist_13, chan_dist_14, chan_dist_15, chan_dist_16, chan_dist_17, chan_dist_18, chan_dist_19, chan_dist_20, chan_dist_21, chan_dist_22, chan_dist_23, chan_dist_24, chan_dist_25, chan_dist_26, chan_dist_27, chan_dist_28, chan_dist_29, chan_dist_30, chan_dist_31, chan_dist_32, chan_dist_33, chan_dist_34, chan_dist_35, chan_dist_36, chan_dist_37, chan_dist_38, chan_dist_39, chan_dist_40, chan_dist_41, chan_dist_42, chan_dist_43, chan_dist_44, chan_dist_45, chan_dist_46, chan_dist_47, chan_dist_48, chan_dist_49, chan_dist_50, chan_dist_51, chan_dist_52, chan_dist_53, chan_dist_54, chan_dist_55, chan_dist_56, chan_dist_57, chan_dist_58, chan_dist_59, chan_dist_60, chan_dist_61, chan_dist_62, chan_dist_63, chan_dist_64, chan_dist_65, chan_dist_66, chan_dist_67, chan_dist_68, chan_dist_69, chan_dist_70, chan_dist_71, chan_dist_72, chan_dist_73, chan_dist_74, chan_dist_75, chan_dist_76, chan_dist_77, chan_dist_78, chan_dist_79, chan_dist_80, chan_dist_81, chan_dist_82, chan_dist_83;

// --- Part 2: Module Instantiations ---
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

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd704), .P_MI2(20'd1856),
            .P_INV0(20'd63), .P_INV1(20'd11), .P_INV2(20'd7),
            .P_M_TOTAL(20'd20416),
            .P_IDX1(4'd0), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_21 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_21),
            .dist_out(chan_dist_21)
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1216), .P_MI2(20'd1472),
            .P_INV0(20'd29), .P_INV1(20'd15), .P_INV2(20'd17),
            .P_M_TOTAL(20'd27968),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_22 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_22),
            .dist_out(chan_dist_22)
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1088), .P_MI2(20'd1472),
            .P_INV0(20'd55), .P_INV1(20'd10), .P_INV2(20'd12),
            .P_M_TOTAL(20'd25024),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_23 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_23),
            .dist_out(chan_dist_23)
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd704), .P_MI2(20'd1472),
            .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd5),
            .P_M_TOTAL(20'd16192),
            .P_IDX1(4'd0), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_24 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_24),
            .dist_out(chan_dist_24)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1088), .P_MI2(20'd1216),
            .P_INV0(20'd43), .P_INV1(20'd4), .P_INV2(20'd2),
            .P_M_TOTAL(20'd20672),
            .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_25 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_25),
            .dist_out(chan_dist_25)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd704), .P_MI2(20'd1216),
            .P_INV0(20'd49), .P_INV1(20'd1), .P_INV2(20'd2),
            .P_M_TOTAL(20'd13376),
            .P_IDX1(4'd0), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_26 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_26),
            .dist_out(chan_dist_26)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd704), .P_MI2(20'd1088),
            .P_INV0(20'd51), .P_INV1(20'd5), .P_INV2(20'd10),
            .P_M_TOTAL(20'd11968),
            .P_IDX1(4'd0), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_27 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_27),
            .dist_out(chan_dist_27)
        );

        channel_unit #(
            .P_MI0(20'd2015), .P_MI1(20'd1953), .P_MI2(20'd4095),
            .P_INV0(20'd62), .P_INV1(20'd22), .P_INV2(20'd21),
            .P_M_TOTAL(20'd126945),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd3)
        ) u_channel_28 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_28),
            .dist_out(chan_dist_28)
        );

        channel_unit #(
            .P_MI0(20'd1885), .P_MI1(20'd1827), .P_MI2(20'd4095),
            .P_INV0(20'd25), .P_INV1(20'd28), .P_INV2(20'd5),
            .P_M_TOTAL(20'd118755),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd4)
        ) u_channel_29 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_29),
            .dist_out(chan_dist_29)
        );

        channel_unit #(
            .P_MI0(20'd1495), .P_MI1(20'd1449), .P_MI2(20'd4095),
            .P_INV0(20'd37), .P_INV1(20'd24), .P_INV2(20'd1),
            .P_M_TOTAL(20'd94185),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd5)
        ) u_channel_30 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_30),
            .dist_out(chan_dist_30)
        );

        channel_unit #(
            .P_MI0(20'd1235), .P_MI1(20'd1197), .P_MI2(20'd4095),
            .P_INV0(20'd5), .P_INV1(20'd53), .P_INV2(20'd2),
            .P_M_TOTAL(20'd77805),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd6)
        ) u_channel_31 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_31),
            .dist_out(chan_dist_31)
        );

        channel_unit #(
            .P_MI0(20'd1105), .P_MI1(20'd1071), .P_MI2(20'd4095),
            .P_INV0(20'd13), .P_INV1(20'd21), .P_INV2(20'd8),
            .P_M_TOTAL(20'd69615),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd7)
        ) u_channel_32 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_32),
            .dist_out(chan_dist_32)
        );

        channel_unit #(
            .P_MI0(20'd715), .P_MI1(20'd693), .P_MI2(20'd4095),
            .P_INV0(20'd43), .P_INV1(20'd62), .P_INV2(20'd4),
            .P_M_TOTAL(20'd45045),
            .P_IDX1(4'd1), .P_IDX2(4'd2), .P_IDX3(4'd8)
        ) u_channel_33 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_33),
            .dist_out(chan_dist_33)
        );

        channel_unit #(
            .P_MI0(20'd899), .P_MI1(20'd1827), .P_MI2(20'd1953),
            .P_INV0(20'd26), .P_INV1(20'd15), .P_INV2(20'd3),
            .P_M_TOTAL(20'd56637),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd4)
        ) u_channel_34 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_34),
            .dist_out(chan_dist_34)
        );

        channel_unit #(
            .P_MI0(20'd713), .P_MI1(20'd1449), .P_MI2(20'd1953),
            .P_INV0(20'd41), .P_INV1(20'd27), .P_INV2(20'd11),
            .P_M_TOTAL(20'd44919),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd5)
        ) u_channel_35 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_35),
            .dist_out(chan_dist_35)
        );

        channel_unit #(
            .P_MI0(20'd589), .P_MI1(20'd1197), .P_MI2(20'd1953),
            .P_INV0(20'd43), .P_INV1(20'd18), .P_INV2(20'd14),
            .P_M_TOTAL(20'd37107),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd6)
        ) u_channel_36 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_36),
            .dist_out(chan_dist_36)
        );

        channel_unit #(
            .P_MI0(20'd527), .P_MI1(20'd1071), .P_MI2(20'd1953),
            .P_INV0(20'd11), .P_INV1(20'd11), .P_INV2(20'd8),
            .P_M_TOTAL(20'd33201),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd7)
        ) u_channel_37 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_37),
            .dist_out(chan_dist_37)
        );

        channel_unit #(
            .P_MI0(20'd341), .P_MI1(20'd693), .P_MI2(20'd1953),
            .P_INV0(20'd17), .P_INV1(20'd17), .P_INV2(20'd2),
            .P_M_TOTAL(20'd21483),
            .P_IDX1(4'd1), .P_IDX2(4'd3), .P_IDX3(4'd8)
        ) u_channel_38 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_38),
            .dist_out(chan_dist_38)
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd1449), .P_MI2(20'd1827),
            .P_INV0(20'd46), .P_INV1(20'd28), .P_INV2(20'd7),
            .P_M_TOTAL(20'd42021),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_39 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_39),
            .dist_out(chan_dist_39)
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd1197), .P_MI2(20'd1827),
            .P_INV0(20'd59), .P_INV1(20'd11), .P_INV2(20'd13),
            .P_M_TOTAL(20'd34713),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_40 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_40),
            .dist_out(chan_dist_40)
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd1071), .P_MI2(20'd1827),
            .P_INV0(20'd40), .P_INV1(20'd14), .P_INV2(20'd15),
            .P_M_TOTAL(20'd31059),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_41 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_41),
            .dist_out(chan_dist_41)
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd693), .P_MI2(20'd1827),
            .P_INV0(20'd16), .P_INV1(20'd19), .P_INV2(20'd1),
            .P_M_TOTAL(20'd20097),
            .P_IDX1(4'd1), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_42 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_42),
            .dist_out(chan_dist_42)
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1197), .P_MI2(20'd1449),
            .P_INV0(20'd47), .P_INV1(20'd1), .P_INV2(20'd4),
            .P_M_TOTAL(20'd27531),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_43 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_43),
            .dist_out(chan_dist_43)
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1071), .P_MI2(20'd1449),
            .P_INV0(20'd34), .P_INV1(20'd16), .P_INV2(20'd13),
            .P_M_TOTAL(20'd24633),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_44 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_44),
            .dist_out(chan_dist_44)
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd693), .P_MI2(20'd1449),
            .P_INV0(20'd1), .P_INV1(20'd8), .P_INV2(20'd7),
            .P_M_TOTAL(20'd15939),
            .P_IDX1(4'd1), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_45 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_45),
            .dist_out(chan_dist_45)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1071), .P_MI2(20'd1197),
            .P_INV0(20'd8), .P_INV1(20'd11), .P_INV2(20'd5),
            .P_M_TOTAL(20'd20349),
            .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_46 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_46),
            .dist_out(chan_dist_46)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd693), .P_MI2(20'd1197),
            .P_INV0(20'd41), .P_INV1(20'd17), .P_INV2(20'd5),
            .P_M_TOTAL(20'd13167),
            .P_IDX1(4'd1), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_47 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_47),
            .dist_out(chan_dist_47)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd693), .P_MI2(20'd1071),
            .P_INV0(20'd31), .P_INV1(20'd4), .P_INV2(20'd3),
            .P_M_TOTAL(20'd11781),
            .P_IDX1(4'd1), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_48 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_48),
            .dist_out(chan_dist_48)
        );

        channel_unit #(
            .P_MI0(20'd899), .P_MI1(20'd1885), .P_MI2(20'd2015),
            .P_INV0(20'd59), .P_INV1(20'd5), .P_INV2(20'd27),
            .P_M_TOTAL(20'd58435),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd4)
        ) u_channel_49 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_49),
            .dist_out(chan_dist_49)
        );

        channel_unit #(
            .P_MI0(20'd713), .P_MI1(20'd1495), .P_MI2(20'd2015),
            .P_INV0(20'd32), .P_INV1(20'd9), .P_INV2(20'd5),
            .P_M_TOTAL(20'd46345),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd5)
        ) u_channel_50 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_50),
            .dist_out(chan_dist_50)
        );

        channel_unit #(
            .P_MI0(20'd589), .P_MI1(20'd1235), .P_MI2(20'd2015),
            .P_INV0(20'd49), .P_INV1(20'd6), .P_INV2(20'd1),
            .P_M_TOTAL(20'd38285),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd6)
        ) u_channel_51 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_51),
            .dist_out(chan_dist_51)
        );

        channel_unit #(
            .P_MI0(20'd527), .P_MI1(20'd1105), .P_MI2(20'd2015),
            .P_INV0(20'd28), .P_INV1(20'd14), .P_INV2(20'd2),
            .P_M_TOTAL(20'd34255),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd7)
        ) u_channel_52 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_52),
            .dist_out(chan_dist_52)
        );

        channel_unit #(
            .P_MI0(20'd341), .P_MI1(20'd715), .P_MI2(20'd2015),
            .P_INV0(20'd61), .P_INV1(20'd16), .P_INV2(20'd6),
            .P_M_TOTAL(20'd22165),
            .P_IDX1(4'd2), .P_IDX2(4'd3), .P_IDX3(4'd8)
        ) u_channel_53 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_53),
            .dist_out(chan_dist_53)
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd1495), .P_MI2(20'd1885),
            .P_INV0(20'd23), .P_INV1(20'd20), .P_INV2(20'd22),
            .P_M_TOTAL(20'd43355),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_54 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_54),
            .dist_out(chan_dist_54)
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd1235), .P_MI2(20'd1885),
            .P_INV0(20'd21), .P_INV1(20'd12), .P_INV2(20'd5),
            .P_M_TOTAL(20'd35815),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_55 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_55),
            .dist_out(chan_dist_55)
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd1105), .P_MI2(20'd1885),
            .P_INV0(20'd12), .P_INV1(20'd10), .P_INV2(20'd8),
            .P_M_TOTAL(20'd32045),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_56 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_56),
            .dist_out(chan_dist_56)
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd715), .P_MI2(20'd1885),
            .P_INV0(20'd54), .P_INV1(20'd26), .P_INV2(20'd3),
            .P_M_TOTAL(20'd20735),
            .P_IDX1(4'd2), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_57 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_57),
            .dist_out(chan_dist_57)
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd1235), .P_MI2(20'd1495),
            .P_INV0(20'd18), .P_INV1(20'd13), .P_INV2(20'd3),
            .P_M_TOTAL(20'd28405),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_58 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_58),
            .dist_out(chan_dist_58)
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd1105), .P_MI2(20'd1495),
            .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd16),
            .P_M_TOTAL(20'd25415),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_59 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_59),
            .dist_out(chan_dist_59)
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd715), .P_MI2(20'd1495),
            .P_INV0(20'd37), .P_INV1(20'd12), .P_INV2(20'd10),
            .P_M_TOTAL(20'd16445),
            .P_IDX1(4'd2), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_60 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_60),
            .dist_out(chan_dist_60)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd1105), .P_MI2(20'd1235),
            .P_INV0(20'd32), .P_INV1(20'd13), .P_INV2(20'd14),
            .P_M_TOTAL(20'd20995),
            .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_61 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_61),
            .dist_out(chan_dist_61)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd715), .P_MI2(20'd1235),
            .P_INV0(20'd14), .P_INV1(20'd8), .P_INV2(20'd4),
            .P_M_TOTAL(20'd13585),
            .P_IDX1(4'd2), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_62 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_62),
            .dist_out(chan_dist_62)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd715), .P_MI2(20'd1105),
            .P_INV0(20'd8), .P_INV1(20'd1), .P_INV2(20'd9),
            .P_M_TOTAL(20'd12155),
            .P_IDX1(4'd2), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_63 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_63),
            .dist_out(chan_dist_63)
        );

        channel_unit #(
            .P_MI0(20'd667), .P_MI1(20'd713), .P_MI2(20'd899),
            .P_INV0(20'd2), .P_INV1(20'd12), .P_INV2(20'd12),
            .P_M_TOTAL(20'd20677),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd5)
        ) u_channel_64 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_64),
            .dist_out(chan_dist_64)
        );

        channel_unit #(
            .P_MI0(20'd551), .P_MI1(20'd589), .P_MI2(20'd899),
            .P_INV0(20'd22), .P_INV1(20'd13), .P_INV2(20'd16),
            .P_M_TOTAL(20'd17081),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd6)
        ) u_channel_65 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_65),
            .dist_out(chan_dist_65)
        );

        channel_unit #(
            .P_MI0(20'd493), .P_MI1(20'd527), .P_MI2(20'd899),
            .P_INV0(20'd10), .P_INV1(20'd6), .P_INV2(20'd8),
            .P_M_TOTAL(20'd15283),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd7)
        ) u_channel_66 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_66),
            .dist_out(chan_dist_66)
        );

        channel_unit #(
            .P_MI0(20'd319), .P_MI1(20'd341), .P_MI2(20'd899),
            .P_INV0(20'd7), .P_INV1(20'd4), .P_INV2(20'd7),
            .P_M_TOTAL(20'd9889),
            .P_IDX1(4'd3), .P_IDX2(4'd4), .P_IDX3(4'd8)
        ) u_channel_67 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_67),
            .dist_out(chan_dist_67)
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd589), .P_MI2(20'd713),
            .P_INV0(20'd21), .P_INV1(20'd5), .P_INV2(20'd2),
            .P_M_TOTAL(20'd13547),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_68 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_68),
            .dist_out(chan_dist_68)
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd527), .P_MI2(20'd713),
            .P_INV0(20'd18), .P_INV1(20'd11), .P_INV2(20'd16),
            .P_M_TOTAL(20'd12121),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_69 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_69),
            .dist_out(chan_dist_69)
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd341), .P_MI2(20'd713),
            .P_INV0(20'd25), .P_INV1(20'd17), .P_INV2(20'd5),
            .P_M_TOTAL(20'd7843),
            .P_IDX1(4'd3), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_70 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_70),
            .dist_out(chan_dist_70)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd527), .P_MI2(20'd589),
            .P_INV0(20'd12), .P_INV1(20'd15), .P_INV2(20'd14),
            .P_M_TOTAL(20'd10013),
            .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_71 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_71),
            .dist_out(chan_dist_71)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd341), .P_MI2(20'd589),
            .P_INV0(20'd27), .P_INV1(20'd18), .P_INV2(20'd2),
            .P_M_TOTAL(20'd6479),
            .P_IDX1(4'd3), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_72 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_72),
            .dist_out(chan_dist_72)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd341), .P_MI2(20'd527),
            .P_INV0(20'd1), .P_INV1(20'd1), .P_INV2(20'd10),
            .P_M_TOTAL(20'd5797),
            .P_IDX1(4'd3), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_73 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_73),
            .dist_out(chan_dist_73)
        );

        channel_unit #(
            .P_MI0(20'd437), .P_MI1(20'd551), .P_MI2(20'd667),
            .P_INV0(20'd15), .P_INV1(20'd22), .P_INV2(20'd10),
            .P_M_TOTAL(20'd12673),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd6)
        ) u_channel_74 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_74),
            .dist_out(chan_dist_74)
        );

        channel_unit #(
            .P_MI0(20'd391), .P_MI1(20'd493), .P_MI2(20'd667),
            .P_INV0(20'd27), .P_INV1(20'd7), .P_INV2(20'd13),
            .P_M_TOTAL(20'd11339),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd7)
        ) u_channel_75 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_75),
            .dist_out(chan_dist_75)
        );

        channel_unit #(
            .P_MI0(20'd253), .P_MI1(20'd319), .P_MI2(20'd667),
            .P_INV0(20'd18), .P_INV1(20'd15), .P_INV2(20'd8),
            .P_M_TOTAL(20'd7337),
            .P_IDX1(4'd4), .P_IDX2(4'd5), .P_IDX3(4'd8)
        ) u_channel_76 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_76),
            .dist_out(chan_dist_76)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd493), .P_MI2(20'd551),
            .P_INV0(20'd22), .P_INV1(20'd18), .P_INV2(20'd5),
            .P_M_TOTAL(20'd9367),
            .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_77 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_77),
            .dist_out(chan_dist_77)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd319), .P_MI2(20'd551),
            .P_INV0(20'd5), .P_INV1(20'd14), .P_INV2(20'd1),
            .P_M_TOTAL(20'd6061),
            .P_IDX1(4'd4), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_78 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_78),
            .dist_out(chan_dist_78)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd319), .P_MI2(20'd493),
            .P_INV0(20'd9), .P_INV1(20'd4), .P_INV2(20'd5),
            .P_M_TOTAL(20'd5423),
            .P_IDX1(4'd4), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_79 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_79),
            .dist_out(chan_dist_79)
        );

        channel_unit #(
            .P_MI0(20'd323), .P_MI1(20'd391), .P_MI2(20'd437),
            .P_INV0(20'd1), .P_INV1(20'd7), .P_INV2(20'd10),
            .P_M_TOTAL(20'd7429),
            .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd7)
        ) u_channel_80 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_80),
            .dist_out(chan_dist_80)
        );

        channel_unit #(
            .P_MI0(20'd209), .P_MI1(20'd253), .P_MI2(20'd437),
            .P_INV0(20'd12), .P_INV1(20'd16), .P_INV2(20'd7),
            .P_M_TOTAL(20'd4807),
            .P_IDX1(4'd5), .P_IDX2(4'd6), .P_IDX3(4'd8)
        ) u_channel_81 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_81),
            .dist_out(chan_dist_81)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd253), .P_MI2(20'd391),
            .P_INV0(20'd8), .P_INV1(20'd8), .P_INV2(20'd2),
            .P_M_TOTAL(20'd4301),
            .P_IDX1(4'd5), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_82 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_82),
            .dist_out(chan_dist_82)
        );

        channel_unit #(
            .P_MI0(20'd187), .P_MI1(20'd209), .P_MI2(20'd323),
            .P_INV0(20'd6), .P_INV1(20'd7), .P_INV2(20'd3),
            .P_M_TOTAL(20'd3553),
            .P_IDX1(4'd6), .P_IDX2(4'd7), .P_IDX3(4'd8)
        ) u_channel_83 (
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8),
            .x_out(chan_x_83),
            .dist_out(chan_dist_83)
        );

// --- Part 3: Concatenation for Logic (Optional but recommended for uniform logic) ---
// Construct flat buses from independent wires for easier processing in find_min logic
wire [1679:0] chan_x_bus = {chan_x_83, chan_x_82, chan_x_81, chan_x_80, chan_x_79, chan_x_78, chan_x_77, chan_x_76, chan_x_75, chan_x_74, chan_x_73, chan_x_72, chan_x_71, chan_x_70, chan_x_69, chan_x_68, chan_x_67, chan_x_66, chan_x_65, chan_x_64, chan_x_63, chan_x_62, chan_x_61, chan_x_60, chan_x_59, chan_x_58, chan_x_57, chan_x_56, chan_x_55, chan_x_54, chan_x_53, chan_x_52, chan_x_51, chan_x_50, chan_x_49, chan_x_48, chan_x_47, chan_x_46, chan_x_45, chan_x_44, chan_x_43, chan_x_42, chan_x_41, chan_x_40, chan_x_39, chan_x_38, chan_x_37, chan_x_36, chan_x_35, chan_x_34, chan_x_33, chan_x_32, chan_x_31, chan_x_30, chan_x_29, chan_x_28, chan_x_27, chan_x_26, chan_x_25, chan_x_24, chan_x_23, chan_x_22, chan_x_21, chan_x_20, chan_x_19, chan_x_18, chan_x_17, chan_x_16, chan_x_15, chan_x_14, chan_x_13, chan_x_12, chan_x_11, chan_x_10, chan_x_9, chan_x_8, chan_x_7, chan_x_6, chan_x_5, chan_x_4, chan_x_3, chan_x_2, chan_x_1, chan_x_0};
wire [1343:0] chan_dist_bus = {chan_dist_83, chan_dist_82, chan_dist_81, chan_dist_80, chan_dist_79, chan_dist_78, chan_dist_77, chan_dist_76, chan_dist_75, chan_dist_74, chan_dist_73, chan_dist_72, chan_dist_71, chan_dist_70, chan_dist_69, chan_dist_68, chan_dist_67, chan_dist_66, chan_dist_65, chan_dist_64, chan_dist_63, chan_dist_62, chan_dist_61, chan_dist_60, chan_dist_59, chan_dist_58, chan_dist_57, chan_dist_56, chan_dist_55, chan_dist_54, chan_dist_53, chan_dist_52, chan_dist_51, chan_dist_50, chan_dist_49, chan_dist_48, chan_dist_47, chan_dist_46, chan_dist_45, chan_dist_44, chan_dist_43, chan_dist_42, chan_dist_41, chan_dist_40, chan_dist_39, chan_dist_38, chan_dist_37, chan_dist_36, chan_dist_35, chan_dist_34, chan_dist_33, chan_dist_32, chan_dist_31, chan_dist_30, chan_dist_29, chan_dist_28, chan_dist_27, chan_dist_26, chan_dist_25, chan_dist_24, chan_dist_23, chan_dist_22, chan_dist_21, chan_dist_20, chan_dist_19, chan_dist_18, chan_dist_17, chan_dist_16, chan_dist_15, chan_dist_14, chan_dist_13, chan_dist_12, chan_dist_11, chan_dist_10, chan_dist_9, chan_dist_8, chan_dist_7, chan_dist_6, chan_dist_5, chan_dist_4, chan_dist_3, chan_dist_2, chan_dist_1, chan_dist_0};
