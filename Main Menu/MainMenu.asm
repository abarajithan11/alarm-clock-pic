
_read_ds1307:

;MainMenu.c,61 :: 		unsigned short read_ds1307(unsigned short address)
;MainMenu.c,64 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;MainMenu.c,65 :: 		I2C1_Wr(0xD0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,66 :: 		I2C1_Wr(address);
	MOVF       FARG_read_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,67 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;MainMenu.c,68 :: 		I2C1_Wr(0xD1); //0x68 followed by 1 --> 0xD1
	MOVLW      209
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,69 :: 		r_data=I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      read_ds1307_r_data_L0+0
;MainMenu.c,70 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;MainMenu.c,71 :: 		return(r_data);
	MOVF       read_ds1307_r_data_L0+0, 0
	MOVWF      R0+0
;MainMenu.c,72 :: 		}
L_end_read_ds1307:
	RETURN
; end of _read_ds1307

_write_ds1307:

;MainMenu.c,74 :: 		void write_ds1307(unsigned short address,unsigned short w_data)
;MainMenu.c,76 :: 		I2C1_Start(); // issue I2C start signal
	CALL       _I2C1_Start+0
;MainMenu.c,78 :: 		I2C1_Wr(0xD0); // send byte via I2C (device address + W)
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,79 :: 		I2C1_Wr(address); // send byte (address of DS1307 location)
	MOVF       FARG_write_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,80 :: 		I2C1_Wr(w_data); // send data (data to be written)
	MOVF       FARG_write_ds1307_w_data+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;MainMenu.c,81 :: 		I2C1_Stop(); // issue I2C stop signal
	CALL       _I2C1_Stop+0
;MainMenu.c,82 :: 		}
L_end_write_ds1307:
	RETURN
; end of _write_ds1307

_BCD2UpperCh:

;MainMenu.c,84 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;MainMenu.c,86 :: 		return ((bcd >> 4) + '0');
	MOVF       FARG_BCD2UpperCh_bcd+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      48
	ADDWF      R0+0, 1
;MainMenu.c,87 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;MainMenu.c,89 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;MainMenu.c,91 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;MainMenu.c,92 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;MainMenu.c,94 :: 		int Binary2BCD(int a)
;MainMenu.c,97 :: 		t1 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;MainMenu.c,98 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Binary2BCD+1
	MOVLW      0
	ANDWF      FLOC__Binary2BCD+1, 1
;MainMenu.c,99 :: 		a = a/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
;MainMenu.c,100 :: 		t2 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;MainMenu.c,101 :: 		t2 = 0x0F & t2;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R3+0
	MOVF       R0+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
;MainMenu.c,102 :: 		t2 = t2 << 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__Binary2BCD95:
	BTFSC      STATUS+0, 2
	GOTO       L__Binary2BCD96
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Binary2BCD95
L__Binary2BCD96:
;MainMenu.c,103 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;MainMenu.c,104 :: 		t1 = t1 | t2;
	MOVF       FLOC__Binary2BCD+0, 0
	IORWF      R0+0, 1
	MOVF       FLOC__Binary2BCD+1, 0
	IORWF      R0+1, 1
;MainMenu.c,105 :: 		return t1;
;MainMenu.c,106 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;MainMenu.c,108 :: 		int BCD2Binary(int a)
;MainMenu.c,111 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
;MainMenu.c,113 :: 		a = 0xF0 & a;
	MOVLW      240
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      R3+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      FARG_BCD2Binary_a+0
	MOVF       R3+1, 0
	MOVWF      FARG_BCD2Binary_a+1
;MainMenu.c,114 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary98:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary99
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary98
L__BCD2Binary99:
;MainMenu.c,115 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;MainMenu.c,116 :: 		r = t*10 + r;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__BCD2Binary+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__BCD2Binary+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;MainMenu.c,117 :: 		return r;
;MainMenu.c,118 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_inputTime:

