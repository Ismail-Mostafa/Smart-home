
_main:

;infra.c,1 :: 		void main() {
;infra.c,2 :: 		trisb=0b11111011;
	MOVLW      251
	MOVWF      TRISB+0
;infra.c,3 :: 		uart1_init(2400);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;infra.c,4 :: 		PWM1_Init(30000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      32
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;infra.c,5 :: 		PWM1_Set_Duty(127);
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;infra.c,6 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;infra.c,7 :: 		for(;;){
L_main0:
;infra.c,8 :: 		if(portb.f0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_main3
;infra.c,10 :: 		uart1_write('a');
	MOVLW      97
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;infra.c,11 :: 		}while(portb.f0==0);
L_main3:
L_main4:
	BTFSC      PORTB+0, 0
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;infra.c,12 :: 		if(portb.f4==0)
	BTFSC      PORTB+0, 4
	GOTO       L_main6
;infra.c,14 :: 		uart1_write('a');
	MOVLW      97
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;infra.c,15 :: 		}while(portb.f4==0);
L_main6:
L_main7:
	BTFSC      PORTB+0, 4
	GOTO       L_main8
	GOTO       L_main7
L_main8:
;infra.c,16 :: 		if(portb.f5==0)
	BTFSC      PORTB+0, 5
	GOTO       L_main9
;infra.c,18 :: 		uart1_write('b');
	MOVLW      98
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;infra.c,19 :: 		}while(portb.f5==0);
L_main9:
L_main10:
	BTFSC      PORTB+0, 5
	GOTO       L_main11
	GOTO       L_main10
L_main11:
;infra.c,20 :: 		if(portb.f6==0)
	BTFSC      PORTB+0, 6
	GOTO       L_main12
;infra.c,22 :: 		uart1_write('c');
	MOVLW      99
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;infra.c,23 :: 		}while(portb.f6==0);
L_main12:
L_main13:
	BTFSC      PORTB+0, 6
	GOTO       L_main14
	GOTO       L_main13
L_main14:
;infra.c,24 :: 		}
	GOTO       L_main0
;infra.c,26 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
