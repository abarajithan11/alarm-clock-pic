
_read_ds1307:

;MyProject.c,83 :: 		unsigned short read_ds1307(unsigned short address)
;MyProject.c,86 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;MyProject.c,87 :: 		I2C1_Wr(0xD0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,88 :: 		I2C1_Wr(address);
	MOVF        FARG_read_ds1307_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,89 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;MyProject.c,90 :: 		I2C1_Wr(0xD1); //0x68 followed by 1 --> 0xD1
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,91 :: 		r_data=I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       read_ds1307_r_data_L0+0 
;MyProject.c,92 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;MyProject.c,93 :: 		return(r_data);
	MOVF        read_ds1307_r_data_L0+0, 0 
	MOVWF       R0 
;MyProject.c,94 :: 		}
L_end_read_ds1307:
	RETURN      0
; end of _read_ds1307

_write_ds1307:

;MyProject.c,96 :: 		void write_ds1307(unsigned short address,unsigned short w_data)
;MyProject.c,98 :: 		I2C1_Start(); // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;MyProject.c,100 :: 		I2C1_Wr(0xD0); // send byte via I2C (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,101 :: 		I2C1_Wr(address); // send byte (address of DS1307 location)
	MOVF        FARG_write_ds1307_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,102 :: 		I2C1_Wr(w_data); // send data (data to be written)
	MOVF        FARG_write_ds1307_w_data+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;MyProject.c,103 :: 		I2C1_Stop(); // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;MyProject.c,104 :: 		}
L_end_write_ds1307:
	RETURN      0
; end of _write_ds1307

_BCD2UpperCh:

;MyProject.c,106 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;MyProject.c,108 :: 		return ((bcd >> 4) + '0');
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
;MyProject.c,109 :: 		}
L_end_BCD2UpperCh:
	RETURN      0
; end of _BCD2UpperCh

_BCD2LowerCh:

;MyProject.c,111 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;MyProject.c,113 :: 		return ((bcd & 0x0F) + '0');
	MOVLW       15
	ANDWF       FARG_BCD2LowerCh_bcd+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
;MyProject.c,114 :: 		}
L_end_BCD2LowerCh:
	RETURN      0
; end of _BCD2LowerCh

_Binary2BCD:

;MyProject.c,116 :: 		int Binary2BCD(int a)
;MyProject.c,119 :: 		t1 = a%10;
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
;MyProject.c,120 :: 		t1 = t1 & 0x0F;
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       FLOC__Binary2BCD+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Binary2BCD+1 
	MOVLW       0
	ANDWF       FLOC__Binary2BCD+1, 1 
;MyProject.c,121 :: 		a = a/10;
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
;MyProject.c,122 :: 		t2 = a%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
;MyProject.c,123 :: 		t2 = 0x0F & t2;
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
;MyProject.c,124 :: 		t2 = t2 << 4;
	MOVLW       4
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__Binary2BCD282:
	BZ          L__Binary2BCD283
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Binary2BCD282
L__Binary2BCD283:
;MyProject.c,125 :: 		t2 = 0xF0 & t2;
	MOVLW       240
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
;MyProject.c,126 :: 		t1 = t1 | t2;
	MOVF        FLOC__Binary2BCD+0, 0 
	IORWF       R0, 1 
	MOVF        FLOC__Binary2BCD+1, 0 
	IORWF       R1, 1 
;MyProject.c,127 :: 		return t1;
;MyProject.c,128 :: 		}
L_end_Binary2BCD:
	RETURN      0
; end of _Binary2BCD

_BCD2Binary:

;MyProject.c,130 :: 		int BCD2Binary(int a)
;MyProject.c,133 :: 		t = a & 0x0F;
	MOVLW       15
	ANDWF       FARG_BCD2Binary_a+0, 0 
	MOVWF       FLOC__BCD2Binary+0 
	MOVF        FARG_BCD2Binary_a+1, 0 
	MOVWF       FLOC__BCD2Binary+1 
	MOVLW       0
	ANDWF       FLOC__BCD2Binary+1, 1 
;MyProject.c,135 :: 		a = 0xF0 & a;
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
;MyProject.c,136 :: 		t = a >> 4;
	MOVLW       4
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__BCD2Binary285:
	BZ          L__BCD2Binary286
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__BCD2Binary285
L__BCD2Binary286:
;MyProject.c,137 :: 		t = 0x0F & t;
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
;MyProject.c,138 :: 		r = t*10 + r;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__BCD2Binary+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BCD2Binary+1, 0 
	ADDWFC      R1, 1 
;MyProject.c,139 :: 		return r;
;MyProject.c,140 :: 		}
L_end_BCD2Binary:
	RETURN      0
; end of _BCD2Binary

_readTime:

;MyProject.c,142 :: 		void readTime()
;MyProject.c,144 :: 		second = read_ds1307(0);
	CLRF        FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
;MyProject.c,145 :: 		minute = read_ds1307(1);
	MOVLW       1
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;MyProject.c,146 :: 		hour = read_ds1307(2);
	MOVLW       2
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _hour+0 
	MOVLW       0
	MOVWF       _hour+1 
;MyProject.c,147 :: 		hr = hour & 0b00011111;
	MOVLW       31
	ANDWF       _hour+0, 0 
	MOVWF       _hr+0 
	MOVF        _hour+1, 0 
	MOVWF       _hr+1 
	MOVLW       0
	ANDWF       _hr+1, 1 
;MyProject.c,148 :: 		ap = hour & 0b00100000;
	MOVLW       32
	ANDWF       _hour+0, 0 
	MOVWF       _ap+0 
;MyProject.c,149 :: 		dday = read_ds1307(3);
	MOVLW       3
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _dday+0 
;MyProject.c,150 :: 		day = read_ds1307(4);
	MOVLW       4
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
;MyProject.c,151 :: 		month = read_ds1307(5);
	MOVLW       5
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;MyProject.c,152 :: 		year = read_ds1307(6);
	MOVLW       6
	MOVWF       FARG_read_ds1307_address+0 
	CALL        _read_ds1307+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;MyProject.c,154 :: 		time2Str(0);
	CLRF        FARG_time2Str+0 
	CLRF        FARG_time2Str+1 
	CALL        _time2Str+0, 0
;MyProject.c,155 :: 		date2Str();
	CALL        _date2Str+0, 0
;MyProject.c,156 :: 		}
L_end_readTime:
	RETURN      0
; end of _readTime

_time2Str:

;MyProject.c,158 :: 		void time2Str(int temp)            //Mode {0-for permanent memory. If not temp memory
;MyProject.c,160 :: 		if (temp)
	MOVF        FARG_time2Str_temp+0, 0 
	IORWF       FARG_time2Str_temp+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str0
;MyProject.c,162 :: 		time[0] = BCD2UpperCh(hr2);
	MOVF        _hr2+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
;MyProject.c,163 :: 		time[1] = BCD2LowerCh(hr2);
	MOVF        _hr2+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+1 
;MyProject.c,164 :: 		time[3] = BCD2UpperCh(minute2);
	MOVF        _minute2+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+3 
;MyProject.c,165 :: 		time[4] = BCD2LowerCh(minute2);
	MOVF        _minute2+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+4 
;MyProject.c,166 :: 		time[6] = BCD2UpperCh(second2);
	MOVF        _second2+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+6 
;MyProject.c,167 :: 		time[7] = BCD2LowerCh(second2);
	MOVF        _second2+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+7 
;MyProject.c,169 :: 		if(ap2)
	MOVF        _ap2+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str1
;MyProject.c,171 :: 		time[9] = 'P';
	MOVLW       80
	MOVWF       _time+9 
;MyProject.c,172 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;MyProject.c,173 :: 		}
	GOTO        L_time2Str2
L_time2Str1:
;MyProject.c,176 :: 		time[9] = 'A';
	MOVLW       65
	MOVWF       _time+9 
;MyProject.c,177 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;MyProject.c,178 :: 		}
L_time2Str2:
;MyProject.c,179 :: 		}
	GOTO        L_time2Str3
L_time2Str0:
;MyProject.c,182 :: 		time[0] = BCD2UpperCh(hr);
	MOVF        _hr+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+0 
;MyProject.c,183 :: 		time[1] = BCD2LowerCh(hr);
	MOVF        _hr+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+1 
;MyProject.c,184 :: 		time[3] = BCD2UpperCh(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+3 
;MyProject.c,185 :: 		time[4] = BCD2LowerCh(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+4 
;MyProject.c,186 :: 		time[6] = BCD2UpperCh(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+6 
;MyProject.c,187 :: 		time[7] = BCD2LowerCh(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _time+7 
;MyProject.c,189 :: 		if(ap)
	MOVF        _ap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_time2Str4
;MyProject.c,191 :: 		time[9] = 'P';
	MOVLW       80
	MOVWF       _time+9 
;MyProject.c,192 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;MyProject.c,193 :: 		}
	GOTO        L_time2Str5
L_time2Str4:
;MyProject.c,196 :: 		time[9] = 'A';
	MOVLW       65
	MOVWF       _time+9 
;MyProject.c,197 :: 		time[10] = 'M';
	MOVLW       77
	MOVWF       _time+10 
;MyProject.c,198 :: 		}
L_time2Str5:
;MyProject.c,199 :: 		}
L_time2Str3:
;MyProject.c,200 :: 		}
L_end_time2Str:
	RETURN      0
