
_BCD2UpperCh:

;AlarmClock-Aba.c,113 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;AlarmClock-Aba.c,115 :: 		return ((bcd >> 4) + '0');
	MOVF        FARG_BCD2UpperCh_bcd+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       48
	ADDWF       R0, 1 
;AlarmClock-Aba.c,116 :: 		}
L_end_BCD2UpperCh:
	RETURN      0
; end of _BCD2UpperCh

_BCD2LowerCh:

;AlarmClock-Aba.c,118 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;AlarmClock-Aba.c,120 :: 		return ((bcd & 0x0F) + '0');
	MOVLW       15
	ANDWF       FARG_BCD2LowerCh_bcd+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
;AlarmClock-Aba.c,121 :: 		}
L_end_BCD2LowerCh:
	RETURN      0
; end of _BCD2LowerCh

_Binary2BCD:

;AlarmClock-Aba.c,123 :: 		int Binary2BCD(int a)
;AlarmClock-Aba.c,126 :: 		t1 = a%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Binary2BCD_a+0, 0 
	MOVWF       R0 
	MOVF        FARG_Binary2BCD_a+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;AlarmClock-Aba.c,127 :: 		t1 = t1 & 0x0F;
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       FLOC__Binary2BCD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Binary2BCD+1 
	MOVLW       0
	ANDWF       FLOC__Binary2BCD+1, 1 
;AlarmClock-Aba.c,128 :: 		a = a/10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Binary2BCD_a+0, 0 
	MOVWF       R0 
	MOVF        FARG_Binary2BCD_a+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
;AlarmClock-Aba.c,129 :: 		t2 = a%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;AlarmClock-Aba.c,130 :: 		t2 = 0x0F & t2;
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
;AlarmClock-Aba.c,131 :: 		t2 = t2 << 4;
	MOVLW       4
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__Binary2BCD339:
	BZ          L__Binary2BCD340
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Binary2BCD339
L__Binary2BCD340:
;AlarmClock-Aba.c,132 :: 		t2 = 0xF0 & t2;
	MOVLW       240
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
;AlarmClock-Aba.c,133 :: 		t1 = t1 | t2;
	MOVF        FLOC__Binary2BCD+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__Binary2BCD+1, 0 
	IORWF       R1, 1 
;AlarmClock-Aba.c,134 :: 		return t1;
;AlarmClock-Aba.c,135 :: 		}
L_end_Binary2BCD:
	RETURN      0
; end of _Binary2BCD

_BCD2Binary:

;AlarmClock-Aba.c,137 :: 		int BCD2Binary(int a)
;AlarmClock-Aba.c,140 :: 		t = a & 0x0F;
	MOVLW       15
	ANDWF       FARG_BCD2Binary_a+0, 0 
	MOVWF       FLOC__BCD2Binary+0 
	MOVF        FARG_BCD2Binary_a+1, 0 
	MOVWF       FLOC__BCD2Binary+1 
	MOVLW       0
	ANDWF       FLOC__BCD2Binary+1, 1 
;AlarmClock-Aba.c,142 :: 		a = 0xF0 & a;
	MOVLW       240
	ANDWF       FARG_BCD2Binary_a+0, 0 
	MOVWF       R3 
	MOVF        FARG_BCD2Binary_a+1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVF        R4, 0 
	MOVWF       FARG_BCD2Binary_a+1 
;AlarmClock-Aba.c,143 :: 		t = a >> 4;
	MOVLW       4
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__BCD2Binary342:
	BZ          L__BCD2Binary343
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__BCD2Binary342
L__BCD2Binary343:
;AlarmClock-Aba.c,144 :: 		t = 0x0F & t;
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
;AlarmClock-Aba.c,145 :: 		r = t*10 + r;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__BCD2Binary+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BCD2Binary+1, 0 
	ADDWFC      R1, 1 
;AlarmClock-Aba.c,146 :: 		return r;
;AlarmClock-Aba.c,147 :: 		}
L_end_BCD2Binary:
	RETURN      0
; end of _BCD2Binary

_time2Str:

;AlarmClock-Aba.c,162 :: 		void time2Str(int temp)            //Mode {0-for permanent memory. If not temp memory
;AlarmClock-Aba.c,164 :: 		if (temp)
	MOVF        FARG_time2Str_temp+0, 0 
	IORWF       FARG_time2Str_temp+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str0
;AlarmClock-Aba.c,166 :: 		time[0] = BCD2UpperCh(Binary2BCD(hrbin2));
	MOVF        _hrbin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        _hrbin2+1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
;AlarmClock-Aba.c,167 :: 		time[1] = BCD2LowerCh(Binary2BCD(hrbin2));
	MOVF        _hrbin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        _hrbin2+1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+1 
;AlarmClock-Aba.c,168 :: 		time[3] = BCD2UpperCh(Binary2BCD(minutebin2));
	MOVF        _minutebin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        _minutebin2+1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+3 
;AlarmClock-Aba.c,169 :: 		time[4] = BCD2LowerCh(Binary2BCD(minutebin2));
	MOVF        _minutebin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        _minutebin2+1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+4 
;AlarmClock-Aba.c,170 :: 		time[6] = BCD2UpperCh(Binary2BCD(secondbin2));
	MOVF        _secondbin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+6 
;AlarmClock-Aba.c,171 :: 		time[7] = BCD2LowerCh(Binary2BCD(secondbin2));
	MOVF        _secondbin2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+7 
;AlarmClock-Aba.c,173 :: 		if(ap2)
	MOVF        _ap2+0, 0 
	IORWF       _ap2+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str1
;AlarmClock-Aba.c,175 :: 		time[9] = 'P';
	MOVLW       80
	MOVWF       _time+9 
;AlarmClock-Aba.c,176 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;AlarmClock-Aba.c,177 :: 		}
	GOTO        L_time2Str2
L_time2Str1:
;AlarmClock-Aba.c,180 :: 		time[9] = 'A';
	MOVLW       65
	MOVWF       _time+9 
;AlarmClock-Aba.c,181 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;AlarmClock-Aba.c,182 :: 		}
L_time2Str2:
;AlarmClock-Aba.c,183 :: 		}
	GOTO        L_time2Str3
L_time2Str0:
;AlarmClock-Aba.c,186 :: 		time[0] = BCD2UpperCh(Binary2BCD(hrbin));
	MOVF        _hrbin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
;AlarmClock-Aba.c,187 :: 		time[1] = BCD2LowerCh(Binary2BCD(hrbin));
	MOVF        _hrbin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+1 
;AlarmClock-Aba.c,188 :: 		time[3] = BCD2UpperCh(Binary2BCD(minutebin));
	MOVF        _minutebin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+3 
;AlarmClock-Aba.c,189 :: 		time[4] = BCD2LowerCh(Binary2BCD(minutebin));
	MOVF        _minutebin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+4 
;AlarmClock-Aba.c,190 :: 		time[6] = BCD2UpperCh(Binary2BCD(secondbin));
	MOVF        _secondbin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+6 
;AlarmClock-Aba.c,191 :: 		time[7] = BCD2LowerCh(Binary2BCD(secondbin));
	MOVF        _secondbin+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+7 
;AlarmClock-Aba.c,193 :: 		if(ap)
	MOVF        _ap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str4
;AlarmClock-Aba.c,195 :: 		time[9] = 'P';
	MOVLW       80
	MOVWF       _time+9 
;AlarmClock-Aba.c,196 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;AlarmClock-Aba.c,197 :: 		}
	GOTO        L_time2Str5
L_time2Str4:
;AlarmClock-Aba.c,200 :: 		time[9] = 'A';
	MOVLW       65
	MOVWF       _time+9 
;AlarmClock-Aba.c,201 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;AlarmClock-Aba.c,202 :: 		}
L_time2Str5:
;AlarmClock-Aba.c,203 :: 		}
L_time2Str3:
;AlarmClock-Aba.c,204 :: 		}
L_end_time2Str:
	RETURN      0
; end of _time2Str

_date2Str:

;AlarmClock-Aba.c,206 :: 		void date2Str()
;AlarmClock-Aba.c,208 :: 		datestr[0] = BCD2UpperCh(Binary2BCD(date));
	MOVF        _date+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+0 
;AlarmClock-Aba.c,209 :: 		datestr[1] = BCD2LowerCh(Binary2BCD(date));
	MOVF        _date+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+1 
;AlarmClock-Aba.c,210 :: 		datestr[3] = BCD2UpperCh(Binary2BCD(month));
	MOVF        _month+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+3 
;AlarmClock-Aba.c,211 :: 		datestr[4] = BCD2LowerCh(Binary2BCD(month));
	MOVF        _month+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+4 
;AlarmClock-Aba.c,212 :: 		datestr[6] = BCD2UpperCh(Binary2BCD(year));
	MOVF        _year+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+6 
;AlarmClock-Aba.c,213 :: 		datestr[7] = BCD2LowerCh(Binary2BCD(year));
	MOVF        _year+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _datestr+7 
;AlarmClock-Aba.c,214 :: 		}
L_end_date2Str:
	RETURN      0
; end of _date2Str

_inputTime:

;AlarmClock-Aba.c,216 :: 		void inputTime(int mode, char setStr[])             // Interface for inputting time
;AlarmClock-Aba.c,218 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,219 :: 		Lcd_out(1,1,setStr);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_inputTime_setStr+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_inputTime_setStr+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,220 :: 		Lcd_out(2,1," [Save] [Cancel]");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,222 :: 		if(mode == 0)                                  //Setting time
	MOVLW       0
	XORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime347
	MOVLW       0
	XORWF       FARG_inputTime_mode+0, 0 
L__inputTime347:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime6
;AlarmClock-Aba.c,225 :: 		secondbin2 = secondbin; minutebin2 = minutebin; hrbin2 = hrbin; ap2 = ap;
	MOVF        _secondbin+0, 0 
	MOVWF       _secondbin2+0 
	MOVF        _minutebin+0, 0 
	MOVWF       _minutebin2+0 
	MOVLW       0
	MOVWF       _minutebin2+1 
	MOVF        _hrbin+0, 0 
	MOVWF       _hrbin2+0 
	MOVLW       0
	MOVWF       _hrbin2+1 
	MOVF        _ap+0, 0 
	MOVWF       _ap2+0 
	MOVLW       0
	MOVWF       _ap2+1 
;AlarmClock-Aba.c,226 :: 		}
	GOTO        L_inputTime7
