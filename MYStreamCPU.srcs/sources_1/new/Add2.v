`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:53:08
// Design Name: 
// Module Name: Add2
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


module Add2(A_data,B_data,O_data);
    input[31:0] A_data;
    input[31:0] B_data;
    output[31:0] O_data;
    assign O_data=A_data+B_data;
endmodule

