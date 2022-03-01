module DataMemory(input [31:0]data_in,input [31:0]Addr,input clk,input MemWr,output [31:0]data_out);
reg [7:0] DM [1023:0];
assign data_out={DM[Addr+3],DM[Addr+2],DM[Addr+1],DM[Addr]};
always@(posedge clk)begin
	if(MemWr)begin
		DM[Addr[9:0]]=data_in[7:0];
		DM[Addr[9:0]+1]=data_in[15:8];
		DM[Addr[9:0]+2]=data_in[23:16];
		DM[Addr[9:0]+3]=data_in[31:24];
	end
end
endmodule