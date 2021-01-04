`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 15:19:22
// Design Name: 
// Module Name: FI_ID_D
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


module FI_ID_D(Inst,R_reg1,R_reg2,Imm,Opcode);
    input[31:0] Inst;
    output[4:0] R_reg1;
    output[4:0] R_reg2;
    output[15:0] Imm;
    output[31:0] Opcode;
    assign R_reg1 = Inst[25:21];
    assign R_reg2 = Inst[20:16];
    assign Imm = Inst[15:0];
    assign Opcode = Inst[31:0];
endmodule
