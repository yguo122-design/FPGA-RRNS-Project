// --- Part 4: Static Unrolled Min Finder (No Loops, No Dynamic Slicing) ---
always @(*) begin : find_min_static
    min_dist = 16'hFFFF;
    min_idx = 7'd0;

    if (chan_dist_0 < min_dist) begin
        min_dist = chan_dist_0;
        min_idx = 7'd0;
    end
    if (chan_dist_1 < min_dist) begin
        min_dist = chan_dist_1;
        min_idx = 7'd1;
    end
    if (chan_dist_2 < min_dist) begin
        min_dist = chan_dist_2;
        min_idx = 7'd2;
    end
    if (chan_dist_3 < min_dist) begin
        min_dist = chan_dist_3;
        min_idx = 7'd3;
    end
    if (chan_dist_4 < min_dist) begin
        min_dist = chan_dist_4;
        min_idx = 7'd4;
    end
    if (chan_dist_5 < min_dist) begin
        min_dist = chan_dist_5;
        min_idx = 7'd5;
    end
    if (chan_dist_6 < min_dist) begin
        min_dist = chan_dist_6;
        min_idx = 7'd6;
    end
    if (chan_dist_7 < min_dist) begin
        min_dist = chan_dist_7;
        min_idx = 7'd7;
    end
    if (chan_dist_8 < min_dist) begin
        min_dist = chan_dist_8;
        min_idx = 7'd8;
    end
    if (chan_dist_9 < min_dist) begin
        min_dist = chan_dist_9;
        min_idx = 7'd9;
    end
    if (chan_dist_10 < min_dist) begin
        min_dist = chan_dist_10;
        min_idx = 7'd10;
    end
    if (chan_dist_11 < min_dist) begin
        min_dist = chan_dist_11;
        min_idx = 7'd11;
    end
    if (chan_dist_12 < min_dist) begin
        min_dist = chan_dist_12;
        min_idx = 7'd12;
    end
    if (chan_dist_13 < min_dist) begin
        min_dist = chan_dist_13;
        min_idx = 7'd13;
    end
    if (chan_dist_14 < min_dist) begin
        min_dist = chan_dist_14;
        min_idx = 7'd14;
    end
    if (chan_dist_15 < min_dist) begin
        min_dist = chan_dist_15;
        min_idx = 7'd15;
    end
    if (chan_dist_16 < min_dist) begin
        min_dist = chan_dist_16;
        min_idx = 7'd16;
    end
    if (chan_dist_17 < min_dist) begin
        min_dist = chan_dist_17;
        min_idx = 7'd17;
    end
    if (chan_dist_18 < min_dist) begin
        min_dist = chan_dist_18;
        min_idx = 7'd18;
    end
    if (chan_dist_19 < min_dist) begin
        min_dist = chan_dist_19;
        min_idx = 7'd19;
    end
    if (chan_dist_20 < min_dist) begin
        min_dist = chan_dist_20;
        min_idx = 7'd20;
    end
    if (chan_dist_21 < min_dist) begin
        min_dist = chan_dist_21;
        min_idx = 7'd21;
    end
    if (chan_dist_22 < min_dist) begin
        min_dist = chan_dist_22;
        min_idx = 7'd22;
    end
    if (chan_dist_23 < min_dist) begin
        min_dist = chan_dist_23;
        min_idx = 7'd23;
    end
    if (chan_dist_24 < min_dist) begin
        min_dist = chan_dist_24;
        min_idx = 7'd24;
    end
    if (chan_dist_25 < min_dist) begin
        min_dist = chan_dist_25;
        min_idx = 7'd25;
    end
    if (chan_dist_26 < min_dist) begin
        min_dist = chan_dist_26;
        min_idx = 7'd26;
    end
    if (chan_dist_27 < min_dist) begin
        min_dist = chan_dist_27;
        min_idx = 7'd27;
    end
    if (chan_dist_28 < min_dist) begin
        min_dist = chan_dist_28;
        min_idx = 7'd28;
    end
    if (chan_dist_29 < min_dist) begin
        min_dist = chan_dist_29;
        min_idx = 7'd29;
    end
    if (chan_dist_30 < min_dist) begin
        min_dist = chan_dist_30;
        min_idx = 7'd30;
    end
    if (chan_dist_31 < min_dist) begin
        min_dist = chan_dist_31;
        min_idx = 7'd31;
    end
    if (chan_dist_32 < min_dist) begin
        min_dist = chan_dist_32;
        min_idx = 7'd32;
    end
    if (chan_dist_33 < min_dist) begin
        min_dist = chan_dist_33;
        min_idx = 7'd33;
    end
    if (chan_dist_34 < min_dist) begin
        min_dist = chan_dist_34;
        min_idx = 7'd34;
    end
    if (chan_dist_35 < min_dist) begin
        min_dist = chan_dist_35;
        min_idx = 7'd35;
    end
    if (chan_dist_36 < min_dist) begin
        min_dist = chan_dist_36;
        min_idx = 7'd36;
    end
    if (chan_dist_37 < min_dist) begin
        min_dist = chan_dist_37;
        min_idx = 7'd37;
    end
    if (chan_dist_38 < min_dist) begin
        min_dist = chan_dist_38;
        min_idx = 7'd38;
    end
    if (chan_dist_39 < min_dist) begin
        min_dist = chan_dist_39;
        min_idx = 7'd39;
    end
    if (chan_dist_40 < min_dist) begin
        min_dist = chan_dist_40;
        min_idx = 7'd40;
    end
    if (chan_dist_41 < min_dist) begin
        min_dist = chan_dist_41;
        min_idx = 7'd41;
    end
    if (chan_dist_42 < min_dist) begin
        min_dist = chan_dist_42;
        min_idx = 7'd42;
    end
    if (chan_dist_43 < min_dist) begin
        min_dist = chan_dist_43;
        min_idx = 7'd43;
    end
    if (chan_dist_44 < min_dist) begin
        min_dist = chan_dist_44;
        min_idx = 7'd44;
    end
    if (chan_dist_45 < min_dist) begin
        min_dist = chan_dist_45;
        min_idx = 7'd45;
    end
    if (chan_dist_46 < min_dist) begin
        min_dist = chan_dist_46;
        min_idx = 7'd46;
    end
    if (chan_dist_47 < min_dist) begin
        min_dist = chan_dist_47;
        min_idx = 7'd47;
    end
    if (chan_dist_48 < min_dist) begin
        min_dist = chan_dist_48;
        min_idx = 7'd48;
    end
    if (chan_dist_49 < min_dist) begin
        min_dist = chan_dist_49;
        min_idx = 7'd49;
    end
    if (chan_dist_50 < min_dist) begin
        min_dist = chan_dist_50;
        min_idx = 7'd50;
    end
    if (chan_dist_51 < min_dist) begin
        min_dist = chan_dist_51;
        min_idx = 7'd51;
    end
    if (chan_dist_52 < min_dist) begin
        min_dist = chan_dist_52;
        min_idx = 7'd52;
    end
    if (chan_dist_53 < min_dist) begin
        min_dist = chan_dist_53;
        min_idx = 7'd53;
    end
    if (chan_dist_54 < min_dist) begin
        min_dist = chan_dist_54;
        min_idx = 7'd54;
    end
    if (chan_dist_55 < min_dist) begin
        min_dist = chan_dist_55;
        min_idx = 7'd55;
    end
    if (chan_dist_56 < min_dist) begin
        min_dist = chan_dist_56;
        min_idx = 7'd56;
    end
    if (chan_dist_57 < min_dist) begin
        min_dist = chan_dist_57;
        min_idx = 7'd57;
    end
    if (chan_dist_58 < min_dist) begin
        min_dist = chan_dist_58;
        min_idx = 7'd58;
    end
    if (chan_dist_59 < min_dist) begin
        min_dist = chan_dist_59;
        min_idx = 7'd59;
    end
    if (chan_dist_60 < min_dist) begin
        min_dist = chan_dist_60;
        min_idx = 7'd60;
    end
    if (chan_dist_61 < min_dist) begin
        min_dist = chan_dist_61;
        min_idx = 7'd61;
    end
    if (chan_dist_62 < min_dist) begin
        min_dist = chan_dist_62;
        min_idx = 7'd62;
    end
    if (chan_dist_63 < min_dist) begin
        min_dist = chan_dist_63;
        min_idx = 7'd63;
    end
    if (chan_dist_64 < min_dist) begin
        min_dist = chan_dist_64;
        min_idx = 7'd64;
    end
    if (chan_dist_65 < min_dist) begin
        min_dist = chan_dist_65;
        min_idx = 7'd65;
    end
    if (chan_dist_66 < min_dist) begin
        min_dist = chan_dist_66;
        min_idx = 7'd66;
    end
    if (chan_dist_67 < min_dist) begin
        min_dist = chan_dist_67;
        min_idx = 7'd67;
    end
    if (chan_dist_68 < min_dist) begin
        min_dist = chan_dist_68;
        min_idx = 7'd68;
    end
    if (chan_dist_69 < min_dist) begin
        min_dist = chan_dist_69;
        min_idx = 7'd69;
    end
    if (chan_dist_70 < min_dist) begin
        min_dist = chan_dist_70;
        min_idx = 7'd70;
    end
    if (chan_dist_71 < min_dist) begin
        min_dist = chan_dist_71;
        min_idx = 7'd71;
    end
    if (chan_dist_72 < min_dist) begin
        min_dist = chan_dist_72;
        min_idx = 7'd72;
    end
    if (chan_dist_73 < min_dist) begin
        min_dist = chan_dist_73;
        min_idx = 7'd73;
    end
    if (chan_dist_74 < min_dist) begin
        min_dist = chan_dist_74;
        min_idx = 7'd74;
    end
    if (chan_dist_75 < min_dist) begin
        min_dist = chan_dist_75;
        min_idx = 7'd75;
    end
    if (chan_dist_76 < min_dist) begin
        min_dist = chan_dist_76;
        min_idx = 7'd76;
    end
    if (chan_dist_77 < min_dist) begin
        min_dist = chan_dist_77;
        min_idx = 7'd77;
    end
    if (chan_dist_78 < min_dist) begin
        min_dist = chan_dist_78;
        min_idx = 7'd78;
    end
    if (chan_dist_79 < min_dist) begin
        min_dist = chan_dist_79;
        min_idx = 7'd79;
    end
    if (chan_dist_80 < min_dist) begin
        min_dist = chan_dist_80;
        min_idx = 7'd80;
    end
    if (chan_dist_81 < min_dist) begin
        min_dist = chan_dist_81;
        min_idx = 7'd81;
    end
    if (chan_dist_82 < min_dist) begin
        min_dist = chan_dist_82;
        min_idx = 7'd82;
    end
    if (chan_dist_83 < min_dist) begin
        min_dist = chan_dist_83;
        min_idx = 7'd83;
    end
