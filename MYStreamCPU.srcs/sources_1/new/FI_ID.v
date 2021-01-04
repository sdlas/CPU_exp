`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:05:29
// Design Name: 
// Module Name: FI_ID
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


module FI_ID(clk,FI_IDWrite,ControlPause,PC,In,NPC1,Inst);
    input clk;
    input FI_IDWrite;
    input ControlPause;
    input[31:0] PC;
    input[31:0] In;
    output[31:0] NPC1;
    output[31:0] Inst;
    reg[31:0]r_NPC1;
    reg[31:0]r_Inst;
    assign NPC1 = r_NPC1;
    assign Inst = r_Inst;
    initial begin
        r_Inst = 32'b11111111111111111111111111111111;
    end
    always@(posedge clk)
    begin
        if(!ControlPause)
            begin
                if(!FI_IDWrite)
                    begin
                        r_NPC1 <=PC;
                        r_Inst <=In;
                    end
            end
        else
            begin
                r_NPC1 <={32{1'b1}};
                r_Inst <={32{1'b1}};
            end
    end
endmodule