; end of _time2Str

_date2Str:

;MyProject.c,202 :: 		void date2Str()
;MyProject.c,204 :: 		date[0] = BCD2UpperCh(day);
	MOVF        _day+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+0 
;MyProject.c,205 :: 		date[1] = BCD2LowerCh(day);
	MOVF        _day+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+1 
;MyProject.c,206 :: 		date[3] = BCD2UpperCh(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+3 
;MyProject.c,207 :: 		date[4] = BCD2LowerCh(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+4 
;MyProject.c,208 :: 		date[6] = BCD2UpperCh(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2UpperCh_bcd+0 
	CALL        _BCD2UpperCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+6 
;MyProject.c,209 :: 		date[7] = BCD2LowerCh(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2LowerCh_bcd+0 
	CALL        _BCD2LowerCh+0, 0
	MOVF        R0, 0 
	MOVWF       _date+7 
;MyProject.c,210 :: 		}
L_end_date2Str:
	RETURN      0
; end of _date2Str

_inputTime:

;MyProject.c,212 :: 		void inputTime(int mode, char setStr[])             // Interface for inputting time
;MyProject.c,214 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,215 :: 		Lcd_out(1,1,setStr);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_inputTime_setStr+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_inputTime_setStr+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,216 :: 		Lcd_out(2,1," [Save] [Cancel]");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,218 :: 		if(mode == 0) //Setting time
	MOVLW       0
	XORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime291
	MOVLW       0
	XORWF       FARG_inputTime_mode+0, 0 
L__inputTime291:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime6
;MyProject.c,219 :: 		{second2 = second; minute2 = minute; hour2 = hour; hr2 = hr; ap2 = ap;}
	MOVF        _second+0, 0 
	MOVWF       _second2+0 
	MOVF        _minute+0, 0 
	MOVWF       _minute2+0 
	MOVF        _hour+0, 0 
	MOVWF       _hour2+0 
	MOVF        _hour+1, 0 
	MOVWF       _hour2+1 
	MOVF        _hr+0, 0 
	MOVWF       _hr2+0 
	MOVF        _hr+1, 0 
	MOVWF       _hr2+1 
	MOVF        _ap+0, 0 
	MOVWF       _ap2+0 
	GOTO        L_inputTime7
L_inputTime6:
;MyProject.c,222 :: 		second2 =Binary2BCD(0); minute2 = Binary2BCD(alarmMinute[mode-1]); hr2 = Binary2BCD(alarmHr[mode-1]);
	CLRF        FARG_Binary2BCD_a+0 
	CLRF        FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _second2+0 
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
	MOVWF       _minute2+0 
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _alarmHr+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmHr+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _hr2+0 
	MOVF        R1, 0 
	MOVWF       _hr2+1 
;MyProject.c,223 :: 		ap2 = alarmAP[mode-1];
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmAP+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_alarmAP+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _ap2+0 
;MyProject.c,225 :: 		time2Str(mode);
	MOVF        FARG_inputTime_mode+0, 0 
	MOVWF       FARG_time2Str_temp+0 
	MOVF        FARG_inputTime_mode+1, 0 
	MOVWF       FARG_time2Str_temp+1 
	CALL        _time2Str+0, 0
;MyProject.c,226 :: 		}
L_inputTime7:
;MyProject.c,227 :: 		Lcd_out(1,6, time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,229 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,230 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,232 :: 		while(1)
L_inputTime8:
;MyProject.c,234 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,235 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime10
;MyProject.c,237 :: 		Delay_ms(100);
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
;MyProject.c,238 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_inputTime12
;MyProject.c,240 :: 		set_count++;
	INCF        _set_count+0, 1 
;MyProject.c,241 :: 		if(mode && (set_count == 3)) set_count++;   //Skip the seconds if mode
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime15
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime15
L__inputTime268:
	INCF        _set_count+0, 1 
L_inputTime15:
;MyProject.c,243 :: 		if(set_count > 5)
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime16
;MyProject.c,245 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;MyProject.c,246 :: 		}
L_inputTime16:
;MyProject.c,247 :: 		}
L_inputTime12:
;MyProject.c,248 :: 		}
L_inputTime10:
;MyProject.c,250 :: 		if(set_count)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime17
;MyProject.c,252 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputTime18
;MyProject.c,254 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime19:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime19
	DECFSZ      R12, 1, 1
	BRA         L_inputTime19
	DECFSZ      R11, 1, 1
	BRA         L_inputTime19
	NOP
;MyProject.c,255 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputTime20
;MyProject.c,256 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_inputTime20:
;MyProject.c,257 :: 		}
L_inputTime18:
;MyProject.c,259 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputTime21
;MyProject.c,261 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime22:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime22
	DECFSZ      R12, 1, 1
	BRA         L_inputTime22
	DECFSZ      R11, 1, 1
	BRA         L_inputTime22
	NOP
;MyProject.c,262 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputTime23
;MyProject.c,263 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_inputTime23:
;MyProject.c,264 :: 		}
L_inputTime21:
;MyProject.c,265 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime26
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime26
L__inputTime267:
;MyProject.c,269 :: 		switch(set_count)
	GOTO        L_inputTime27
;MyProject.c,271 :: 		case 1:
L_inputTime29:
;MyProject.c,272 :: 		hour2 = BCD2Binary(hour2);
	MOVF        _hour2+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVF        _hour2+1, 0 
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _hour2+0 
	MOVF        R1, 0 
	MOVWF       _hour2+1 
;MyProject.c,273 :: 		hour2 = hour2 + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	BTFSC       _set+0, 7 
	MOVLW       255
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _hour2+0 
	MOVF        R1, 0 
	MOVWF       _hour2+1 
;MyProject.c,274 :: 		hour2 = Binary2BCD(hour2);
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _hour2+0 
	MOVF        R1, 0 
	MOVWF       _hour2+1 
;MyProject.c,275 :: 		if((hour2 & 0x1F) >= 0x13)
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime292
	MOVLW       19
	SUBWF       R2, 0 
L__inputTime292:
	BTFSS       STATUS+0, 0 
	GOTO        L_inputTime30
;MyProject.c,277 :: 		hour2 = hour2 & 0b11100001;
	MOVLW       225
	ANDWF       _hour2+0, 1 
	MOVLW       0
	ANDWF       _hour2+1, 1 
;MyProject.c,278 :: 		hour2 = hour2 ^ 0x20;
	BTG         _hour2+0, 5 
;MyProject.c,279 :: 		}
	GOTO        L_inputTime31
L_inputTime30:
;MyProject.c,280 :: 		else if((hour2 & 0x1F) <= 0x00)
	MOVLW       31
	ANDWF       _hour2+0, 0 
	MOVWF       R1 
	MOVF        _hour2+1, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R2, 1 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputTime293
	MOVF        R1, 0 
	SUBLW       0
L__inputTime293:
	BTFSS       STATUS+0, 0 
	GOTO        L_inputTime32
;MyProject.c,282 :: 		hour2 = hour2 | 0b00010010;
	MOVLW       18
	IORWF       _hour2+0, 1 
	MOVLW       0
	IORWF       _hour2+1, 1 
;MyProject.c,283 :: 		hour2 = hour2 ^ 0x20;
	BTG         _hour2+0, 5 
;MyProject.c,284 :: 		}
L_inputTime32:
L_inputTime31:
;MyProject.c,286 :: 		hr2 = hour2 & 0b00011111;
	MOVLW       31
	ANDWF       _hour2+0, 0 
	MOVWF       _hr2+0 
	MOVF        _hour2+1, 0 
	MOVWF       _hr2+1 
	MOVLW       0
	ANDWF       _hr2+1, 1 
;MyProject.c,287 :: 		ap2 = hour2 & 0b00100000;
	MOVLW       32
	ANDWF       _hour2+0, 0 
	MOVWF       _ap2+0 
;MyProject.c,289 :: 		break;
	GOTO        L_inputTime28
;MyProject.c,290 :: 		case 2:
L_inputTime33:
;MyProject.c,291 :: 		minute2 = BCD2Binary(minute2);
	MOVF        _minute2+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _minute2+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _minute2+0 
;MyProject.c,292 :: 		minute2 = minute2 + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minute2+0 
;MyProject.c,293 :: 		if(minute2 >= 60)
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       60
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_inputTime34
;MyProject.c,294 :: 		minute2 = 0;
	CLRF        _minute2+0 
L_inputTime34:
;MyProject.c,295 :: 		if(minute2 < 0)
	MOVLW       128
	XORWF       _minute2+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime35
;MyProject.c,296 :: 		minute2 = 59;
	MOVLW       59
	MOVWF       _minute2+0 
L_inputTime35:
;MyProject.c,297 :: 		minute2 = Binary2BCD(minute2);
	MOVF        _minute2+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       _minute2+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _minute2+0 
