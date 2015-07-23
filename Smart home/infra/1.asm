
_main:

;1.c,1 :: 		void main() {
;1.c,2 :: 		pwm1_init(38000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      25
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;1.c,4 :: 		pwm1_set_duty(127);
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;1.c,5 :: 		pwm1_start();
	CALL       _PWM1_Start+0
;1.c,6 :: 		trisd=255;
	MOVLW      255
	MOVWF      TRISD+0
;1.c,7 :: 		uart1_init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;1.c,8 :: 		for(;;)
L_main0:
;1.c,10 :: 		if(portd.f0==0)
	BTFSC      PORTD+0, 0
	GOTO       L_main3
;1.c,12 :: 		uart1_write('a');
	MOVLW      97
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;1.c,13 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
;1.c,14 :: 		}
L_main3:
;1.c,15 :: 		}
	GOTO       L_main0
;1.c,20 :: 		}
	GOTO       $+0
; end of _main
