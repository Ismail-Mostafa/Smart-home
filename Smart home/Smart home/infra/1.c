void main() {
pwm1_init(38000);

pwm1_set_duty(127);
pwm1_start();
trisd=255;
uart1_init(9600);
for(;;)
{
if(portd.f0==0)
{
uart1_write('a');
delay_ms(300);
}
}




}
