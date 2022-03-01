module Mips(input clk,rstPC,rstRF);
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,zero;
wire RegDst_ID,ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemWrite_ID;
wire MemtoReg_EX,RegWrite_EX,MemWrite_EX;
wire MemtoReg_MEM,RegWrite_MEM;
wire [1:0]ExtOp,ForwardA,ForwardB;
wire [2:0]ALUctr,ALUctr_ID;
wire [4:0]RW,RW_EX,RW_MEM,rs,rt,rd;
wire [5:0]op,func;
wire [15:0]imm;
wire [31:0]instr,busA,busB,busBsel,ALUout,busW,extender_num,DMout,PC_4,PCnew;
wire [31:0]PC_4_IF,instr_IF;
wire [31:0]instr_ID,busA_ID,busB_ID,PC_4_ID,extender_num_ID;
wire [31:0]ALUout_EX,PCnew_EX,busB_EX;
wire [31:0]DMout_MEM,ALUout_MEM;
wire [31:0]busA_forwarding,busB_forwarding,busB_forwarding_data,PC_last;
wire IF_Write,PCWrite,Control_Write;
wire EX_Flush,IF_Flush,lw_beq;
wire [1:0]ForwardA_reg,ForwardB_reg;
wire [31:0]busA_forwarding_reg,busB_forwarding_reg,busB_forwarding_data_reg,busBsel_reg,busW_reg;
ControlUnit control_unit(instr_IF,Control_Write,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,EX_Flush,IF_Flush,ALUctr,ExtOp,imm,rs,rt,rd,op,func);
IFU ifu(PCnew,PC_last,rstPC,clk,lw_beq,nPC_sel,zero,jSig,PCWrite,instr,PC_4);
RegFile regfile(RW_MEM,rs,rt,busW,clk,rstRF,RegWrite_MEM,busA,busB);

Detect_zero detect_zero(busA_forwarding_reg,busB_forwarding_reg,zero);
MUX_forwardingA mux_forwardingA_reg(busA,ALUout,busW_reg,ForwardA_reg,busA_forwarding_reg);
MUX_forwardingB mux_forwardingB_reg(busBsel_reg,ALUout,busW_reg,ForwardB_reg,MemWrite,busB_forwarding_reg,busB_forwarding_data_reg);
Forwarding_unit forwarding_unit_reg(instr_IF[25:21],instr_IF[20:16],RW,RW_EX,RegWrite_ID,RegWrite_EX,ForwardB_reg,ForwardA_reg);
MUX_32 mux_busB_reg(extender_num,busB,ALUSrc,busBsel_reg);
MUX_32 mux_data_reg(DMout,ALUout_EX,MemtoReg_EX,busW_reg);



Forwarding_unit forwarding_unit(instr_ID[25:21],instr_ID[20:16],RW_EX,RW_MEM,RegWrite_EX,RegWrite_MEM,ForwardB,ForwardA);
MUX_forwardingA mux_forwardingA(busA_ID,ALUout_EX,busW,ForwardA,busA_forwarding);
MUX_forwardingB mux_forwardingB(busBsel,ALUout_EX,busW,ForwardB,MemWrite_ID,busB_forwarding,busB_forwarding_data);

Hazard_detection_unit hazard_detection_unit(instr_IF[20:16],instr_IF[25:21],instr_ID[20:16],MemtoReg_ID,nPC_sel,IF_Write,PCWrite,Control_Write,lw_beq);

Extender extender(imm,ExtOp,extender_num);
MUX_1 mux_rd_rt(instr_ID[15:11],instr_ID[20:16],RegDst_ID,RW);
MUX_32 mux_busB(extender_num_ID,busB_ID,ALUSrc_ID,busBsel);
IFU_Addu ifu_addu(PC_4_IF,instr_IF,nPC_sel,jSig,PCnew);
ALU alu(busA_forwarding,busB_forwarding,ALUctr_ID,ALUout);
DataMemory datamemory(busB_EX,ALUout_EX,clk,MemWrite_EX,DMout);
MUX_32 mux_data(DMout_MEM,ALUout_MEM,MemtoReg_MEM,busW);

IF_ID_flipflop if_id_flipflop(PC_4,instr,clk,IF_Write,IF_Flush,instr_IF,PC_4_IF,PC_last);

ID_EX_flipflop id_ex_flipflop(PC_4_IF,busA,busB,extender_num,instr_IF,ALUctr,
RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,
clk,PC_4_ID,busA_ID,busB_ID,extender_num_ID,instr_ID,ALUctr_ID,
RegDst_ID,ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemWrite_ID,nPC_sel_ID,jSig_ID);

EX_MEM_flipflop ex_mem_flipflop(PCnew,ALUout,busB_forwarding_data,RW,
clk,MemWrite_ID,MemtoReg_ID,RegWrite_ID,EX_Flush,
PCnew_EX,ALUout_EX,busB_EX,RW_EX,
MemWrite_EX,MemtoReg_EX,RegWrite_EX);

MEM_WB_flipflop mem_wb_flipflop(DMout,ALUout_EX,
clk,MemtoReg_EX,RegWrite_EX,RW_EX,
DMout_MEM,ALUout_MEM,RW_MEM,RegWrite_MEM,MemtoReg_MEM);
endmodule
