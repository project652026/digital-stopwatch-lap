`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module counter # ( 
    parameter N = 16
)(
    input i_clk,
    input i_rst,
    input i_en,
    output reg [N-1:0] o_cnt
    );
    
    always @(posedge i_clk) begin
        if (i_rst) begin
            o_cnt <= 0;
        end
        else if (i_en) begin   
            o_cnt <= o_cnt + 1'b1;
        end
    end
endmodule
