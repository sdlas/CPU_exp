`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 16:13:10
// Design Name: 
// Module Name: Or
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


module Or(DATA_1,DATA_2,O_DATA);
    input DATA_1;
    input DATA_2;
    output O_DATA;
    assign O_DATA = DATA_1||DATA_2;
endmodule
