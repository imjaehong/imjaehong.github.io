`timescale 1ns / 1ps

module button_detector (
    input  logic clk,
    input  logic reset,
    input  logic i_btn,
    output logic rising_edge,
    output logic falling_edge,
    output logic both_edge
);

    logic                       clk_1khz;
    logic                       debounce;
    logic [                7:0] shift_reg;
    logic [$clog2(100_000)-1:0] div_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            clk_1khz    <= 1'b0;
        end else begin
            if (div_counter == 100_000 - 1) begin
                div_counter <= 0;
                clk_1khz    <= 1'b1;
            end else begin
                div_counter <= div_counter + 1;
                clk_1khz    <= 1'b0;
            end
        end
    end

    shift_register U_SHIFT_REG (
        .clk   (clk_1khz),
        .reset (reset),
        .i_data(i_btn),
        .o_data(shift_reg)
    );

    assign debounce = &shift_reg;
    //assign o_btn = debounce;

    logic [1:0] edge_reg;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            edge_reg <= 0;
        end else begin
            edge_reg[0] <= debounce;
            edge_reg[1] <= edge_reg[0];
        end
    end

    assign rising_edge  = edge_reg[0] & ~edge_reg[1];
    assign falling_edge = ~edge_reg[0] & edge_reg[1];
    assign both_edge    = rising_edge | falling_edge;

endmodule


module shift_register (
    input  logic       clk,
    input  logic       reset,
    input  logic       i_data,
    output logic [7:0] o_data
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            o_data <= 0;
        end else begin
            o_data <= {i_data, o_data[7:1]};  // right shift
            //o_data <= {o_data[6:0], i_data};// left shift
        end
    end

endmodule