L_inputTime6:
;AlarmClock-Aba.c,229 :: 		secondbin2 = 0; minutebin2 = alarmMinute[mode-1]; hrbin2 = alarmHr[mode-1]; ap2 = alarmAP[mode-1];
	CLRF        _secondbin2+0 
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmMinute+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmMinute+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minutebin2+0 
	MOVLW       0
	BTFSC       _minutebin2+1, 7 
	MOVLW       255
	MOVWF       _minutebin2+1 
	MOVLW       0
	BTFSC       _minutebin2+0, 7 
	MOVLW       255
	MOVWF       _minutebin2+1 
	MOVLW       _alarmHr+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmHr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _hrbin2+0 
	MOVLW       0
	MOVWF       _hrbin2+1 
	MOVLW       0
	MOVWF       _hrbin2+1 
	MOVLW       _alarmAP+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmAP+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _ap2+0 
	MOVLW       0
	MOVWF       _ap2+1 
	MOVLW       0
	MOVWF       _ap2+1 
;AlarmClock-Aba.c,230 :: 		}
L_inputTime7:
;AlarmClock-Aba.c,231 :: 		time2Str(mode);
	MOVF        FARG_inputTime_mode+0, 0 
	MOVWF       FARG_time2Str_temp+0 
	MOVF        FARG_inputTime_mode+1, 0 
	MOVWF       FARG_time2Str_temp+1 
	CALL        _time2Str+0, 0
;AlarmClock-Aba.c,232 :: 		Lcd_out(1,6, time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,234 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,235 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,237 :: 		while(1)
L_inputTime8:
;AlarmClock-Aba.c,241 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,242 :: 		if(PORTA.F0 == 0)                      //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime10
;AlarmClock-Aba.c,244 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime11:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime11
	DECFSZ      R12, 1, 1
	BRA         L_inputTime11
	DECFSZ      R11, 1, 1
	BRA         L_inputTime11
	NOP
;AlarmClock-Aba.c,245 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime12
;AlarmClock-Aba.c,247 :: 		while(PORTA.F0 == 0) {}        //Avoid Overpressing
L_inputTime13:
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime14
	GOTO        L_inputTime13
L_inputTime14:
;AlarmClock-Aba.c,248 :: 		set_count++;
	INCF        _set_count+0, 1 
;AlarmClock-Aba.c,249 :: 		if(mode && (set_count == 3)) set_count++;   //Skip the seconds if mode
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime17
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime17
L__inputTime323:
	INCF        _set_count+0, 1 
L_inputTime17:
;AlarmClock-Aba.c,251 :: 		if(set_count > 5)
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime18
;AlarmClock-Aba.c,253 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;AlarmClock-Aba.c,254 :: 		}
L_inputTime18:
;AlarmClock-Aba.c,255 :: 		}
L_inputTime12:
;AlarmClock-Aba.c,256 :: 		}
L_inputTime10:
;AlarmClock-Aba.c,258 :: 		if((set_count)&& (set_count != 4) && (set_count!= 5))      // Up down pressed outside Save/ Cancel
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime21
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime21
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime21
L__inputTime322:
;AlarmClock-Aba.c,260 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputTime22
;AlarmClock-Aba.c,262 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime23:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime23
	DECFSZ      R12, 1, 1
	BRA         L_inputTime23
	DECFSZ      R11, 1, 1
	BRA         L_inputTime23
	NOP
;AlarmClock-Aba.c,263 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputTime24
;AlarmClock-Aba.c,264 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_inputTime24:
;AlarmClock-Aba.c,265 :: 		}
L_inputTime22:
;AlarmClock-Aba.c,267 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputTime25
;AlarmClock-Aba.c,269 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime26:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime26
	DECFSZ      R12, 1, 1
	BRA         L_inputTime26
	DECFSZ      R11, 1, 1
	BRA         L_inputTime26
	NOP
;AlarmClock-Aba.c,270 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputTime27
;AlarmClock-Aba.c,271 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_inputTime27:
;AlarmClock-Aba.c,272 :: 		}
L_inputTime25:
;AlarmClock-Aba.c,273 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime30
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime30
L__inputTime321:
;AlarmClock-Aba.c,277 :: 		switch(set_count)
	GOTO        L_inputTime31
;AlarmClock-Aba.c,279 :: 		case 1:
L_inputTime33:
;AlarmClock-Aba.c,280 :: 		hrbin2 = hrbin2 + set;
	MOVF        _set+0, 0 
	ADDWF       _hrbin2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _set+0, 7 
	MOVLW       255
	ADDWFC      _hrbin2+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _hrbin2+0 
	MOVF        R2, 0 
	MOVWF       _hrbin2+1 
;AlarmClock-Aba.c,281 :: 		if(hrbin2 > 12)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime348
	MOVF        R1, 0 
	SUBLW       12
L__inputTime348:
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime34
;AlarmClock-Aba.c,282 :: 		{ hrbin2 = 1; ap2 = !ap2;}
	MOVLW       1
	MOVWF       _hrbin2+0 
	MOVLW       0
	MOVWF       _hrbin2+1 
	MOVF        _ap2+0, 0 
	IORWF       _ap2+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _ap2+0 
	MOVLW       0
	MOVWF       _ap2+1 
L_inputTime34:
;AlarmClock-Aba.c,283 :: 		if(hrbin2 < 1)
	MOVLW       128
	XORWF       _hrbin2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime349
	MOVLW       1
	SUBWF       _hrbin2+0, 0 
L__inputTime349:
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime35
;AlarmClock-Aba.c,284 :: 		{ hrbin2 = 12; ap2 = !ap2;}
	MOVLW       12
	MOVWF       _hrbin2+0 
	MOVLW       0
	MOVWF       _hrbin2+1 
	MOVF        _ap2+0, 0 
	IORWF       _ap2+1, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _ap2+0 
	MOVLW       0
	MOVWF       _ap2+1 
L_inputTime35:
;AlarmClock-Aba.c,285 :: 		break;
	GOTO        L_inputTime32
;AlarmClock-Aba.c,286 :: 		case 2:
L_inputTime36:
;AlarmClock-Aba.c,287 :: 		minutebin2 = minutebin2 + set;
	MOVF        _set+0, 0 
	ADDWF       _minutebin2+0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _set+0, 7 
	MOVLW       255
	ADDWFC      _minutebin2+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _minutebin2+0 
	MOVF        R2, 0 
	MOVWF       _minutebin2+1 
;AlarmClock-Aba.c,288 :: 		if(minutebin2 >= 60)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime350
	MOVLW       60
	SUBWF       R1, 0 
L__inputTime350:
	BTFSS       STATUS+0, 0 
	GOTO        L_inputTime37
;AlarmClock-Aba.c,289 :: 		minutebin2 = 0;
	CLRF        _minutebin2+0 
	CLRF        _minutebin2+1 
L_inputTime37:
;AlarmClock-Aba.c,290 :: 		if(minutebin2 < 0)
	MOVLW       128
	XORWF       _minutebin2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime351
	MOVLW       0
	SUBWF       _minutebin2+0, 0 
L__inputTime351:
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime38
;AlarmClock-Aba.c,291 :: 		minutebin2 = 59;
	MOVLW       59
	MOVWF       _minutebin2+0 
	MOVLW       0
	MOVWF       _minutebin2+1 
L_inputTime38:
;AlarmClock-Aba.c,292 :: 		break;
	GOTO        L_inputTime32
;AlarmClock-Aba.c,293 :: 		case 3:
L_inputTime39:
;AlarmClock-Aba.c,294 :: 		if((!mode)&& abs(set))
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime42
	MOVF        _set+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVLW       0
	BTFSC       _set+0, 7 
	MOVLW       255
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime42
L__inputTime320:
;AlarmClock-Aba.c,297 :: 		secondbin = 0;
	CLRF        _secondbin+0 
;AlarmClock-Aba.c,298 :: 		Lcd_out(1,12, "00");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,299 :: 		}
L_inputTime42:
;AlarmClock-Aba.c,300 :: 		break;
	GOTO        L_inputTime32
;AlarmClock-Aba.c,301 :: 		}
L_inputTime31:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime33
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime36
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime39
L_inputTime32:
;AlarmClock-Aba.c,303 :: 		}
L_inputTime30:
;AlarmClock-Aba.c,304 :: 		}
L_inputTime21:
;AlarmClock-Aba.c,305 :: 		time2Str(1);
	MOVLW       1
	MOVWF       FARG_time2Str_temp+0 
	MOVLW       0
	MOVWF       FARG_time2Str_temp+1 
	CALL        _time2Str+0, 0
;AlarmClock-Aba.c,308 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;AlarmClock-Aba.c,309 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime43
	CLRF        _loopcount+0 
L_inputTime43:
;AlarmClock-Aba.c,310 :: 		if(loopcount < 5)                 //Full display for 0.5s
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime44
;AlarmClock-Aba.c,312 :: 		Lcd_out(1,6, time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,313 :: 		Lcd_out(2,3, "Save");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,314 :: 		Lcd_out(2,10, "Cancel");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,315 :: 		}
	GOTO        L_inputTime45
L_inputTime44:
;AlarmClock-Aba.c,318 :: 		if (set_count  ==1) Lcd_out(1,6, "__");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime46
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime47
L_inputTime46:
;AlarmClock-Aba.c,319 :: 		else if (set_count  ==2) Lcd_out(1,9, "__");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime48
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime49
L_inputTime48:
;AlarmClock-Aba.c,320 :: 		else if (set_count  ==3) Lcd_out(1,12, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime50
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime51
L_inputTime50:
;AlarmClock-Aba.c,321 :: 		else if (set_count == 4) Lcd_out(2,3, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime52
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime53
L_inputTime52:
;AlarmClock-Aba.c,322 :: 		else if (set_count  ==5) Lcd_out(2,10, "______");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime54
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_inputTime54:
L_inputTime53:
L_inputTime51:
L_inputTime49:
L_inputTime47:
;AlarmClock-Aba.c,323 :: 		}
L_inputTime45:
;AlarmClock-Aba.c,326 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime55:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime55
	DECFSZ      R12, 1, 1
	BRA         L_inputTime55
	DECFSZ      R11, 1, 1
	BRA         L_inputTime55
	NOP
;AlarmClock-Aba.c,328 :: 		if(PORTA.F4 == 0)                        // OK pressed
	BTFSC       PORTA+0, 4 
	GOTO        L_inputTime56
;AlarmClock-Aba.c,330 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime57:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime57
	DECFSZ      R12, 1, 1
	BRA         L_inputTime57
	DECFSZ      R11, 1, 1
	BRA         L_inputTime57
	NOP
;AlarmClock-Aba.c,331 :: 		if(PORTA.F4 == 0)
	BTFSC       PORTA+0, 4 
	GOTO        L_inputTime58
;AlarmClock-Aba.c,333 :: 		if(set_count == 4)              //if Save is pressed
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime59
;AlarmClock-Aba.c,335 :: 		if(!mode)                    //Write to RTC
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime60
;AlarmClock-Aba.c,339 :: 		minutebin = minutebin2;
	MOVF        _minutebin2+0, 0 
	MOVWF       _minutebin+0 
;AlarmClock-Aba.c,340 :: 		hrbin = hrbin2;
	MOVF        _hrbin2+0, 0 
	MOVWF       _hrbin+0 
;AlarmClock-Aba.c,342 :: 		break;
	GOTO        L_inputTime9
;AlarmClock-Aba.c,343 :: 		}
L_inputTime60:
;AlarmClock-Aba.c,346 :: 		alarmHr[mode-1] = hrbin2;
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmHr+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_alarmHr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _hrbin2+0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,347 :: 		alarmMinute[mode-1] = minutebin2;
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmMinute+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_alarmMinute+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _minutebin2+0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,348 :: 		break;
	GOTO        L_inputTime9
