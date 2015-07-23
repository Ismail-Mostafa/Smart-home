char rec;
int x;
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
  int x,y,i,temp,light,g;
   int s[2],z[2];
   g=0;
   INTCON=0b11000000;
   PIE1=0b00100000;
   Lcd_Init();
   UART1_Init(9600);
  Lcd_Cmd( _LCD_CURSOR_OFF);
      portd.f2=0;
   trisc=0b10100000;
   for(;;)
   {

   if(g==0)

   {
      x=ADC_Read(0);
      y=ADC_Read(2);
       i=adc_read(1)*0.005;
       temp=x*  .48875855 ;
        s[0]=temp%10;
        s[1]=temp/10;
        Lcd_Out(1,1,"Temp ");
            Lcd_Chr(1, 7, s[1]+48);
            Lcd_Chr(1, 8, s[0]+48);
            if(temp>25)
            {
             portc.f0 =1;
           // portc.f2=1;
             }
         if(temp<23)
         {
        portc.f0 =0;
       // portc.f2=0;
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
                        if(i<2)
                        {
                        g=1;
                         Lcd_Cmd(_LCD_CLEAR);
                         }}
                         else{
                         Lcd_Out(1,1,"alarm ");
                        // portc.f4=1;
                         portc.f1=1;
                         if(portc.f5==0)
                         {
                         g=0;
                        // portc.f4=0;
                         portc.f1=0;
                         }
                         }
                         }
                         }