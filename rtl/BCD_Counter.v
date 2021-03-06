/***************************************************
*       Module Name             :       BCD_Counter                
*       Engineer                   :    小梅哥
*       Target Device   :       EP4CE10F17C8
*       Tool versions   :       Quartus II 13.0
*       Create Date             :       2017-3-31
*       Revision                   :    v1.0
*       Description             :   BCD计数器设计
**************************************************/

module BCD_Counter(
           Clk,
           Cin,
           Rst_n, Cout, q );
input Clk; //计数基准时钟
input Cin;      //计数器进位输入
input Rst_n;    //系统复位

output Cout;  //计数进位输出
//reg Cout;
output [ 3: 0 ] q;  //计数值输出
reg [ 3: 0 ] cnt;   //定义计数器寄存器
reg [ 3: 0 ] cnt0;   //定义计数器寄存器
reg [ 3: 0 ] cnt1;   //定义计数器寄存器
reg [ 3: 0 ] cnt2;   //定义计数器寄存器
reg [ 3: 0 ] cnt3;   //定义计数器寄存器

//执行计数过程
always@( posedge Clk or negedge Rst_n )
    if ( Rst_n == 1'b0 ) begin
        cnt <= 4'd0;
    end
    else if ( Cin == 1'b1 ) begin
        if ( cnt == 4'd9 ) begin
            cnt <= 4'd0;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end
    else begin
        cnt <= cnt;
    end

//产生进位输出信号
assign Cout = ( Cin == 1'b1 && cnt == 4'd9 );
/*      always@(posedge Clk or negedge Rst_n)
 if (!Rst_n)
 Cout <= 1'b0;
 else if(Cin == 1'b1 && cnt ==4'd9)
 Cout <= 1'b1;
 else
 Cout <= 1'b0;   
 */
assign q = cnt;

endmodule









