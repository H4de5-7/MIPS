module ControlUnit(input [31:0]instr,input Control_Write,output reg RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,nPC_sel,jSig,output reg[2:0]ALUctr,output [1:0]ExtOp,output [15:0]imm,output [4:0]rs,rt,rd,output [5:0]op,func);
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

always@(*)begin
	if(Control_Write===0)begin
	RegDst=0; 
	ALUSrc=0;
	MemtoReg=0;
	RegWrite=0;
	MemWrite=0;
	nPC_sel=0;
	jSig=0;
	ALUctr[0]=0;
	ALUctr[1]=0;
	ALUctr[2]=0;
	end
	
	else begin
	RegDst=add|sub; 
	ALUSrc=ori|lw|sw|lui;
	MemtoReg=lw;
	RegWrite=add|sub|ori|lw|lui;
	MemWrite=sw;
	nPC_sel=beq;
	jSig=j;
	ALUctr[0]=sub|lw|beq;
	ALUctr[1]=ori|lw|lui;
	ALUctr[2]=sw|beq|lui;
	end
end
	

assign ExtOp[0]=lw|sw;
assign ExtOp[1]=lui;

endmodule

	
	