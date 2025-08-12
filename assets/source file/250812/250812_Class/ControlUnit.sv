`timescale 1ns / 1ps

module ControlUnit (
    input  logic clk,
    input  logic reset,
    input  logic ILe10,
    output logic SumSrcMuxSel,
    output logic ISrcMuxSel,
    output logic SumEn,
    output logic IEn,
    output logic AdderSrcMuxSel,
    output logic OutPortEn
);

    typedef enum {
        S0,
        S1,
        S2,
        S3,
        S4,
        S5
    } state_e;

    state_e state, next_state;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        SumSrcMuxSel = 0;
        ISrcMuxSel = 0;
        SumEn = 0;
        IEn = 0;
        AdderSrcMuxSel = 0;
        OutPortEn = 0;
        case (state)
            S0: begin
                SumSrcMuxSel = 0;
                ISrcMuxSel = 0;
                SumEn = 1;
                IEn = 1;
                AdderSrcMuxSel = 0;  // X
                OutPortEn = 0;
                next_state = S1;
            end
            S1: begin
                SumSrcMuxSel = 0;
                ISrcMuxSel = 0;
                SumEn = 0;
                IEn = 0;
                AdderSrcMuxSel = 0;
                OutPortEn = 0;
                if (ILe10) next_state = S2;
                else next_state = S5;
            end
            S2: begin
                SumSrcMuxSel = 1;
                ISrcMuxSel = 1;
                SumEn = 1;
                IEn = 0;
                AdderSrcMuxSel = 0;
                OutPortEn = 0;
                next_state = S3;
            end
            S3: begin
                SumSrcMuxSel = 1;
                ISrcMuxSel = 1;
                SumEn = 0;
                IEn = 1;
                AdderSrcMuxSel = 1;
                OutPortEn = 0;
                next_state = S4;
            end
            S4: begin
                SumSrcMuxSel = 1;
                ISrcMuxSel = 1;
                SumEn = 0;
                IEn = 0;
                AdderSrcMuxSel = 0;
                OutPortEn = 1;
                next_state = S1;
            end
            S5: begin
                SumSrcMuxSel = 1;
                ISrcMuxSel = 1;
                SumEn = 0;
                IEn = 0;
                AdderSrcMuxSel = 0;
                OutPortEn = 0;
                next_state = S5;
            end
        endcase
    end

endmodule
