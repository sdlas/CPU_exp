`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:01:08
// Design Name: 
// Module Name: SHL2_2
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


module SHL2_2(Inst,PC,O_data);
    input[25:0] Inst;
    input[31:0] PC;
    output [31:0] O_data;
    reg[1:0] X=2'b00;
    assign O_data={PC[31:28],Inst,X};
endmodule

