
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;rec_rem.c,23 :: 		interrupt()
;rec_rem.c,26 :: 		rec = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _rec+0
;rec_rem.c,27 :: 		x=1;
	MOVLW      1
	MOVWF      _x+0
	MOVLW      0
	MOVWF      _x+1
;rec_rem.c,28 :: 		}
L_end_interrupt:
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;rec_rem.c,30 :: 		void main() {
;rec_rem.c,32 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;rec_rem.c,33 :: 		INTCON=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;rec_rem.c,34 :: 		PIE1=0b00100000;
	MOVLW      32
	MOVWF      PIE1+0
;rec_rem.c,35 :: 		UART1_Init(2400);               // Initialize UART module at 9600 bps
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;rec_rem.c,36 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
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
;rec_rem.c,37 :: 		trisc=0b10000000;
	MOVLW      128
	MOVWF      TRISC+0
;rec_rem.c,38 :: 		trisd=255;
	MOVLW      255
	MOVWF      TRISD+0
;rec_rem.c,39 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;rec_rem.c,40 :: 		for(;;){
L_main1:
;rec_rem.c,42 :: 		count= adc_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _count+0
	MOVF       R0+1, 0
	MOVWF      _count+1
;rec_rem.c,43 :: 		display=count+display;
	MOVF       _display+0, 0
	ADDWF      R0+0, 1
	MOVF       _display+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _display+0
	MOVF       R0+1, 0
	MOVWF      _display+1
;rec_rem.c,44 :: 		IntToStr(display, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;rec_rem.c,45 :: 		lcd_out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;rec_rem.c,48 :: 		if(x==1)
	MOVLW      0
	XORWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main8
	MOVLW      1
	XORWF      _x+0, 0
L__main8:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;rec_rem.c,50 :: 		Lcd_Chr(1,1,rec);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _rec+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;rec_rem.c,51 :: 		x=0;
	CLRF       _x+0
	CLRF       _x+1
;rec_rem.c,52 :: 		}
L_main4:
;rec_rem.c,53 :: 		}}
	GOTO       L_main1
L_end_main:
	GOTO       $+0
; end of _main
