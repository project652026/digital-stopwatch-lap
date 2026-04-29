`timescale 1ns/1ps

module counter #(
    // "#()" after a module name introduces a parameter list
    parameter N = 3  //! Number of bits for the counter
)(
    input  wire clk,         //! Main clock
    input  wire rst,         //! High-active synchronous reset
    input  wire en,          //! Clock enable
    output reg  [N-1:0] cnt  //! Counter value
);

    //! Clocked, sequential process, triggered when clk rises
    //! from 0 to 1 (positive edge of a signal)
    always @(posedge clk) begin
        if (rst) begin
            cnt <= 0;  // Reset counter; non-blocking assignment (<=)
        end
        else if (en) begin
            cnt <= cnt + 1'b1;  // Increment counter when enabled
        end
    end

endmodule