;MyProject.c,299 :: 		break;
	GOTO        L_inputTime28
;MyProject.c,300 :: 		case 3:
L_inputTime36:
;MyProject.c,301 :: 		if((!mode)&& abs(set))
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime39
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
	GOTO        L_inputTime39
L__inputTime266:
;MyProject.c,303 :: 		write_ds1307(0,0x00); //Reset second to 0 sec. and start Oscillator
	CLRF        FARG_write_ds1307_address+0 
	CLRF        FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,304 :: 		second2 = 0x00;
	CLRF        _second2+0 
;MyProject.c,305 :: 		Lcd_out(1,12, "00");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,306 :: 		}
L_inputTime39:
;MyProject.c,307 :: 		break;
	GOTO        L_inputTime28
;MyProject.c,308 :: 		}
L_inputTime27:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime29
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime33
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime36
L_inputTime28:
;MyProject.c,310 :: 		}
L_inputTime26:
;MyProject.c,311 :: 		}
L_inputTime17:
;MyProject.c,312 :: 		time2Str(1);
	MOVLW       1
	MOVWF       FARG_time2Str_temp+0 
	MOVLW       0
	MOVWF       FARG_time2Str_temp+1 
	CALL        _time2Str+0, 0
;MyProject.c,315 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;MyProject.c,316 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime40
	CLRF        _loopcount+0 
L_inputTime40:
;MyProject.c,317 :: 		if(loopcount < 5)                 //Full display for 0.5s
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputTime41
;MyProject.c,319 :: 		Lcd_out(1,6, time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,320 :: 		Lcd_out(2,3, "Save");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,321 :: 		Lcd_out(2,10, "Cancel");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,322 :: 		}
	GOTO        L_inputTime42
L_inputTime41:
;MyProject.c,325 :: 		if (set_count  ==1) Lcd_out(1,6, "__");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime43
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime44
L_inputTime43:
;MyProject.c,326 :: 		else if (set_count  ==2) Lcd_out(1,9, "__");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime45
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime46
L_inputTime45:
;MyProject.c,327 :: 		else if (set_count  ==3) Lcd_out(1,12, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime47
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime48
L_inputTime47:
;MyProject.c,328 :: 		else if (set_count == 4) Lcd_out(2,3, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime49
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputTime50
L_inputTime49:
;MyProject.c,329 :: 		else if (set_count  ==5) Lcd_out(2,10, "______");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime51
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_inputTime51:
L_inputTime50:
L_inputTime48:
L_inputTime46:
L_inputTime44:
;MyProject.c,330 :: 		}
L_inputTime42:
;MyProject.c,333 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime52:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime52
	DECFSZ      R12, 1, 1
	BRA         L_inputTime52
	DECFSZ      R11, 1, 1
	BRA         L_inputTime52
	NOP
;MyProject.c,335 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_inputTime53
;MyProject.c,337 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputTime54:
	DECFSZ      R13, 1, 1
	BRA         L_inputTime54
	DECFSZ      R12, 1, 1
	BRA         L_inputTime54
	DECFSZ      R11, 1, 1
	BRA         L_inputTime54
	NOP
;MyProject.c,338 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_inputTime55
;MyProject.c,340 :: 		if(set_count == 4)              //if Save is pressed
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime56
;MyProject.c,342 :: 		if(!mode)                    //Write to RTC
	MOVF        FARG_inputTime_mode+0, 0 
	IORWF       FARG_inputTime_mode+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime57
;MyProject.c,344 :: 		write_ds1307(2, hour2);
	MOVLW       2
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        _hour2+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,345 :: 		write_ds1307(1, minute2);
	MOVLW       1
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        _minute2+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,346 :: 		break;
	GOTO        L_inputTime9
;MyProject.c,347 :: 		}
L_inputTime57:
;MyProject.c,350 :: 		alarmHr[mode-1] = BCD2Binary(hr2);
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _alarmHr+0
	ADDWF       R0, 0 
	MOVWF       FLOC__inputTime+0 
	MOVLW       hi_addr(_alarmHr+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__inputTime+1 
	MOVF        _hr2+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVF        _hr2+1, 0 
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVFF       FLOC__inputTime+0, FSR1
	MOVFF       FLOC__inputTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,351 :: 		alarmMinute[mode-1] = BCD2Binary(minute2);
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmMinute+0
	ADDWF       R0, 0 
	MOVWF       FLOC__inputTime+0 
	MOVLW       hi_addr(_alarmMinute+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__inputTime+1 
	MOVF        _minute2+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _minute2+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVFF       FLOC__inputTime+0, FSR1
	MOVFF       FLOC__inputTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,352 :: 		alarmAP[mode-1] = BCD2Binary(ap2);
	MOVLW       1
	SUBWF       FARG_inputTime_mode+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_inputTime_mode+1, 0 
	MOVWF       R1 
	MOVLW       _alarmAP+0
	ADDWF       R0, 0 
	MOVWF       FLOC__inputTime+0 
	MOVLW       hi_addr(_alarmAP+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__inputTime+1 
	MOVF        _ap2+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _ap2+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVFF       FLOC__inputTime+0, FSR1
	MOVFF       FLOC__inputTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,353 :: 		break;
	GOTO        L_inputTime9
;MyProject.c,355 :: 		}
L_inputTime56:
;MyProject.c,357 :: 		if(set_count == 5) break;
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputTime59
	GOTO        L_inputTime9
L_inputTime59:
;MyProject.c,358 :: 		}
L_inputTime55:
;MyProject.c,359 :: 		}
L_inputTime53:
;MyProject.c,360 :: 		if(goBackAlarm) break;            //Break if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputTime60
	GOTO        L_inputTime9
L_inputTime60:
;MyProject.c,361 :: 		}
	GOTO        L_inputTime8
L_inputTime9:
;MyProject.c,363 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,364 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,365 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,367 :: 		}
L_end_inputTime:
	RETURN      0
; end of _inputTime

_inputDate:

;MyProject.c,369 :: 		void inputDate()                      // Interface for input & write Date
;MyProject.c,371 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,372 :: 		Lcd_out(1,1,"Date:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,373 :: 		Lcd_out(1,6, date);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _date+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_date+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,374 :: 		Lcd_out(2,1," [Save] [Cancel]");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,376 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,377 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,379 :: 		while(1)
L_inputDate61:
;MyProject.c,381 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,382 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate63
;MyProject.c,384 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate64:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate64
	DECFSZ      R12, 1, 1
	BRA         L_inputDate64
	DECFSZ      R11, 1, 1
	BRA         L_inputDate64
	NOP
;MyProject.c,385 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_inputDate65
;MyProject.c,387 :: 		set_count++;
	INCF        _set_count+0, 1 
;MyProject.c,388 :: 		if(set_count > 5)
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate66
;MyProject.c,390 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;MyProject.c,391 :: 		}
L_inputDate66:
;MyProject.c,392 :: 		}
L_inputDate65:
;MyProject.c,393 :: 		}
L_inputDate63:
;MyProject.c,395 :: 		if(set_count)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate67
;MyProject.c,397 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputDate68
;MyProject.c,399 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate69:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate69
	DECFSZ      R12, 1, 1
	BRA         L_inputDate69
	DECFSZ      R11, 1, 1
	BRA         L_inputDate69
	NOP
;MyProject.c,400 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_inputDate70
;MyProject.c,401 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_inputDate70:
;MyProject.c,402 :: 		}
L_inputDate68:
;MyProject.c,404 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputDate71
;MyProject.c,406 :: 		Delay_ms(100);
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
;MyProject.c,407 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_inputDate73
;MyProject.c,408 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_inputDate73:
;MyProject.c,409 :: 		}
L_inputDate71:
;MyProject.c,410 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate76
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate76
L__inputDate271:
;MyProject.c,412 :: 		switch(set_count)
	GOTO        L_inputDate77
;MyProject.c,414 :: 		case 3:
L_inputDate79:
;MyProject.c,415 :: 		day = BCD2Binary(day);
	MOVF        _day+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _day+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
;MyProject.c,416 :: 		day = day + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _day+0 
;MyProject.c,417 :: 		day = Binary2BCD(day);
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
;MyProject.c,423 :: 		if(month == 0x1 || month == 0x3 || month == 0x5 || month == 0x7 || month == 0x8 || month == 0x10 || month == 0x12) // 31 Days
	MOVF        _month+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	MOVF        _month+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate270
	GOTO        L_inputDate82
L__inputDate270:
;MyProject.c,425 :: 		if (day > 0x31) day =1;
	MOVLW       128
	XORLW       49
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate83
	MOVLW       1
	MOVWF       _day+0 
L_inputDate83:
;MyProject.c,426 :: 		if (day < 1) day = 0x31;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate84
	MOVLW       49
	MOVWF       _day+0 
L_inputDate84:
;MyProject.c,427 :: 		}
L_inputDate82:
;MyProject.c,428 :: 		if(month == 0x4 || month == 0x6 || month == 0x9 || month == 0x11) // 30 Days
	MOVF        _month+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate269
	MOVF        _month+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate269
	MOVF        _month+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate269
	MOVF        _month+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L__inputDate269
	GOTO        L_inputDate87
