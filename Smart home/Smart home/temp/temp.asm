
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;temp.c,16 :: 		interrupt()
;temp.c,19 :: 		rec = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _rec+0
;temp.c,20 :: 		x=1;
	MOVLW      1
	MOVWF      _x+0
	MOVLW      0
	MOVWF      _x+1
;temp.c,21 :: 		if(rec=='a')
	MOVF       R0+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;temp.c,22 :: 		portc.f2=1;
	BSF        PORTC+0, 2
L_interrupt0:
;temp.c,23 :: 		if(rec=='b')
	MOVF       _rec+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;temp.c,24 :: 		portc.f2=0;
	BCF        PORTC+0, 2
L_interrupt1:
;temp.c,25 :: 		if(rec=='c')
	MOVF       _rec+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;temp.c,26 :: 		portc.f4=1;
	BSF        PORTC+0, 4
L_interrupt2:
;temp.c,27 :: 		if(rec=='d')
	MOVF       _rec+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;temp.c,28 :: 		portc.f4=0;
	BCF        PORTC+0, 4
L_interrupt3:
;temp.c,29 :: 		}
L_end_interrupt:
L__interrupt17:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;temp.c,31 :: 		main()
;temp.c,35 :: 		g=0;
	CLRF       main_g_L0+0
	CLRF       main_g_L0+1
;temp.c,36 :: 		INTCON=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;temp.c,37 :: 		PIE1=0b00100000;
	MOVLW      32
	MOVWF      PIE1+0
;temp.c,38 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;temp.c,39 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;temp.c,40 :: 		Lcd_Cmd( _LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;temp.c,41 :: 		portd.f2=0;
	BCF        PORTD+0, 2
;temp.c,42 :: 		trisc=0b10100000;
	MOVLW      160
	MOVWF      TRISC+0
;temp.c,43 :: 		for(;;)
L_main4:
;temp.c,46 :: 		if(g==0)
	MOVLW      0
	XORWF      main_g_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      0
	XORWF      main_g_L0+0, 0
L__main19:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;temp.c,49 :: 		x=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVF       R0+1, 0
	MOVWF      main_x_L0+1
;temp.c,50 :: 		y=ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVF       R0+1, 0
	MOVWF      main_y_L0+1
;temp.c,51 :: 		i=adc_read(1)*0.005;
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _Word2Double+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      215
	MOVWF      R4+1
	MOVLW      35
	MOVWF      R4+2
	MOVLW      119
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      main_i_L0+0
	MOVF       R0+1, 0
	MOVWF      main_i_L0+1
;temp.c,52 :: 		temp=x*  .48875855 ;
	MOVF       main_x_L0+0, 0
	MOVWF      R0+0
	MOVF       main_x_L0+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVLW      144
	MOVWF      R4+0
	MOVLW      62
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp_L0+1
;temp.c,53 :: 		s[0]=temp%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_s_L0+0
	MOVF       R0+1, 0
	MOVWF      main_s_L0+1
;temp.c,54 :: 		s[1]=temp/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_temp_L0+0, 0
	MOVWF      R0+0
	MOVF       main_temp_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_s_L0+2
	MOVF       R0+1, 0
	MOVWF      main_s_L0+3
;temp.c,55 :: 		Lcd_Out(1,1,"Temp ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_temp+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;temp.c,56 :: 		Lcd_Chr(1, 7, s[1]+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_s_L0+2, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;temp.c,57 :: 		Lcd_Chr(1, 8, s[0]+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_s_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;temp.c,58 :: 		if(temp>25)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temp_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVF       main_temp_L0+0, 0
	SUBLW      25
L__main20:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
;temp.c,60 :: 		portc.f0 =1;
	BSF        PORTC+0, 0
;temp.c,62 :: 		}
L_main8:
;temp.c,63 :: 		if(temp<23)
	MOVLW      128
	XORWF      main_temp_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVLW      23
	SUBWF      main_temp_L0+0, 0
L__main21:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;temp.c,65 :: 		portc.f0 =0;
	BCF        PORTC+0, 0
;temp.c,67 :: 		}
L_main9:
;temp.c,68 :: 		light=y*.05;
	MOVF       main_y_L0+0, 0
	MOVWF      R0+0
	MOVF       main_y_L0+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      122
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      main_light_L0+0
	MOVF       R0+1, 0
	MOVWF      main_light_L0+1
;temp.c,69 :: 		light=light*2;
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVF       R2+0, 0
	MOVWF      main_light_L0+0
	MOVF       R2+1, 0
	MOVWF      main_light_L0+1
;temp.c,70 :: 		z[0]=light%10;
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_z_L0+0
	MOVF       R0+1, 0
	MOVWF      main_z_L0+1
;temp.c,71 :: 		z[1]=light/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_light_L0+0, 0
	MOVWF      R0+0
	MOVF       main_light_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_z_L0+2
	MOVF       R0+1, 0
	MOVWF      main_z_L0+3
;temp.c,72 :: 		Lcd_Out(2,1,"Light ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_temp+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;temp.c,73 :: 		Lcd_Chr(2, 7, z[1]+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_z_L0+2, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;temp.c,74 :: 		Lcd_Chr(2, 8, z[0]+48) ;
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_z_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;temp.c,75 :: 		Lcd_Chr(2, 9, '%');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      37
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;temp.c,76 :: 		if(light>50)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_light_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVF       main_light_L0+0, 0
	SUBLW      50
L__main22:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;temp.c,77 :: 		portc.f3 =0;
	BCF        PORTC+0, 3
	GOTO       L_main11
L_main10:
;temp.c,79 :: 		portc.f3 =1;
	BSF        PORTC+0, 3
L_main11:
;temp.c,81 :: 		UART1_Write(temp);
	MOVF       main_temp_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;temp.c,82 :: 		UART1_Write('k');
	MOVLW      107
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;temp.c,83 :: 		UART1_Write(light);
	MOVF       main_light_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;temp.c,86 :: 		delay_ms(200) ;
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
;temp.c,87 :: 		if(i<2)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      2
	SUBWF      main_i_L0+0, 0
L__main23:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;temp.c,89 :: 		g=1;
	MOVLW      1
	MOVWF      main_g_L0+0
	MOVLW      0
	MOVWF      main_g_L0+1
;temp.c,90 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;temp.c,91 :: 		}}
L_main13:
	GOTO       L_main14
L_main7:
;temp.c,93 :: 		Lcd_Out(1,1,"alarm ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_temp+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;temp.c,95 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;temp.c,96 :: 		if(portc.f5==0)
	BTFSC      PORTC+0, 5
	GOTO       L_main15
;temp.c,98 :: 		g=0;
	CLRF       main_g_L0+0
	CLRF       main_g_L0+1
;temp.c,100 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;temp.c,101 :: 		}
L_main15:
;temp.c,102 :: 		}
L_main14:
;temp.c,103 :: 		}
	GOTO       L_main4
;temp.c,104 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