end

// --- Part 5: Static Output Mux ---
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 20'd0;
        valid <= 1'b0;
        uncorrectable <= 1'b0;
    end else if (start) begin
        // Static Mux for data_out
        case(min_idx)
            7'd0: data_out <= chan_x_0;
            7'd1: data_out <= chan_x_1;
            7'd2: data_out <= chan_x_2;
            7'd3: data_out <= chan_x_3;
            7'd4: data_out <= chan_x_4;
            7'd5: data_out <= chan_x_5;
            7'd6: data_out <= chan_x_6;
            7'd7: data_out <= chan_x_7;
            7'd8: data_out <= chan_x_8;
            7'd9: data_out <= chan_x_9;
            7'd10: data_out <= chan_x_10;
            7'd11: data_out <= chan_x_11;
            7'd12: data_out <= chan_x_12;
            7'd13: data_out <= chan_x_13;
            7'd14: data_out <= chan_x_14;
            7'd15: data_out <= chan_x_15;
            7'd16: data_out <= chan_x_16;
            7'd17: data_out <= chan_x_17;
            7'd18: data_out <= chan_x_18;
            7'd19: data_out <= chan_x_19;
            7'd20: data_out <= chan_x_20;
            7'd21: data_out <= chan_x_21;
            7'd22: data_out <= chan_x_22;
            7'd23: data_out <= chan_x_23;
            7'd24: data_out <= chan_x_24;
            7'd25: data_out <= chan_x_25;
            7'd26: data_out <= chan_x_26;
            7'd27: data_out <= chan_x_27;
            7'd28: data_out <= chan_x_28;
            7'd29: data_out <= chan_x_29;
            7'd30: data_out <= chan_x_30;
            7'd31: data_out <= chan_x_31;
            7'd32: data_out <= chan_x_32;
            7'd33: data_out <= chan_x_33;
            7'd34: data_out <= chan_x_34;
            7'd35: data_out <= chan_x_35;
            7'd36: data_out <= chan_x_36;
            7'd37: data_out <= chan_x_37;
            7'd38: data_out <= chan_x_38;
            7'd39: data_out <= chan_x_39;
            7'd40: data_out <= chan_x_40;
            7'd41: data_out <= chan_x_41;
            7'd42: data_out <= chan_x_42;
            7'd43: data_out <= chan_x_43;
            7'd44: data_out <= chan_x_44;
            7'd45: data_out <= chan_x_45;
            7'd46: data_out <= chan_x_46;
            7'd47: data_out <= chan_x_47;
            7'd48: data_out <= chan_x_48;
            7'd49: data_out <= chan_x_49;
            7'd50: data_out <= chan_x_50;
            7'd51: data_out <= chan_x_51;
            7'd52: data_out <= chan_x_52;
            7'd53: data_out <= chan_x_53;
            7'd54: data_out <= chan_x_54;
            7'd55: data_out <= chan_x_55;
            7'd56: data_out <= chan_x_56;
            7'd57: data_out <= chan_x_57;
            7'd58: data_out <= chan_x_58;
            7'd59: data_out <= chan_x_59;
            7'd60: data_out <= chan_x_60;
            7'd61: data_out <= chan_x_61;
            7'd62: data_out <= chan_x_62;
            7'd63: data_out <= chan_x_63;
            7'd64: data_out <= chan_x_64;
            7'd65: data_out <= chan_x_65;
            7'd66: data_out <= chan_x_66;
            7'd67: data_out <= chan_x_67;
            7'd68: data_out <= chan_x_68;
            7'd69: data_out <= chan_x_69;
            7'd70: data_out <= chan_x_70;
            7'd71: data_out <= chan_x_71;
            7'd72: data_out <= chan_x_72;
            7'd73: data_out <= chan_x_73;
            7'd74: data_out <= chan_x_74;
            7'd75: data_out <= chan_x_75;
            7'd76: data_out <= chan_x_76;
            7'd77: data_out <= chan_x_77;
            7'd78: data_out <= chan_x_78;
            7'd79: data_out <= chan_x_79;
            7'd80: data_out <= chan_x_80;
            7'd81: data_out <= chan_x_81;
            7'd82: data_out <= chan_x_82;
            7'd83: data_out <= chan_x_83;
            default: data_out <= 20'd0;
        endcase
        valid <= 1'b1;
        uncorrectable <= (min_dist > 16'd100) ? 1'b1 : 1'b0;
    end
end
