module MUX_forwardingB(input [31:0]bus,num_EX,num_MEM,input [1:0]Forward,
input MemWrite,output reg[31:0]bus_out,bus_out_data);
always@(*)begin
   if(Forward==2'b10&!MemWrite)begin bus_out=num_EX;bus_out_data=num_EX;end
   else if(Forward==2'b01&!MemWrite)begin bus_out=num_MEM;bus_out_data=num_MEM;end
   else if(Forward==2'b10&MemWrite)begin bus_out=bus;bus_out_data=num_EX;end
   else if(Forward==2'b01&MemWrite)begin bus_out=bus;bus_out_data=num_MEM;end
   else begin bus_out=bus;bus_out_data=bus;end
end
       //10:num_EX 01:num_MEM 00,11:bus
endmodule