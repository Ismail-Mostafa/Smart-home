
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;hanem.c,16 :: 		interrupt()
;hanem.c,19 :: 		rec = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _rec+0
;hanem.c,20 :: 		if(rec=='a')
	MOVF       R0+0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;hanem.c,21 :: 		portc.f2=1;
	BSF        PORTC+0, 2
L_interrupt0:
;hanem.c,22 :: 		if(rec=='b')
	MOVF       _rec+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;hanem.c,23 :: 		portc.f2=0;
	BCF        PORTC+0, 2
L_interrupt1:
;hanem.c,24 :: 		if(rec=='c')
	MOVF       _rec+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;hanem.c,25 :: 		portc.f4=1;
	BSF        PORTC+0, 4
L_interrupt2:
;hanem.c,26 :: 		if(rec=='d')
	MOVF       _rec+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;hanem.c,27 :: 		portc.f4=0;
	BCF        PORTC+0, 4
L_interrupt3:
;hanem.c,28 :: 		}
L_end_interrupt:
L__interrupt59:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;hanem.c,30 :: 		main()
;hanem.c,35 :: 		char kp =0;
	CLRF       main_kp_L0+0
	CLRF       main_go_L0+0
	CLRF       main_go_L0+1
;hanem.c,39 :: 		l=0;
	CLRF       main_l_L0+0
	CLRF       main_l_L0+1
;hanem.c,40 :: 		m=0;
	CLRF       main_m_L0+0
	CLRF       main_m_L0+1
;hanem.c,41 :: 		n=0;
	CLRF       main_n_L0+0
	CLRF       main_n_L0+1
;hanem.c,42 :: 		adcon1=2;
	MOVLW      2
	MOVWF      ADCON1+0
;hanem.c,43 :: 		trise=0;
	CLRF       TRISE+0
;hanem.c,44 :: 		porte=0;
	CLRF       PORTE+0
;hanem.c,46 :: 		valid[0]=1;
	MOVLW      1
	MOVWF      main_valid_L0+0
	MOVLW      0
	MOVWF      main_valid_L0+1
;hanem.c,47 :: 		valid[1]=2;
	MOVLW      2
	MOVWF      main_valid_L0+2
	MOVLW      0
	MOVWF      main_valid_L0+3
;hanem.c,48 :: 		valid[2]=3;
	MOVLW      3
	MOVWF      main_valid_L0+4
	MOVLW      0
	MOVWF      main_valid_L0+5
;hanem.c,49 :: 		INTCON=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;hanem.c,50 :: 		PIE1=0b00100000;
	MOVLW      32
	MOVWF      PIE1+0
;hanem.c,51 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;hanem.c,52 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;hanem.c,53 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;hanem.c,54 :: 		Lcd_Cmd( _LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;hanem.c,55 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;hanem.c,56 :: 		trisc=0b10100000;
	MOVLW      160
	MOVWF      TRISC+0
;hanem.c,57 :: 		portc=0;  // actoin  infrared
	CLRF       PORTC+0
;hanem.c,58 :: 		for(;;)
L_main4:
;hanem.c,60 :: 		if(go==0)
	MOVLW      0
	XORWF      main_go_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      0
	XORWF      main_go_L0+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;hanem.c,61 :: 		while(!kp)
L_main8:
	MOVF       main_kp_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;hanem.c,63 :: 		i=adc_read(1)*0.005;
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
;hanem.c,64 :: 		kp =  Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      main_kp_L0+0
;hanem.c,65 :: 		if(kp!=0)
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;hanem.c,66 :: 		lcd_chr(1,1,kp+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_kp_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
L_main10:
;hanem.c,67 :: 		if(kp ==1)
	MOVF       main_kp_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;hanem.c,69 :: 		l=1;
	MOVLW      1
	MOVWF      main_l_L0+0
	MOVLW      0
	MOVWF      main_l_L0+1
;hanem.c,70 :: 		kp =1;
	MOVLW      1
	MOVWF      main_kp_L0+0
;hanem.c,71 :: 		}
	GOTO       L_main12
L_main11:
;hanem.c,72 :: 		else if(kp ==2)
	MOVF       main_kp_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;hanem.c,74 :: 		m=1;
	MOVLW      1
	MOVWF      main_m_L0+0
	MOVLW      0
	MOVWF      main_m_L0+1
;hanem.c,75 :: 		kp =2;
	MOVLW      2
	MOVWF      main_kp_L0+0
;hanem.c,76 :: 		}
	GOTO       L_main14
L_main13:
;hanem.c,77 :: 		else  if(kp ==3)
	MOVF       main_kp_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;hanem.c,79 :: 		n=1;
	MOVLW      1
	MOVWF      main_n_L0+0
	MOVLW      0
	MOVWF      main_n_L0+1
