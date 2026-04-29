`timescale 1ns / 1ps

module debounce(
    input clk,
    input rst,
    input btn_in,
    output btn_state,
    output btn_press
    );
            //------------------------------------------------------------
    // Constants (internal)
    //------------------------------------------------------------
    localparam C_SHIFT_LEN = 4;  // Debounce history
    localparam C_MAX       = 200_000;  // Sampling period
                                 // 2 for simulation
                                 // 200_000 (2 ms) for implementation !!!

    //------------------------------------------------------------
    // Internal signals
    //------------------------------------------------------------
    wire ce_sample;
    reg sync0, sync1;
    reg [C_SHIFT_LEN-1:0] shift_reg;
    reg debounced;
    reg delayed;

    //------------------------------------------------------------
    // Clock enable instance
    //------------------------------------------------------------
    clk_en #(
        .MAX (C_MAX)
    ) clock_inst (
        .i_clk (clk),
        .i_rst (rst),
        .o_ce  (ce_sample)
    );

    //------------------------------------------------------------
    // Debounce logic
    //------------------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            sync0     <= 0;
            sync1     <= 0;
            shift_reg <= 0;
            debounced <= 0;
            delayed   <= 0;
        end else begin
            // Input synchronizer
            sync1 <= sync0;
            sync0 <= btn_in;

            // Sample only when enable pulse occurs
            if (ce_sample) begin

                // Shift values to the left and load a new sample as LSB
                shift_reg <= {shift_reg[C_SHIFT_LEN-2:0], sync1};

                // Check if all bits are '1'
                if (&shift_reg)
                    debounced <= 1;
                // Check if all bits are '0'
                else if (~|shift_reg)
                    debounced <= 0;
            end

            // One clock delayed output for edge detector
            delayed <= debounced;
        end
    end

    //------------------------------------------------------------
    // Outputs
    //------------------------------------------------------------
    assign btn_state = debounced;

    // One-clock pulse when button pressed
    assign btn_press = debounced & ~delayed;

endmodule