;AlarmClock-Aba.c,350 :: 		}
L_inputTime59:
;AlarmClock-Aba.c,352 :: 		if(set_count == 5) break;
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime62
	GOTO        L_inputTime9
L_inputTime62:
;AlarmClock-Aba.c,353 :: 		}
L_inputTime58:
;AlarmClock-Aba.c,354 :: 		}
L_inputTime56:
;AlarmClock-Aba.c,355 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_inputTime63
;AlarmClock-Aba.c,357 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime64:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime64
	DECFSZ      R12, 1, 1
	BRA         L_inputTime64
	DECFSZ      R11, 1, 1
	BRA         L_inputTime64
	NOP
;AlarmClock-Aba.c,358 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_inputTime65
;AlarmClock-Aba.c,360 :: 		while(PORTA.F0 == 0) {}
L_inputTime66:
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime67
	GOTO        L_inputTime66
L_inputTime67:
;AlarmClock-Aba.c,361 :: 		break;
	GOTO        L_inputTime9
;AlarmClock-Aba.c,362 :: 		}
L_inputTime65:
;AlarmClock-Aba.c,363 :: 		}
L_inputTime63:
;AlarmClock-Aba.c,365 :: 		if(goBackAlarm) break;            //Break if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime68
	GOTO        L_inputTime9
L_inputTime68:
;AlarmClock-Aba.c,366 :: 		}
	GOTO        L_inputTime8
L_inputTime9:
;AlarmClock-Aba.c,368 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,369 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,370 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,371 :: 		hrbin2 = 0;
	CLRF        _hrbin2+0 
	CLRF        _hrbin2+1 
;AlarmClock-Aba.c,372 :: 		minutebin2 = 0;
	CLRF        _minutebin2+0 
	CLRF        _minutebin2+1 
;AlarmClock-Aba.c,374 :: 		}
L_end_inputTime:
	RETURN      0
; end of _inputTime

_inputDate:

;AlarmClock-Aba.c,376 :: 		void inputDate()                      // Interface for input & write Date
;AlarmClock-Aba.c,378 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,379 :: 		Lcd_out(1,1,"Date:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,380 :: 		Lcd_out(1,6, datestr);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _datestr+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_datestr+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,381 :: 		Lcd_out(2,1," [Save] [Cancel]");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,383 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,384 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,386 :: 		while(1)
L_inputDate69:
;AlarmClock-Aba.c,389 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,390 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate71
;AlarmClock-Aba.c,392 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate72:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate72
	DECFSZ      R12, 1, 1
	BRA         L_inputDate72
	DECFSZ      R11, 1, 1
	BRA         L_inputDate72
	NOP
;AlarmClock-Aba.c,393 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate73
;AlarmClock-Aba.c,395 :: 		while(PORTA.F0 == 0) {}
L_inputDate74:
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate75
	GOTO        L_inputDate74
L_inputDate75:
;AlarmClock-Aba.c,397 :: 		set_count++;
	INCF        _set_count+0, 1 
;AlarmClock-Aba.c,398 :: 		if(set_count > 5)
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate76
;AlarmClock-Aba.c,400 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;AlarmClock-Aba.c,401 :: 		}
L_inputDate76:
;AlarmClock-Aba.c,402 :: 		}
L_inputDate73:
;AlarmClock-Aba.c,403 :: 		}
L_inputDate71:
;AlarmClock-Aba.c,405 :: 		if(set_count && (set_count != 4) && set_count != 5)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate79
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate79
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate79
L__inputDate327:
;AlarmClock-Aba.c,407 :: 		if(PORTA.F1 == 0)            //Up Down pressed
	BTFSC       PORTA+0, 1 
	GOTO        L_inputDate80
;AlarmClock-Aba.c,409 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate81:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate81
	DECFSZ      R12, 1, 1
	BRA         L_inputDate81
	DECFSZ      R11, 1, 1
	BRA         L_inputDate81
	NOP
;AlarmClock-Aba.c,410 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputDate82
;AlarmClock-Aba.c,411 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_inputDate82:
;AlarmClock-Aba.c,412 :: 		}
L_inputDate80:
;AlarmClock-Aba.c,414 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputDate83
;AlarmClock-Aba.c,416 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate84:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate84
	DECFSZ      R12, 1, 1
	BRA         L_inputDate84
	DECFSZ      R11, 1, 1
	BRA         L_inputDate84
	NOP
;AlarmClock-Aba.c,417 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputDate85
;AlarmClock-Aba.c,418 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_inputDate85:
;AlarmClock-Aba.c,419 :: 		}
L_inputDate83:
;AlarmClock-Aba.c,420 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate88
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate88
L__inputDate326:
;AlarmClock-Aba.c,422 :: 		switch(set_count)
	GOTO        L_inputDate89
;AlarmClock-Aba.c,424 :: 		case 3:
L_inputDate91:
;AlarmClock-Aba.c,425 :: 		date = date + set;
	MOVF        _set+0, 0 
	ADDWF       _date+0, 1 
;AlarmClock-Aba.c,427 :: 		if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) // 31 Days
	MOVF        _month+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	MOVF        _month+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate325
	GOTO        L_inputDate94
L__inputDate325:
;AlarmClock-Aba.c,429 :: 		if (date > 31) date =1;
	MOVF        _date+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate95
	MOVLW       1
	MOVWF       _date+0 
L_inputDate95:
;AlarmClock-Aba.c,430 :: 		if (date < 1) date = 31;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate96
	MOVLW       31
	MOVWF       _date+0 
L_inputDate96:
;AlarmClock-Aba.c,431 :: 		}
L_inputDate94:
;AlarmClock-Aba.c,432 :: 		if(month == 4 || month == 6 || month == 9 || month == 11) // 30 Days
	MOVF        _month+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate324
	MOVF        _month+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate324
	MOVF        _month+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate324
	MOVF        _month+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate324
	GOTO        L_inputDate99
L__inputDate324:
;AlarmClock-Aba.c,434 :: 		if (date > 30) date =1;
	MOVF        _date+0, 0 
	SUBLW       30
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate100
	MOVLW       1
	MOVWF       _date+0 
L_inputDate100:
;AlarmClock-Aba.c,435 :: 		if (date < 1) date = 30;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate101
	MOVLW       30
	MOVWF       _date+0 
L_inputDate101:
;AlarmClock-Aba.c,436 :: 		}
L_inputDate99:
;AlarmClock-Aba.c,437 :: 		if(month == 2) // February
	MOVF        _month+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate102
;AlarmClock-Aba.c,439 :: 		if(year % 100 == 0)                                          // If Divisible by 100
	MOVLW       100
	MOVWF       R4 
	MOVF        _year+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate103
;AlarmClock-Aba.c,441 :: 		if(year % 400 == 0) //Leap Year
	MOVLW       144
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	MOVF        _year+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputDate353
	MOVLW       0
	XORWF       R0, 0 
L__inputDate353:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate104
;AlarmClock-Aba.c,443 :: 		if (date > 29) date =1;
	MOVF        _date+0, 0 
	SUBLW       29
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate105
	MOVLW       1
	MOVWF       _date+0 
L_inputDate105:
;AlarmClock-Aba.c,444 :: 		if (date < 1) date = 29;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate106
	MOVLW       29
	MOVWF       _date+0 
L_inputDate106:
;AlarmClock-Aba.c,445 :: 		}
	GOTO        L_inputDate107
L_inputDate104:
;AlarmClock-Aba.c,448 :: 		if (date > 28) date =1;
	MOVF        _date+0, 0 
	SUBLW       28
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate108
	MOVLW       1
	MOVWF       _date+0 
L_inputDate108:
;AlarmClock-Aba.c,449 :: 		if (date < 1) date = 28;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate109
	MOVLW       28
	MOVWF       _date+0 
L_inputDate109:
;AlarmClock-Aba.c,450 :: 		}
L_inputDate107:
;AlarmClock-Aba.c,451 :: 		}
	GOTO        L_inputDate110
L_inputDate103:
;AlarmClock-Aba.c,454 :: 		if(year % 4 == 0) //Leap Year
	MOVLW       3
	ANDWF       _year+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate111
;AlarmClock-Aba.c,456 :: 		if (date > 29) date =1;
	MOVF        _date+0, 0 
	SUBLW       29
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate112
	MOVLW       1
	MOVWF       _date+0 
L_inputDate112:
;AlarmClock-Aba.c,457 :: 		if (date < 1) date = 29;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate113
	MOVLW       29
	MOVWF       _date+0 
L_inputDate113:
;AlarmClock-Aba.c,458 :: 		}
	GOTO        L_inputDate114
L_inputDate111:
;AlarmClock-Aba.c,461 :: 		if (date > 28) date =1;
	MOVF        _date+0, 0 
	SUBLW       28
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate115
	MOVLW       1
	MOVWF       _date+0 
L_inputDate115:
;AlarmClock-Aba.c,462 :: 		if (date < 1) date = 28;
	MOVLW       1
	SUBWF       _date+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate116
	MOVLW       28
	MOVWF       _date+0 
