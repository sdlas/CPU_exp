`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:00:37
// Design Name: 
// Module Name: SHL2_1
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


module SHL2_1(I_data,O_data);
    input[31:0] I_data;
    output[31:0] O_data;
    parameter Z=2'b00;
    assign O_data = {I_data[29:0],Z};
endmodule