;MainMenu.c,120 :: 		inputTime(int mode, char *text)   //Dummy function
;MainMenu.c,122 :: 		while(1){
L_inputTime0:
;MainMenu.c,123 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,124 :: 		Lcd_out(1,1, "Time Input Mode ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,125 :: 		Lcd_out(1,1, "It is working   ");}
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_inputTime0
;MainMenu.c,126 :: 		}
L_end_inputTime:
	RETURN
; end of _inputTime

_inputDate:

;MainMenu.c,128 :: 		inputDate()   //Dummy function
;MainMenu.c,130 :: 		while(1){
L_inputDate2:
;MainMenu.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,132 :: 		Lcd_out(1,1, "Date Input Mode ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,133 :: 		Lcd_out(1,1, "It is working   ");}
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_inputDate2
;MainMenu.c,134 :: 		}
L_end_inputDate:
	RETURN
; end of _inputDate

_menuMain2:

;MainMenu.c,140 :: 		void menuMain2()
;MainMenu.c,142 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,144 :: 		loopcount = 0;
	CLRF       _loopcount+0
	CLRF       _loopcount+1
;MainMenu.c,145 :: 		while(1)
L_menuMain24:
;MainMenu.c,147 :: 		set = 0;
	CLRF       _set+0
;MainMenu.c,148 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC      PORTA+0, 0
	GOTO       L_menuMain26
;MainMenu.c,150 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain27:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain27
	DECFSZ     R12+0, 1
	GOTO       L_menuMain27
	DECFSZ     R11+0, 1
	GOTO       L_menuMain27
	NOP
;MainMenu.c,151 :: 		if(PORTA.F0 == 0)
	BTFSC      PORTA+0, 0
	GOTO       L_menuMain28
;MainMenu.c,153 :: 		set_count++;
	INCF       _set_count+0, 1
;MainMenu.c,154 :: 		if(set_count > 5)
	MOVF       _set_count+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain29
;MainMenu.c,156 :: 		set_count = 1;
	MOVLW      1
	MOVWF      _set_count+0
;MainMenu.c,157 :: 		}
L_menuMain29:
;MainMenu.c,158 :: 		}
L_menuMain28:
;MainMenu.c,159 :: 		}
L_menuMain26:
;MainMenu.c,161 :: 		if(set_count)
	MOVF       _set_count+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain210
;MainMenu.c,163 :: 		if(PORTA.F1 == 0)
	BTFSC      PORTA+0, 1
	GOTO       L_menuMain211
;MainMenu.c,165 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain212:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain212
	DECFSZ     R12+0, 1
	GOTO       L_menuMain212
	DECFSZ     R11+0, 1
	GOTO       L_menuMain212
	NOP
;MainMenu.c,166 :: 		if(PORTA.F1 == 0)
	BTFSC      PORTA+0, 1
	GOTO       L_menuMain213
;MainMenu.c,167 :: 		set = 1;
	MOVLW      1
	MOVWF      _set+0
L_menuMain213:
;MainMenu.c,168 :: 		}
L_menuMain211:
;MainMenu.c,170 :: 		if(PORTA.F2 == 0)
	BTFSC      PORTA+0, 2
	GOTO       L_menuMain214
;MainMenu.c,172 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain215:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain215
	DECFSZ     R12+0, 1
	GOTO       L_menuMain215
	DECFSZ     R11+0, 1
	GOTO       L_menuMain215
	NOP
;MainMenu.c,173 :: 		if(PORTA.F2 == 0)
	BTFSC      PORTA+0, 2
	GOTO       L_menuMain216
;MainMenu.c,174 :: 		set = -1;
	MOVLW      255
	MOVWF      _set+0
L_menuMain216:
;MainMenu.c,175 :: 		}
L_menuMain214:
;MainMenu.c,176 :: 		if(set_count && set)
	MOVF       _set_count+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain219
	MOVF       _set+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain219
L__menuMain288:
;MainMenu.c,178 :: 		switch(set_count)
	GOTO       L_menuMain220
