
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;rec_rem.c,21 :: 		interrupt()
;rec_rem.c,24 :: 		rec = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _rec+0
;rec_rem.c,25 :: 		x=1;
	MOVLW      1
	MOVWF      _x+0
	MOVLW      0
	MOVWF      _x+1
;rec_rem.c,26 :: 		}
L_end_interrupt:
L__interrupt8:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;rec_rem.c,28 :: 		void main() {
;rec_rem.c,29 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;rec_rem.c,30 :: 		INTCON=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;rec_rem.c,31 :: 		PIE1=0b00100000;
	MOVLW      32
	MOVWF      PIE1+0
;rec_rem.c,32 :: 		UART1_Init(2400);               // Initialize UART module at 9600 bps
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;rec_rem.c,33 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
;rec_rem.c,34 :: 		trisc=0b10000000;
	MOVLW      128
	MOVWF      TRISC+0
;rec_rem.c,35 :: 		trisd=0;
	CLRF       TRISD+0
;rec_rem.c,36 :: 		portd=0;
	CLRF       PORTD+0
;rec_rem.c,37 :: 		for(;;){
L_main1:
;rec_rem.c,39 :: 		if(x==1)
	MOVLW      0
	XORWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVLW      1
	XORWF      _x+0, 0
L__main10:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;rec_rem.c,41 :: 		Lcd_Chr_Cp(rec);
	MOVF       _rec+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;rec_rem.c,42 :: 		x=0;
	CLRF       _x+0
	CLRF       _x+1
;rec_rem.c,43 :: 		if(rec=='a')
	MOVF       _rec+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;rec_rem.c,45 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;rec_rem.c,46 :: 		rd2_bit=1;
	BSF        RD2_bit+0, 2
;rec_rem.c,47 :: 		}
L_main5:
;rec_rem.c,48 :: 		if(rec=='5')
	MOVF       _rec+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;rec_rem.c,50 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;rec_rem.c,51 :: 		rd2_bit=0;
	BCF        RD2_bit+0, 2
;rec_rem.c,52 :: 		}
L_main6:
;rec_rem.c,53 :: 		}}}
L_main4:
	GOTO       L_main1
L_end_main:
	GOTO       $+0
; end of _main
