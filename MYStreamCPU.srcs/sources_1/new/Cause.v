`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 20:35:11
// Design Name: 
// Module Name: Cause
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Cause(clk,IntCause,CPUInt,Cause);
    input clk;
    input[31:0] IntCause;
    input CPUInt;
    output[31:0]Cause;
    reg [31:0]r_Cause;
    assign Cause = r_Cause;
    always@(posedge clk)
    begin
        if(CPUInt)
            r_Cause = IntCause;
    end
endmodule
