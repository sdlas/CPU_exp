`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:53:39
// Design Name: 
// Module Name: ALU
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


module ALU(A_data,B_data,ALUCtrl,Out_data,Zero,Overflow);
    input[31:0] A_data;
    input[31:0] B_data;
    input[2:0] ALUCtrl;
    output[31:0] Out_data;
    output Zero;//零标志
    output Overflow;//溢出标志
    reg r_Zero;
    reg r_Overflow;
    reg[31:0] r_Out_data;
    assign  Out_data = r_Out_data;
    assign Zero = r_Zero;
    assign Overflow = r_Overflow;
    initial begin
        r_Zero=0;
        r_Overflow=0;
    end
    always@(*)
        begin
            r_Zero=0;
            r_Overflow=0;
            case(ALUCtrl)
                3'b100://判溢出加
                    begin
                       {r_Overflow,r_Out_data}=A_data+B_data;
                    end
                3'b101://不判溢出加
                    begin
                        r_Out_data=A_data+B_data;
                    end
                3'b110://判溢出减
                    begin
                        r_Out_data=A_data-B_data;
                        r_Overflow = A_data[31]&B_data[31] ^ A_data[30]&B_data[30]; 
                    end
                3'b000://与
                    begin
                        r_Out_data=A_data&B_data;
                    end
                3'b001://或
                    begin
                        r_Out_data=A_data|B_data;
                    end
                3'b011://
                    begin
                        if(A_data<B_data)
                            begin
                                r_Out_data = 1;
                            end
                        else
                            begin
                                r_Out_data = 0;
                            end
                    end
                3'b111:
                    begin
                        r_Out_data = A_data*B_data;
                    end
            endcase
            r_Zero=(r_Out_data==0)?1:0;//判零
        end
endmodule

