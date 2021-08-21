/***************************************************
 *      Module Name             :       uart_eeprom                
 *      Engineer                   :    С÷��
 *      Target Device   :       EP4CE10F17C8
 *      Tool versions   :       Quartus II 13.0
 *      Create Date             :       2017-3-31
 *      Revision                   :    v1.0
 *      Description             :  ���ڶ�дEEPROM�����ļ�
 **************************************************/
module uart_eeprom_topp(
                        Clk,
                        Rst_n,

                        Uart_rx,
                        Uart_tx,

                        Sda,
                        Scl
                   );

parameter Baud_set = 3'd4;//����������,��������Ϊ115200

input       Clk;          //ϵͳʱ��
input       Rst_n;        //ϵͳ��λ

input       Uart_rx;      //���ڽ���
output      Uart_tx;      //���ڷ���

inout       Sda;          //I2Cʱ����
output      Scl;          //I2C������

wire [7:0]  Rx_data;      //���ڽ���һ�ֽ�����
wire        Rx_done;         //���ڽ���һ�ֽ��������

wire        wfifo_req;    //дFIFOģ��д����
wire [7:0]  wfifo_data;   //дFIFOģ��д����
wire [5:0]  wfifo_usedw;  //дFIFOģ����д������

wire [5:0]  rfifo_usedw;  //��FIFOģ��ɶ�������
wire        rfifo_rdreq;  //��FIFOģ�������

wire [5:0]  Rddata_num;   //I2C����������ȡ�����ֽ���
wire [5:0]  Wrdata_num;   //I2C����������ȡ�����ֽ���
wire [1:0]  Wdaddr_num;   //EEPROM���ݵ�ַ�ֽ���
wire [2:0]  Device_addr;  //EEPROM��ַ
wire [15:0] Word_addr;    //EEPROM�Ĵ�����ַ
wire        Wr;           //EEPROMдʹ��
wire [7:0]  Wr_data;      //EEPROMд����
wire        Wr_data_vaild;//EEPROMд������Ч��־λ
wire        Rd;           //EEPROM��ʹ��
wire [7:0]  Rd_data;      //EEPROM������
wire        Rd_data_vaild;//EEPROM��������Ч��־λ
wire        Done;         //EEPRO��д��ɱ�ʶλ

wire        tx_en;        //���ڷ���ʹ��
wire [7:0]  tx_data;      //���ڴ���������
wire        tx_done ;     //һ�δ��ڷ�����ɱ�־λ

//���ڽ���ģ������
uart_byte_rx uart_rx(
                     .Clk(Clk),
                     .Rst_n(Rst_n),
                     .Rs232_rx(Uart_rx),
                     .baud_set(Baud_set),

                     .Data_Byte(Rx_data),
                     .Rx_Done(Rx_done)
                     );

//ָ�����ģ������
cmd_analysis cmd_analysis(
                          .Clk(Clk),
                          .Rst_n(Rst_n),

                          .Rx_done(Rx_done),
                          .Rx_data(Rx_data),

                          .Wfifo_req(wfifo_req),
                          .Wfifo_data(wfifo_data),

                          .Rddata_num(Rddata_num),
                          .Wrdata_num(Wrdata_num),
                          .Wdaddr_num(Wdaddr_num),
                          .Device_addr(Device_addr),
                          .Word_addr(Word_addr),
                          .Rd(Rd)
                          );

//д����fifoģ������
fifo_wr fifo_wr(
                .clock(Clk),
                .data(wfifo_data),
                .rdreq(Wr_data_vaild),
                .wrreq(wfifo_req),
                .empty(),
                .full(),
                .q(Wr_data),
                .usedw(wfifo_usedw)
                );

//EEPROMдʹ��
assign Wr = (wfifo_usedw == Wrdata_num)&&
            (wfifo_usedw != 6'd0);

//I2C����ģ������
I2C I2C(
        .Clk(Clk),
        .Rst_n(Rst_n),

        .Rddata_num(Rddata_num),
        .Wrdata_num(Wrdata_num),
        .Wdaddr_num(Wdaddr_num),

        .Device_addr(Device_addr),
        .Word_addr(Word_addr),

        .Wr(Wr),
        .Wr_data(Wr_data),
        .Wr_data_vaild(Wr_data_vaild),
        .Rd(Rd),
        .Rd_data(Rd_data),
        .Rd_data_vaild(Rd_data_vaild),

        .Scl(Scl),
        .Sda(Sda),
        .Done(Done)
        );

//������fifoģ������
fifo_rd fifo_rd(
                .clock(Clk),
                .data(Rd_data),
                .rdreq(rfifo_rdreq),
                .wrreq(Rd_data_vaild),
                .empty(),
                .full(),
                .q(tx_data),
                .usedw(rfifo_usedw)
                );

//���ڷ���ʹ��
assign tx_en = ((rfifo_usedw == Rddata_num)&&Done)||
               ((rfifo_usedw < Rddata_num)&&
                (rfifo_usedw >0)&&tx_done);
//��FIFOģ�������                                      
assign rfifo_rdreq = tx_en;

//���ڷ���ģ������
uart_byte_tx uart_tx(
                     .Clk(Clk), 
                     .Rst_n(Rst_n), 
                     .send_en(tx_en),
                     .baud_set(Baud_set),
                     .Data_Byte(tx_data),

                     .Rs232_Tx(Uart_tx),
                     .Tx_Done(tx_done),
                     .uart_state()
                     ); 

endmodule 




