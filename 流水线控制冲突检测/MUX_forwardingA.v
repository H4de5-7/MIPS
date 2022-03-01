module MUX_forwardingA(input [31:0]bus,num_EX,num_MEM,input [1:0]Forward,output [31:0]bus_out);
assign bus_out=(Forward==2'b10)?num_EX:(Forward==2'b01)?num_MEM:bus;       //10:num_EX 01:num_MEM 00,11:bus
endmodule