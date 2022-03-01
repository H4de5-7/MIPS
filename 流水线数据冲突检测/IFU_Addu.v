module IFU_Addu(input [31:0]PC_4_ID,instr_ID,input nPC_sel_ID,output [31:0]PCnew);
wire [15:0]imm;
assign imm=instr_ID[15:0];
assign PCnew=nPC_sel_ID?PC_4_ID+{{16{imm[15]}},imm,2'b00}:PC_4_ID;
endmodule
