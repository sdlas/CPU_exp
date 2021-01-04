`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:59:57
// Design Name: 
// Module Name: RegFile
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


module RegFile(clk,W_data,R_reg1,R_reg2,W_reg,W,R_data1,R_data2);
    input clk;//ʱ��
    input [31:0]W_data;//��д������
    input [4:0]R_reg1;//�Ĵ�����1
    input [4:0]R_reg2;//�Ĵ�����2
    input [4:0]W_reg;//д��Ĵ�����
    input W;//�Ĵ���д�����ź�
    output [31:0]R_data1;//��������1
    output [31:0]R_data2;//��������2
    reg[31:0] mem [31:0];
    assign R_data1=mem[R_reg1];
    assign R_data2=mem[R_reg2];
    initial begin
        mem[0]=0;
        mem[3]=1;
    end
    always@(posedge clk)
    begin
        if(W)
            begin
                mem[W_reg]<=W_data;
            end
    end
endmodule
