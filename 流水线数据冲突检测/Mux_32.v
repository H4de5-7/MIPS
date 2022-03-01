module MUX_32(input [31:0]A,input [31:0]B,input sel,output [31:0]out);
assign out=sel?A:B;
endmodule