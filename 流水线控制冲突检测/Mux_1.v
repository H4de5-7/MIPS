module MUX_1(input [4:0]A,input [4:0]B,input sel,output [4:0]out);
assign out=sel?A:B;
endmodule