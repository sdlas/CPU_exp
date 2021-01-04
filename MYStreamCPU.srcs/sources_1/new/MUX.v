`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:58:55
// Design Name: 
// Module Name: MUX
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


module MUX(First_data,Second_data,control,O_data);
    input[31:0] First_data;
    input[31:0] Second_data;
    input control;
    output[31:0] O_data;
    assign O_data=control?Second_data:First_data;
endmodule
