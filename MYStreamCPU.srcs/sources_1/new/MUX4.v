`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 15:57:41
// Design Name: 
// Module Name: MUX4
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


module MUX4(DATA_1,DATA_2,DATA_3,DATA_4,control1,control2,O_DATA);
    input[31:0]DATA_1;
    input[31:0]DATA_2;
    input[31:0]DATA_3;
    input[31:0]DATA_4;
    input control1;
    input control2;
    output[31:0] O_DATA;
    assign O_DATA=control1?(control2?DATA_4:DATA_3):(control2?DATA_2:DATA_1);
endmodule
