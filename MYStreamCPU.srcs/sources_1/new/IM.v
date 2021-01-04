`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:56:52
// Design Name: 
// Module Name: IM
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


module IM(clk,Addr,R_data);
    parameter DATA_WIDTH=32;
    parameter ADDR_WIDTH=32;
    parameter RAM_DEPTH = 1000;
    input clk;//ʱ���ź�
    input [ADDR_WIDTH-1:0] Addr;
    output[DATA_WIDTH-1:0] R_data;
    reg [DATA_WIDTH-1:0] data_out;//���������
    reg [7:0] mem [127:0];//�洢�����ݿ�
    assign R_data = {mem[Addr],mem[Addr+1],mem[Addr+2],mem[Addr+3]};//��������
    initial begin
        $readmemb("D:/project/vivado/MYStreamCPU/instruction.txt", mem); // ���ļ��ж�ȡָ������ƴ���
        data_out=32'b11111111111111111111111111111111;
    end
endmodule
