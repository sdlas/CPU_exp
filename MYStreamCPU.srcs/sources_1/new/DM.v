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
    input clk;//时钟信号
    input MemWr;//写
    input MemRd;//读
    input [ADDR_WIDTH-1:0] Addr;
    input [DATA_WIDTH-1:0] W_data;
    output[DATA_WIDTH-1:0] R_data;
    reg [DATA_WIDTH-1:0] data_out;//待输出数据
    reg [DATA_WIDTH-1:0] mem [RAM_DEPTH-1:0];//存储器数据块
    assign R_data = (MemRd)?data_out:{DATA_WIDTH{1'bz}};//读出数据
    initial begin
        mem[0]=0;
        mem[1]=1;
        mem[2]=12;
    end
    always @(posedge clk)
        begin:MEM_WRITE
            if(MemWr) //时钟上升沿，且写入有效，则将输入数据端的数据写给存储器
                begin
                    mem[Addr] <=W_data;
                end
        end
    always @(*)
    begin: MEM_READ
        if(MemRd)//读出有效
            begin
                data_out<=mem[Addr];
            end
    end
endmodule
