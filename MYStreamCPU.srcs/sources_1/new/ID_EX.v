`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 14:05:43
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(clk,Pause,I_NPC1,I_Rs,I_Rt,I_Imm32,I_IR,NPC1,Rs,Rt,Imm32,IR);
    input clk;
    input Pause;
    input[31:0]I_NPC1;
    input[31:0]I_Rs;
    input[31:0]I_Rt;
    input[31:0]I_Imm32;
    input[31:0]I_IR;
    output[31:0]NPC1;
    output[31:0]Rs;
    output[31:0]Rt;
    output[31:0]Imm32;
    output[31:0]IR;
    reg[31:0]r_NPC1;
    reg[31:0]r_Rs;
    reg[31:0]r_Rt;
    reg[31:0]r_Imm32;
    reg[31:0]r_IR;
    assign NPC1 = r_NPC1;
    assign Rs = r_Rs;
    assign Rt = r_Rt;
    assign Imm32 = r_Imm32;
    assign IR = r_IR;
    initial begin
        r_IR = 32'b11111111111111111111111111111111;
    end
    always@(posedge clk)
    begin
        if(!Pause)
            begin
                r_NPC1<=I_NPC1;
                r_Rs<=I_Rs;
                r_Rt<=I_Rt;
                r_Imm32<=I_Imm32;
                r_IR<=I_IR;
            end
         else
            begin
                //若希望阻塞，则将所有信号置1
                r_NPC1<={32{1'b1}};
                r_Rs<={32{1'b1}};
                r_Rt<={32{1'b1}};
                r_Imm32<={32{1'b1}};
                r_IR<={32{1'b1}};
            end

    end
endmodule
