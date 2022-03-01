module RegFile(input [4:0]RW,input [4:0]RA,input[4:0] RB,input[31:0] busW,input clk,input reset,
input RegWr,output [31:0]busA,output [31:0]busB);
reg [31:0] RF [31:0];
assign busA=(RegWr&&RW===RA&&RW!=0)?busW:RF[RA];
assign busB=(RegWr&&RW===RB&&RW!=0)?busW:RF[RB];
//assign zero=(busA==busB)?1:0;
//assign busA=RF[RA];
//assign busB=RF[RB];
integer i;
always@(posedge clk,posedge reset)begin
	if(reset)
		for(i=0;i<=31;i=i+1)RF[i]=32'h0000_0000;
	else begin
	   if(RegWr&&RW!=0)RF[RW]=busW;
	end
end
endmodule
