module Mips(input clk,rstPC,rstRF);
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,zero;
wire RegDst_ID,ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemWrite_ID,nPC_sel_ID,jSig_ID;
wire MemtoReg_EX,RegWrite_EX,MemWrite_EX,nPC_sel_EX,jSig_EX,zero_EX;
wire MemtoReg_MEM,RegWrite_MEM;
wire [1:0]ExtOp;
wire [2:0]ALUctr,ALUctr_ID;
wire [4:0]RW,RW_EX,RW_MEM,rs,rt,rd;
wire [5:0]op,func;
wire [15:0]imm;
wire [31:0]instr,busA,busB,busBsel,ALUout,busW,extender_num,DMout,PC_4,PCnew;
wire [31:0]PC_4_IF,instr_IF;
wire [31:0]instr_ID,busA_ID,busB_ID,PC_4_ID,extender_num_ID;
wire [31:0]ALUout_EX,PCnew_EX,busB_EX;
wire [31:0]DMout_MEM,ALUout_MEM;
ControlUnit control_unit(instr_IF,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,ALUctr,ExtOp,imm,rs,rt,rd,op,func);
IFU ifu(PCnew_EX,PC_4_ID,instr_ID,rstPC,clk,nPC_sel_EX,zero_EX,jSig_ID,instr,PC_4);
RegFile regfile(RW_MEM,rs,rt,busW,clk,rstRF,RegWrite_MEM,busA,busB);
Extender extender(imm,ExtOp,extender_num);
MUX_1 mux_rd_rt(instr_ID[15:11],instr_ID[20:16],RegDst_ID,RW);
MUX_32 mux_busB(extender_num_ID,busB_ID,ALUSrc_ID,busBsel);
IFU_Addu ifu_addu(PC_4_ID,instr_ID,nPC_sel_ID,PCnew);
ALU alu(busA_ID,busBsel,ALUctr_ID,ALUout,zero);
DataMemory datamemory(busB_EX,ALUout_EX,clk,MemWrite_EX,DMout);
MUX_32 mux_data(DMout_MEM,ALUout_MEM,MemtoReg_MEM,busW);

IF_ID_flipflop if_id_flipflop(PC_4,instr,clk,instr_IF,PC_4_IF);

ID_EX_flipflop id_ex_flipflop(PC_4_IF,busA,busB,extender_num,instr_IF,ALUctr,
RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,
clk,PC_4_ID,busA_ID,busB_ID,extender_num_ID,instr_ID,ALUctr_ID,
RegDst_ID,ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemWrite_ID,nPC_sel_ID,jSig_ID);

EX_MEM_flipflop ex_mem_flipflop(PCnew,ALUout,busB_ID,RW,
clk,zero,nPC_sel_ID,MemWrite_ID,MemtoReg_ID,RegWrite_ID,
PCnew_EX,ALUout_EX,busB_EX,RW_EX,
zero_EX,nPC_sel_EX,MemWrite_EX,MemtoReg_EX,RegWrite_EX);

MEM_WB_flipflop mem_wb_flipflop(DMout,ALUout_EX,
clk,MemtoReg_EX,RegWrite_EX,RW_EX,
DMout_MEM,ALUout_MEM,RW_MEM,RegWrite_MEM,MemtoReg_MEM);
endmodule
