`timescale 1ns / 1ps

module display_driver(
    input  wire i_clk,
    input  wire i_rst,

    input  wire [31:0] i_time,   // current stopwatch value
    input  wire [31:0] i_lap,    // stored lap value
    input  wire        i_sel,    // 0 = time, 1 = lap

    output wire [6:0]  o_seg,
    output reg  [7:0]  o_an
);

    // ---------------------------------------------------------
    // Internal signals
    // ---------------------------------------------------------
    wire w_en;
    wire [2:0] w_digit;   // 0–7 digits
    reg  [3:0] w_bin;
    wire [31:0] w_data;

    // ---------------------------------------------------------
    // Select displayed value
    // ---------------------------------------------------------
    assign w_data = (i_sel) ? i_lap : i_time;

    // ---------------------------------------------------------
    // Refresh clock (~1-2ms per digit)
    // ---------------------------------------------------------
    clk_en #(
        .MAX(100_000)
    ) clk_mux (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_ce(w_en)
    );

    // ---------------------------------------------------------
    // 3-bit counter (0–7 digits)
    // ---------------------------------------------------------
    counter #(
        .N(3)
    ) digit_counter (
        .clk(i_clk),
        .rst(i_rst),
        .en(w_en),
        .cnt(w_digit)
    );

    // ---------------------------------------------------------
    // Select 4-bit nibble (one digit)
    // ---------------------------------------------------------
    always @(*) begin
        case (w_digit)
            3'd0: w_bin = w_data[3:0];
            3'd1: w_bin = w_data[7:4];
            3'd2: w_bin = w_data[11:8];
            3'd3: w_bin = w_data[15:12];
            3'd4: w_bin = w_data[19:16];
            3'd5: w_bin = w_data[23:20];
            3'd6: w_bin = w_data[27:24];
            3'd7: w_bin = w_data[31:28];
            default: w_bin = 4'b0;
        endcase
    end

    // ---------------------------------------------------------
    // 7-seg decoder
    // ---------------------------------------------------------
    bin2seg decoder (
        .i_bin(w_bin),
        .o_seg(o_seg)
    );

    // ---------------------------------------------------------
    // Anode control (active-low)
    // ---------------------------------------------------------
    always @(*) begin
        o_an = 8'b11111111;
        o_an[w_digit] = 1'b0;
    end

endmodule
