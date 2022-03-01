module IFU(input [31:0]PCnew_EX,PC_4_ID,instr_ID,input reset,input clk,nPC_sel_EX,zero_EX,jSig_ID,output [31:0]instr,PC_4);
reg [31:0]PC;
reg [7:0] IM [1023:0];
wire [31:0]PC_new;
assign PC_4=PC+4;
assign instr={IM[PC[9:0]],IM[PC[9:0]+1],IM[PC[9:0]+2],IM[PC[9:0]+3]};

assign PC_new=((nPC_sel_EX&zero_EX)===1)?PCnew_EX:(jSig_ID===1)?{PC_4_ID[31:28],instr_ID[25:0],2'b00}:PC+4;

always@(posedge clk,posedge reset)begin
	if(reset)PC=32'h0000_3000;
	else PC=PC_new;
end
endmodule
