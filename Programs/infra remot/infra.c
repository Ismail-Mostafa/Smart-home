void main() {
CMCON=0b00000111;
trisa=0b11111111;
trisb=0b11111011;
uart1_init(2400);
PWM1_Init(30000);
PWM1_Set_Duty(127);
PWM1_Start();
for(;;){
if(porta.f0==0)
{
uart1_write('1');
}while(porta.f0==0);
if(porta.f1==0)
{
uart1_write('2');
}while(porta.f1==0);
if(porta.f2==0)
{
uart1_write('3');
}while(porta.f2==0);


if(portb.f0==0)
{
uart1_write('a');
}while(portb.f0==0);
if(portb.f4==0)
{
uart1_write('a');
}while(portb.f4==0);
if(portb.f5==0)
{
uart1_write('b');
}while(portb.f5==0);
if(portb.f6==0)
{
uart1_write('c');
}while(portb.f6==0);








}

}