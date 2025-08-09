`timescale 1ns / 1ps

module btn_debounce (
    input  logic clk,
    input  logic rst,
    input  logic i_btn,
    output logic o_btn
);

    parameter F_COUNT = 10000;

    logic [$clog2(F_COUNT)-1:0] r_counter;
    logic r_clk;
    logic [7:0] q_reg, q_next;
    logic w_debounce;

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            r_counter <= 0;
            r_clk <= 0;
        end else begin
            if (r_counter == (F_COUNT - 1)) begin
                r_counter <= 0;
                r_clk <= 1'b1;
            end else begin
                r_counter <= r_counter + 1;
                r_clk <= 1'b0;
            end
        end
    end

    // debounce
    always_ff @(posedge r_clk, posedge rst) begin
        if (rst) begin
            q_reg <= 0;
        end else begin
            q_reg <= q_next;
        end
    end

    // shift register
    always_comb begin
        q_next = {i_btn, q_reg[7:1]};
    end

    // 8 input and gate
    assign w_debounce = &q_reg;

    logic r_edge_q;

    // edge detector
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            r_edge_q <= 0;
        end else begin
            r_edge_q <= w_debounce;
        end
    end

    // rising edge 
    // assign o_btn = (~r_edge_q) & w_debounce;

    // falling edge
    assign o_btn = r_edge_q & ~w_debounce;

endmodule
