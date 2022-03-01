module Extender(input [15:0]imm,input [1:0]ExtOp,output [31:0]out);
assign out=ExtOp[1]?{imm,16'h0000}:ExtOp[0]?{{16{imm[15]}},imm}:{16'b0000_0000_0000_0000,imm};       //1:sig extender 0:zero extender
endmodule