;MainMenu.c,180 :: 		case 1: // Alarm1
L_menuMain222:
;MainMenu.c,183 :: 		break;
	GOTO       L_menuMain221
;MainMenu.c,184 :: 		case 2: //Alarm2
L_menuMain223:
;MainMenu.c,187 :: 		break;
	GOTO       L_menuMain221
;MainMenu.c,188 :: 		case 3: //Alarm3
L_menuMain224:
;MainMenu.c,191 :: 		break;
	GOTO       L_menuMain221
;MainMenu.c,192 :: 		case 4: //Time
L_menuMain225:
;MainMenu.c,193 :: 		inputTime(1, "Time:");
	MOVLW      1
	MOVWF      FARG_inputTime_mode+0
	MOVLW      0
	MOVWF      FARG_inputTime_mode+1
	MOVLW      ?lstr10_MainMenu+0
	MOVWF      FARG_inputTime_text+0
	CALL       _inputTime+0
;MainMenu.c,195 :: 		break;
	GOTO       L_menuMain221
;MainMenu.c,196 :: 		case 5: //Date
L_menuMain226:
;MainMenu.c,197 :: 		inputDate();
	CALL       _inputDate+0
;MainMenu.c,199 :: 		break;
	GOTO       L_menuMain221
;MainMenu.c,200 :: 		}
L_menuMain220:
	MOVF       _set_count+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain222
	MOVF       _set_count+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain223
	MOVF       _set_count+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain224
	MOVF       _set_count+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain225
	MOVF       _set_count+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain226
L_menuMain221:
;MainMenu.c,202 :: 		}
L_menuMain219:
;MainMenu.c,207 :: 		loopcount++;
	INCF       _loopcount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _loopcount+1, 1
;MainMenu.c,208 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _loopcount+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__menuMain2103
	MOVF       _loopcount+0, 0
	SUBLW      10
L__menuMain2103:
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain227
	CLRF       _loopcount+0
	CLRF       _loopcount+1
L_menuMain227:
;MainMenu.c,209 :: 		if(loopcount < 5)
	MOVLW      128
	XORWF      _loopcount+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__menuMain2104
	MOVLW      5
	SUBWF      _loopcount+0, 0
L__menuMain2104:
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain228
;MainMenu.c,211 :: 		Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Edit Alarm:1|2|3");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,212 :: 		}
	GOTO       L_menuMain229
L_menuMain228:
;MainMenu.c,215 :: 		if      (set_count  ==1) Lcd_out(1,12, "_");
	MOVF       _set_count+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain230
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain231
L_menuMain230:
;MainMenu.c,216 :: 		else if (set_count  ==2) Lcd_out(1,14, "_");
	MOVF       _set_count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain232
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain233
L_menuMain232:
;MainMenu.c,217 :: 		else if (set_count  ==3) Lcd_out(1,16, "_");
	MOVF       _set_count+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain234
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain235
L_menuMain234:
;MainMenu.c,218 :: 		else if (set_count  ==4) Lcd_out(2,6, "____");
	MOVF       _set_count+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain236
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr16_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain237
L_menuMain236:
;MainMenu.c,219 :: 		else if (set_count  ==5) Lcd_out(2,13, "____");
	MOVF       _set_count+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain238
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr17_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_menuMain238:
L_menuMain237:
L_menuMain235:
L_menuMain233:
L_menuMain231:
;MainMenu.c,220 :: 		}
L_menuMain229:
;MainMenu.c,222 :: 		}
L_menuMain210:
;MainMenu.c,224 :: 		if(PORTA.F3 == 0)  // Break the while loop when menu pressed
	BTFSC      PORTA+0, 3
	GOTO       L_menuMain239
;MainMenu.c,226 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain240:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain240
	DECFSZ     R12+0, 1
	GOTO       L_menuMain240
	DECFSZ     R11+0, 1
	GOTO       L_menuMain240
	NOP
