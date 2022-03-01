module Hazard_detection_unit(input [4:0]rt_IF,rs_IF,rt_ID,input MemtoReg_ID,output reg IF_Write,PCWrite,Control_Write);

always@(*)begin
	if(MemtoReg_ID&((rt_IF===rt_ID)|(rs_IF===rt_ID)))begin
		IF_Write=0;
		PCWrite=0;
		Control_Write=0;
		end
	else
		begin
		IF_Write=1;
		PCWrite=1;
		Control_Write=1;
		end
end
endmodule