;hanem.c,80 :: 		kp =3;
	MOVLW      3
	MOVWF      main_kp_L0+0
;hanem.c,81 :: 		}
	GOTO       L_main16
L_main15:
;hanem.c,82 :: 		else if(kp ==5) kp =4;
	MOVF       main_kp_L0+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_main17
	MOVLW      4
	MOVWF      main_kp_L0+0
	GOTO       L_main18
L_main17:
;hanem.c,83 :: 		else if(kp ==6) kp =5;
	MOVF       main_kp_L0+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVLW      5
	MOVWF      main_kp_L0+0
	GOTO       L_main20
L_main19:
;hanem.c,84 :: 		else if(kp ==7) kp =6;
	MOVF       main_kp_L0+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_main21
	MOVLW      6
	MOVWF      main_kp_L0+0
	GOTO       L_main22
L_main21:
;hanem.c,85 :: 		else if(kp ==9) kp =7;
	MOVF       main_kp_L0+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	MOVLW      7
	MOVWF      main_kp_L0+0
	GOTO       L_main24
L_main23:
;hanem.c,86 :: 		else if(kp ==10) kp =8;
	MOVF       main_kp_L0+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVLW      8
	MOVWF      main_kp_L0+0
	GOTO       L_main26
L_main25:
;hanem.c,87 :: 		else if(kp ==11) kp =9;
	MOVF       main_kp_L0+0, 0
	XORLW      11
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVLW      9
	MOVWF      main_kp_L0+0
	GOTO       L_main28
L_main27:
;hanem.c,88 :: 		else if(kp ==14)
	MOVF       main_kp_L0+0, 0
	XORLW      14
	BTFSS      STATUS+0, 2
	GOTO       L_main29
;hanem.c,90 :: 		kp = 0;
	CLRF       main_kp_L0+0
;hanem.c,91 :: 		lcd_chr(2,1,kp+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,92 :: 		}
	GOTO       L_main30
L_main29:
;hanem.c,93 :: 		else if(kp ==4) kp =17;
	MOVF       main_kp_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main31
	MOVLW      17
	MOVWF      main_kp_L0+0
	GOTO       L_main32
L_main31:
;hanem.c,94 :: 		else if(kp ==8) kp =18;
	MOVF       main_kp_L0+0, 0
	XORLW      8
	BTFSS      STATUS+0, 2
	GOTO       L_main33
	MOVLW      18
	MOVWF      main_kp_L0+0
	GOTO       L_main34
L_main33:
;hanem.c,95 :: 		else if(kp ==12) kp =19;
	MOVF       main_kp_L0+0, 0
	XORLW      12
	BTFSS      STATUS+0, 2
	GOTO       L_main35
	MOVLW      19
	MOVWF      main_kp_L0+0
	GOTO       L_main36
L_main35:
;hanem.c,96 :: 		else if(kp==16)
	MOVF       main_kp_L0+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;hanem.c,98 :: 		if(l==1&&m==1&&n==1)
	MOVLW      0
	XORWF      main_l_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      1
	XORWF      main_l_L0+0, 0
L__main62:
	BTFSS      STATUS+0, 2
	GOTO       L_main40
	MOVLW      0
	XORWF      main_m_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      1
	XORWF      main_m_L0+0, 0
L__main63:
	BTFSS      STATUS+0, 2
	GOTO       L_main40
	MOVLW      0
	XORWF      main_n_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      1
	XORWF      main_n_L0+0, 0
L__main64:
	BTFSS      STATUS+0, 2
	GOTO       L_main40
L__main57:
;hanem.c,100 :: 		lcd_out(1,1,"valid PASS     ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,101 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;hanem.c,102 :: 		kp =20;
	MOVLW      20
	MOVWF      main_kp_L0+0
;hanem.c,103 :: 		go=1;
	MOVLW      1
	MOVWF      main_go_L0+0
	MOVLW      0
	MOVWF      main_go_L0+1
;hanem.c,104 :: 		porte=7;
	MOVLW      7
	MOVWF      PORTE+0
;hanem.c,106 :: 		}
	GOTO       L_main42
L_main40:
;hanem.c,109 :: 		lcd_out(1,1,"unvalid PASS");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,110 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;hanem.c,111 :: 		}
L_main42:
;hanem.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;hanem.c,113 :: 		}
	GOTO       L_main44
L_main37:
;hanem.c,114 :: 		else if(kp ==13) kp =-6;
	MOVF       main_kp_L0+0, 0
	XORLW      13
	BTFSS      STATUS+0, 2
	GOTO       L_main45
	MOVLW      250
	MOVWF      main_kp_L0+0
	GOTO       L_main46
L_main45:
;hanem.c,115 :: 		else if(kp ==15) kp =-13;
	MOVF       main_kp_L0+0, 0
	XORLW      15
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	MOVLW      243
	MOVWF      main_kp_L0+0
