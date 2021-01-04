`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:06:00
// Design Name: 
// Module Name: EX_MA
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


module EX_MA(clk,I_NPC1,I_NPC2,I_Z,I_ALUOut,I_Rt,I_IR,NPC3,NPC2,Flag,ALUOut,Rt,IR,Opcode);
    input clk;
    input[31:0]I_NPC1;
    input[31:0]I_NPC2;
    input I_Z;
    input[31:0] I_ALUOut;
    input[31:0]I_Rt;
    input[31:0]I_IR;
    output[31:0]Opcode;
    output[31:0] NPC3;
    output[31:0] NPC2;
    output Flag;
    output[31:0] ALUOut;
    output[31:0] Rt;
    output[31:0]IR;
    reg[31:0]  r_NPC3;
    reg [31:0] r_NPC2;
    reg r_Flag;
    reg [31:0] r_ALUOut;
    reg [31:0] r_Rt;
    reg [31:0]r_IR;
    assign NPC3 =r_NPC3;
    assign NPC2 =r_NPC2;
    assign Flag = r_Flag;
    assign ALUOut = r_ALUOut;
    assign Rt = r_Rt;
    assign IR = r_IR;
    assign Opcode = IR[31:0];
    initial begin
        r_IR = 32'b11111111111111111111111111111111;
    end
    always@(posedge clk)
    begin
        r_NPC3 = I_NPC1;
        r_NPC2 = I_NPC2;
        r_Flag = I_Z;
        r_ALUOut = I_ALUOut;
        r_Rt = I_Rt;
        r_IR = I_IR;
    end
endmodule