L__inputDate269:
;MyProject.c,430 :: 		if (day > 0x30) day =1;
	MOVLW       128
	XORLW       48
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate88
	MOVLW       1
	MOVWF       _day+0 
L_inputDate88:
;MyProject.c,431 :: 		if (day < 1) day = 0x30;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate89
	MOVLW       48
	MOVWF       _day+0 
L_inputDate89:
;MyProject.c,432 :: 		}
L_inputDate87:
;MyProject.c,433 :: 		if(month == 0x2) // February
	MOVF        _month+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate90
;MyProject.c,435 :: 		if(BCD2Binary(year) % 100 == 0)                                          // If Divisible by 100
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _year+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputDate295
	MOVLW       0
	XORWF       R0, 0 
L__inputDate295:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate91
;MyProject.c,437 :: 		if(BCD2Binary(year) % 400 == 0) //Leap Year
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _year+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVLW       144
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputDate296
	MOVLW       0
	XORWF       R0, 0 
L__inputDate296:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate92
;MyProject.c,439 :: 		if (day > 0x29) day =1;
	MOVLW       128
	XORLW       41
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate93
	MOVLW       1
	MOVWF       _day+0 
L_inputDate93:
;MyProject.c,440 :: 		if (day < 1) day = 0x29;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate94
	MOVLW       41
	MOVWF       _day+0 
L_inputDate94:
;MyProject.c,441 :: 		}
	GOTO        L_inputDate95
L_inputDate92:
;MyProject.c,444 :: 		if (day > 0x28) day =1;
	MOVLW       128
	XORLW       40
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate96
	MOVLW       1
	MOVWF       _day+0 
L_inputDate96:
;MyProject.c,445 :: 		if (day < 1) day = 0x28;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate97
	MOVLW       40
	MOVWF       _day+0 
L_inputDate97:
;MyProject.c,446 :: 		}
L_inputDate95:
;MyProject.c,447 :: 		}
	GOTO        L_inputDate98
L_inputDate91:
;MyProject.c,450 :: 		if(BCD2Binary(year) % 4 == 0) //Leap Year
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _year+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__inputDate297
	MOVLW       0
	XORWF       R0, 0 
L__inputDate297:
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate99
;MyProject.c,452 :: 		if (day > 0x29) day =1;
	MOVLW       128
	XORLW       41
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate100
	MOVLW       1
	MOVWF       _day+0 
L_inputDate100:
;MyProject.c,453 :: 		if (day < 1) day = 0x29;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate101
	MOVLW       41
	MOVWF       _day+0 
L_inputDate101:
;MyProject.c,454 :: 		}
	GOTO        L_inputDate102
L_inputDate99:
;MyProject.c,457 :: 		if (day > 0x28) day =1;
	MOVLW       128
	XORLW       40
	MOVWF       R0 
	MOVLW       128
	XORWF       _day+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate103
	MOVLW       1
	MOVWF       _day+0 
L_inputDate103:
;MyProject.c,458 :: 		if (day < 1) day = 0x28;
	MOVLW       128
	XORWF       _day+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate104
	MOVLW       40
	MOVWF       _day+0 
L_inputDate104:
;MyProject.c,459 :: 		}
L_inputDate102:
;MyProject.c,460 :: 		}
L_inputDate98:
;MyProject.c,461 :: 		}
L_inputDate90:
;MyProject.c,463 :: 		break;
	GOTO        L_inputDate78
;MyProject.c,466 :: 		case 2:
L_inputDate105:
;MyProject.c,467 :: 		month = BCD2Binary(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _month+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;MyProject.c,468 :: 		month = month + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _month+0 
;MyProject.c,469 :: 		month = Binary2BCD(month);
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;MyProject.c,470 :: 		if(month > 0x12)
	MOVLW       128
	XORLW       18
	MOVWF       R2 
	MOVLW       128
	XORWF       R0, 0 
	SUBWF       R2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate106
;MyProject.c,471 :: 		month = 1;
	MOVLW       1
	MOVWF       _month+0 
L_inputDate106:
;MyProject.c,472 :: 		if(month <= 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _month+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate107
;MyProject.c,473 :: 		month = 0x12;
	MOVLW       18
	MOVWF       _month+0 
L_inputDate107:
;MyProject.c,474 :: 		minute = Binary2BCD(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       _minute+0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;MyProject.c,476 :: 		break;
	GOTO        L_inputDate78
;MyProject.c,477 :: 		case 1:
L_inputDate108:
;MyProject.c,478 :: 		year = BCD2Binary(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _year+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;MyProject.c,479 :: 		year = year + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _year+0 
;MyProject.c,480 :: 		year = Binary2BCD(year);
	MOVF        R0, 0 
	MOVWF       FARG_Binary2BCD_a+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_Binary2BCD_a+1 
	CALL        _Binary2BCD+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;MyProject.c,481 :: 		if(year <= -1)
	MOVLW       128
	XORLW       255
	MOVWF       R2 
	MOVLW       128
	XORWF       R0, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate109
;MyProject.c,482 :: 		year = 0x99;
	MOVLW       153
	MOVWF       _year+0 
L_inputDate109:
;MyProject.c,483 :: 		if(year >= 0x50)
	MOVLW       128
	XORWF       _year+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       80
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_inputDate110
;MyProject.c,484 :: 		year = 0;
	CLRF        _year+0 
L_inputDate110:
;MyProject.c,485 :: 		break;
	GOTO        L_inputDate78
;MyProject.c,486 :: 		}
L_inputDate77:
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate79
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate105
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate108
L_inputDate78:
;MyProject.c,488 :: 		}
L_inputDate76:
;MyProject.c,489 :: 		}
L_inputDate67:
;MyProject.c,490 :: 		date2Str();
	CALL        _date2Str+0, 0
;MyProject.c,493 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;MyProject.c,494 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate111
	CLRF        _loopcount+0 
L_inputDate111:
;MyProject.c,495 :: 		if(loopcount < 5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inputDate112
;MyProject.c,497 :: 		Lcd_out(1,6, date);     //Show full date for 1s
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _date+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_date+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,498 :: 		Lcd_out(2,3, "Save");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,499 :: 		Lcd_out(2,10, "Cancel");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,500 :: 		}
	GOTO        L_inputDate113
L_inputDate112:
;MyProject.c,503 :: 		if (set_count  ==1) Lcd_out(1,12, "__");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate114
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate115
L_inputDate114:
;MyProject.c,504 :: 		else if (set_count  ==2) Lcd_out(1,9, "__");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate116
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate117
L_inputDate116:
;MyProject.c,505 :: 		else if (set_count  ==3) Lcd_out(1,6, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate118
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate119
L_inputDate118:
;MyProject.c,506 :: 		else if (set_count == 4) Lcd_out(2,3, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate120
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_inputDate121
L_inputDate120:
;MyProject.c,507 :: 		else if (set_count  ==5) Lcd_out(2,10, "______");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate122
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_inputDate122:
L_inputDate121:
L_inputDate119:
L_inputDate117:
L_inputDate115:
;MyProject.c,508 :: 		}
L_inputDate113:
;MyProject.c,511 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate123:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate123
	DECFSZ      R12, 1, 1
	BRA         L_inputDate123
	DECFSZ      R11, 1, 1
	BRA         L_inputDate123
	NOP
;MyProject.c,513 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_inputDate124
;MyProject.c,515 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_inputDate125:
	DECFSZ      R13, 1, 1
	BRA         L_inputDate125
	DECFSZ      R12, 1, 1
	BRA         L_inputDate125
	DECFSZ      R11, 1, 1
	BRA         L_inputDate125
	NOP
;MyProject.c,516 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_inputDate126
;MyProject.c,518 :: 		if(set_count == 4 )             //Write to RTC, if Save is pressed
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_inputDate127
;MyProject.c,520 :: 		write_ds1307(4, day);
	MOVLW       4
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        _day+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,521 :: 		write_ds1307(5,month);
	MOVLW       5
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        _month+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,522 :: 		write_ds1307(6, year);
	MOVLW       6
	MOVWF       FARG_write_ds1307_address+0 
	MOVF        _year+0, 0 
	MOVWF       FARG_write_ds1307_w_data+0 
	CALL        _write_ds1307+0, 0
;MyProject.c,523 :: 		}
L_inputDate127:
;MyProject.c,524 :: 		break;
	GOTO        L_inputDate62
;MyProject.c,527 :: 		}
L_inputDate126:
;MyProject.c,528 :: 		}
L_inputDate124:
;MyProject.c,529 :: 		if(goBackAlarm) break;                  //Break if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_inputDate129
	GOTO        L_inputDate62
L_inputDate129:
;MyProject.c,530 :: 		}
	GOTO        L_inputDate61
L_inputDate62:
;MyProject.c,532 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,533 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,534 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,536 :: 		}
L_end_inputDate:
	RETURN      0
