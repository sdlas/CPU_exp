`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:54:08
// Design Name: 
// Module Name: ALUCU
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


module ALUCU(Func,ALUOp,ALUCtrl);
    input[5:0]Func;
    input[1:0]ALUOp;
    output[2:0]ALUCtrl;
    reg[2:0] r_ALUCtrl;
    assign ALUCtrl = r_ALUCtrl;
    always@(*)
    begin
        case(ALUOp)
            2'b00:
                begin
                    r_ALUCtrl=3'b100;
                end
            2'b01:
                begin
                    r_ALUCtrl=3'b110;
                end
            2'b10:
                begin
                    case(Func)
                        6'b100000:r_ALUCtrl=3'b100;
                        6'b100001:r_ALUCtrl=3'b101;
                        6'b100010:r_ALUCtrl=3'b110;
                        6'b100100:r_ALUCtrl=3'b000;
                        6'b100101:r_ALUCtrl=3'b001;
                        6'b101010:r_ALUCtrl=3'b011;
                        6'b101011:r_ALUCtrl=3'b111;
                        default:r_ALUCtrl=3'b000;
                    endcase
                end
             2'b11:
                begin
                    r_ALUCtrl=3'b110;
                end
             default:r_ALUCtrl=3'b111;
        endcase
    end
endmodule
