// pins TFT_CTRL.csv
// rgb-lcd 800_480
module tft_ctrl_800_480_topp(
                             Clk,      //50MHZ
                             Rst_n,
                             TFT_RGB,  //TFT
                             TFT_HS,   //TFT
                             TFT_VS,   //TFT
                             TFT_CLK,
                             TFT_DE,
                             TFT_BLANK
                             );

input Clk;
input Rst_n;
output [ 15: 0 ] TFT_RGB;
output           TFT_HS;
output           TFT_VS;
output           TFT_CLK;
output           TFT_DE;
output           TFT_BLANK;
wire [ 11: 0 ]   hcount;
wire [ 11: 0 ]   vcount;
wire             Clk33M;

reg [ 15: 0 ]    disp_data;
reg [7:0]        color_mode=8'b0100_0000;

assign TFT_BLANK = 1;

pll_tft TFT_test_pll(
                     .inclk0( Clk ),
                     .c0( Clk33M )
                     );

TFT_CTRL_800_480_16bit TFT_CTRL_800_480_16bit(
                                              .Clk33M( Clk33M ),  //
                                              .Rst_n( Rst_n ),  //
                                              .data_in( disp_data ),     //
                                              .hcount(),                 //TFT
                                              .vcount(),                 //TFT
                                              .TFT_RGB( TFT_RGB ),      //TFT
                                              .TFT_HS( TFT_HS ),           //TFT
                                              .TFT_VS( TFT_VS ),           //TFT
                                              .TFT_BLANK(),
                                              .TFT_VCLK( TFT_CLK ),
                                              .TFT_DE( TFT_DE )
                                              );

// wire             R0_act = vcount >= 0 && vcount < 68;       //
  // wire             R1_act = vcount >= 68 && vcount < 136; //
  // wire             R2_act = vcount >= 136 && vcount < 204; //
  // wire             R3_act = vcount >= 204 && vcount < 272; //
  // wire             C0_act = hcount >= 0 && hcount < 240; //
  // wire             C1_act = hcount >= 240 && hcount < 480; //

// wire             R0_C0_act = R0_act & C0_act;       //
  // wire             R0_C1_act = R0_act & C1_act;       //
  // wire             R1_C0_act = R1_act & C0_act;       //
  // wire             R1_C1_act = R1_act & C1_act;       //
  // wire             R2_C0_act = R2_act & C0_act;       //
  // wire             R2_C1_act = R2_act & C1_act;       //
  // wire             R3_C0_act = R3_act & C0_act;       //
  // wire             R3_C1_act = R3_act & C1_act;       //

//
localparam
  BLACK = 16'h0000,   //
  BLUE = 16'h001F,   //
  RED = 16'hF800,   //
  PURPPLE = 16'hF81F,   //
  GREEN = 16'h07E0,   //
  CYAN = 16'h07FF,   //
  YELLOW = 16'hFFE0,   //
  WHITE = 16'hFFFF; //

//
localparam
  R0_C0 = BLACK,    
  R0_C1 = BLUE,     
  R1_C0 = RED,      
  R1_C1 = PURPPLE,  
  R2_C0 = GREEN,    
  R2_C1 = CYAN,     
  R3_C0 = YELLOW,   
  R3_C1 = WHITE;  


always@( * )
  // case ( { R3_C1_act, R3_C0_act, R2_C1_act, R2_C0_act,
  //          R1_C1_act, R1_C0_act, R0_C1_act, R0_C0_act } )
  case (color_mode) 
    8'b0000_0001:
      disp_data = R0_C0;
    8'b0000_0010:
      disp_data = R0_C1;
    8'b0000_0100:
      disp_data = R1_C0;
    8'b0000_1000:
      disp_data = R1_C1;
    8'b0001_0000:
      disp_data = R2_C0;
    8'b0010_0000:
      disp_data = R2_C1;
    8'b0100_0000:
      disp_data = R3_C0;
    8'b1000_0000:
      disp_data = R3_C1;
    default:
      disp_data = R0_C0;
  endcase

endmodule







