module EX_MEM_flipflop(input [31:0]PCnew,out,busB_ID,
input [4:0]RW,
input clk,MemWrite_ID,MemtoReg_ID,RegWrite_ID,EX_Flush,
output reg[31:0]PCnew_EX,out_EX,busB_EX,
output reg[4:0]RW_EX,
output reg MemWrite_EX,MemtoReg_EX,RegWrite_EX);
always@(posedge clk)begin
   PCnew_EX=PCnew;
	out_EX=out;
	busB_EX=busB_ID;
	
	RW_EX=RW;
	
   if(EX_Flush===0&&MemtoReg_ID===0)begin
	MemWrite_EX=0;
	MemtoReg_EX=0;
	RegWrite_EX=0;
	end
	else begin
	MemWrite_EX=MemWrite_ID;
	MemtoReg_EX=MemtoReg_ID;
	RegWrite_EX=RegWrite_ID;
	end
end
endmodule