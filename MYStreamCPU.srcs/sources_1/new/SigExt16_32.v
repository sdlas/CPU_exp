`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:01:54
// Design Name: 
// Module Name: SigExt16_32
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


module SigExt16_32(I_data,O_data);
    input [15:0] I_data;
    output [31:0] O_data;
    reg [15:0]zero=0;
    assign O_data = {zero,I_data};
endmodule