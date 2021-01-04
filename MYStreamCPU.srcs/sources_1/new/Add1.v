`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:52:42
// Design Name: 
// Module Name: Add1
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


module Add1(B_data,O_data);
    input[31:0] B_data;
    output[31:0] O_data;
    assign O_data=B_data+4;
endmodule
