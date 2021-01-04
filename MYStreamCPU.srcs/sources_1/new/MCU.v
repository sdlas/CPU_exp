`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:58:25
// Design Name: 
// Module Name: MCU
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


`define R 6'b000000
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define J 6'b000010

module MCU(clk,Opcode_FI,Opcode_ID,Opcode_EX,Opcode_MA,Overflow,RegDst,Jump,RegWr,Branch,MemtoReg,ALUOp,MemWr,MemRd,ALUSrc,IntCause,CPUInt,PCWrite,Pause,PauseCount,ControlPause);
    input clk;//为了解决冒险问题
    input [31:0]Opcode_FI;
    input [31:0]Opcode_ID;
    input [31:0]Opcode_EX;
    input [31:0]Opcode_MA;
    input Overflow;
    output RegDst;//目的寄存器选择
    output Jump;//无条件转移
    output RegWr;//寄存器写
    output Branch;//条件转移
    output MemtoReg;//存储器至寄存器选择
    output [1:0]ALUOp;//ALU操作类型
    output MemWr;//存储器写
    output MemRd;//存储器读
    output ALUSrc;//ALUs数据源选择
    output[31:0] IntCause;
    output CPUInt;
    output PCWrite;
    output Pause;
    output ControlPause;
    output[2:0] PauseCount;
    assign RegDst=(Opcode_MA[31:26]==`R)?1:0;
    assign Jump=(Opcode_EX[31:26]==`J)?1:0;
    assign RegWr=(Opcode_MA[31:26]==`R||Opcode_MA[31:26]==`LW)?1:0;
    assign Branch=(Opcode_EX[31:26]==`BEQ)?1:0;
    assign MemtoReg=(Opcode_MA[31:26]==`LW)?1:0;
    assign MemWr=(Opcode_EX[31:26]==`SW)?1:0;
    assign MemRd=(Opcode_EX[31:26]==`LW)?1:0;
    assign ALUSrc=(Opcode_ID[31:26]==`LW||Opcode_ID[31:26]==`SW)?1:0;
    reg [1:0]r_ALUOp;
    reg [31:0]r_IntCause;
    reg r_CPUInt;
    reg r_PCWrite;
    reg r_FI_IDWrite;
    reg pause;//检测到数据冒险，并已经采取措施
    reg[2:0] pauseCount;//阻塞周期计数
    reg[4:0] FIRs;
    reg[4:0] FIRt;
    reg[4:0] FIRd;
    reg[4:0] tempRs;
    reg[4:0] tempRt;
    reg[4:0] tempRd;
    reg r_ControlPause;
    assign ALUOp = r_ALUOp;
    assign IntCause = r_IntCause;
    assign CPUInt = r_CPUInt;
    assign PCWrite = r_PCWrite;
    assign Pause =pause;
    assign PauseCount = pauseCount;
    assign ControlPause = r_ControlPause;
    initial begin
        r_PCWrite=1;
        r_FI_IDWrite=1;
        r_ControlPause=0;
        pause=0;
    end
    always@(posedge clk)
    begin
        r_PCWrite=1;
        pause=0;
        r_ControlPause=0;
        pauseCount=0;
    end
    always@(*)
    begin
        //判断溢出发中断
        if(Overflow)
            begin
                r_IntCause=8;
                r_CPUInt=1;
            end
        else
            begin
                r_IntCause={32{1'bz}};
                r_CPUInt=0;
            end
        //根据各个段的指令发出控制信号
        case(Opcode_ID[31:26])
            `R:
                begin
                    r_ALUOp<=2'b10;
                end
            `LW:
                begin
                    r_ALUOp<=2'b00;
                end
            `SW:
                begin
                    r_ALUOp<=2'b00;
                end
            `BEQ:
                begin
                    r_ALUOp<=2'b01;
                end
            `J:
                begin
                    r_ALUOp<=2'bzz;
                end
             default:
                begin
                    r_ALUOp<=2'b11;
                end
        endcase
        //数据冒险判断
        case(Opcode_FI[31:26])
            6'b000000://FI是R型指令时
                begin
                    FIRs = Opcode_FI[25:21];
                    FIRt = Opcode_FI[20:16];
                    FIRd = Opcode_FI[15:11];
                    //数据冒险
                    //ID中间没有间隔周期
                    case(Opcode_ID[31:26])
                        6'b000000://R与R
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if((tempRd == FIRs)||(tempRd==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                                    
                            end
                        6'b100011://I与R
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if((tempRt == FIRs)||(tempRt==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if((tempRt == FIRs)||(tempRt==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                    endcase
                    //EX中间间隔一个周期,阻塞两个周期
                    case(Opcode_EX[31:26])
                        6'b000000://R与R
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if((tempRd == FIRs)||(tempRd==FIRt))
                                begin
                                    pause=1;
                                    r_PCWrite=0;
                                end
                            end
                        6'b100011://I与R
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if((tempRt == FIRs)||(tempRt==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if((tempRt == FIRs)||(tempRt==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                    endcase
                    //MA中间间隔两个周期，阻塞一个周期
                    case(Opcode_MA[31:26])
                        6'b000000://R与R
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                tempRd = Opcode_MA[15:11];
                                if((tempRd == FIRs)||(tempRd==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                         6'b100011://I与R
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                tempRd = Opcode_MA[15:11];
                                if((tempRt == FIRs)||(tempRt==FIRt))
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end
                            end
                         6'b101011:
                            begin
                                 tempRs = Opcode_MA[25:21];
                                 tempRt = Opcode_MA[20:16];
                                 tempRd = Opcode_MA[15:11];
                                 if((tempRt == FIRs)||(tempRt==FIRt))
                                     begin
                                         pause=1;
                                         r_PCWrite=0;
                                     end
                             end
                    endcase
                end
            6'b100011://FI是LW指令
                begin
                    FIRs = Opcode_FI[25:21];
                    FIRt = Opcode_FI[20:16];
                    case(Opcode_ID[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;            
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_EX[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_MA[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                tempRd = Opcode_MA[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                end
            6'b101011:
                begin
                    FIRs = Opcode_FI[25:21];
                    FIRt = Opcode_FI[20:16];
                    case(Opcode_ID[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_EX[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_MA[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                tempRd = Opcode_MA[15:11];
                                if(tempRd == FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                end
            6'b000100:
                begin
                    FIRs = Opcode_FI[25:21];
                    FIRt = Opcode_FI[20:16];
                    case(Opcode_ID[31:26])
                        6'b000000://BEQ与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                tempRd = Opcode_ID[15:11];
                                if(tempRd == FIRs||tempRd == FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://BEQ型与I型
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs||tempRt==FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_ID[25:21];
                                tempRt = Opcode_ID[20:16];
                                if(tempRt==FIRs||tempRt==FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_EX[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                tempRd = Opcode_EX[15:11];
                                if(tempRd == FIRs||tempRd == FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs||tempRt == FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_EX[25:21];
                                tempRt = Opcode_EX[20:16];
                                if(tempRt==FIRs || tempRt==FIRs)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                    case(Opcode_MA[31:26])
                        6'b000000://R与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                tempRd = Opcode_MA[15:11];
                                if(tempRd == FIRs||tempRd == FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b100011://I型与I型
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs || tempRt == FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                        6'b101011:
                            begin
                                tempRs = Opcode_MA[25:21];
                                tempRt = Opcode_MA[20:16];
                                if(tempRt==FIRs || tempRt==FIRt)
                                    begin
                                        pause=1;
                                        r_PCWrite=0;
                                    end  
                            end
                    endcase
                end
        endcase
        //控制冒险判断
        if(!pause)
            begin
                case(Opcode_FI[31:26])
                    6'b000100:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end
                    6'b000010:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end
                endcase
                case(Opcode_ID[31:26])
                    6'b000100:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end
                    6'b000010:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end 
                endcase
                case(Opcode_EX[31:26])
                    6'b000100:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end
                    6'b000010:
                        begin
                            r_ControlPause=1;
                            r_PCWrite=0;
                        end
                endcase
            end
    end
endmodule
