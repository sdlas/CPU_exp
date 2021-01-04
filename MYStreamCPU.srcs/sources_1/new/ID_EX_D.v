`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 15:36:02
// Design Name: 
// Module Name: ID_EX_D
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


module ID_EX_D(Inst,Imm,Func,Opcode);
    input[31:0]Inst;
    output[25:0]Imm;
    output[5:0]Func;
    output[31:0]Opcode;
    assign Imm = Inst[25:0];
    assign Func = Inst[5:0];
    assign Opcode = Inst[31:0];
endmodule
