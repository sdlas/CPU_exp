`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 13:57:46
// Design Name: 
// Module Name: main
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


module main();
reg clk=0;
//线
//PC
wire[31:0]PCout;

//IM
wire[31:0]Inst;
wire Pause;
wire ControlPause;

//FI_ID
wire[31:0] FI_ID_IR;
wire[31:0] FI_ID_NPC1;
//FI_ID_D
wire[4:0] FI_ID_reg1;
wire[4:0] FI_ID_reg2;
wire[15:0] FI_ID_Imm;
//ID_EX
wire[31:0] ID_EX_IR;
wire[31:0] ID_EX_NPC1;
wire[31:0] ID_EX_Rs;
wire[31:0] ALUBin;
wire[31:0] ID_EX_Rt;
//ALU
wire Zero;
wire Overflow;
wire[31:0] ALUOut;
wire[2:0] ALUCtrl;
wire[31:0] ID_EX_Imm32;
//ID_EX_D
wire[25:0]ID_EX_Imm26;
wire[5:0]ID_EX_Func;
//EX_MA
wire[31:0] EX_MA_IR;
wire[31:0]EX_MA_NPC3;
wire[31:0]EX_MA_NPC2;
wire EX_MA_Flag;
wire[31:0] EX_MA_ALUOut;
wire[31:0] EX_MA_Rt;


//MA_WB
wire[31:0] MA_WB_IR;
wire[31:0] MA_WB_ALUOut;
wire[31:0] MA_WB_MEMOut;
//MA_WB_D
wire[4:0] MA_WB_Rt;
wire[4:0] MA_WB_Rd;
//forMCU
wire[31:0] Opcode_FI;
wire[31:0] Opcode_ID;
wire[31:0] Opcode_EX;
wire[31:0] Opcode_MA;
//ADD1
wire[31:0] PCADD4;
//SigExt
wire[31:0] SigExtout;
//SHL2_2
wire [31:0] J_Addr;
//SHL2_1
wire[31:0] BEQ_Addr_Part;
//Add2
wire[31:0] BEQ_Addr;
//RegFile
wire [4:0] W_reg;
wire [31:0] R_data1;
wire [31:0] R_data2;
wire[31:0] W_data;

//MCU
wire RegDst;
wire Jump;
wire RegWr;
wire Branch;
wire MemtoReg;
wire MemWr;
wire MemRd;
wire ALUSrc;
wire CPUInt; 
wire PCWrite;

wire[1:0] ALUOp;
wire[2:0] PauseCount;
wire[31:0] IntCause;

//PC J BEQ
wire[31:0] PCin;
wire Andout;
wire[31:0] JumpOrBEQ;
wire PCSrc;

//DM
wire[31:0] R_data;

//Cause
wire[31:0] Cause;
//元件
//第一段
PC myPC(.clk(clk),.PCWrite(PCWrite),.PCSrc(PCSrc),.W_data(PCin),.R_data(PCout));
IM myIM(.clk(clk),.Addr(PCout),.R_data(Inst));
Add1 myAdd1(.B_data(PCout),.O_data(PCADD4));
FI_ID myFI_ID(.clk(clk),.FI_IDWrite(Pause),.ControlPause(ControlPause),.PC(PCADD4),.In(Inst),.NPC1(FI_ID_NPC1),.Inst(FI_ID_IR));
FI_ID_D myFI_ID_D(.Inst(FI_ID_IR),.R_reg1(FI_ID_reg1),.R_reg2(FI_ID_reg2),.Imm(FI_ID_Imm),.Opcode(Opcode_FI));

//第二段
RegFile myRegFile(.clk(clk),.W_data(W_data),.R_reg1(FI_ID_reg1),.R_reg2(FI_ID_reg2),.W_reg(W_reg),.W(RegWr),.R_data1(R_data1),.R_data2(R_data2));
SigExt16_32 mySigExt(.I_data(FI_ID_Imm),.O_data(SigExtout));
ID_EX myID_EX(.clk(clk),.Pause(Pause),.I_NPC1(FI_ID_NPC1),.I_Rs(R_data1),.I_Rt(R_data2),.I_Imm32(SigExtout),.I_IR(FI_ID_IR),.NPC1(ID_EX_NPC1),.Rs(ID_EX_Rs),.Rt(ID_EX_Rt),.Imm32(ID_EX_Imm32),.IR(ID_EX_IR));
ID_EX_D myID_EX_D(.Inst(ID_EX_IR),.Imm(ID_EX_Imm26),.Func(ID_EX_Func),.Opcode(Opcode_ID));

//第三段
SHL2_1 mySHL2_1(.I_data(ID_EX_Imm32),.O_data(BEQ_Addr_Part));
Add2 myAdd2(.A_data(ID_EX_NPC1),.B_data(BEQ_Addr_Part),.O_data(BEQ_Addr));
SHL2_2 mySHL2_2(.Inst(ID_EX_Imm26),.PC(ID_EX_NPC1),.O_data(J_Addr));
MUX ID_EX_Rt_Imm32(.First_data(ID_EX_Rt),.Second_data(ID_EX_Imm32),.control(ALUSrc),.O_data(ALUBin));
ALUCU myALUCU(.Func(ID_EX_Func),.ALUOp(ALUOp),.ALUCtrl(ALUCtrl));
ALU myALU(.A_data(ID_EX_Rs),.B_data(ALUBin),.ALUCtrl(ALUCtrl),.Out_data(ALUOut),.Zero(Zero),.Overflow(Overflow));
EX_MA myEX_MA(.clk(clk),.I_NPC1(J_Addr),.I_NPC2(BEQ_Addr),.I_Z(Zero),.I_ALUOut(ALUOut),.I_Rt(ID_EX_Rt),.I_IR(ID_EX_IR),.NPC3(EX_MA_NPC3),.NPC2(EX_MA_NPC2),.Flag(EX_MA_Flag),.ALUOut(EX_MA_ALUOut),.Rt(EX_MA_Rt),.IR(EX_MA_IR),.Opcode(Opcode_EX));
Cause myCause(.clk(clk),.IntCause(IntCause),.CPUInt(CPUInt),.Cause(Cause));
//第四段
And myAnd(.IN1(Branch),.IN2(EX_MA_Flag),.OUT(Andout));
MUX4 myMUX(.DATA_1(),.DATA_2(EX_MA_NPC3),.DATA_3(EX_MA_NPC2),.DATA_4(),.control1(Andout),.control2(Jump),.O_DATA(JumpOrBEQ));
Or myOr(.DATA_1(Andout),.DATA_2(Jump),.O_DATA(PCSrc));
DM myDM(.clk(clk),.Addr(EX_MA_ALUOut),.MemWr(MemWr),.MemRd(MemRd),.W_data(EX_MA_Rt),.R_data(R_data));
MA_WB myMA_WB(.clk(clk),.I_ALUOut(EX_MA_ALUOut),.I_MEMOut(R_data),.I_IR(EX_MA_IR),.ALUOut(MA_WB_ALUOut),.MEMOut(MA_WB_MEMOut),.IR(MA_WB_IR));
MA_WB_D myMA_WB_D(.I_IR(MA_WB_IR),.Rt(MA_WB_Rt),.Rd(MA_WB_Rd),.Opcode(Opcode_MA));
//第五段
MUX mux5(.First_data(MA_WB_ALUOut),.Second_data(MA_WB_MEMOut),.control(MemtoReg),.O_data(W_data));
MUX mux1(.First_data(MA_WB_Rt),.Second_data(MA_WB_Rd),.control(RegDst),.O_data(W_reg));
MUX mux3(.First_data(PCADD4),.Second_data(JumpOrBEQ),.control(PCSrc),.O_data(PCin));

//MCU
MCU myMCU(.clk(clk),.Opcode_FI(Opcode_FI),.Opcode_ID(Opcode_ID),.Opcode_EX(Opcode_EX),.Opcode_MA(Opcode_MA),.Overflow(Overflow),.RegDst(RegDst),.Jump(Jump),.RegWr(RegWr),.Branch(Branch),.MemtoReg(MemtoReg),.ALUOp(ALUOp),.MemWr(MemWr),.MemRd(MemRd),.ALUSrc(ALUSrc),.IntCause(IntCause),.CPUInt(CPUInt),.PCWrite(PCWrite),.Pause(Pause),.PauseCount(PauseCount),.ControlPause(ControlPause));
always@(*)
begin
    #10
    clk <= ~clk;
end
endmodule
