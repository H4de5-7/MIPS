module IFU_Addu(input [31:0]PC_4_IF,instr_IF,input nPC_sel,jSig,output [31:0]PCnew);
wire [15:0]imm;
assign imm=instr_IF[15:0];
assign PCnew=nPC_sel?PC_4_IF+{{16{imm[15]}},imm,2'b00}:jSig?{PC_4_IF[31:28],instr_IF[25:0],2'b00}:PC_4_IF;
endmodule
