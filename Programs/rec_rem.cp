#line 1 "F:/ArabTech/projects/home automotion/Smart home/Programs/rec_rem.c"
char rec;
int i=1;
int x=0;
int j=0;


sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;


sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;
interrupt()
{

 rec = UART1_Read();
 x=1;
 }

void main() {
Lcd_Init();
INTCON=0b11000000;
PIE1=0b00100000;
UART1_Init(2400);
Delay_ms(300);
trisc=0b10000000;
trisd=0;
portd=0;
 for(;;){

 if(x==1)
{
 Lcd_Chr_Cp(rec);
 x=0;
 if(rec=='a')
 {
 rd0_bit=1;
 rd2_bit=1;
 }
 if(rec=='5')
 {
 rd0_bit=0;
 rd2_bit=0;
 }
 }}}