; end of _inputDate

_populateAlarm:

;MyProject.c,539 :: 		void populateAlarm(int alarmNo)
;MyProject.c,541 :: 		switch(alarmNo)  //Add the alarm's number in LCD
	GOTO        L_populateAlarm130
;MyProject.c,543 :: 		case 1:
L_populateAlarm132:
;MyProject.c,544 :: 		menuAlarmText[0][6] = '1';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       49
	MOVWF       POSTINC1+0 
;MyProject.c,545 :: 		break;
	GOTO        L_populateAlarm131
;MyProject.c,546 :: 		case 2:
L_populateAlarm133:
;MyProject.c,547 :: 		menuAlarmText[0][6] = '2';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       50
	MOVWF       POSTINC1+0 
;MyProject.c,548 :: 		break;
	GOTO        L_populateAlarm131
;MyProject.c,549 :: 		case 3:
L_populateAlarm134:
;MyProject.c,550 :: 		menuAlarmText[0][6] = '3';
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       51
	MOVWF       POSTINC1+0 
;MyProject.c,551 :: 		break;
	GOTO        L_populateAlarm131
;MyProject.c,552 :: 		}
L_populateAlarm130:
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm299
	MOVLW       1
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm299:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm132
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm300
	MOVLW       2
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm300:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm133
	MOVLW       0
	XORWF       FARG_populateAlarm_alarmNo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__populateAlarm301
	MOVLW       3
	XORWF       FARG_populateAlarm_alarmNo+0, 0 
L__populateAlarm301:
	BTFSC       STATUS+0, 2 
	GOTO        L_populateAlarm134
L_populateAlarm131:
;MyProject.c,554 :: 		if(alarmStatus[alarmNo-1]) //ON
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
	GOTO        L_populateAlarm135
;MyProject.c,556 :: 		menuAlarmText[0][9] = 'N';
	MOVLW       9
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       78
	MOVWF       POSTINC1+0 
;MyProject.c,557 :: 		menuAlarmText[0][10] = ' ';
	MOVLW       10
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;MyProject.c,558 :: 		}
	GOTO        L_populateAlarm136
L_populateAlarm135:
;MyProject.c,561 :: 		menuAlarmText[0][9] = 'F';
	MOVLW       9
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       70
	MOVWF       POSTINC1+0 
;MyProject.c,562 :: 		menuAlarmText[0][10] = 'F';
	MOVLW       10
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       70
	MOVWF       POSTINC1+0 
;MyProject.c,563 :: 		}
L_populateAlarm136:
;MyProject.c,565 :: 		menuAlarmText[1][15] = BCD2LowerCh(Binary2BCD(alarmTunes[alarmNo-1]));
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
;MyProject.c,568 :: 		menuAlarmText[1][7] = BCD2UpperCh(Binary2BCD(snoozeTimes[alarmNo-1]));
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
;MyProject.c,569 :: 		menuAlarmText[1][8] = BCD2LowerCh(Binary2BCD(snoozeTimes[alarmNo-1]));
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
;MyProject.c,572 :: 		Lcd_out(1,1, menuAlarmText[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,573 :: 		Lcd_out(2,1, menuAlarmText[1]);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+2, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+3, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,574 :: 		}
L_end_populateAlarm:
	RETURN      0
; end of _populateAlarm

_menuAlarm2:

;MyProject.c,578 :: 		void menuAlarm2(int alarmNo)//****************************** ALARM MENU
;MyProject.c,584 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,585 :: 		populateAlarm(alarmNo);
	MOVF        FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       FARG_populateAlarm_alarmNo+0 
	MOVF        FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       FARG_populateAlarm_alarmNo+1 
	CALL        _populateAlarm+0, 0
;MyProject.c,587 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,588 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,590 :: 		while(1)
L_menuAlarm2137:
;MyProject.c,592 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,593 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_menuAlarm2139
;MyProject.c,595 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2140:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2140
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2140
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2140
	NOP
;MyProject.c,596 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_menuAlarm2141
;MyProject.c,598 :: 		set_count++;
	INCF        _set_count+0, 1 
;MyProject.c,599 :: 		if(set_count > 4)
	MOVF        _set_count+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2142
;MyProject.c,601 :: 		set_count = 1;
	MOVLW       1
	MOVWF       _set_count+0 
;MyProject.c,602 :: 		}
L_menuAlarm2142:
;MyProject.c,603 :: 		}
L_menuAlarm2141:
;MyProject.c,604 :: 		}
L_menuAlarm2139:
;MyProject.c,606 :: 		if(set_count)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2143
;MyProject.c,608 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuAlarm2144
;MyProject.c,610 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2145:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2145
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2145
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2145
	NOP
;MyProject.c,611 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuAlarm2146
;MyProject.c,612 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_menuAlarm2146:
;MyProject.c,613 :: 		}
L_menuAlarm2144:
;MyProject.c,615 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuAlarm2147
;MyProject.c,617 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2148:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2148
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2148
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2148
	NOP
;MyProject.c,618 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuAlarm2149
;MyProject.c,619 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_menuAlarm2149:
;MyProject.c,620 :: 		}
L_menuAlarm2147:
;MyProject.c,621 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2152
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2152
L__menuAlarm2272:
;MyProject.c,625 :: 		switch(set_count)
	GOTO        L_menuAlarm2153
;MyProject.c,627 :: 		case 1: //On Off
L_menuAlarm2155:
;MyProject.c,628 :: 		alarmStatus[alarmNo-1] = !alarmStatus[alarmNo-1];
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
;MyProject.c,629 :: 		break;
	GOTO        L_menuAlarm2154
;MyProject.c,630 :: 		case 3: //Snooze
L_menuAlarm2156:
;MyProject.c,631 :: 		snoozeTimes[alarmNo-1] += set;
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
;MyProject.c,632 :: 		if(snoozeTimes[alarmNo-1] >19) snoozeTimes[alarmNo-1] = 0;
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
	GOTO        L_menuAlarm2157
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
L_menuAlarm2157:
;MyProject.c,633 :: 		if(snoozeTimes[alarmNo-1] <0) snoozeTimes[alarmNo-1] = 19;
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
	GOTO        L_menuAlarm2158
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
L_menuAlarm2158:
;MyProject.c,634 :: 		break;
	GOTO        L_menuAlarm2154
;MyProject.c,635 :: 		case 2: //Time
L_menuAlarm2159:
;MyProject.c,636 :: 		alText[3] = BCD2LowerCh(Binary2BCD(alarmNo));
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
;MyProject.c,637 :: 		inputTime(2, alText);    //
	MOVLW       2
	MOVWF       FARG_inputTime_mode+0 
	MOVLW       0
	MOVWF       FARG_inputTime_mode+1 
	MOVLW       _alText+0
	MOVWF       FARG_inputTime_setStr+0 
	MOVLW       hi_addr(_alText+0)
	MOVWF       FARG_inputTime_setStr+1 
	CALL        _inputTime+0, 0
;MyProject.c,638 :: 		break;
	GOTO        L_menuAlarm2154
;MyProject.c,639 :: 		case 4: //Tune
L_menuAlarm2160:
;MyProject.c,640 :: 		alarmTunes[alarmNo-1] += set;
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
;MyProject.c,641 :: 		if(alarmTunes[alarmNo-1] >3) alarmTunes[alarmNo-1] = 1;
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
	GOTO        L_menuAlarm2161
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
L_menuAlarm2161:
;MyProject.c,642 :: 		break;
	GOTO        L_menuAlarm2154
;MyProject.c,644 :: 		}
L_menuAlarm2153:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2155
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2156
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2159
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2160
L_menuAlarm2154:
;MyProject.c,645 :: 		populateAlarm(alarmNo);
	MOVF        FARG_menuAlarm2_alarmNo+0, 0 
	MOVWF       FARG_populateAlarm_alarmNo+0 
	MOVF        FARG_menuAlarm2_alarmNo+1, 0 
	MOVWF       FARG_populateAlarm_alarmNo+1 
	CALL        _populateAlarm+0, 0
;MyProject.c,647 :: 		}
L_menuAlarm2152:
;MyProject.c,649 :: 		loopcount ++;
	INCF        _loopcount+0, 1 
;MyProject.c,650 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2162
	CLRF        _loopcount+0 
L_menuAlarm2162:
;MyProject.c,651 :: 		if(loopcount < 5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuAlarm2163
;MyProject.c,653 :: 		Lcd_out(1,1, menuAlarmText[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,654 :: 		Lcd_out(2,1, menuAlarmText[1]);     //Show full menu for 0.5s
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _menuAlarmText+2, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _menuAlarmText+3, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,655 :: 		}
	GOTO        L_menuAlarm2164
L_menuAlarm2163:
;MyProject.c,658 :: 		if      (set_count  ==1) Lcd_out(1,9, "___");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2165
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr23_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2166
L_menuAlarm2165:
;MyProject.c,659 :: 		else if (set_count  ==2) Lcd_out(1,13, "____");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2167
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr24_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2168
L_menuAlarm2167:
;MyProject.c,660 :: 		else if (set_count  ==3) Lcd_out(2,8, "__");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2169
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr25_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuAlarm2170
L_menuAlarm2169:
;MyProject.c,661 :: 		else if (set_count  ==4) Lcd_out(2,16, "_");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_menuAlarm2171
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_menuAlarm2171:
L_menuAlarm2170:
L_menuAlarm2168:
L_menuAlarm2166:
;MyProject.c,662 :: 		}
L_menuAlarm2164:
;MyProject.c,664 :: 		}
L_menuAlarm2143:
;MyProject.c,666 :: 		if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_menuAlarm2172
;MyProject.c,668 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2173:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2173
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2173
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2173
	NOP
