module IF_ID_flipflop(input [31:0]PC_4,input [31:0]instr,input clk,IF_Write,output reg[31:0]instr_IF,PC_4_IF,PC_last);
always@(posedge clk)begin
   PC_last=PC_4;
	if(!(IF_Write===0))begin
		instr_IF=instr;
		PC_4_IF=PC_4;
		PC_last=PC_4-4;
	end
end
endmodule