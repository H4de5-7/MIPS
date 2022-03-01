module IF_ID_flipflop(input [31:0]PC_4,input [31:0]instr,input clk,output reg[31:0]instr_IF,PC_4_IF);
always@(posedge clk)begin
	instr_IF=instr;
	PC_4_IF=PC_4;
end
endmodule