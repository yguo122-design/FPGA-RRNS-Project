`timescale 1ns / 1ps

// =============================================================================
// Module: channel_unit
// Description: Single Channel CRT Reconstruction and MLD Distance Calculation
// Format: SystemVerilog (.sv) for better XSim compatibility
// =============================================================================

module channel_unit #(
    parameter [19:0] P_MI0     = 20'd0,
    parameter [19:0] P_MI1     = 20'd0,
    parameter [19:0] P_MI2     = 20'd0,
    parameter [19:0] P_INV0    = 20'd0,
    parameter [19:0] P_INV1    = 20'd0,
    parameter [19:0] P_INV2    = 20'd0,
    parameter [19:0] P_M_TOTAL = 20'd0,
    parameter [3:0]  P_IDX1    = 4'd0,
    parameter [3:0]  P_IDX2    = 4'd0,
    parameter [3:0]  P_IDX3    = 4'd0
) (
    input wire [6:0] r0, input wire [6:0] r1, input wire [6:0] r2,
    input wire [6:0] r3, input wire [6:0] r4, input wire [6:0] r5,
    input wire [6:0] r6, input wire [6:0] r7, input wire [6:0] r8,
    
    output logic [19:0] x_out,    // SV: use logic instead of reg
    output logic [15:0] dist_out
);

    // Internal Signals
    logic [6:0] r_a, r_b, r_c; 
    logic [6:0] m_val_iter, xm, d1, d2, d;
    logic [6:0] r_val;
    int i;                      // SV: use int instead of integer
    logic [19:0] x_temp;
    logic [15:0] sum_sq;

    // Helper function to get modulus value from index
    // SV allows functions to be called inside always blocks
    function automatic logic [6:0] get_mod_val(input logic [3:0] idx);
        case(idx)
            0: return 7'd64;
            1: return 7'd63;
            2: return 7'd65;
            3: return 7'd31;
            4: return 7'd29;
            5: return 7'd23;
            6: return 7'd19;
            7: return 7'd17;
            8: return 7'd11;
            default: return 7'd1;
        endcase
    endfunction

    // 1. Select Residues
    always_comb begin
        case(P_IDX1)
            0: r_a = r0; 1: r_a = r1; 2: r_a = r2; 3: r_a = r3;
            4: r_a = r4; 5: r_a = r5; 6: r_a = r6; 7: r_a = r7;
            default: r_a = r8;
        endcase
        case(P_IDX2)
            0: r_b = r0; 1: r_b = r1; 2: r_b = r2; 3: r_b = r3;
            4: r_b = r4; 5: r_b = r5; 6: r_b = r6; 7: r_b = r7;
            default: r_b = r8;
        endcase
        case(P_IDX3)
            0: r_c = r0; 1: r_c = r1; 2: r_c = r2; 3: r_c = r3;
            4: r_c = r4; 5: r_c = r5; 6: r_c = r6; 7: r_c = r7;
            default: r_c = r8;
        endcase
    end

    // 2. CRT Reconstruction
    always_comb begin
        logic [63:0] term1, term2, term3, sum_raw;
        
        // SV: $signed works perfectly here
        term1 = $signed(r_a) * $signed(P_MI0) * $signed(P_INV0);
        term2 = $signed(r_b) * $signed(P_MI1) * $signed(P_INV1);
        term3 = $signed(r_c) * $signed(P_MI2) * $signed(P_INV2);
        
        sum_raw = term1 + term2 + term3;
        
        if (P_M_TOTAL != 0)
            x_temp = sum_raw % P_M_TOTAL;
        else
            x_temp = 0;
            
        x_out = x_temp[19:0];
    end

    // 3. Distance Calculation
    always_comb begin
        sum_sq = 0;
        // SV: for loop with int is standard
        for (i = 0; i < 9; i++) begin
            if (i != P_IDX1 && i != P_IDX2 && i != P_IDX3) begin
                case(i)
                    0: r_val = r0; 1: r_val = r1; 2: r_val = r2; 3: r_val = r3;
                    4: r_val = r4; 5: r_val = r5; 6: r_val = r6; 7: r_val = r7;
                    default: r_val = r8;
                endcase
                
                m_val_iter = get_mod_val(i);
                
                if (m_val_iter != 0) begin
                    xm = x_temp % m_val_iter;
                    d1 = (xm > r_val) ? (xm - r_val) : (r_val - xm);
                    d2 = m_val_iter - d1;
                    d = (d1 < d2) ? d1 : d2;
                    sum_sq = sum_sq + (d * d);
                end
            end
        end
        dist_out = sum_sq;
    end

endmodule