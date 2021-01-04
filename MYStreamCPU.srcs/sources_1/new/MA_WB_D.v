`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 16:22:21
// Design Name: 
// Module Name: MA_WB_D
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


module MA_WB_D(I_IR,Rt,Rd,Opcode);
    input[31:0]I_IR;
    output[4:0] Rt;
    output[4:0] Rd;
    output[31:0] Opcode;
    assign Rt = I_IR[20:16];
    assign Rd = I_IR[15:11];
    assign Opcode = I_IR[31:0];
endmodule