;MainMenu.c,227 :: 		if(PORTA.F3 == 0) break;
	BTFSC      PORTA+0, 3
	GOTO       L_menuMain241
	GOTO       L_menuMain25
L_menuMain241:
;MainMenu.c,228 :: 		}
L_menuMain239:
;MainMenu.c,229 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain242:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain242
	DECFSZ     R12+0, 1
	GOTO       L_menuMain242
	DECFSZ     R11+0, 1
	GOTO       L_menuMain242
	NOP
;MainMenu.c,230 :: 		}
	GOTO       L_menuMain24
L_menuMain25:
;MainMenu.c,232 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,233 :: 		set = 0;
	CLRF       _set+0
;MainMenu.c,234 :: 		set_count = 0;
	CLRF       _set_count+0
;MainMenu.c,235 :: 		loopcount = 0;
	CLRF       _loopcount+0
	CLRF       _loopcount+1
;MainMenu.c,236 :: 		}
L_end_menuMain2:
	RETURN
; end of _menuMain2

_menuMain:

;MainMenu.c,238 :: 		void menuMain()
;MainMenu.c,240 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;MainMenu.c,241 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,242 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,243 :: 		Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr18_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr19_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,245 :: 		loopcount = 0;
	CLRF       _loopcount+0
	CLRF       _loopcount+1
;MainMenu.c,246 :: 		while(1)
L_menuMain43:
;MainMenu.c,248 :: 		set = 0;
	CLRF       _set+0
;MainMenu.c,249 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC      PORTA+0, 0
	GOTO       L_menuMain45
;MainMenu.c,251 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain46:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain46
	DECFSZ     R12+0, 1
	GOTO       L_menuMain46
	DECFSZ     R11+0, 1
	GOTO       L_menuMain46
	NOP
;MainMenu.c,252 :: 		if(PORTA.F0 == 0)
	BTFSC      PORTA+0, 0
	GOTO       L_menuMain47
;MainMenu.c,254 :: 		set_count++;
	INCF       _set_count+0, 1
;MainMenu.c,255 :: 		if(set_count > 5)  set_count = 1;
	MOVF       _set_count+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain48
	MOVLW      1
	MOVWF      _set_count+0
L_menuMain48:
;MainMenu.c,257 :: 		}
L_menuMain47:
;MainMenu.c,258 :: 		}
L_menuMain45:
;MainMenu.c,260 :: 		if(set_count)
	MOVF       _set_count+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain49
;MainMenu.c,262 :: 		if(PORTA.F1 == 0)
	BTFSC      PORTA+0, 1
	GOTO       L_menuMain50
;MainMenu.c,264 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain51:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain51
	DECFSZ     R12+0, 1
	GOTO       L_menuMain51
	DECFSZ     R11+0, 1
	GOTO       L_menuMain51
	NOP
;MainMenu.c,265 :: 		if(PORTA.F1 == 0)
	BTFSC      PORTA+0, 1
	GOTO       L_menuMain52
;MainMenu.c,266 :: 		set = 1;
	MOVLW      1
	MOVWF      _set+0
L_menuMain52:
;MainMenu.c,267 :: 		}
L_menuMain50:
;MainMenu.c,269 :: 		if(PORTA.F2 == 0)
	BTFSC      PORTA+0, 2
	GOTO       L_menuMain53
;MainMenu.c,271 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain54:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain54
	DECFSZ     R12+0, 1
	GOTO       L_menuMain54
	DECFSZ     R11+0, 1
	GOTO       L_menuMain54
	NOP
;MainMenu.c,272 :: 		if(PORTA.F2 == 0)
	BTFSC      PORTA+0, 2
	GOTO       L_menuMain55
;MainMenu.c,273 :: 		set = -1;
	MOVLW      255
	MOVWF      _set+0
L_menuMain55:
;MainMenu.c,274 :: 		}
L_menuMain53:
;MainMenu.c,275 :: 		if(set_count && set)
	MOVF       _set_count+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain58
	MOVF       _set+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain58
L__menuMain89:
;MainMenu.c,277 :: 		switch(set_count)
	GOTO       L_menuMain59
;MainMenu.c,279 :: 		case 1: // Alarm1
L_menuMain61:
;MainMenu.c,282 :: 		break;
	GOTO       L_menuMain60
;MainMenu.c,283 :: 		case 2: //Alarm2
L_menuMain62:
;MainMenu.c,286 :: 		break;
	GOTO       L_menuMain60
;MainMenu.c,287 :: 		case 3: //Alarm3
L_menuMain63:
;MainMenu.c,290 :: 		break;
	GOTO       L_menuMain60
;MainMenu.c,291 :: 		case 4: //Time
L_menuMain64:
;MainMenu.c,292 :: 		inputTime(1, "Time:");
	MOVLW      1
	MOVWF      FARG_inputTime_mode+0
	MOVLW      0
	MOVWF      FARG_inputTime_mode+1
	MOVLW      ?lstr20_MainMenu+0
	MOVWF      FARG_inputTime_text+0
	CALL       _inputTime+0
;MainMenu.c,294 :: 		break;
	GOTO       L_menuMain60
;MainMenu.c,295 :: 		case 5: //Date
L_menuMain65:
;MainMenu.c,296 :: 		inputDate();
	CALL       _inputDate+0
;MainMenu.c,298 :: 		break;
	GOTO       L_menuMain60
;MainMenu.c,299 :: 		}
L_menuMain59:
	MOVF       _set_count+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain61
	MOVF       _set_count+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain62
	MOVF       _set_count+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain63
	MOVF       _set_count+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain64
	MOVF       _set_count+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_menuMain65
L_menuMain60:
;MainMenu.c,301 :: 		}
L_menuMain58:
;MainMenu.c,306 :: 		loopcount++;
	INCF       _loopcount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _loopcount+1, 1
;MainMenu.c,307 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _loopcount+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__menuMain106
	MOVF       _loopcount+0, 0
	SUBLW      10
L__menuMain106:
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain66
	CLRF       _loopcount+0
	CLRF       _loopcount+1
L_menuMain66:
;MainMenu.c,308 :: 		if(loopcount < 5)
	MOVLW      128
	XORWF      _loopcount+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__menuMain107
	MOVLW      5
	SUBWF      _loopcount+0, 0
L__menuMain107:
	BTFSC      STATUS+0, 0
	GOTO       L_menuMain67
;MainMenu.c,310 :: 		Lcd_out(1,12, "1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr21_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,311 :: 		Lcd_out(1,14, "2");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr22_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,312 :: 		Lcd_out(1,16, "3");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr23_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,313 :: 		Lcd_out(2,6, "Time");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr24_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,314 :: 		Lcd_out(2,13, "Date");//                       Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr25_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,315 :: 		}
	GOTO       L_menuMain68
L_menuMain67:
;MainMenu.c,318 :: 		if      (set_count  ==1) Lcd_out(1,12, "_");
	MOVF       _set_count+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain69
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr26_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain70
L_menuMain69:
;MainMenu.c,319 :: 		else if (set_count  ==2) Lcd_out(1,14, "_");
	MOVF       _set_count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain71
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr27_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain72
L_menuMain71:
;MainMenu.c,320 :: 		else if (set_count  ==3) Lcd_out(1,16, "_");
	MOVF       _set_count+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain73
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr28_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain74
L_menuMain73:
;MainMenu.c,321 :: 		else if (set_count  ==4) Lcd_out(2,6, "____");
	MOVF       _set_count+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain75
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr29_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_menuMain76
L_menuMain75:
;MainMenu.c,322 :: 		else if (set_count  ==5) Lcd_out(2,13, "____");
	MOVF       _set_count+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_menuMain77
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr30_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_menuMain77:
L_menuMain76:
L_menuMain74:
L_menuMain72:
L_menuMain70:
;MainMenu.c,323 :: 		}
L_menuMain68:
;MainMenu.c,325 :: 		}
L_menuMain49:
;MainMenu.c,327 :: 		if(PORTA.F3 == 0)  // Break the while loop when menu pressed
	BTFSC      PORTA+0, 3
	GOTO       L_menuMain78
