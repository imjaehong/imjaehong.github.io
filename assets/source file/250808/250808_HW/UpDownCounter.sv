`timescale 1ns / 1ps

module UpDownCounter (
    input  logic        clk,
    input  logic        reset,
    input  logic        btn_mode,
    input  logic        btn_run_stop,
    input  logic        btn_clear,
    input  logic [ 7:0] uart_data,
    output logic [ 1:0] led_mode,
    output logic [ 1:0] led_run_stop,
    output logic [13:0] count
);

    logic tick_10hz;
    logic mode, run_stop, clear;

    clk_div_10hz U_Clk_Div_10hz (
        .clk      (clk),
        .reset    (reset),
        .run_stop (run_stop),
        .clear    (clear),
        .tick_10hz(tick_10hz)
    );

    up_down_counter U_Up_Down_Counter (
        .clk  (clk),
        .reset(reset),
        .tick (tick_10hz),
        .mode (mode),
        .clear(clear),
        .count(count)
    );

    control_unit U_Control_Unit (
        .clk         (clk),
        .reset       (reset),
        .btn_mode    (btn_mode),
        .btn_run_stop(btn_run_stop),
        .btn_clear   (btn_clear),
        .uart_data   (uart_data),
        .mode        (mode),
        .run_stop    (run_stop),
        .clear       (clear),
        .led_mode    (led_mode),
        .led_run_stop(led_run_stop)
    );

endmodule


module clk_div_10hz (
    input  logic clk,
    input  logic reset,
    input  logic run_stop,
    input  logic clear,
    output logic tick_10hz
);

    //logic [23:0] div_counter;
    logic [$clog2(10_000_000)-1:0] div_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            div_counter <= 0;
            tick_10hz   <= 1'b0;
        end else begin
            if (run_stop) begin
                if (div_counter == 10_000_000 - 1) begin
                    div_counter <= 0;
                    tick_10hz   <= 1'b1;
                end else begin
                    div_counter <= div_counter + 1;
                    tick_10hz   <= 1'b0;
                end
            end
            if (clear) begin
                div_counter <= 0;
                tick_10hz   <= 1'b0;
            end
        end
    end

endmodule


module up_down_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic        tick,
    input  logic        mode,
    input  logic        clear,
    output logic [13:0] count
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            if (clear) begin
                count <= 0;
            end
            if (mode == 1'b0) begin  // up counter
                if (tick) begin
                    if (count == 9999) begin
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
            end else begin  // down counter
                if (tick) begin
                    if (count == 0) begin
                        count <= 9999;
                    end else begin
                        count <= count - 1;
                    end
                end
            end
        end
    end

endmodule


module control_unit (
    input  logic       clk,
    input  logic       reset,
    input  logic       btn_mode,
    input  logic       btn_run_stop,
    input  logic       btn_clear,
    input  logic [7:0] uart_data,
    output logic       mode,
    output logic       run_stop,
    output logic       clear,
    output logic [1:0] led_mode,
    output logic [1:0] led_run_stop
);
    /******************** MODE FSM ********************/

    typedef enum {
        UP,
        DOWN
    } state_mode_e;

    state_mode_e state_mode, next_state_mode;

    // state memory
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state_mode <= UP;
        end else begin
            state_mode <= next_state_mode;
        end
    end

    // transition logic
    always_comb begin
        next_state_mode = state_mode;
        mode = 0;
        led_mode = 2'b00;
        case (state_mode)
            UP: begin
                led_mode = 2'b01;
                if (btn_mode || (uart_data == "m")) begin
                    next_state_mode = DOWN;
                end
            end
            DOWN: begin
                mode = 1;
                led_mode = 2'b10;
                if (btn_mode || (uart_data == "m")) begin
                    next_state_mode = UP;
                end
            end
        endcase
    end

    /******************** RUN STOP CLEAR FSM ********************/

    typedef enum {
        STOP,
        RUN,
        CLEAR
    } state_counter_e;

    state_counter_e state_counter, next_state_counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            state_counter <= STOP;
        end else begin
            state_counter <= next_state_counter;
        end
    end

    always_comb begin
        next_state_counter = state_counter;
        run_stop = 0;
        clear = 0;
        led_run_stop = 2'b00;
        case (state_counter)
            STOP: begin
                led_run_stop = 2'b01;
                if (btn_run_stop || (uart_data == "r"))
                    next_state_counter = RUN;
                else if (btn_clear || (uart_data == "c"))
                    next_state_counter = CLEAR;
            end
            RUN: begin
                run_stop = 1;
                led_run_stop = 2'b10;
                if (btn_run_stop || (uart_data == "s"))
                    next_state_counter = STOP;
            end
            CLEAR: begin
                clear = 1;
                next_state_counter = STOP;
            end
        endcase
    end

endmodule
