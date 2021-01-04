`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:55:06
// Design Name: 
// Module Name: And
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


module And(IN1,IN2,OUT);
    input IN1;
    input IN2;
    output OUT;
    assign OUT=IN1&IN2;
endmodule
