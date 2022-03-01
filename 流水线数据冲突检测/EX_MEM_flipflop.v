module EX_MEM_flipflop(input [31:0]PCnew,out,busB_ID,
input [4:0]RW,
input clk,zero,nPC_sel_ID,MemWrite_ID,MemtoReg_ID,RegWrite_ID,
output reg[31:0]PCnew_EX,out_EX,busB_EX,
output reg[4:0]RW_EX,
output reg zero_EX,nPC_sel_EX,MemWrite_EX,MemtoReg_EX,RegWrite_EX);
always@(posedge clk)begin
	PCnew_EX=PCnew;
	out_EX=out;
	busB_EX=busB_ID;
	
	RW_EX=RW;
	
	zero_EX=zero;
	nPC_sel_EX=nPC_sel_ID;
	MemWrite_EX=MemWrite_ID;
	MemtoReg_EX=MemtoReg_ID;
	RegWrite_EX=RegWrite_ID;
end
endmodule