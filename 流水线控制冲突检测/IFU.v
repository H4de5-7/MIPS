module IFU(input [31:0]PCnew,PC_last,input reset,input clk,lw_beq,nPC_sel,zero,jSig,PCWrite,output [31:0]instr,PC_4);
reg [31:0]PC;
reg [7:0] IM [1023:0];
reg nPC_sel_store,zero_store;
wire [31:0]PC_new;
assign PC_4=PC+4;
assign instr={IM[PC[9:0]],IM[PC[9:0]+1],IM[PC[9:0]+2],IM[PC[9:0]+3]};

assign PC_new=(((nPC_sel&zero)|jSig)===1)?PCnew:PC+4;

always@(posedge clk,posedge reset)begin
   nPC_sel_store=nPC_sel;
   zero_store=zero;
	if(reset)PC=32'h0000_3000;
	else if(!(PCWrite===0))PC=PC_new;
	if(((nPC_sel_store===1)&(zero_store===0)))PC=PC_new-4;;
	if(lw_beq===0)PC=PC_last;
end
endmodule
