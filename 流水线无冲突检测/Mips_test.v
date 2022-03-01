module Mips_test;
    reg clk,rstPC,rstRF;
    Mips mips(clk,rstPC,rstRF);
    initial #10000 $stop;
    initial
    begin
        clk=0;rstPC=0;rstRF=0;
        #5 rstPC=1;
        #5 rstPC=0;
        #5 rstRF=1;
        #5 rstRF=0;
        #5 $readmemh("code.txt",mips.ifu.IM);
    end
    
    always
       #60 clk=~clk;
endmodule