L_inputDate116:
;AlarmClock-Aba.c,463 :: 		}
L_inputDate114:
;AlarmClock-Aba.c,464 :: 		}
L_inputDate110:
;AlarmClock-Aba.c,465 :: 		}
L_inputDate102:
;AlarmClock-Aba.c,467 :: 		break;
	GOTO        L_inputDate90
;AlarmClock-Aba.c,469 :: 		case 2:
L_inputDate117:
;AlarmClock-Aba.c,470 :: 		month = month + set;
	MOVF        _set+0, 0 
	ADDWF       _month+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _month+0 
;AlarmClock-Aba.c,471 :: 		if(month > 12)
	MOVF        R1, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate118
;AlarmClock-Aba.c,472 :: 		month = 1;
	MOVLW       1
	MOVWF       _month+0 
L_inputDate118:
;AlarmClock-Aba.c,473 :: 		if(month <= 0)
	MOVF        _month+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate119
;AlarmClock-Aba.c,474 :: 		month = 12;
	MOVLW       12
	MOVWF       _month+0 
L_inputDate119:
;AlarmClock-Aba.c,475 :: 		break;
	GOTO        L_inputDate90
;AlarmClock-Aba.c,476 :: 		case 1:
L_inputDate120:
;AlarmClock-Aba.c,477 :: 		year = year + set;
	MOVF        _set+0, 0 
	ADDWF       _year+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _year+0 
;AlarmClock-Aba.c,478 :: 		if(year <= -1)
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputDate354
	MOVF        R1, 0 
	SUBLW       255
L__inputDate354:
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate121
;AlarmClock-Aba.c,479 :: 		year = 99;
	MOVLW       99
	MOVWF       _year+0 
L_inputDate121:
;AlarmClock-Aba.c,480 :: 		if(year >= 100)
	MOVLW       100
	SUBWF       _year+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate122
;AlarmClock-Aba.c,481 :: 		year = 0;
	CLRF        _year+0 
L_inputDate122:
;AlarmClock-Aba.c,482 :: 		break;
	GOTO        L_inputDate90
;AlarmClock-Aba.c,483 :: 		}
L_inputDate89:
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate91
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate117
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate120
L_inputDate90:
;AlarmClock-Aba.c,485 :: 		}
L_inputDate88:
;AlarmClock-Aba.c,486 :: 		}
L_inputDate79:
;AlarmClock-Aba.c,487 :: 		date2Str();
	CALL        _date2Str+0, 0
;AlarmClock-Aba.c,490 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;AlarmClock-Aba.c,491 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate123
	CLRF        _loopcount+0 
L_inputDate123:
;AlarmClock-Aba.c,492 :: 		if(loopcount < 5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate124
;AlarmClock-Aba.c,494 :: 		Lcd_out(1,6, date);     //Show full date for 1s
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _date+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,495 :: 		Lcd_out(2,3, "Save");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,496 :: 		Lcd_out(2,10, "Cancel");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,497 :: 		}
	GOTO        L_inputDate125
L_inputDate124:
;AlarmClock-Aba.c,500 :: 		if (set_count  ==1) Lcd_out(1,12, "__");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate126
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate127
L_inputDate126:
;AlarmClock-Aba.c,501 :: 		else if (set_count  ==2) Lcd_out(1,9, "__");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate128
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate129
L_inputDate128:
;AlarmClock-Aba.c,502 :: 		else if (set_count  ==3) Lcd_out(1,6, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate130
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate131
L_inputDate130:
;AlarmClock-Aba.c,503 :: 		else if (set_count == 4) Lcd_out(2,3, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate132
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate133
L_inputDate132:
;AlarmClock-Aba.c,504 :: 		else if (set_count  ==5) Lcd_out(2,10, "______");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate134
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_inputDate134:
L_inputDate133:
L_inputDate131:
L_inputDate129:
L_inputDate127:
;AlarmClock-Aba.c,505 :: 		}
L_inputDate125:
;AlarmClock-Aba.c,508 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate135:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate135
	DECFSZ      R12, 1, 1
	BRA         L_inputDate135
	DECFSZ      R11, 1, 1
	BRA         L_inputDate135
	NOP
;AlarmClock-Aba.c,510 :: 		if(PORTA.F4 == 0)                         // When OK pressed upon Save/ Cance
	BTFSC       PORTA+0, 4 
	GOTO        L_inputDate136
;AlarmClock-Aba.c,512 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate137:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate137
	DECFSZ      R12, 1, 1
	BRA         L_inputDate137
	DECFSZ      R11, 1, 1
	BRA         L_inputDate137
	NOP
;AlarmClock-Aba.c,513 :: 		if(PORTA.F4 == 0)
	BTFSC       PORTA+0, 4 
	GOTO        L_inputDate138
;AlarmClock-Aba.c,515 :: 		if(set_count == 4 )             //Write to RTC, if Save is pressed
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate139
;AlarmClock-Aba.c,520 :: 		}
L_inputDate139:
;AlarmClock-Aba.c,521 :: 		break;
	GOTO        L_inputDate70
;AlarmClock-Aba.c,524 :: 		}
L_inputDate138:
;AlarmClock-Aba.c,525 :: 		}
L_inputDate136:
;AlarmClock-Aba.c,526 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_inputDate141
;AlarmClock-Aba.c,528 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate142:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate142
	DECFSZ      R12, 1, 1
	BRA         L_inputDate142
	DECFSZ      R11, 1, 1
	BRA         L_inputDate142
	NOP
;AlarmClock-Aba.c,529 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_inputDate143
;AlarmClock-Aba.c,531 :: 		while(PORTA.F0 == 0) {}
L_inputDate144:
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate145
	GOTO        L_inputDate144
L_inputDate145:
;AlarmClock-Aba.c,532 :: 		break;
	GOTO        L_inputDate70
;AlarmClock-Aba.c,533 :: 		}
L_inputDate143:
;AlarmClock-Aba.c,534 :: 		}
L_inputDate141:
;AlarmClock-Aba.c,536 :: 		if(goBackAlarm) break;                  //Break if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate146
	GOTO        L_inputDate70
L_inputDate146:
;AlarmClock-Aba.c,537 :: 		}
	GOTO        L_inputDate69
L_inputDate70:
;AlarmClock-Aba.c,539 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,540 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,541 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,543 :: 		}
L_end_inputDate:
	RETURN      0
; end of _inputDate

_populateAlarm:

;AlarmClock-Aba.c,546 :: 		void populateAlarm(int alarmNo)
;AlarmClock-Aba.c,548 :: 		switch(alarmNo)  //Add the alarm's number in LCD
	GOTO        L_populateAlarm147
;AlarmClock-Aba.c,550 :: 		case 1:
L_populateAlarm149:
;AlarmClock-Aba.c,551 :: 		menuAlarmText[0][6] = '1';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       49
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,552 :: 		break;
	GOTO        L_populateAlarm148
;AlarmClock-Aba.c,553 :: 		case 2:
L_populateAlarm150:
;AlarmClock-Aba.c,554 :: 		menuAlarmText[0][6] = '2';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       50
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,555 :: 		break;
	GOTO        L_populateAlarm148
;AlarmClock-Aba.c,556 :: 		case 3:
L_populateAlarm151:
;AlarmClock-Aba.c,557 :: 		menuAlarmText[0][6] = '3';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       51
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,558 :: 		break;
	GOTO        L_populateAlarm148
;AlarmClock-Aba.c,559 :: 		}
L_populateAlarm147:
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm356
	MOVLW       1
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm356:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm149
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm357
	MOVLW       2
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm357:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm150
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm358
	MOVLW       3
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm358:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm151
L_populateAlarm148:
;AlarmClock-Aba.c,561 :: 		if(alarmStatus[alarmNo-1]) //ON
	MOVLW       1
	SUBWF       FARG_populateAlarm_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_populateAlarm_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmStatus+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmStatus+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm152
;AlarmClock-Aba.c,563 :: 		menuAlarmText[0][9] = 'N';
	MOVLW       9
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       78
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,564 :: 		menuAlarmText[0][10] = ' ';
	MOVLW       10
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,565 :: 		}
	GOTO        L_populateAlarm153
L_populateAlarm152:
;AlarmClock-Aba.c,568 :: 		menuAlarmText[0][9] = 'F';
	MOVLW       9
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       70
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,569 :: 		menuAlarmText[0][10] = 'F';
	MOVLW       10
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       70
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,570 :: 		}
L_populateAlarm153:
;AlarmClock-Aba.c,572 :: 		menuAlarmText[1][15] = BCD2LowerCh(Binary2BCD(alarmTunes[alarmNo-1]));
	MOVLW       15
	ADDWF       _menuAlarmText+2, 0 
	MOVWF       FLOC__populateAlarm+0 
	MOVLW       0
	ADDWFC      _menuAlarmText+3, 0 
	MOVWF       FLOC__populateAlarm+1 
	MOVLW       1
	SUBWF       FARG_populateAlarm_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_populateAlarm_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmTunes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmTunes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+1, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVFF       FLOC__populateAlarm+0, FSR1
	MOVFF       FLOC__populateAlarm+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,575 :: 		menuAlarmText[1][7] = BCD2UpperCh(Binary2BCD(snoozeTimes[alarmNo-1]));
	MOVLW       7
	ADDWF       _menuAlarmText+2, 0 
	MOVWF       FLOC__populateAlarm+0 
	MOVLW       0
	ADDWFC      _menuAlarmText+3, 0 
	MOVWF       FLOC__populateAlarm+1 
	MOVLW       1
	SUBWF       FARG_populateAlarm_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_populateAlarm_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+1, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVFF       FLOC__populateAlarm+0, FSR1
	MOVFF       FLOC__populateAlarm+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,576 :: 		menuAlarmText[1][8] = BCD2LowerCh(Binary2BCD(snoozeTimes[alarmNo-1]));
	MOVLW       8
	ADDWF       _menuAlarmText+2, 0 
	MOVWF       FLOC__populateAlarm+0 
	MOVLW       0
	ADDWFC      _menuAlarmText+3, 0 
	MOVWF       FLOC__populateAlarm+1 
	MOVLW       1
	SUBWF       FARG_populateAlarm_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_populateAlarm_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+1, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	MOVLW       0
	BTFSC       FARG_Binary2BCD_a+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVFF       FLOC__populateAlarm+0, FSR1
	MOVFF       FLOC__populateAlarm+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,579 :: 		Lcd_out(1,1, menuAlarmText[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,580 :: 		Lcd_out(2,1, menuAlarmText[1]);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+2, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+3, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,581 :: 		}
L_end_populateAlarm:
	RETURN      0
; end of _populateAlarm

_menuAlarm2:

;AlarmClock-Aba.c,585 :: 		void menuAlarm2(int alarmNo)//****************************** ALARM MENU
;AlarmClock-Aba.c,591 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,592 :: 		populateAlarm(alarmNo);
	MOVF        FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       FARG_populateAlarm_alarmNo+0 
	MOVF        FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       FARG_populateAlarm_alarmNo+1 
	CALL        _populateAlarm+0, 0
;AlarmClock-Aba.c,594 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,595 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,597 :: 		while(1)
L_menuAlarm2154:
;AlarmClock-Aba.c,601 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,602 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_menuAlarm2156
;AlarmClock-Aba.c,604 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2157:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2157
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2157
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2157
	NOP
;AlarmClock-Aba.c,605 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_menuAlarm2158
;AlarmClock-Aba.c,607 :: 		while(PORTA.F0 == 0) {}         //To avoid overpressing
L_menuAlarm2159:
	BTFSC       PORTA+0, 0 
	GOTO        L_menuAlarm2160
	GOTO        L_menuAlarm2159
L_menuAlarm2160:
;AlarmClock-Aba.c,608 :: 		set_count++;
	INCF        _set_count+0, 1 
;AlarmClock-Aba.c,609 :: 		if(set_count > 4)
	MOVF        _set_count+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2161
;AlarmClock-Aba.c,611 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;AlarmClock-Aba.c,612 :: 		}
L_menuAlarm2161:
;AlarmClock-Aba.c,613 :: 		}
L_menuAlarm2158:
;AlarmClock-Aba.c,614 :: 		}
L_menuAlarm2156:
;AlarmClock-Aba.c,616 :: 		if(set_count)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2162
;AlarmClock-Aba.c,618 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuAlarm2163
;AlarmClock-Aba.c,620 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2164:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2164
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2164
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2164
	NOP
