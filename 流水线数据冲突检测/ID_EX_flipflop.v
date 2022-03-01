module ID_EX_flipflop(input [31:0]PC_4_IF,
input [31:0]busA,busB,extender_num,instr_IF,
input [2:0]ALUctr,
input RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,
input clk,
output reg[31:0]PC_4_ID,busA_ID,busB_ID,extender_num_ID,instr_ID,
output reg[2:0]ALUctr_ID,
output reg RegDst_ID,ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemWrite_ID,nPC_sel_ID,jSig_ID);
always@(posedge clk)begin
	PC_4_ID=PC_4_IF;
	busA_ID=busA;
	busB_ID=busB;
	extender_num_ID=extender_num;
	instr_ID=instr_IF;
	ALUctr_ID=ALUctr;
	RegDst_ID=RegDst;
	ALUSrc_ID=ALUSrc;
	MemtoReg_ID=MemtoReg;
	RegWrite_ID=RegWrite;
	MemWrite_ID=MemWrite;
	nPC_sel_ID=nPC_sel;
	jSig_ID=jSig;
end
endmodule