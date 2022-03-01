module ControlUnit(input [31:0]instr,output RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,output [2:0]ALUctr,output [1:0]ExtOp,output [15:0]imm,output [4:0]rs,rt,rd,output [5:0]op,func);
assign op=instr[31:26];
assign rs=instr[25:21];
assign rt=instr[20:16];
assign rd=instr[15:11];
assign func=instr[5:0];
assign imm=instr[15:0];

assign beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
assign sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
assign lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
assign ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
assign lui=~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0];
assign j=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];
assign Rtype=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
assign add=Rtype&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0];
assign sub=Rtype&func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];

assign RegDst=add|sub; 
assign ALUSrc=ori|lw|sw|lui;
assign MemtoReg=lw;
assign RegWrite=add|sub|ori|lw|lui;
assign MemWrite=sw;
assign nPC_sel=beq;
assign jSig=j;
assign ExtOp[0]=lw|sw;
assign ExtOp[1]=lui;

assign ALUctr[0]=sub|lw|beq;
assign ALUctr[1]=ori|lw|lui;
assign ALUctr[2]=sw|beq|lui;
endmodule

	
	