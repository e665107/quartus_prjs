//--------------------------------------------------------------------------------
// encoder.v
// Konstantin Pavlov, pavlovconst@gmail.com
//--------------------------------------------------------------------------------

// INFO --------------------------------------------------------------------------------
//  Digital encoder


/*encoder E1(
 .clk(),
 .nrst(),
 .incA(),
 .incB(),
 .plus1(),
 .minus1()
 );*/


module encoder(
           clk, nrst, incA, incB, plus1, minus1 /*AUTOARG*/ );

input wire clk;
input wire nrst;
input wire incA, incB;          // present input values
output reg plus1 = 0, minus1 = 0;

reg bufA = 0, bufB = 0;         // previous inputvalues

always@( posedge clk ) begin
    if ( ~nrst ) begin
        bufA <= 0;
        bufB <= 0;
        plus1 <= 0;
        minus1 <= 0;
    end
    else begin
        plus1 <= ( bufA ^ incB ) & ~( incA ^ bufB );
        minus1 <= ( incA ^ bufB ) & ~( bufA ^ incB );
        bufA <= incA;
        bufB <= incB;
    end             // if
end

always @ ( posedge CLK or negedge RSTN ) begin
    if ( !RSTN ) begin
        /*AUTORESET*/
    end
    else begin

    end
end
endmodule

