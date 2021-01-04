`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:59:30
// Design Name: 
// Module Name: PC
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


module PC(clk,PCWrite,PCSrc,W_data,R_data);
    input clk;
    input PCWrite;
    input PCSrc;
    output[31:0] W_data;
    input[31:0] R_data;
    reg[31:0] PCcount;
    assign R_data = PCcount;
    initial begin
        PCcount=0;
    end
    always@(posedge clk)
        if(PCWrite||PCSrc)
            PCcount <= W_data;
endmodule

