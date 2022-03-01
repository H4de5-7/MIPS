module ALU(input [31:0]A,input [31:0]B,input[2:0] ALUctr,output reg [31:0]out);
parameter ADDU =3'b000;
parameter SUBU =3'b001;
parameter ORI =3'b010;
parameter LOAD =3'b011;
parameter STORE =3'b100;
parameter BEQ =3'b101;
parameter LUI =3'b110;

always@(*)
begin
case(ALUctr)
	ADDU:out=A+B;
	SUBU:out=A-B;
	ORI:out=A|B;
	LOAD:out=A+B;
	STORE:out=A+B;
	//BEQ: if(A-B==0)zero=1;
	LUI:out=B;
endcase
end

endmodule