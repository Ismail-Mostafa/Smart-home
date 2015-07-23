char rec;
int i=1;
int x=0;
int j=0;
int count;
int display;

 // Lcd pinout settings
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
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
char txt[7];
Lcd_Init();
INTCON=0b11000000;
PIE1=0b00100000;
UART1_Init(2400);               // Initialize UART module at 9600 bps
Delay_ms(300);                  // Wait for UART module to stabilize
trisc=0b10000000;
trisd=255;
lcd_cmd(_LCD_CURSOR_OFF);
  for(;;){
 // delay_ms(400);
count= adc_read(2);
if(count>100)
{
display=count+display;
IntToStr(display, txt);
lcd_out(2,1,txt);
}

  if(x==1)
{
  Lcd_Chr(1,1,rec);
  x=0;
}
    }}