;MyProject.c,669 :: 		if(PORTA.F3 == 0) break;
	BTFSC       PORTA+0, 3 
	GOTO        L_menuAlarm2174
	GOTO        L_menuAlarm2138
L_menuAlarm2174:
;MyProject.c,670 :: 		}
L_menuAlarm2172:
;MyProject.c,672 :: 		if(goBackAlarm) break;            //Immediately go back if alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuAlarm2175
	GOTO        L_menuAlarm2138
L_menuAlarm2175:
;MyProject.c,675 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuAlarm2176:
	DECFSZ      R13, 1, 1
	BRA         L_menuAlarm2176
	DECFSZ      R12, 1, 1
	BRA         L_menuAlarm2176
	DECFSZ      R11, 1, 1
	BRA         L_menuAlarm2176
	NOP
;MyProject.c,676 :: 		}
	GOTO        L_menuAlarm2137
L_menuAlarm2138:
;MyProject.c,678 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,679 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,680 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,681 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,682 :: 		menuAlarmText[0][6] = "_";
	MOVLW       6
	ADDWF       _menuAlarmText+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      _menuAlarmText+1, 0 
	MOVWF       FSR1H 
	MOVLW       ?lstr_27_MyProject+0
	MOVWF       POSTINC1+0 
;MyProject.c,683 :: 		}
L_end_menuAlarm2:
	RETURN      0
; end of _menuAlarm2

_menuMain2:

;MyProject.c,686 :: 		void menuMain2() //***************************************** MAIN MENU
;MyProject.c,691 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;MyProject.c,692 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,693 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,694 :: 		Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr29_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr29_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,696 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,697 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,698 :: 		while(1)
L_menuMain2177:
;MyProject.c,700 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,701 :: 		if(PORTA.F0 == 0)              //Mode Pressed
	BTFSC       PORTA+0, 0 
	GOTO        L_menuMain2179
;MyProject.c,703 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2180:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2180
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2180
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2180
	NOP
;MyProject.c,704 :: 		if(PORTA.F0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_menuMain2181
;MyProject.c,706 :: 		set_count++;
	INCF        _set_count+0, 1 
;MyProject.c,707 :: 		if(set_count > 5)  set_count = 1;
	MOVF        _set_count+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_menuMain2182
	MOVLW       1
	MOVWF       _set_count+0 
L_menuMain2182:
;MyProject.c,708 :: 		}
L_menuMain2181:
;MyProject.c,709 :: 		}
L_menuMain2179:
;MyProject.c,711 :: 		if(set_count)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2183
;MyProject.c,713 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuMain2184
;MyProject.c,715 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2185:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2185
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2185
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2185
	NOP
;MyProject.c,716 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_menuMain2186
;MyProject.c,717 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
L_menuMain2186:
;MyProject.c,718 :: 		}
L_menuMain2184:
;MyProject.c,720 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuMain2187
;MyProject.c,722 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2188:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2188
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2188
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2188
	NOP
;MyProject.c,723 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_menuMain2189
;MyProject.c,724 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
L_menuMain2189:
;MyProject.c,725 :: 		}
L_menuMain2187:
;MyProject.c,726 :: 		if(set_count && set)
	MOVF        _set_count+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2192
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2192
L__menuMain2273:
;MyProject.c,728 :: 		switch(set_count)
	GOTO        L_menuMain2193
;MyProject.c,730 :: 		case 1: // Alarm1
L_menuMain2195:
;MyProject.c,731 :: 		menuAlarm2(1);
	MOVLW       1
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;MyProject.c,732 :: 		break;
	GOTO        L_menuMain2194
;MyProject.c,733 :: 		case 2: //Alarm2
L_menuMain2196:
;MyProject.c,734 :: 		menuAlarm2(2);
	MOVLW       2
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;MyProject.c,735 :: 		break;
	GOTO        L_menuMain2194
;MyProject.c,736 :: 		case 3: //Alarm3
L_menuMain2197:
;MyProject.c,737 :: 		menuAlarm2(3);
	MOVLW       3
	MOVWF       FARG_menuAlarm2_alarmNo+0 
	MOVLW       0
	MOVWF       FARG_menuAlarm2_alarmNo+1 
	CALL        _menuAlarm2+0, 0
;MyProject.c,738 :: 		break;
	GOTO        L_menuMain2194
;MyProject.c,739 :: 		case 4: //Time
L_menuMain2198:
;MyProject.c,740 :: 		inputTime(0, "Time:");
	CLRF        FARG_inputTime_mode+0 
	CLRF        FARG_inputTime_mode+1 
	MOVLW       ?lstr30_MyProject+0
	MOVWF       FARG_inputTime_setStr+0 
	MOVLW       hi_addr(?lstr30_MyProject+0)
	MOVWF       FARG_inputTime_setStr+1 
	CALL        _inputTime+0, 0
;MyProject.c,741 :: 		break;
	GOTO        L_menuMain2194
;MyProject.c,742 :: 		case 5: //Date
L_menuMain2199:
;MyProject.c,743 :: 		inputDate();
	CALL        _inputDate+0, 0
;MyProject.c,744 :: 		break;
	GOTO        L_menuMain2194
;MyProject.c,745 :: 		}
L_menuMain2193:
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2195
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2196
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2197
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2198
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2199
L_menuMain2194:
;MyProject.c,746 :: 		}
L_menuMain2192:
;MyProject.c,749 :: 		loopcount++;
	INCF        _loopcount+0, 1 
;MyProject.c,750 :: 		if(loopcount > 10) loopcount = 0; // For blinking
	MOVLW       128
	XORLW       10
	MOVWF       R0 
	MOVLW       128
	XORWF       _loopcount+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuMain2200
	CLRF        _loopcount+0 
L_menuMain2200:
;MyProject.c,751 :: 		if(loopcount < 5)
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_menuMain2201
;MyProject.c,753 :: 		Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr31_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr31_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr32_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr32_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,754 :: 		}
	GOTO        L_menuMain2202
L_menuMain2201:
;MyProject.c,757 :: 		if      (set_count  ==1) Lcd_out(1,12, "_");
	MOVF        _set_count+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2203
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr33_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr33_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2204
L_menuMain2203:
;MyProject.c,758 :: 		else if (set_count  ==2) Lcd_out(1,14, "_");
	MOVF        _set_count+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2205
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr34_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr34_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2206
L_menuMain2205:
;MyProject.c,759 :: 		else if (set_count  ==3) Lcd_out(1,16, "_");
	MOVF        _set_count+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2207
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr35_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr35_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2208
L_menuMain2207:
;MyProject.c,760 :: 		else if (set_count  ==4) Lcd_out(2,6, "____");
	MOVF        _set_count+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2209
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr36_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr36_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_menuMain2210
L_menuMain2209:
;MyProject.c,761 :: 		else if (set_count  ==5) Lcd_out(2,13, "____");
	MOVF        _set_count+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_menuMain2211
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr37_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr37_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_menuMain2211:
L_menuMain2210:
L_menuMain2208:
L_menuMain2206:
L_menuMain2204:
;MyProject.c,762 :: 		}
L_menuMain2202:
;MyProject.c,764 :: 		}
L_menuMain2183:
;MyProject.c,766 :: 		if(PORTA.F3 == 0)  // Break the while loop when menu pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_menuMain2212
;MyProject.c,768 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2213:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2213
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2213
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2213
	NOP
;MyProject.c,769 :: 		if(PORTA.F3 == 0) break;
	BTFSC       PORTA+0, 3 
	GOTO        L_menuMain2214
	GOTO        L_menuMain2178
L_menuMain2214:
;MyProject.c,770 :: 		}
L_menuMain2212:
;MyProject.c,771 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_menuMain2215:
	DECFSZ      R13, 1, 1
	BRA         L_menuMain2215
	DECFSZ      R12, 1, 1
	BRA         L_menuMain2215
	DECFSZ      R11, 1, 1
	BRA         L_menuMain2215
	NOP
;MyProject.c,773 :: 		if(goBackAlarm) break; //Immediately return if Alarm goes off
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menuMain2216
	GOTO        L_menuMain2178
L_menuMain2216:
;MyProject.c,774 :: 		}
	GOTO        L_menuMain2177
L_menuMain2178:
;MyProject.c,776 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,777 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,778 :: 		set_count = 0;
	CLRF        _set_count+0 
;MyProject.c,779 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,780 :: 		}
L_end_menuMain2:
	RETURN      0
; end of _menuMain2

_playTone:

