#line 1 "F:/Smart home/ÈÑäÇãÌ ßÇãá/hanem.c"
 char rec;
char keypadPort at PORTD;
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
 if(rec=='a')
 portc.f2=1;
 if(rec=='b')
 portc.f2=0;
 if(rec=='c')
 portc.f4=1;
 if(rec=='d')
 portc.f4=0;
 }

 main()
 {
 int s[2],z[2];
 int valid [3];
int invalid [7];
 char kp =0;
 int i;
 int go=0;
 int x,y,temp,light,g,m,n,l;
 l=0;
 m=0;
 n=0;
 adcon1=2;
 trise=0;
 porte=0;

valid[0]=1;
valid[1]=2;
valid[2]=3;
 INTCON=0b11000000;
 PIE1=0b00100000;
 Keypad_Init();
 Lcd_Init();
 UART1_Init(9600);
 Lcd_Cmd( _LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 trisc=0b10100000;
 portc=0;
 for(;;)
 {
 if(go==0)
 while(!kp)
 {
 i=adc_read(1)*0.005;
 kp = Keypad_Key_Click();
 if(kp!=0)
 lcd_chr(1,1,kp+48);
 if(kp ==1)
 {
 l=1;
 kp =1;
 }
 else if(kp ==2)
 {
 m=1;
 kp =2;
 }
 else if(kp ==3)
 {
 n=1;
 kp =3;
 }
 else if(kp ==5) kp =4;
 else if(kp ==6) kp =5;
 else if(kp ==7) kp =6;
 else if(kp ==9) kp =7;
 else if(kp ==10) kp =8;
 else if(kp ==11) kp =9;
 else if(kp ==14)
 {
 kp = 0;
 lcd_chr(2,1,kp+48);
 }
 else if(kp ==4) kp =17;
 else if(kp ==8) kp =18;
 else if(kp ==12) kp =19;
 else if(kp==16)
 {
 if(l==1&&m==1&&n==1)
 {
 lcd_out(1,1,"valid PASS     ");
 delay_ms(2000);
 kp =20;
 go=1;
 porte=7;

 }
 else
 {
 lcd_out(1,1,"unvalid PASS");
 delay_ms(2000);
 }
 Lcd_Cmd(_LCD_CLEAR);
 }
 else if(kp ==13) kp =-6;
 else if(kp ==15) kp =-13;


 if(go==0)
 kp=0;
 if(i>2)
 {
 Lcd_Out(2,1,"alarm ");

 portc.f1=1;
 }
 if(portc.f5==0)
 {
 Lcd_Out(2,1,"       ");

 portc.f1=0;
 }

 }



 if(go==1)
 {

x=ADC_Read(0);
 y=ADC_Read(2);
 i=adc_read(1)*0.005;
 temp=x* .48875855 ;
 s[0]=temp%10;
 s[1]=temp/10;
 Lcd_Out(1,1,"Temp ");
 Lcd_Chr(1, 7, s[1]+48);
 Lcd_Chr(1, 8, s[0]+48);
 if(temp>25)
 {
 portc.f0 =1;

 }
 if(temp<23)
 {
 portc.f0 =0;

 }
 light=y*.05;
 light=light*2;
 z[0]=light%10;
 z[1]=light/10;
 Lcd_Out(2,1,"Light ");
 Lcd_Chr(2, 7, z[1]+48);
 Lcd_Chr(2, 8, z[0]+48) ;
 Lcd_Chr(2, 9, '%');
 if(light>50)
 portc.f3 =0;
 else
 portc.f3 =1;

 UART1_Write(temp);
 UART1_Write('k');
 UART1_Write(light);


 delay_ms(200) ;
 }

 }




 }