L_main47:
L_main46:
L_main44:
L_main36:
L_main34:
L_main32:
L_main30:
L_main28:
L_main26:
L_main24:
L_main22:
L_main20:
L_main18:
L_main16:
L_main14:
L_main12:
;hanem.c,118 :: 		if(go==0)
	MOVLW      0
	XORWF      main_go_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      0
	XORWF      main_go_L0+0, 0
L__main65:
	BTFSS      STATUS+0, 2
	GOTO       L_main48
;hanem.c,119 :: 		kp=0;
	CLRF       main_kp_L0+0
L_main48:
;hanem.c,120 :: 		if(i>2)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVF       main_i_L0+0, 0
	SUBLW      2
L__main66:
	BTFSC      STATUS+0, 0
	GOTO       L_main49
;hanem.c,122 :: 		Lcd_Out(2,1,"alarm ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,124 :: 		portc.f1=1;
	BSF        PORTC+0, 1
;hanem.c,125 :: 		}
L_main49:
;hanem.c,126 :: 		if(portc.f5==0)
	BTFSC      PORTC+0, 5
	GOTO       L_main50
;hanem.c,128 :: 		Lcd_Out(2,1,"       ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,130 :: 		portc.f1=0;
	BCF        PORTC+0, 1
;hanem.c,131 :: 		}
L_main50:
;hanem.c,133 :: 		}
	GOTO       L_main8
L_main9:
L_main7:
;hanem.c,137 :: 		if(go==1)
	MOVLW      0
	XORWF      main_go_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      1
	XORWF      main_go_L0+0, 0
L__main67:
	BTFSS      STATUS+0, 2
	GOTO       L_main51
;hanem.c,140 :: 		x=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVF       R0+1, 0
	MOVWF      main_x_L0+1
;hanem.c,141 :: 		y=ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVF       R0+1, 0
	MOVWF      main_y_L0+1
;hanem.c,142 :: 		i=adc_read(1)*0.005;
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
;hanem.c,143 :: 		temp=x*  .48875855 ;
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
;hanem.c,144 :: 		s[0]=temp%10;
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
;hanem.c,145 :: 		s[1]=temp/10;
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
;hanem.c,146 :: 		Lcd_Out(1,1,"Temp ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,147 :: 		Lcd_Chr(1, 7, s[1]+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_s_L0+2, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,148 :: 		Lcd_Chr(1, 8, s[0]+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_s_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,149 :: 		if(temp>25)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temp_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVF       main_temp_L0+0, 0
	SUBLW      25
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L_main52
;hanem.c,151 :: 		portc.f0 =1;
	BSF        PORTC+0, 0
;hanem.c,153 :: 		}
L_main52:
;hanem.c,154 :: 		if(temp<23)
	MOVLW      128
	XORWF      main_temp_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      23
	SUBWF      main_temp_L0+0, 0
L__main69:
	BTFSC      STATUS+0, 0
	GOTO       L_main53
;hanem.c,156 :: 		portc.f0 =0;
	BCF        PORTC+0, 0
;hanem.c,158 :: 		}
L_main53:
;hanem.c,159 :: 		light=y*.05;
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
;hanem.c,160 :: 		light=light*2;
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
;hanem.c,161 :: 		z[0]=light%10;
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
;hanem.c,162 :: 		z[1]=light/10;
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
;hanem.c,163 :: 		Lcd_Out(2,1,"Light ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_hanem+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;hanem.c,164 :: 		Lcd_Chr(2, 7, z[1]+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_z_L0+2, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,165 :: 		Lcd_Chr(2, 8, z[0]+48) ;
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_z_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,166 :: 		Lcd_Chr(2, 9, '%');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      37
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;hanem.c,167 :: 		if(light>50)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_light_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       main_light_L0+0, 0
	SUBLW      50
L__main70:
	BTFSC      STATUS+0, 0
	GOTO       L_main54
;hanem.c,168 :: 		portc.f3 =0;
	BCF        PORTC+0, 3
	GOTO       L_main55
L_main54:
;hanem.c,170 :: 		portc.f3 =1;
	BSF        PORTC+0, 3
L_main55:
;hanem.c,172 :: 		UART1_Write(temp);
	MOVF       main_temp_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;hanem.c,173 :: 		UART1_Write('k');
	MOVLW      107
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;hanem.c,174 :: 		UART1_Write(light);
	MOVF       main_light_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;hanem.c,177 :: 		delay_ms(200) ;
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	DECFSZ     R12+0, 1
	GOTO       L_main56
	DECFSZ     R11+0, 1
	GOTO       L_main56
	NOP
;hanem.c,178 :: 		}
L_main51:
;hanem.c,180 :: 		}
	GOTO       L_main4
;hanem.c,185 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