;MyProject.c,783 :: 		void playTone()                              // Runs while ringing/snoozing the alarm. Plays the tone, stops, snooze...etc.
;MyProject.c,785 :: 		ringAlarmText[6] = BCD2LowerCh(Binary2BCD(goBackAlarm));
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
;MyProject.c,786 :: 		Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _ringAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _ringAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,787 :: 		loopcount = 0;
	CLRF        _loopcount+0 
;MyProject.c,789 :: 		while(1)
L_playTone217:
;MyProject.c,795 :: 		if         (loopcount < 5) Lcd_out(2,10, "       ");
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone219
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr38_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr38_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone220
L_playTone219:
;MyProject.c,796 :: 		else if    (loopcount <10) Lcd_out(2,10, "RINGING");
	MOVLW       128
	XORWF       _loopcount+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       10
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_playTone221
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr39_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr39_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_playTone222
L_playTone221:
;MyProject.c,797 :: 		else       loopcount = 0;
	CLRF        _loopcount+0 
L_playTone222:
L_playTone220:
;MyProject.c,799 :: 		if(PORTA.F1 == 0)              //Up/Snooze Pressed
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone223
;MyProject.c,801 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone224:
	DECFSZ      R13, 1, 1
	BRA         L_playTone224
	DECFSZ      R12, 1, 1
	BRA         L_playTone224
	DECFSZ      R11, 1, 1
	BRA         L_playTone224
	NOP
;MyProject.c,802 :: 		if(PORTA.F1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone225
;MyProject.c,805 :: 		Lcd_out(2,1, "SNOOZING - 00:00");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr40_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr40_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,806 :: 		snoozeMax = snoozeTimes[goBackAlarm-1]*600;   //Max Snooze count = snooze in seconds * 10
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
;MyProject.c,807 :: 		snoozeCounter = snoozeMax;
	MOVF        R0, 0 
	MOVWF       _snoozeCounter+0 
	MOVF        R1, 0 
	MOVWF       _snoozeCounter+1 
;MyProject.c,808 :: 		while(snoozeCounter >=1)
L_playTone226:
	MOVLW       128
	XORWF       _snoozeCounter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__playTone305
	MOVLW       1
	SUBWF       _snoozeCounter+0, 0 
L__playTone305:
	BTFSS       STATUS+0, 0 
	GOTO        L_playTone227
;MyProject.c,810 :: 		if(!(snoozeCounter%10))                   //Every second
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
	GOTO        L_playTone228
;MyProject.c,812 :: 		snoozeCounter = snoozeCounter/10;        //Bring the count to second
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
;MyProject.c,814 :: 		snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter/60));
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
;MyProject.c,815 :: 		snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter/60));
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
;MyProject.c,816 :: 		Lcd_out(2,12, snoozeTime);               //Show Minutes left
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _snoozeTime+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,818 :: 		snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter%60));
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
;MyProject.c,819 :: 		snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter%60));
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
;MyProject.c,821 :: 		Lcd_out(2,15, snoozeTime);               //Show Seconds left
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _snoozeTime+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _snoozeTime+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,823 :: 		snoozeCounter = snoozeCounter*10;         //Take it back to count
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
;MyProject.c,824 :: 		}
L_playTone228:
;MyProject.c,826 :: 		if(PORTA.F1 == 0)                           //If Snooze Pressed inside snooze, reset snooze count
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone229
;MyProject.c,828 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone230:
	DECFSZ      R13, 1, 1
	BRA         L_playTone230
	DECFSZ      R12, 1, 1
	BRA         L_playTone230
	DECFSZ      R11, 1, 1
	BRA         L_playTone230
	NOP
;MyProject.c,829 :: 		if(PORTA.F1 == 0) snoozeCounter = snoozeMax+1;
	BTFSC       PORTA+0, 1 
	GOTO        L_playTone231
	MOVLW       1
	ADDWF       _snoozeMax+0, 0 
	MOVWF       _snoozeCounter+0 
	MOVLW       0
	ADDWFC      _snoozeMax+1, 0 
	MOVWF       _snoozeCounter+1 
L_playTone231:
;MyProject.c,830 :: 		}
L_playTone229:
;MyProject.c,832 :: 		if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone232
;MyProject.c,834 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone233:
	DECFSZ      R13, 1, 1
	BRA         L_playTone233
	DECFSZ      R12, 1, 1
	BRA         L_playTone233
	DECFSZ      R11, 1, 1
	BRA         L_playTone233
	NOP
;MyProject.c,835 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone234
;MyProject.c,837 :: 		stopCounter = 1;
	MOVLW       1
	MOVWF       _stopCounter+0 
	MOVLW       0
	MOVWF       _stopCounter+1 
;MyProject.c,838 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;MyProject.c,839 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;MyProject.c,840 :: 		snoozeMax = 0;
	CLRF        _snoozeMax+0 
	CLRF        _snoozeMax+1 
;MyProject.c,841 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,842 :: 		return;
	GOTO        L_end_playTone
;MyProject.c,843 :: 		}
L_playTone234:
;MyProject.c,844 :: 		}
L_playTone232:
;MyProject.c,845 :: 		snoozeCounter--;
	MOVLW       1
	SUBWF       _snoozeCounter+0, 1 
	MOVLW       0
	SUBWFB      _snoozeCounter+1, 1 
;MyProject.c,846 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone235:
	DECFSZ      R13, 1, 1
	BRA         L_playTone235
	DECFSZ      R12, 1, 1
	BRA         L_playTone235
	DECFSZ      R11, 1, 1
	BRA         L_playTone235
	NOP
;MyProject.c,847 :: 		}
	GOTO        L_playTone226
L_playTone227:
;MyProject.c,848 :: 		snoozeTime = "00";
	MOVLW       ?lstr41_MyProject+0
	MOVWF       _snoozeTime+0 
	MOVLW       hi_addr(?lstr41_MyProject+0)
	MOVWF       _snoozeTime+1 
;MyProject.c,849 :: 		Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _ringAlarmText+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _ringAlarmText+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,850 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;MyProject.c,851 :: 		}
L_playTone225:
;MyProject.c,853 :: 		}
L_playTone223:
;MyProject.c,855 :: 		if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone236
;MyProject.c,857 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone237:
	DECFSZ      R13, 1, 1
	BRA         L_playTone237
	DECFSZ      R12, 1, 1
	BRA         L_playTone237
	DECFSZ      R11, 1, 1
	BRA         L_playTone237
	NOP
;MyProject.c,858 :: 		if(PORTA.F2 == 0)
	BTFSC       PORTA+0, 2 
	GOTO        L_playTone238
;MyProject.c,860 :: 		stopCounter = 1;
	MOVLW       1
	MOVWF       _stopCounter+0 
	MOVLW       0
	MOVWF       _stopCounter+1 
;MyProject.c,861 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;MyProject.c,862 :: 		snoozeCounter = 0;
	CLRF        _snoozeCounter+0 
	CLRF        _snoozeCounter+1 
;MyProject.c,863 :: 		snoozeMax = 0;
	CLRF        _snoozeMax+0 
	CLRF        _snoozeMax+1 
;MyProject.c,864 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,865 :: 		return;
	GOTO        L_end_playTone
;MyProject.c,866 :: 		}
L_playTone238:
;MyProject.c,867 :: 		}
L_playTone236:
;MyProject.c,868 :: 		loopcount++;
	INCF        _loopcount+0, 1 
;MyProject.c,869 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_playTone239:
	DECFSZ      R13, 1, 1
	BRA         L_playTone239
	DECFSZ      R12, 1, 1
	BRA         L_playTone239
	DECFSZ      R11, 1, 1
	BRA         L_playTone239
	NOP
;MyProject.c,870 :: 		}
	GOTO        L_playTone217
;MyProject.c,875 :: 		}
L_end_playTone:
	RETURN      0
; end of _playTone

_interrupt:

;MyProject.c,878 :: 		void interrupt(void)
;MyProject.c,880 :: 		if (TMR0IF_bit)          //Timer Interrupt (every  1 seconds)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt240
;MyProject.c,883 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;MyProject.c,884 :: 		TMR0H	 = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;MyProject.c,885 :: 		TMR0L	 = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;MyProject.c,890 :: 		if(stopCounter)                                                                  //If stop counter is activated
	MOVF        _stopCounter+0, 0 
	IORWF       _stopCounter+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt241
;MyProject.c,892 :: 		if(stopCounter > 90) stopCounter = 0;                                         //Expire the stop counter after 1.5 minutes
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _stopCounter+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt308
	MOVF        _stopCounter+0, 0 
	SUBLW       90
L__interrupt308:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt242
	CLRF        _stopCounter+0 
	CLRF        _stopCounter+1 
	GOTO        L_interrupt243
L_interrupt242:
;MyProject.c,893 :: 		else stopCounter += 1;                                                         //Increment the counter by 1 second.
	INFSNZ      _stopCounter+0, 1 
	INCF        _stopCounter+1, 1 
L_interrupt243:
;MyProject.c,894 :: 		}
	GOTO        L_interrupt244