;AlarmClock-Aba.c,621 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuAlarm2165
;AlarmClock-Aba.c,622 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_menuAlarm2165:
;AlarmClock-Aba.c,623 :: 		}
L_menuAlarm2163:
;AlarmClock-Aba.c,625 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuAlarm2166
;AlarmClock-Aba.c,627 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2167:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2167
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2167
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2167
	NOP
;AlarmClock-Aba.c,628 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuAlarm2168
;AlarmClock-Aba.c,629 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_menuAlarm2168:
;AlarmClock-Aba.c,630 :: 		}
L_menuAlarm2166:
;AlarmClock-Aba.c,631 :: 		if((PORTA.F4 ==0) && set_count == 2)
	BTFSC       PORTA+0, 4 
	GOTO        L_menuAlarm2171
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2171
L__menuAlarm2329:
;AlarmClock-Aba.c,633 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2172:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2172
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2172
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2172
	NOP
;AlarmClock-Aba.c,634 :: 		if(PORTA.F4 ==0)
	BTFSC       PORTA+0, 4 
	GOTO        L_menuAlarm2173
;AlarmClock-Aba.c,636 :: 		while(PORTA.F4 == 0) {}         //To avoid overpressing
L_menuAlarm2174:
	BTFSC       PORTA+0, 4 
	GOTO        L_menuAlarm2175
	GOTO        L_menuAlarm2174
L_menuAlarm2175:
;AlarmClock-Aba.c,637 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
;AlarmClock-Aba.c,638 :: 		}
L_menuAlarm2173:
;AlarmClock-Aba.c,639 :: 		}
L_menuAlarm2171:
;AlarmClock-Aba.c,641 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2178
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2178
L__menuAlarm2328:
;AlarmClock-Aba.c,644 :: 		switch(set_count)
	GOTO        L_menuAlarm2179
;AlarmClock-Aba.c,646 :: 		case 1: //On Off
L_menuAlarm2181:
;AlarmClock-Aba.c,647 :: 		alarmStatus[alarmNo-1] = !alarmStatus[alarmNo-1];
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmStatus+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_alarmStatus+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,648 :: 		break;
	GOTO        L_menuAlarm2180
;AlarmClock-Aba.c,649 :: 		case 3: //Snooze
L_menuAlarm2182:
;AlarmClock-Aba.c,650 :: 		snoozeTimes[alarmNo-1] += set;
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        _set+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,651 :: 		if(snoozeTimes[alarmNo-1] >19) snoozeTimes[alarmNo-1] = 0;
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       128
	XORLW       19
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2183
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_menuAlarm2183:
;AlarmClock-Aba.c,652 :: 		if(snoozeTimes[alarmNo-1] <0) snoozeTimes[alarmNo-1] = 19;
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2184
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       19
	MOVWF       POSTINC1+0 
L_menuAlarm2184:
;AlarmClock-Aba.c,653 :: 		break;
	GOTO        L_menuAlarm2180
;AlarmClock-Aba.c,654 :: 		case 2: //Time
L_menuAlarm2185:
;AlarmClock-Aba.c,655 :: 		alText[3] = BCD2LowerCh(Binary2BCD(alarmNo));
	MOVF        FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _alText+3 
;AlarmClock-Aba.c,656 :: 		inputTime(2, alText);    //
	MOVLW       2
	MOVWF       FARG_inputTime_mode+0 
	MOVLW       0
	MOVWF       FARG_inputTime_mode+1 
	MOVLW       _alText+0
	MOVWF       FARG_inputTime_setStr+0 
	MOVLW       hi_addr(_alText+0)
	MOVWF       FARG_inputTime_setStr+1 
	CALL        _inputTime+0, 0
;AlarmClock-Aba.c,657 :: 		break;
	GOTO        L_menuAlarm2180
;AlarmClock-Aba.c,658 :: 		case 4: //Tune
L_menuAlarm2186:
;AlarmClock-Aba.c,659 :: 		alarmTunes[alarmNo-1] += set;
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmTunes+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_alarmTunes+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVF        _set+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,660 :: 		if(alarmTunes[alarmNo-1] >3) alarmTunes[alarmNo-1] = 1;
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmTunes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmTunes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       POSTINC0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2187
	MOVLW       1
	SUBWF       FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       R1 
	MOVLW       _alarmTunes+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_alarmTunes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_menuAlarm2187:
;AlarmClock-Aba.c,661 :: 		break;
	GOTO        L_menuAlarm2180
;AlarmClock-Aba.c,663 :: 		}
L_menuAlarm2179:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2181
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2182
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2185
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2186
L_menuAlarm2180:
;AlarmClock-Aba.c,664 :: 		populateAlarm(alarmNo);
	MOVF        FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       FARG_populateAlarm_alarmNo+0 
	MOVF        FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       FARG_populateAlarm_alarmNo+1 
	CALL        _populateAlarm+0, 0
;AlarmClock-Aba.c,666 :: 		}
L_menuAlarm2178:
;AlarmClock-Aba.c,668 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;AlarmClock-Aba.c,669 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2188
	CLRF        _loopcount+0 
L_menuAlarm2188:
;AlarmClock-Aba.c,670 :: 		if(loopcount < 5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2189
;AlarmClock-Aba.c,672 :: 		Lcd_out(1,1, menuAlarmText[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,673 :: 		Lcd_out(2,1, menuAlarmText[1]);     //Show full menu for 0.5s
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+2, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+3, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,674 :: 		}
	GOTO        L_menuAlarm2190
L_menuAlarm2189:
;AlarmClock-Aba.c,677 :: 		if      (set_count  ==1) Lcd_out(1,9, "___");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2191
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr23_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2192
L_menuAlarm2191:
;AlarmClock-Aba.c,678 :: 		else if (set_count  ==2) Lcd_out(1,13, "____");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2193
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr24_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2194
L_menuAlarm2193:
;AlarmClock-Aba.c,679 :: 		else if (set_count  ==3) Lcd_out(2,8, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2195
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr25_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2196
L_menuAlarm2195:
;AlarmClock-Aba.c,680 :: 		else if (set_count  ==4) Lcd_out(2,16, "_");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2197
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_menuAlarm2197:
L_menuAlarm2196:
L_menuAlarm2194:
L_menuAlarm2192:
;AlarmClock-Aba.c,681 :: 		}
L_menuAlarm2190:
;AlarmClock-Aba.c,683 :: 		}
L_menuAlarm2162:
;AlarmClock-Aba.c,685 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_menuAlarm2198
;AlarmClock-Aba.c,687 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2199:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2199
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2199
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2199
	NOP
;AlarmClock-Aba.c,688 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_menuAlarm2200
;AlarmClock-Aba.c,690 :: 		while(PORTA.F3 == 0) {}         //To avoid overpressing
L_menuAlarm2201:
	BTFSC       PORTA+0, 3 
	GOTO        L_menuAlarm2202
	GOTO        L_menuAlarm2201
L_menuAlarm2202:
;AlarmClock-Aba.c,691 :: 		break;
	GOTO        L_menuAlarm2155
;AlarmClock-Aba.c,692 :: 		}
L_menuAlarm2200:
;AlarmClock-Aba.c,693 :: 		}
L_menuAlarm2198:
;AlarmClock-Aba.c,695 :: 		if(goBackAlarm) break;            //Immediately go back if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2203
	GOTO        L_menuAlarm2155
L_menuAlarm2203:
;AlarmClock-Aba.c,698 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2204:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2204
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2204
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2204
	NOP
;AlarmClock-Aba.c,699 :: 		}
	GOTO        L_menuAlarm2154
L_menuAlarm2155:
;AlarmClock-Aba.c,701 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,702 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,703 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,704 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,705 :: 		menuAlarmText[0][6] = "_";
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       ?lstr_27_AlarmClock_45Aba+0
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,706 :: 		}
L_end_menuAlarm2:
	RETURN      0
; end of _menuAlarm2

_menuMain2:

;AlarmClock-Aba.c,709 :: 		void menuMain2() //***************************************** MAIN MENU
;AlarmClock-Aba.c,714 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;AlarmClock-Aba.c,715 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,716 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,718 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,719 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,720 :: 		while(1)
L_menuMain2205:
;AlarmClock-Aba.c,724 :: 		loopcount++;
	INCF        _loopcount+0, 1 
;AlarmClock-Aba.c,725 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuMain2207
	CLRF        _loopcount+0 
L_menuMain2207:
;AlarmClock-Aba.c,726 :: 		if((loopcount < 5)||(!set_count))
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__menuMain2331
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__menuMain2331
	GOTO        L_menuMain2210
