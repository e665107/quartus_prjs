// -*- Mode: Verilog -*-
// Filename        : digital_sys_test_top.v
// Description     :

`include "digital_system_top_header.v"

module digital_system_top(/*AUTOARG*/
                          // Outputs
                          Uart_tx, Scl,
                          // Inputs
                          Uart_rx, Rst_n, Clk
                          ) ;

`ifdef TFT_800_480_RGB
///*AUTOINPUT*/
///*AUTOOUTPUT*/
// tft_ctrl_800_480_topp tft_ctrl_800_480_topp_inst(/*AUTOINST*/);
`endif
`ifdef  EDGE_DETECT_DEF

`endif
`ifdef UART_EEPROM_SYS
/*AUTOINPUT*/
// Beginning of automatic inputs (from unused autoinst inputs)
input                   Clk;                    // To uart_eeprom_topp_ins of uart_eeprom_topp.v
input                   Rst_n;                  // To uart_eeprom_topp_ins of uart_eeprom_topp.v
input                   Uart_rx;                // To uart_eeprom_topp_ins of uart_eeprom_topp.v
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output                  Scl;                    // From uart_eeprom_topp_ins of uart_eeprom_topp.v
output                  Uart_tx;                // From uart_eeprom_topp_ins of uart_eeprom_topp.v
// End of automatics
uart_eeprom_topp uart_eeprom_topp_ins(/*AUTOINST*/
                                      // Outputs
                                      .Uart_tx          (Uart_tx),
                                      .Scl              (Scl),
                                      // Inouts
                                      .Sda              (Sda),
                                      // Inputs
                                      .Clk              (Clk),
                                      .Rst_n            (Rst_n),
                                      .Uart_rx          (Uart_rx));


`endif

endmodule





// Local Variables:
// verilog-library-flags:("-y digital_system_tops ")
// End:




