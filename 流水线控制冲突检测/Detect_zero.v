module Detect_zero(input [31:0]busA,busB,output zero);
assign zero=(busA==busB)?1:0;
endmodule