L__menuMain2331:
;AlarmClock-Aba.c,728 :: 		Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr29_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr29_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,729 :: 		}
L_menuMain2210:
;AlarmClock-Aba.c,731 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,732 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_menuMain2211
;AlarmClock-Aba.c,734 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2212:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2212
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2212
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2212
	NOP
;AlarmClock-Aba.c,735 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_menuMain2213
;AlarmClock-Aba.c,737 :: 		while(PORTA.F0 == 0) {}         //To avoid overpressing
L_menuMain2214:
	BTFSC       PORTA+0, 0 
	GOTO        L_menuMain2215
	GOTO        L_menuMain2214
L_menuMain2215:
;AlarmClock-Aba.c,738 :: 		set_count++;
	INCF        _set_count+0, 1 
;AlarmClock-Aba.c,739 :: 		if(set_count > 5)  set_count = 1;
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_menuMain2216
	MOVLW       1
	MOVWF       _set_count+0 
L_menuMain2216:
;AlarmClock-Aba.c,740 :: 		}
L_menuMain2213:
;AlarmClock-Aba.c,741 :: 		}
L_menuMain2211:
;AlarmClock-Aba.c,743 :: 		if(set_count)                   //After Mode pressed, pressing ok.
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2217
;AlarmClock-Aba.c,745 :: 		if(PORTA.F4 == 0)
	BTFSC       PORTA+0, 4 
	GOTO        L_menuMain2218
;AlarmClock-Aba.c,747 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2219:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2219
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2219
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2219
	NOP
;AlarmClock-Aba.c,748 :: 		if(PORTA.F4 == 0)
	BTFSC       PORTA+0, 4 
	GOTO        L_menuMain2220
;AlarmClock-Aba.c,750 :: 		while(PORTA.F4 == 0) {}         //To avoid overpressing
L_menuMain2221:
	BTFSC       PORTA+0, 4 
	GOTO        L_menuMain2222
	GOTO        L_menuMain2221
L_menuMain2222:
;AlarmClock-Aba.c,751 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
;AlarmClock-Aba.c,752 :: 		}
L_menuMain2220:
;AlarmClock-Aba.c,753 :: 		}
L_menuMain2218:
;AlarmClock-Aba.c,754 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2225
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2225
L__menuMain2330:
;AlarmClock-Aba.c,756 :: 		switch(set_count)
	GOTO        L_menuMain2226
;AlarmClock-Aba.c,758 :: 		case 1: // Alarm1
L_menuMain2228:
;AlarmClock-Aba.c,759 :: 		menuAlarm2(1);
	MOVLW       1
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;AlarmClock-Aba.c,760 :: 		break;
	GOTO        L_menuMain2227
;AlarmClock-Aba.c,761 :: 		case 2: //Alarm2
L_menuMain2229:
;AlarmClock-Aba.c,762 :: 		menuAlarm2(2);
	MOVLW       2
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;AlarmClock-Aba.c,763 :: 		break;
	GOTO        L_menuMain2227
;AlarmClock-Aba.c,764 :: 		case 3: //Alarm3
L_menuMain2230:
;AlarmClock-Aba.c,765 :: 		menuAlarm2(3);
	MOVLW       3
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;AlarmClock-Aba.c,766 :: 		break;
	GOTO        L_menuMain2227
;AlarmClock-Aba.c,767 :: 		case 4: //Time
L_menuMain2231:
;AlarmClock-Aba.c,768 :: 		inputTime(0, "Time:");
	CLRF        FARG_inputTime_mode+0 
	CLRF        FARG_inputTime_mode+1 
	MOVLW       ?lstr30_AlarmClock_45Aba+0
	MOVWF       FARG_inputTime_setStr+0 
	MOVLW       hi_addr(?lstr30_AlarmClock_45Aba+0)
	MOVWF       FARG_inputTime_setStr+1 
	CALL        _inputTime+0, 0
;AlarmClock-Aba.c,769 :: 		break;
	GOTO        L_menuMain2227
;AlarmClock-Aba.c,770 :: 		case 5: //Date
L_menuMain2232:
;AlarmClock-Aba.c,771 :: 		inputDate();
	CALL        _inputDate+0, 0
;AlarmClock-Aba.c,772 :: 		break;
	GOTO        L_menuMain2227
;AlarmClock-Aba.c,773 :: 		}
L_menuMain2226:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2228
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2229
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2230
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2231
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2232
L_menuMain2227:
;AlarmClock-Aba.c,774 :: 		}
L_menuMain2225:
;AlarmClock-Aba.c,778 :: 		if(loopcount >=5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_menuMain2233
;AlarmClock-Aba.c,780 :: 		if      (set_count  ==1) Lcd_out(1,12, "_");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2234
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr31_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr31_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2235
L_menuMain2234:
;AlarmClock-Aba.c,781 :: 		else if (set_count  ==2) Lcd_out(1,14, "_");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2236
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr32_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr32_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2237
L_menuMain2236:
;AlarmClock-Aba.c,782 :: 		else if (set_count  ==3) Lcd_out(1,16, "_");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2238
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr33_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr33_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2239
L_menuMain2238:
;AlarmClock-Aba.c,783 :: 		else if (set_count  ==4) Lcd_out(2,6, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2240
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr34_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr34_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2241
L_menuMain2240:
;AlarmClock-Aba.c,784 :: 		else if (set_count  ==5) Lcd_out(2,13, "____");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2242
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr35_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr35_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_menuMain2242:
L_menuMain2241:
L_menuMain2239:
L_menuMain2237:
L_menuMain2235:
;AlarmClock-Aba.c,785 :: 		}
L_menuMain2233:
;AlarmClock-Aba.c,787 :: 		}
L_menuMain2217:
;AlarmClock-Aba.c,789 :: 		if(PORTA.F3 == 0)              // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_menuMain2243
;AlarmClock-Aba.c,791 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2244:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2244
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2244
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2244
	NOP
;AlarmClock-Aba.c,792 :: 		if(PORTA.F3 == 0) break;
	BTFSC       PORTA+0, 3 
	GOTO        L_menuMain2245
	GOTO        L_menuMain2206
L_menuMain2245:
;AlarmClock-Aba.c,793 :: 		}
L_menuMain2243:
;AlarmClock-Aba.c,794 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2246:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2246
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2246
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2246
	NOP
;AlarmClock-Aba.c,796 :: 		if(goBackAlarm) break;         //Immediately return if Alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2247
	GOTO        L_menuMain2206
L_menuMain2247:
;AlarmClock-Aba.c,797 :: 		}
	GOTO        L_menuMain2205
L_menuMain2206:
;AlarmClock-Aba.c,800 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,801 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,802 :: 		set_count = 0;
	CLRF        _set_count+0 
;AlarmClock-Aba.c,803 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,804 :: 		}
L_end_menuMain2:
	RETURN      0
; end of _menuMain2

_playTone:

;AlarmClock-Aba.c,806 :: 		void playTone()                              // Runs while ringing/snoozing the alarm. Plays the tone, stops, snooze...etc.
;AlarmClock-Aba.c,808 :: 		ringAlarmText[6] = BCD2LowerCh(Binary2BCD(goBackAlarm));
	MOVLW       6
	ADDWF       _ringAlarmText+0, 0 
	MOVWF       FLOC__playTone+0 
	MOVLW       0
	ADDWFC      _ringAlarmText+1, 0 
	MOVWF       FLOC__playTone+1 
	MOVF        _goBackAlarm+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       _goBackAlarm+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVFF       FLOC__playTone+0, FSR1
	MOVFF       FLOC__playTone+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,809 :: 		Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _ringAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _ringAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,810 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,812 :: 		while(1)
L_playTone248:
;AlarmClock-Aba.c,815 :: 		if(goBackAlarm == 1)
	MOVF        _goBackAlarm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_playTone250
;AlarmClock-Aba.c,817 :: 		Sound_Play(tune1[loopcount], 100*interval1[loopcount]);
	MOVF        _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tune1+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_tune1+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       _interval1+0
	MOVWF       FSR2 
	MOVLW       hi_addr(_interval1+0)
	MOVWF       FSR2H 
	MOVF        _loopcount+0, 0 
	ADDWF       FSR2, 1 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	ADDWFC      FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;AlarmClock-Aba.c,819 :: 		if         (loopcount < 8) Lcd_out(2,10, "       ");               //Blinking
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone251
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr36_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr36_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone252
L_playTone251:
;AlarmClock-Aba.c,820 :: 		else if    (loopcount <16) Lcd_out(2,10, "RINGING");
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       16
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone253
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr37_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr37_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone254
L_playTone253:
;AlarmClock-Aba.c,822 :: 		{ loopcount = 0;
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,823 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_playTone255:
	DECFSZ      R13, 1, 1
	BRA         L_playTone255
	DECFSZ      R12, 1, 1
	BRA         L_playTone255
	DECFSZ      R11, 1, 1
	BRA         L_playTone255
	NOP
	NOP
;AlarmClock-Aba.c,824 :: 		}
L_playTone254:
L_playTone252:
;AlarmClock-Aba.c,825 :: 		}
	GOTO        L_playTone256
L_playTone250:
;AlarmClock-Aba.c,826 :: 		else if(goBackAlarm == 2)
	MOVF        _goBackAlarm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_playTone257
;AlarmClock-Aba.c,828 :: 		Sound_Play(tune2[loopcount], 100*interval2[loopcount]);
	MOVF        _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tune2+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_tune2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       _interval2+0
	MOVWF       FSR2 
	MOVLW       hi_addr(_interval2+0)
	MOVWF       FSR2H 
	MOVF        _loopcount+0, 0 
	ADDWF       FSR2, 1 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	ADDWFC      FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;AlarmClock-Aba.c,830 :: 		if         (loopcount < 1) Lcd_out(2,10, "       ");               //Blinking
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone258
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr38_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr38_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone259
L_playTone258:
;AlarmClock-Aba.c,831 :: 		else if    (loopcount < 2) Lcd_out(2,10, "RINGING");
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone260
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr39_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr39_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone261
L_playTone260:
;AlarmClock-Aba.c,833 :: 		{ loopcount = 0;           //Legnth of arrays
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,834 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_playTone262:
	DECFSZ      R13, 1, 1
	BRA         L_playTone262
	DECFSZ      R12, 1, 1
	BRA         L_playTone262
	DECFSZ      R11, 1, 1
	BRA         L_playTone262
	NOP
	NOP
;AlarmClock-Aba.c,835 :: 		}
L_playTone261:
L_playTone259:
;AlarmClock-Aba.c,836 :: 		}
	GOTO        L_playTone263