L_interrupt241:
;MyProject.c,899 :: 		else if(!gobackAlarm)
	MOVF        _goBackAlarm+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt245
;MyProject.c,902 :: 		if      (alarmStatus[0] && (nowAP == alarmAP[0]) && (nowHrBin == alarmHr[0]) && (nowMinBin == alarmMinute[0]))
	MOVF        _alarmStatus+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt248
	MOVLW       0
	BTFSC       _alarmAP+0, 7 
	MOVLW       255
	XORWF       _nowAP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt309
	MOVF        _alarmAP+0, 0 
	XORWF       _nowAP+0, 0 
L__interrupt309:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt248
	MOVF        _nowHrBin+1, 0 
	XORWF       _alarmHr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt310
	MOVF        _alarmHr+0, 0 
	XORWF       _nowHrBin+0, 0 
L__interrupt310:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt248
	MOVF        _nowMinBin+0, 0 
	XORWF       _alarmMinute+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt248
L__interrupt276:
;MyProject.c,903 :: 		{goBackAlarm = 1;}
	MOVLW       1
	MOVWF       _goBackAlarm+0 
	GOTO        L_interrupt249
L_interrupt248:
;MyProject.c,904 :: 		else if (alarmStatus[1] && (nowAP == alarmAP[1]) && (nowHrBin == alarmHr[1]) && (nowMinBin == alarmMinute[1]))
	MOVF        _alarmStatus+1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt252
	MOVLW       0
	BTFSC       _alarmAP+1, 7 
	MOVLW       255
	XORWF       _nowAP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt311
	MOVF        _alarmAP+1, 0 
	XORWF       _nowAP+0, 0 
L__interrupt311:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt252
	MOVF        _nowHrBin+1, 0 
	XORWF       _alarmHr+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt312
	MOVF        _alarmHr+2, 0 
	XORWF       _nowHrBin+0, 0 
L__interrupt312:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt252
	MOVF        _nowMinBin+0, 0 
	XORWF       _alarmMinute+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt252
L__interrupt275:
;MyProject.c,905 :: 		{goBackAlarm = 2;}
	MOVLW       2
	MOVWF       _goBackAlarm+0 
	GOTO        L_interrupt253
L_interrupt252:
;MyProject.c,906 :: 		else if (alarmStatus[2] && (nowAP == alarmAP[2]) && (nowHrBin == alarmHr[2]) && (nowMinBin == alarmMinute[2]))
	MOVF        _alarmStatus+2, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt256
	MOVLW       0
	BTFSC       _alarmAP+2, 7 
	MOVLW       255
	XORWF       _nowAP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt313
	MOVF        _alarmAP+2, 0 
	XORWF       _nowAP+0, 0 
L__interrupt313:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt256
	MOVF        _nowHrBin+1, 0 
	XORWF       _alarmHr+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt314
	MOVF        _alarmHr+4, 0 
	XORWF       _nowHrBin+0, 0 
L__interrupt314:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt256
	MOVF        _nowMinBin+0, 0 
	XORWF       _alarmMinute+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt256
L__interrupt274:
;MyProject.c,907 :: 		goBackAlarm = 3;
	MOVLW       3
	MOVWF       _goBackAlarm+0 
L_interrupt256:
L_interrupt253:
L_interrupt249:
;MyProject.c,909 :: 		}
L_interrupt245:
L_interrupt244:
;MyProject.c,912 :: 		nowSecBin ++;
	INFSNZ      _nowSecBin+0, 1 
	INCF        _nowSecBin+1, 1 
;MyProject.c,913 :: 		if(nowSecBin > 59)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _nowSecBin+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt315
	MOVF        _nowSecBin+0, 0 
	SUBLW       59
L__interrupt315:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt257
;MyProject.c,915 :: 		nowSecBin = 0;
	CLRF        _nowSecBin+0 
	CLRF        _nowSecBin+1 
;MyProject.c,916 :: 		nowMinBin++;
	INCF        _nowMinBin+0, 1 
;MyProject.c,918 :: 		if(nowMinBin >59)
	MOVLW       128
	XORLW       59
	MOVWF       R0 
	MOVLW       128
	XORWF       _nowMinBin+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt258
;MyProject.c,920 :: 		nowHrBin ++;                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< COULD GIVE ERROR
	INFSNZ      _nowHrBin+0, 1 
	INCF        _nowHrBin+1, 1 
;MyProject.c,921 :: 		nowMinBin = 0;
	CLRF        _nowMinBin+0 
;MyProject.c,922 :: 		}
L_interrupt258:
;MyProject.c,923 :: 		}
L_interrupt257:
;MyProject.c,925 :: 		}
L_interrupt240:
;MyProject.c,926 :: 		}
L_end_interrupt:
L__interrupt307:
	RETFIE      1
; end of _interrupt

_main:

;MyProject.c,928 :: 		void main()
;MyProject.c,930 :: 		I2C1_Init(100000); //DS1307 I2C is running at 100KHz
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;MyProject.c,931 :: 		CMCON = 0x07;   // To turn off comparators
	MOVLW       7
	MOVWF       CMCON+0 
;MyProject.c,932 :: 		ADCON1 = 0x06;  // To turn off analog to digital converters
	MOVLW       6
	MOVWF       ADCON1+0 
;MyProject.c,933 :: 		TRISA = 0xFF;   //Port A Set output
	MOVLW       255
	MOVWF       TRISA+0 
;MyProject.c,934 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;MyProject.c,936 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;MyProject.c,937 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,940 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;MyProject.c,941 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,942 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,945 :: 		T0CON	 = 0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;MyProject.c,946 :: 		TMR0H	 = 0x0B;
	MOVLW       11
	MOVWF       TMR0H+0 
;MyProject.c,947 :: 		TMR0L	 = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;MyProject.c,948 :: 		GIE_bit	 = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;MyProject.c,949 :: 		TMR0IE_bit	 = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;MyProject.c,951 :: 		readTime();
	CALL        _readTime+0, 0
;MyProject.c,954 :: 		while(1)                                   //*********************Main Loop *****************************
L_main259:
;MyProject.c,956 :: 		Lcd_out(1,1,"Time:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr42_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr42_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,957 :: 		Lcd_out(2,1,"Date:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr43_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr43_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,958 :: 		readTime();
	CALL        _readTime+0, 0
;MyProject.c,959 :: 		nowHrBin = BCD2Binary(hour); nowMinBin = BCD2Binary(minute); nowSecBin = BCD2Binary(second); nowAP = ap;
	MOVF        _hour+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVF        _hour+1, 0 
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _nowHrBin+0 
	MOVF        R1, 0 
	MOVWF       _nowHrBin+1 
	MOVF        _minute+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _minute+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _nowMinBin+0 
	MOVF        _second+0, 0 
	MOVWF       FARG_BCD2Binary_a+0 
	MOVLW       0
	BTFSC       _second+0, 7 
	MOVLW       255
	MOVWF       FARG_BCD2Binary_a+1 
	CALL        _BCD2Binary+0, 0
	MOVF        R0, 0 
	MOVWF       _nowSecBin+0 
	MOVF        R1, 0 
	MOVWF       _nowSecBin+1 
	MOVF        _ap+0, 0 
	MOVWF       _nowAP+0 
	MOVLW       0
	BTFSC       _ap+0, 7 
	MOVLW       255
	MOVWF       _nowAP+1 
;MyProject.c,961 :: 		Lcd_out(1,6,time);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _time+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,962 :: 		Lcd_out(2,6,date);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _date+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_date+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,963 :: 		set = 0;
	CLRF        _set+0 
;MyProject.c,965 :: 		if(gobackAlarm)                          //When the gobackAlarm varibale was set by the Timer Interrupt (Alarm goes off),
	MOVF        _goBackAlarm+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main261
;MyProject.c,967 :: 		playTone();                           //Here we set the alarm
	CALL        _playTone+0, 0
;MyProject.c,968 :: 		goBackAlarm = 0;
	CLRF        _goBackAlarm+0 
;MyProject.c,969 :: 		}
L_main261:
;MyProject.c,973 :: 		if(PORTA.F3 == 0)              //Menu Button Pressed
	BTFSC       PORTA+0, 3 
	GOTO        L_main262
;MyProject.c,975 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main263:
	DECFSZ      R13, 1, 1
	BRA         L_main263
	DECFSZ      R12, 1, 1
	BRA         L_main263
	DECFSZ      R11, 1, 1
	BRA         L_main263
	NOP
;MyProject.c,976 :: 		if(PORTA.F3 == 0)
	BTFSC       PORTA+0, 3 
	GOTO        L_main264
;MyProject.c,978 :: 		menuMain2();
	CALL        _menuMain2+0, 0
;MyProject.c,979 :: 		}
L_main264:
;MyProject.c,980 :: 		}
L_main262:
;MyProject.c,982 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main265:
	DECFSZ      R13, 1, 1
	BRA         L_main265
	DECFSZ      R12, 1, 1
	BRA         L_main265
	DECFSZ      R11, 1, 1
	BRA         L_main265
	NOP
;MyProject.c,983 :: 		}
	GOTO        L_main259
;MyProject.c,984 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
