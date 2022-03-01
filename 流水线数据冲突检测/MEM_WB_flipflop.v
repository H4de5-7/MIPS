module MEM_WB_flipflop(input [31:0]data_out,out_EX,
input clk,MemtoReg_EX,RegWrite_EX,
input [4:0]RW_EX,
output reg[31:0]data_out_MEM,out_MEM,
output reg[4:0]RW_MEM,
output reg RegWrite_MEM,MemtoReg_MEM);
always@(posedge clk)begin
	data_out_MEM=data_out;
	out_MEM=out_EX;
	
	RW_MEM=RW_EX;
	
	MemtoReg_MEM=MemtoReg_EX;
	RegWrite_MEM=RegWrite_EX;
end
endmodule