L_playTone257:
;AlarmClock-Aba.c,837 :: 		else if(goBackAlarm == 3)
	MOVF        _goBackAlarm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_playTone264
;AlarmClock-Aba.c,839 :: 		Sound_Play(tune3[loopcount], 100*interval3[loopcount]);
	MOVF        _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _tune3+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_tune3+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       _interval3+0
	MOVWF       FSR2 
	MOVLW       hi_addr(_interval3+0)
	MOVWF       FSR2H 
	MOVF        _loopcount+0, 0 
	ADDWF       FSR2, 1 
	MOVLW       0
	BTFSC       _loopcount+0, 7 
	MOVLW       255
	ADDWFC      FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;AlarmClock-Aba.c,841 :: 		if         (loopcount < 1) Lcd_out(2,10, "       ");               //Blinking
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone265
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr40_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr40_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone266
L_playTone265:
;AlarmClock-Aba.c,842 :: 		else if    (loopcount < 2) Lcd_out(2,10, "RINGING");
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone267
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr41_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr41_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone268
L_playTone267:
;AlarmClock-Aba.c,844 :: 		{ loopcount = 0;           //Legnth of arrays
	CLRF        _loopcount+0 
;AlarmClock-Aba.c,845 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_playTone269:
	DECFSZ      R13, 1, 1
	BRA         L_playTone269
	DECFSZ      R12, 1, 1
	BRA         L_playTone269
	DECFSZ      R11, 1, 1
	BRA         L_playTone269
	NOP
	NOP
;AlarmClock-Aba.c,846 :: 		}
L_playTone268:
L_playTone266:
;AlarmClock-Aba.c,847 :: 		}
	GOTO        L_playTone270
L_playTone264:
;AlarmClock-Aba.c,848 :: 		else return;
	GOTO        L_end_playTone
L_playTone270:
L_playTone263:
L_playTone256:
;AlarmClock-Aba.c,850 :: 		if(PORTA.F1 == 0)              //Up/Snooze Pressed
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone271
;AlarmClock-Aba.c,852 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone272:
	DECFSZ      R13, 1, 1
	BRA         L_playTone272
	DECFSZ      R12, 1, 1
	BRA         L_playTone272
	DECFSZ      R11, 1, 1
	BRA         L_playTone272
	NOP
;AlarmClock-Aba.c,853 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone273
;AlarmClock-Aba.c,856 :: 		Lcd_out(2,1, "SNOOZING - 00:00");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr42_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr42_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,857 :: 		snoozeMax = snoozeTimes[goBackAlarm-1]*600;   //Max Snooze count = snooze in seconds * 10
	DECF        _goBackAlarm+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _goBackAlarm+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _snoozeTimes+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_snoozeTimes+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       88
	MOVWF       R4 
	MOVLW       2
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _snoozeMax+0 
	MOVF        R1, 0 
	MOVWF       _snoozeMax+1 
;AlarmClock-Aba.c,858 :: 		snoozeCounter = snoozeMax;
	MOVF        R0, 0 
	MOVWF       _snoozeCounter+0 
	MOVF        R1, 0 
	MOVWF       _snoozeCounter+1 
;AlarmClock-Aba.c,859 :: 		while(snoozeCounter >=1)
L_playTone274:
	MOVLW       128
	XORWF       _snoozeCounter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__playTone362
	MOVLW       1
	SUBWF       _snoozeCounter+0, 0 
L__playTone362:
	BTFSS       STATUS+0, 0 
	GOTO        L_playTone275
;AlarmClock-Aba.c,861 :: 		if(!(snoozeCounter%10))                   //Every second
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_playTone276
;AlarmClock-Aba.c,863 :: 		snoozeCounter = snoozeCounter/10;        //Bring the count to second
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _snoozeCounter+0 
	MOVF        R1, 0 
	MOVWF       _snoozeCounter+1 
;AlarmClock-Aba.c,865 :: 		snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter/60));
	MOVF        _snoozeTime+0, 0 
	MOVWF       FLOC__playTone+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FLOC__playTone+1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVFF       FLOC__playTone+0, FSR1
	MOVFF       FLOC__playTone+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,866 :: 		snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter/60));
	MOVLW       1
	ADDWF       _snoozeTime+0, 0 
	MOVWF       FLOC__playTone+0 
	MOVLW       0
	ADDWFC      _snoozeTime+1, 0 
	MOVWF       FLOC__playTone+1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVFF       FLOC__playTone+0, FSR1
	MOVFF       FLOC__playTone+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,867 :: 		Lcd_out(2,12, snoozeTime);               //Show Minutes left
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _snoozeTime+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,869 :: 		snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter%60));
	MOVF        _snoozeTime+0, 0 
	MOVWF       FLOC__playTone+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FLOC__playTone+1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVFF       FLOC__playTone+0, FSR1
	MOVFF       FLOC__playTone+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,870 :: 		snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter%60));
	MOVLW       1
	ADDWF       _snoozeTime+0, 0 
	MOVWF       FLOC__playTone+0 
	MOVLW       0
	ADDWFC      _snoozeTime+1, 0 
	MOVWF       FLOC__playTone+1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVFF       FLOC__playTone+0, FSR1
	MOVFF       FLOC__playTone+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;AlarmClock-Aba.c,872 :: 		Lcd_out(2,15, snoozeTime);               //Show Seconds left
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _snoozeTime+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,874 :: 		snoozeCounter = snoozeCounter*10;         //Take it back to count
	MOVF        _snoozeCounter+0, 0 
	MOVWF       R0 
	MOVF        _snoozeCounter+1, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _snoozeCounter+0 
	MOVF        R1, 0 
	MOVWF       _snoozeCounter+1 
;AlarmClock-Aba.c,875 :: 		}
L_playTone276:
;AlarmClock-Aba.c,877 :: 		if(PORTA.F1 == 0)                           //If Snooze Pressed inside snooze, reset snooze count
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone277
;AlarmClock-Aba.c,879 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone278:
	DECFSZ      R13, 1, 1
	BRA         L_playTone278
	DECFSZ      R12, 1, 1
	BRA         L_playTone278
	DECFSZ      R11, 1, 1
	BRA         L_playTone278
	NOP
;AlarmClock-Aba.c,880 :: 		if(PORTA.F1 == 0) snoozeCounter = snoozeMax+1;
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone279
	MOVLW       1
	ADDWF       _snoozeMax+0, 0 
	MOVWF       _snoozeCounter+0 
	MOVLW       0
	ADDWFC      _snoozeMax+1, 0 
	MOVWF       _snoozeCounter+1 
L_playTone279:
;AlarmClock-Aba.c,881 :: 		}
L_playTone277:
;AlarmClock-Aba.c,883 :: 		if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone280
;AlarmClock-Aba.c,885 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone281:
	DECFSZ      R13, 1, 1
	BRA         L_playTone281
	DECFSZ      R12, 1, 1
	BRA         L_playTone281
	DECFSZ      R11, 1, 1
	BRA         L_playTone281
	NOP
;AlarmClock-Aba.c,886 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone282
;AlarmClock-Aba.c,888 :: 		stopCounter = 1;
	MOVLW       1
	MOVWF       _stopCounter+0 
	MOVLW       0
	MOVWF       _stopCounter+1 
;AlarmClock-Aba.c,889 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;AlarmClock-Aba.c,890 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;AlarmClock-Aba.c,891 :: 		snoozeMax = 0;
	CLRF        _snoozeMax+0 
	CLRF        _snoozeMax+1 
;AlarmClock-Aba.c,892 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,893 :: 		return;
	GOTO        L_end_playTone
;AlarmClock-Aba.c,894 :: 		}
L_playTone282:
;AlarmClock-Aba.c,895 :: 		}
L_playTone280:
;AlarmClock-Aba.c,896 :: 		snoozeCounter--;
	MOVLW       1
	SUBWF       _snoozeCounter+0, 1 
	MOVLW       0
	SUBWFB      _snoozeCounter+1, 1 
;AlarmClock-Aba.c,897 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone283:
	DECFSZ      R13, 1, 1
	BRA         L_playTone283
	DECFSZ      R12, 1, 1
	BRA         L_playTone283
	DECFSZ      R11, 1, 1
	BRA         L_playTone283
	NOP
;AlarmClock-Aba.c,898 :: 		}
	GOTO        L_playTone274
L_playTone275:
;AlarmClock-Aba.c,899 :: 		snoozeTime = "00";
	MOVLW       ?lstr43_AlarmClock_45Aba+0
	MOVWF       _snoozeTime+0 
	MOVLW       hi_addr(?lstr43_AlarmClock_45Aba+0)
	MOVWF       _snoozeTime+1 
;AlarmClock-Aba.c,900 :: 		Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _ringAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _ringAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,901 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;AlarmClock-Aba.c,902 :: 		}
L_playTone273:
;AlarmClock-Aba.c,904 :: 		}
L_playTone271:
;AlarmClock-Aba.c,906 :: 		if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone284
;AlarmClock-Aba.c,908 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone285:
	DECFSZ      R13, 1, 1
	BRA         L_playTone285
	DECFSZ      R12, 1, 1
	BRA         L_playTone285
	DECFSZ      R11, 1, 1
	BRA         L_playTone285
	NOP
;AlarmClock-Aba.c,909 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone286
;AlarmClock-Aba.c,911 :: 		stopCounter = 1;
	MOVLW       1
	MOVWF       _stopCounter+0 
	MOVLW       0
	MOVWF       _stopCounter+1 
;AlarmClock-Aba.c,912 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;AlarmClock-Aba.c,913 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;AlarmClock-Aba.c,914 :: 		snoozeMax = 0;
	CLRF        _snoozeMax+0 
	CLRF        _snoozeMax+1 
;AlarmClock-Aba.c,915 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,916 :: 		return;
	GOTO        L_end_playTone
;AlarmClock-Aba.c,917 :: 		}
L_playTone286:
;AlarmClock-Aba.c,918 :: 		}
L_playTone284:
;AlarmClock-Aba.c,921 :: 		loopcount++;
	INCF        _loopcount+0, 1 
;AlarmClock-Aba.c,922 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone287:
	DECFSZ      R13, 1, 1
	BRA         L_playTone287
	DECFSZ      R12, 1, 1
	BRA         L_playTone287
	DECFSZ      R11, 1, 1
	BRA         L_playTone287
	NOP
