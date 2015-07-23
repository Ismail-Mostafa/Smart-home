
_main:

;rem.c,1 :: 		void main() {
;rem.c,2 :: 		CMCON=0b00000111;
	MOVLW      7
	MOVWF      CMCON+0
;rem.c,3 :: 		trisa=0b11111111;
	MOVLW      255
	MOVWF      TRISA+0
;rem.c,4 :: 		trisb=0b11111011;
	MOVLW      251
	MOVWF      TRISB+0
;rem.c,5 :: 		uart1_init(2400);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;rem.c,6 :: 		PWM1_Init(30000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      32
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;rem.c,7 :: 		PWM1_Set_Duty(127);
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;rem.c,8 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;rem.c,9 :: 		for(;;){
L_main0:
;rem.c,12 :: 		if(porta.f0==0)
	BTFSC      PORTA+0, 0
	GOTO       L_main3
;rem.c,14 :: 		uart1_write('1');
	MOVLW      49
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,15 :: 		}while(porta.f0==0);
L_main3:
L_main4:
	BTFSC      PORTA+0, 0
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;rem.c,17 :: 		if(porta.f1==0)
	BTFSC      PORTA+0, 1
	GOTO       L_main6
;rem.c,19 :: 		uart1_write('2');
	MOVLW      50
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,20 :: 		}while(porta.f1==0);
L_main6:
L_main7:
	BTFSC      PORTA+0, 1
	GOTO       L_main8
	GOTO       L_main7
L_main8:
;rem.c,22 :: 		if(porta.f2==0)
	BTFSC      PORTA+0, 2
	GOTO       L_main9
;rem.c,24 :: 		uart1_write('3');
	MOVLW      51
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,25 :: 		}while(porta.f2==0);
L_main9:
L_main10:
	BTFSC      PORTA+0, 2
	GOTO       L_main11
	GOTO       L_main10
L_main11:
;rem.c,27 :: 		if(porta.f3==0)
	BTFSC      PORTA+0, 3
	GOTO       L_main12
;rem.c,29 :: 		uart1_write('4');
	MOVLW      52
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,30 :: 		}while(porta.f3==0);
L_main12:
L_main13:
	BTFSC      PORTA+0, 3
	GOTO       L_main14
	GOTO       L_main13
L_main14:
;rem.c,32 :: 		if(portb.f0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_main15
;rem.c,34 :: 		uart1_write('5');
	MOVLW      53
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,35 :: 		}while(portb.f0==0);
L_main15:
L_main16:
	BTFSC      PORTB+0, 0
	GOTO       L_main17
	GOTO       L_main16
L_main17:
;rem.c,37 :: 		if(portb.f4==0)
	BTFSC      PORTB+0, 4
	GOTO       L_main18
;rem.c,39 :: 		uart1_write('6');
	MOVLW      54
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,40 :: 		}while(portb.f4==0);
L_main18:
L_main19:
	BTFSC      PORTB+0, 4
	GOTO       L_main20
	GOTO       L_main19
L_main20:
;rem.c,42 :: 		if(portb.f5==0)
	BTFSC      PORTB+0, 5
	GOTO       L_main21
;rem.c,44 :: 		uart1_write('7');
	MOVLW      55
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,45 :: 		}while(portb.f5==0);
L_main21:
L_main22:
	BTFSC      PORTB+0, 5
	GOTO       L_main23
	GOTO       L_main22
L_main23:
;rem.c,47 :: 		if(portb.f6==0)
	BTFSC      PORTB+0, 6
	GOTO       L_main24
;rem.c,49 :: 		uart1_write('8');
	MOVLW      56
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,50 :: 		}while(portb.f6==0);
L_main24:
L_main25:
	BTFSC      PORTB+0, 6
	GOTO       L_main26
	GOTO       L_main25
L_main26:
;rem.c,52 :: 		if(portb.f7==0)
	BTFSC      PORTB+0, 7
	GOTO       L_main27
;rem.c,54 :: 		uart1_write('9');
	MOVLW      57
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,55 :: 		}while(portb.f7==0);
L_main27:
L_main28:
	BTFSC      PORTB+0, 7
	GOTO       L_main29
	GOTO       L_main28
L_main29:
;rem.c,57 :: 		if(portb.f1==0)
	BTFSC      PORTB+0, 1
	GOTO       L_main30
;rem.c,59 :: 		uart1_write('a');
	MOVLW      97
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;rem.c,60 :: 		}while(portb.f1==0);
L_main30:
L_main31:
	BTFSC      PORTB+0, 1
	GOTO       L_main32
	GOTO       L_main31
L_main32:
;rem.c,63 :: 		}
	GOTO       L_main0
;rem.c,64 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
