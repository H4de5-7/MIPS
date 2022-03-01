module IF_ID_flipflop(input [31:0]PC_4,input [31:0]instr,input clk,IF_Write,IF_Flush,output reg[31:0]instr_IF,PC_4_IF,PC_last);
always@(posedge clk)begin
   PC_last=PC_4-4;
   if(IF_Flush===0)begin
      instr_IF=0;
		PC_4_IF=0;
   end
	else if(!(IF_Write===0))begin
		instr_IF=instr;
		PC_4_IF=PC_4;
	end
end
endmodule