;AlarmClock-Aba.c,923 :: 		}
	GOTO        L_playTone248
;AlarmClock-Aba.c,929 :: 		}
L_end_playTone:
	RETURN      0
; end of _playTone

_interrupt:

;AlarmClock-Aba.c,931 :: 		void interrupt(void)
;AlarmClock-Aba.c,933 :: 		if (TMR0IF_bit)          //Timer Interrupt (every  1 seconds)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt288
;AlarmClock-Aba.c,936 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;AlarmClock-Aba.c,937 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;AlarmClock-Aba.c,938 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;AlarmClock-Aba.c,941 :: 		secondbin++;
	INCF        _secondbin+0, 1 
;AlarmClock-Aba.c,942 :: 		if(secondbin >= 60)
	MOVLW       60
	SUBWF       _secondbin+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt289
;AlarmClock-Aba.c,944 :: 		secondbin = 0;
	CLRF        _secondbin+0 
;AlarmClock-Aba.c,945 :: 		minutebin++;
	INCF        _minutebin+0, 1 
;AlarmClock-Aba.c,946 :: 		}
L_interrupt289:
;AlarmClock-Aba.c,947 :: 		if (minutebin >= 60)
	MOVLW       60
	SUBWF       _minutebin+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt290
;AlarmClock-Aba.c,949 :: 		hrbin++;
	INCF        _hrbin+0, 1 
;AlarmClock-Aba.c,950 :: 		minutebin = 0;
	CLRF        _minutebin+0 
;AlarmClock-Aba.c,951 :: 		}
L_interrupt290:
;AlarmClock-Aba.c,952 :: 		if (hrbin > 12)
	MOVF        _hrbin+0, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt291
;AlarmClock-Aba.c,954 :: 		hrbin = 1;
	MOVLW       1
	MOVWF       _hrbin+0 
;AlarmClock-Aba.c,955 :: 		minutebin = 0;
	CLRF        _minutebin+0 
;AlarmClock-Aba.c,956 :: 		}
L_interrupt291:
;AlarmClock-Aba.c,957 :: 		if (hrbin ==12 && minutebin == 0 && secondbin == 0) ap = !ap;
	MOVF        _hrbin+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt294
	MOVF        _minutebin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt294
	MOVF        _secondbin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt294
L__interrupt335:
	MOVF        _ap+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _ap+0 
L_interrupt294:
;AlarmClock-Aba.c,960 :: 		if(stopCounter)                                                                  //If stop counter is activated
	MOVF        _stopCounter+0, 0 
	IORWF       _stopCounter+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt295
;AlarmClock-Aba.c,962 :: 		if(stopCounter > 90) stopCounter = 0;                                         //Expire the stop counter after 1.5 minutes
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _stopCounter+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt365
	MOVF        _stopCounter+0, 0 
	SUBLW       90
L__interrupt365:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt296
	CLRF        _stopCounter+0 
	CLRF        _stopCounter+1 
	GOTO        L_interrupt297
L_interrupt296:
;AlarmClock-Aba.c,963 :: 		else stopCounter += 1;                                                         //Increment the counter by 1 second.
	INFSNZ      _stopCounter+0, 1 
	INCF        _stopCounter+1, 1 
L_interrupt297:
;AlarmClock-Aba.c,964 :: 		}
	GOTO        L_interrupt298
L_interrupt295:
;AlarmClock-Aba.c,969 :: 		else if(!gobackAlarm)
	MOVF        _goBackAlarm+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt299
;AlarmClock-Aba.c,972 :: 		if      (alarmStatus[0] && (hrbin == alarmHr[0]) && (minutebin == alarmMinute[0]) && (ap == alarmAP[0]))
	MOVF        _alarmStatus+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt302
	MOVF        _hrbin+0, 0 
	XORWF       _alarmHr+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt302
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alarmMinute+0, 7 
	MOVLW       255
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt366
	MOVF        _alarmMinute+0, 0 
	XORWF       _minutebin+0, 0 
L__interrupt366:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt302
	MOVF        _ap+0, 0 
	XORWF       _alarmAP+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt302
L__interrupt334:
;AlarmClock-Aba.c,973 :: 		goBackAlarm = 1;
	MOVLW       1
	MOVWF       _goBackAlarm+0 
	GOTO        L_interrupt303
L_interrupt302:
;AlarmClock-Aba.c,974 :: 		else if (alarmStatus[1] && (hrbin == alarmHr[1]) && (minutebin == alarmMinute[1]) && (ap == alarmAP[1]))
	MOVF        _alarmStatus+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt306
	MOVF        _hrbin+0, 0 
	XORWF       _alarmHr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt306
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alarmMinute+1, 7 
	MOVLW       255
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt367
	MOVF        _alarmMinute+1, 0 
	XORWF       _minutebin+0, 0 
L__interrupt367:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt306
	MOVF        _ap+0, 0 
	XORWF       _alarmAP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt306
L__interrupt333:
;AlarmClock-Aba.c,975 :: 		goBackAlarm = 2;
	MOVLW       2
	MOVWF       _goBackAlarm+0 
	GOTO        L_interrupt307
L_interrupt306:
;AlarmClock-Aba.c,976 :: 		else if (alarmStatus[2] && (hrbin == alarmHr[2]) && (minutebin == alarmMinute[2]) && (ap == alarmAP[2]))
	MOVF        _alarmStatus+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt310
	MOVF        _hrbin+0, 0 
	XORWF       _alarmHr+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt310
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	BTFSC       _alarmMinute+2, 7 
	MOVLW       255
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt368
	MOVF        _alarmMinute+2, 0 
	XORWF       _minutebin+0, 0 
L__interrupt368:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt310
	MOVF        _ap+0, 0 
	XORWF       _alarmAP+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt310
L__interrupt332:
;AlarmClock-Aba.c,977 :: 		goBackAlarm = 3;
	MOVLW       3
	MOVWF       _goBackAlarm+0 
L_interrupt310:
L_interrupt307:
L_interrupt303:
;AlarmClock-Aba.c,979 :: 		}
L_interrupt299:
L_interrupt298:
;AlarmClock-Aba.c,980 :: 		}
L_interrupt288:
;AlarmClock-Aba.c,981 :: 		}
L_end_interrupt:
L__interrupt364:
	RETFIE      1
; end of _interrupt

_main:

;AlarmClock-Aba.c,983 :: 		void main()
;AlarmClock-Aba.c,985 :: 		I2C1_Init(100000); //DS1307 I2C is running at 100KHz
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;AlarmClock-Aba.c,987 :: 		CMCON = 0x07;   // To turn off comparators
	MOVLW       7
	MOVWF       CMCON+0 
;AlarmClock-Aba.c,988 :: 		ADCON1 = 0x0F;  // To turn off analog to digital converters
	MOVLW       15
	MOVWF       ADCON1+0 
;AlarmClock-Aba.c,989 :: 		LATB = 0x00;
	CLRF        LATB+0 
;AlarmClock-Aba.c,992 :: 		TRISA = 0xFF;         //Buttons in Port A
	MOVLW       255
	MOVWF       TRISA+0 
;AlarmClock-Aba.c,993 :: 		PORTA = 0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;AlarmClock-Aba.c,994 :: 		TRISC = 0x00;   // Sound Output in C
	CLRF        TRISC+0 
;AlarmClock-Aba.c,997 :: 		Sound_Init(&PORTC,2);
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       2
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;AlarmClock-Aba.c,1000 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;AlarmClock-Aba.c,1001 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,1002 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AlarmClock-Aba.c,1005 :: 		T0CON         = 0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;AlarmClock-Aba.c,1006 :: 		TMR0H         = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;AlarmClock-Aba.c,1007 :: 		TMR0L         = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;AlarmClock-Aba.c,1008 :: 		GIE_bit       = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;AlarmClock-Aba.c,1009 :: 		TMR0IE_bit    = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;AlarmClock-Aba.c,1011 :: 		while(1)                                   //*********************Main Loop *****************************
L_main311:
;AlarmClock-Aba.c,1013 :: 		Lcd_out(1,1,"Time:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr44_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr44_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,1014 :: 		Lcd_out(2,1,"Date:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr45_AlarmClock_45Aba+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr45_AlarmClock_45Aba+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,1017 :: 		time2Str(0);
	CLRF        FARG_time2Str_temp+0 
	CLRF        FARG_time2Str_temp+1 
	CALL        _time2Str+0, 0
;AlarmClock-Aba.c,1018 :: 		date2Str();
	CALL        _date2Str+0, 0
;AlarmClock-Aba.c,1020 :: 		Lcd_out(1,6,time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,1021 :: 		Lcd_out(2,6,datestr);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _datestr+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_datestr+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AlarmClock-Aba.c,1022 :: 		set = 0;
	CLRF        _set+0 
;AlarmClock-Aba.c,1024 :: 		if(gobackAlarm)                          //When the gobackAlarm varibale was set by the Timer Interrupt (Alarm goes off),
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main313
;AlarmClock-Aba.c,1026 :: 		playTone();                           //Here we set the alarm
	CALL        _playTone+0, 0
;AlarmClock-Aba.c,1027 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;AlarmClock-Aba.c,1028 :: 		}
L_main313:
;AlarmClock-Aba.c,1030 :: 		if(PORTA.F3 == 0)              //Menu Button Pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_main314
;AlarmClock-Aba.c,1032 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main315:
	DECFSZ      R13, 1, 1
	BRA         L_main315
	DECFSZ      R12, 1, 1
	BRA         L_main315
	NOP
	NOP
;AlarmClock-Aba.c,1033 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_main316
;AlarmClock-Aba.c,1035 :: 		while(PORTA.F3 != 1) {}         //To avoid overpressing
L_main317:
	BTFSC       PORTA+0, 3 
	GOTO        L_main318
	GOTO        L_main317
L_main318:
;AlarmClock-Aba.c,1036 :: 		menuMain2();
	CALL        _menuMain2+0, 0
;AlarmClock-Aba.c,1037 :: 		}
L_main316:
;AlarmClock-Aba.c,1038 :: 		}
L_main314:
;AlarmClock-Aba.c,1040 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main319:
	DECFSZ      R13, 1, 1
	BRA         L_main319
	DECFSZ      R12, 1, 1
	BRA         L_main319
	DECFSZ      R11, 1, 1
	BRA         L_main319
	NOP
;AlarmClock-Aba.c,1041 :: 		}
	GOTO        L_main311
;AlarmClock-Aba.c,1042 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
