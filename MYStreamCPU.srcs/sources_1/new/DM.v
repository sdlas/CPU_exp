`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:55:39
// Design Name: 
// Module Name: DM
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


module DM(clk,Addr,MemWr,MemRd,W_data,R_data);
    parameter DATA_WIDTH=32;
    parameter ADDR_WIDTH=32;
    parameter RAM_DEPTH = 16;
    input clk;//ʱ���ź�
    input MemWr;//д
    input MemRd;//��
    input [ADDR_WIDTH-1:0] Addr;
    input [DATA_WIDTH-1:0] W_data;
    output[DATA_WIDTH-1:0] R_data;
    reg [DATA_WIDTH-1:0] data_out;//���������
    reg [DATA_WIDTH-1:0] mem [RAM_DEPTH-1:0];//�洢�����ݿ�
    assign R_data = (MemRd)?data_out:{DATA_WIDTH{1'bz}};//��������
    initial begin
        mem[0]=0;
        mem[1]=1;
        mem[2]=12;
    end
    always @(posedge clk)
        begin:MEM_WRITE
            if(MemWr) //ʱ�������أ���д����Ч�����������ݶ˵�����д���洢��
                begin
                    mem[Addr] <=W_data;
                end
        end
    always @(*)
    begin: MEM_READ
        if(MemRd)//������Ч
            begin
                data_out<=mem[Addr];
            end
    end
endmodule
