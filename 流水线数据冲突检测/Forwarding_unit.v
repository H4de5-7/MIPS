module Forwarding_unit(input [4:0]rs,rt,RW_EX,RW_MEM,input RegWrite_EX,RegWrite_MEM,output reg [1:0]ForwardB,ForwardA);
always@(*)begin
   ForwardA=0;ForwardB=0;
	if(RegWrite_EX&(RW_EX!=0)&(RW_EX==rs))ForwardA=2'b10;
	if(RegWrite_EX&(RW_EX!=0)&(RW_EX==rt))ForwardB=2'b10;
	if(RegWrite_MEM&(RW_MEM!=0)&(RW_MEM==rs)&!(RegWrite_EX&(RW_EX!=0)&(RW_EX==rs)))ForwardA=2'b01;
	if (RegWrite_MEM&(RW_MEM!=0)&(RW_MEM==rt)&!(RegWrite_EX&(RW_EX!=0)&(RW_EX==rt)))ForwardB=2'b01;
end
endmodule
