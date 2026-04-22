`timescale 1ns / 1ps

module stopwatch_counter #(
    parameter N = 16
)(
    input wire clk, // main clock
    input wire rst, // synchronous reset
    input wire en, // running enable
    input wire tick, // slow pulse from clk_en
    output reg [N-1:0] time_out // current stopwatch value
);

    always @(posedge clk) begin
        if (rst) begin
            time_out <= 0;
        end
        else if (en && tick) begin
            time_out <= time_out + 1'b1;
        end
    end

endmodule