;MainMenu.c,329 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain79:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain79
	DECFSZ     R12+0, 1
	GOTO       L_menuMain79
	DECFSZ     R11+0, 1
	GOTO       L_menuMain79
	NOP
;MainMenu.c,330 :: 		if(PORTA.F3 == 0) break;
	BTFSC      PORTA+0, 3
	GOTO       L_menuMain80
	GOTO       L_menuMain44
L_menuMain80:
;MainMenu.c,331 :: 		}
L_menuMain78:
;MainMenu.c,332 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_menuMain81:
	DECFSZ     R13+0, 1
	GOTO       L_menuMain81
	DECFSZ     R12+0, 1
	GOTO       L_menuMain81
	DECFSZ     R11+0, 1
	GOTO       L_menuMain81
	NOP
;MainMenu.c,333 :: 		}
	GOTO       L_menuMain43
L_menuMain44:
;MainMenu.c,335 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,336 :: 		set = 0;
	CLRF       _set+0
;MainMenu.c,337 :: 		set_count = 0;
	CLRF       _set_count+0
;MainMenu.c,338 :: 		loopcount = 0;
	CLRF       _loopcount+0
	CLRF       _loopcount+1
;MainMenu.c,339 :: 		}
L_end_menuMain:
	RETURN
; end of _menuMain

_main:

;MainMenu.c,342 :: 		void main()
;MainMenu.c,344 :: 		I2C1_Init(100000); //DS1307 I2C is running at 100KHz
	MOVLW      20
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;MainMenu.c,345 :: 		CMCON = 0x07;   // To turn off comparators
	MOVLW      7
	MOVWF      CMCON+0
;MainMenu.c,346 :: 		ADCON1 = 0x06;  // To turn off analog to digital converters
	MOVLW      6
	MOVWF      ADCON1+0
;MainMenu.c,347 :: 		TRISA = 0xFF;   //Port A Set output
	MOVLW      255
	MOVWF      TRISA+0
;MainMenu.c,348 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MainMenu.c,350 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;MainMenu.c,351 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,352 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MainMenu.c,355 :: 		while(1)                                   //*********************Main Loop *****************************
L_main82:
;MainMenu.c,357 :: 		Lcd_out(1,1,"Initial New");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr31_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,358 :: 		Lcd_out(2,1,"Second New");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr32_MainMenu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MainMenu.c,359 :: 		set = 0;
	CLRF       _set+0
;MainMenu.c,361 :: 		if(PORTA.F3 == 0)              //Menu Pressed
	BTFSC      PORTA+0, 3
	GOTO       L_main84
;MainMenu.c,363 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main85:
	DECFSZ     R13+0, 1
	GOTO       L_main85
	DECFSZ     R12+0, 1
	GOTO       L_main85
	DECFSZ     R11+0, 1
	GOTO       L_main85
	NOP
;MainMenu.c,364 :: 		if(PORTA.F3 == 0)
	BTFSC      PORTA+0, 3
	GOTO       L_main86
;MainMenu.c,366 :: 		menuMain();
	CALL       _menuMain+0
;MainMenu.c,367 :: 		}
L_main86:
;MainMenu.c,368 :: 		}
L_main84:
;MainMenu.c,370 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main87:
	DECFSZ     R13+0, 1
	GOTO       L_main87
	DECFSZ     R12+0, 1
	GOTO       L_main87
	DECFSZ     R11+0, 1
	GOTO       L_main87
	NOP
;MainMenu.c,371 :: 		}
	GOTO       L_main82
;MainMenu.c,372 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
