module Hazard_detection_unit(input [4:0]rt_IF,rs_IF,rt_ID,input MemtoReg_ID,nPC_sel,output reg IF_Write,PCWrite,Control_Write,lw_beq);
reg nPC_sel_reg;
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
	if(MemtoReg_ID&((rt_IF===rt_ID)|(rs_IF===rt_ID))&(nPC_sel===1))lw_beq=0;
   else lw_beq=1;
	if(lw_beq===0&&nPC_sel_reg===1)begin
	    IF_Write=0;
		PCWrite=0;
		Control_Write=0;
	end
	if(nPC_sel_reg===0)nPC_sel_reg=nPC_sel;
	else nPC_sel_reg=0;

end
endmodule