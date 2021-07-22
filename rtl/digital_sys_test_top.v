//                              -*- Mode: Verilog -*-
// Filename        : digital_sys_test_top.v
// Description     :


// `define CLK_DIVIDER_DEF
`define EDGE_DETECT_DEF

module digital_sys_test(/*AUTOARG*/
                        // Outputs
                        out,
                        // Inputs
                        clk, in
                        ) ;

`ifdef CLK_DIVIDER_DEF
    input  clk;
    clk_divider #(
                  .WIDTH(32)
                  ) CD1 (
                         .nrst( 1'b1 ),
                         .ena( 1'b1 ),
                         .out(),
                         /*AUTOINST*/
                         // Inputs
                         .clk                   (clk));
    
`endif
`ifdef  EDGE_DETECT_DEF
    input  clk;
    input [31:0] in;
    output [31:0] out;
    edge_detect #(
                  .REGISTER_OUTPUTS( 1'b1 )
                  ) ED1[31:0] (
                               .clk( {32{clk}} ),
                               .nrst( {32{1'b1}} ),
                               .in( in[31:0] ),
                               .rising( out[31:0] ),
                               .falling(  ),
                               .both(  )
                               );

`endif




    
endmodule

