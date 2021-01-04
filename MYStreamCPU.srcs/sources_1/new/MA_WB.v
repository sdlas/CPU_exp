`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:06:19
// Design Name: 
// Module Name: MA_WB
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


module MA_WB(clk,I_ALUOut,I_MEMOut,I_IR,ALUOut,MEMOut,IR);
    input clk;
    input[31:0] I_ALUOut;
    input[31:0] I_MEMOut;
    input[31:0] I_IR;
    output[31:0] ALUOut;
    output[31:0] MEMOut;
    output[31:0] IR;
    reg[31:0] r_ALUOut;
    reg[31:0] r_MEMOut;
    reg[31:0] r_IR;
    assign ALUOut = r_ALUOut;
    assign MEMOut = r_MEMOut;
    assign IR = r_IR;
    initial begin
        r_IR = 32'b11111111111111111111111111111111;
    end
    always@(posedge clk)
    begin
        r_ALUOut = I_ALUOut;
        r_MEMOut = I_MEMOut;
        r_IR = I_IR;
    end
endmodule
