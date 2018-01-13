#line 1 "E:/Abarajithan/Desktop/Alarm Clock/Alarm Clock Final2/AlarmClock-Aba.c"
#line 13 "E:/Abarajithan/Desktop/Alarm Clock/Alarm Clock Final2/AlarmClock-Aba.c"
void time2Str(int); void date2Str();


sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;






unsigned short secondbin = 36;
unsigned short minutebin =42;
unsigned short hrbin = 5;
unsigned short ap = 0;
unsigned short month =1;
unsigned short date = 1;
unsigned short year = 16;

unsigned short secondbin2; minutebin2; hrbin2; ap2;


unsigned short set_count = 0;
short set = 0;


char time[] = "00:00:00 PM";
char datestr[] = "00-00-00";


short alarmTunes[3] = {3,2,1};
short snoozeTimes[3] = {15,2,5};
short alarmStatus[3] = {0,1,1};
unsigned short alarmHr[3] = {7,8,9};
short alarmMinute[3] = {10,45,15};
unsigned short alarmAP[3] = {0,0,0};


unsigned int tune1[] = {1047,1175,1319,1397,1568,1760,1975,2093,1975,1760,1568,1397,1319,1175,1047};
unsigned int tune2[] = {1760,1760,1760,2637,1975,2093,1975,1760,1568,1975,1760,1975,1760,1568,1760,1975,2093,1975,1760,1568,1318};
unsigned int tune3[] = {2093,2637,3136,4186,4186,3136,2637,2093};

unsigned char interval1[] = {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
unsigned char interval2[] = {3,1,2,2,1,1,1,2,2,2,1,1,1,1,1,1,2,2,1,1,3};
unsigned char interval3[] = {1,2,3,4,1,2,3,4};


char *menuAlarmText[2] = {"Alarm-1:O_ |Time","Snooze:__|Tone:_"};


short loopcount;
char alText[] = "AL-1:";


short goBackAlarm = 0;
int stopCounter = 0;
char* ringAlarmText = "Alarm 1: RINGING";
int snoozeCounter = 0;
int snoozeMax = 0;
char* snoozeTime = "00";
#line 113 "E:/Abarajithan/Desktop/Alarm Clock/Alarm Clock Final2/AlarmClock-Aba.c"
unsigned char BCD2UpperCh(unsigned char bcd)
{
 return ((bcd >> 4) + '0');
}

unsigned char BCD2LowerCh(unsigned char bcd)
{
 return ((bcd & 0x0F) + '0');
}

int Binary2BCD(int a)
{
 int t1, t2;
 t1 = a%10;
 t1 = t1 & 0x0F;
 a = a/10;
 t2 = a%10;
 t2 = 0x0F & t2;
 t2 = t2 << 4;
 t2 = 0xF0 & t2;
 t1 = t1 | t2;
 return t1;
}

int BCD2Binary(int a)
{
 int r,t;
 t = a & 0x0F;
 r = t;
 a = 0xF0 & a;
 t = a >> 4;
 t = 0x0F & t;
 r = t*10 + r;
 return r;
}
#line 162 "E:/Abarajithan/Desktop/Alarm Clock/Alarm Clock Final2/AlarmClock-Aba.c"
void time2Str(int temp)
{
 if (temp)
 {
 time[0] = BCD2UpperCh(Binary2BCD(hrbin2));
 time[1] = BCD2LowerCh(Binary2BCD(hrbin2));
 time[3] = BCD2UpperCh(Binary2BCD(minutebin2));
 time[4] = BCD2LowerCh(Binary2BCD(minutebin2));
 time[6] = BCD2UpperCh(Binary2BCD(secondbin2));
 time[7] = BCD2LowerCh(Binary2BCD(secondbin2));

 if(ap2)
 {
 time[9] = 'P';
 time[10] = 'M';
 }
 else
 {
 time[9] = 'A';
 time[10] = 'M';
 }
 }
 else
 {
 time[0] = BCD2UpperCh(Binary2BCD(hrbin));
 time[1] = BCD2LowerCh(Binary2BCD(hrbin));
 time[3] = BCD2UpperCh(Binary2BCD(minutebin));
 time[4] = BCD2LowerCh(Binary2BCD(minutebin));
 time[6] = BCD2UpperCh(Binary2BCD(secondbin));
 time[7] = BCD2LowerCh(Binary2BCD(secondbin));

 if(ap)
 {
 time[9] = 'P';
 time[10] = 'M';
 }
 else
 {
 time[9] = 'A';
 time[10] = 'M';
 }
 }
}

void date2Str()
{
 datestr[0] = BCD2UpperCh(Binary2BCD(date));
 datestr[1] = BCD2LowerCh(Binary2BCD(date));
 datestr[3] = BCD2UpperCh(Binary2BCD(month));
 datestr[4] = BCD2LowerCh(Binary2BCD(month));
 datestr[6] = BCD2UpperCh(Binary2BCD(year));
 datestr[7] = BCD2LowerCh(Binary2BCD(year));
}

void inputTime(int mode, char setStr[])
{
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_out(1,1,setStr);
 Lcd_out(2,1," [Save] [Cancel]");

 if(mode == 0)
 {

 secondbin2 = secondbin; minutebin2 = minutebin; hrbin2 = hrbin; ap2 = ap;
 }
 else
 {
 secondbin2 = 0; minutebin2 = alarmMinute[mode-1]; hrbin2 = alarmHr[mode-1]; ap2 = alarmAP[mode-1];
 }
 time2Str(mode);
 Lcd_out(1,6, time);

 loopcount = 0;
 set_count = 0;

 while(1)
 {


 set = 0;
 if(PORTA.F0 == 0)
 {
 Delay_ms(100);
 if(PORTA.F0 == 0)
 {
 while(PORTA.F0 == 0) {}
 set_count++;
 if(mode && (set_count == 3)) set_count++;

 if(set_count > 5)
 {
 set_count = 1;
 }
 }
 }

 if((set_count)&& (set_count != 4) && (set_count!= 5))
 {
 if(PORTA.F1 == 0)
 {
 Delay_ms(100);
 if(PORTA.F1 == 0)
 set = 1;
 }

 if(PORTA.F2 == 0)
 {
 Delay_ms(100);
 if(PORTA.F2 == 0)
 set = -1;
 }
 if(set_count && set)
 {


 switch(set_count)
 {
 case 1:
 hrbin2 = hrbin2 + set;
 if(hrbin2 > 12)
 { hrbin2 = 1; ap2 = !ap2;}
 if(hrbin2 < 1)
 { hrbin2 = 12; ap2 = !ap2;}
 break;
 case 2:
 minutebin2 = minutebin2 + set;
 if(minutebin2 >= 60)
 minutebin2 = 0;
 if(minutebin2 < 0)
 minutebin2 = 59;
 break;
 case 3:
 if((!mode)&& abs(set))
 {

 secondbin = 0;
 Lcd_out(1,12, "00");
 }
 break;
 }

 }
 }
 time2Str(1);


 loopcount ++;
 if(loopcount > 10) loopcount = 0;
 if(loopcount < 5)
 {
 Lcd_out(1,6, time);
 Lcd_out(2,3, "Save");
 Lcd_out(2,10, "Cancel");
 }
 else
 {
 if (set_count ==1) Lcd_out(1,6, "__");
 else if (set_count ==2) Lcd_out(1,9, "__");
 else if (set_count ==3) Lcd_out(1,12, "__");
 else if (set_count == 4) Lcd_out(2,3, "____");
 else if (set_count ==5) Lcd_out(2,10, "______");
 }


 Delay_ms(100);

 if(PORTA.F4 == 0)
 {
 Delay_ms(100);
 if(PORTA.F4 == 0)
 {
 if(set_count == 4)
 {
 if(!mode)
 {


 minutebin = minutebin2;
 hrbin = hrbin2;

 break;
 }
 else
 {
 alarmHr[mode-1] = hrbin2;
 alarmMinute[mode-1] = minutebin2;
 break;
 }
 }

 if(set_count == 5) break;
 }
 }
 if(PORTA.F3 == 0)
 {
 Delay_ms(100);
 if(PORTA.F3 == 0)
 {
 while(PORTA.F0 == 0) {}
 break;
 }
 }

 if(goBackAlarm) break;
 }

 Lcd_Cmd(_LCD_CLEAR);
 set = 0;
 set_count = 0;
 hrbin2 = 0;
 minutebin2 = 0;

}

void inputDate()
{
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_out(1,1,"Date:");
 Lcd_out(1,6, datestr);
 Lcd_out(2,1," [Save] [Cancel]");

 loopcount = 0;
 set_count = 0;

 while(1)
 {

 set = 0;
 if(PORTA.F0 == 0)
 {
 Delay_ms(100);
 if(PORTA.F0 == 0)
 {
 while(PORTA.F0 == 0) {}

 set_count++;
 if(set_count > 5)
 {
 set_count = 1;
 }
 }
 }

 if(set_count && (set_count != 4) && set_count != 5)
 {
 if(PORTA.F1 == 0)
 {
 Delay_ms(100);
 if(PORTA.F1 == 0)
 set = 1;
 }

 if(PORTA.F2 == 0)
 {
 Delay_ms(100);
 if(PORTA.F2 == 0)
 set = -1;
 }
 if(set_count && set)
 {
 switch(set_count)
 {
 case 3:
 date = date + set;

 if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
 {
 if (date > 31) date =1;
 if (date < 1) date = 31;
 }
 if(month == 4 || month == 6 || month == 9 || month == 11)
 {
 if (date > 30) date =1;
 if (date < 1) date = 30;
 }
 if(month == 2)
 {
 if(year % 100 == 0)
 {
 if(year % 400 == 0)
 {
 if (date > 29) date =1;
 if (date < 1) date = 29;
 }
 else
 {
 if (date > 28) date =1;
 if (date < 1) date = 28;
 }
 }
 else
 {
 if(year % 4 == 0)
 {
 if (date > 29) date =1;
 if (date < 1) date = 29;
 }
 else
 {
 if (date > 28) date =1;
 if (date < 1) date = 28;
 }
 }
 }

 break;

 case 2:
 month = month + set;
 if(month > 12)
 month = 1;
 if(month <= 0)
 month = 12;
 break;
 case 1:
 year = year + set;
 if(year <= -1)
 year = 99;
 if(year >= 100)
 year = 0;
 break;
 }

 }
 }
 date2Str();


 loopcount ++;
 if(loopcount > 10) loopcount = 0;
 if(loopcount < 5)
 {
 Lcd_out(1,6, date);
 Lcd_out(2,3, "Save");
 Lcd_out(2,10, "Cancel");
 }
 else
 {
 if (set_count ==1) Lcd_out(1,12, "__");
 else if (set_count ==2) Lcd_out(1,9, "__");
 else if (set_count ==3) Lcd_out(1,6, "__");
 else if (set_count == 4) Lcd_out(2,3, "____");
 else if (set_count ==5) Lcd_out(2,10, "______");
 }


 Delay_ms(100);

 if(PORTA.F4 == 0)
 {
 Delay_ms(100);
 if(PORTA.F4 == 0)
 {
 if(set_count == 4 )
 {



 }
 break;

 if(set_count == 5) break;
 }
 }
 if(PORTA.F3 == 0)
 {
 Delay_ms(100);
 if(PORTA.F3 == 0)
 {
 while(PORTA.F0 == 0) {}
 break;
 }
 }

 if(goBackAlarm) break;
 }

 Lcd_Cmd(_LCD_CLEAR);
 set = 0;
 set_count = 0;

}


void populateAlarm(int alarmNo)
{
 switch(alarmNo)
 {
 case 1:
 menuAlarmText[0][6] = '1';
 break;
 case 2:
 menuAlarmText[0][6] = '2';
 break;
 case 3:
 menuAlarmText[0][6] = '3';
 break;
 }

 if(alarmStatus[alarmNo-1])
 {
 menuAlarmText[0][9] = 'N';
 menuAlarmText[0][10] = ' ';
 }
 else
 {
 menuAlarmText[0][9] = 'F';
 menuAlarmText[0][10] = 'F';
 }

 menuAlarmText[1][15] = BCD2LowerCh(Binary2BCD(alarmTunes[alarmNo-1]));


 menuAlarmText[1][7] = BCD2UpperCh(Binary2BCD(snoozeTimes[alarmNo-1]));
 menuAlarmText[1][8] = BCD2LowerCh(Binary2BCD(snoozeTimes[alarmNo-1]));


 Lcd_out(1,1, menuAlarmText[0]);
 Lcd_out(2,1, menuAlarmText[1]);
}



void menuAlarm2(int alarmNo)




{
 Lcd_Cmd(_LCD_CLEAR);
 populateAlarm(alarmNo);

 loopcount = 0;
 set_count = 0;

 while(1)
 {


 set = 0;
 if(PORTA.F0 == 0)
 {
 Delay_ms(100);
 if(PORTA.F0 == 0)
 {
 while(PORTA.F0 == 0) {}
 set_count++;
 if(set_count > 4)
 {
 set_count = 1;
 }
 }
 }

 if(set_count)
 {
 if(PORTA.F1 == 0)
 {
 Delay_ms(100);
 if(PORTA.F1 == 0)
 set = 1;
 }

 if(PORTA.F2 == 0)
 {
 Delay_ms(100);
 if(PORTA.F2 == 0)
 set = -1;
 }
 if((PORTA.F4 ==0) && set_count == 2)
 {
 Delay_ms(100);
 if(PORTA.F4 ==0)
 {
 while(PORTA.F4 == 0) {}
 set = 1;
 }
 }

 if(set_count && set)
 {

 switch(set_count)
 {
 case 1:
 alarmStatus[alarmNo-1] = !alarmStatus[alarmNo-1];
 break;
 case 3:
 snoozeTimes[alarmNo-1] += set;
 if(snoozeTimes[alarmNo-1] >19) snoozeTimes[alarmNo-1] = 0;
 if(snoozeTimes[alarmNo-1] <0) snoozeTimes[alarmNo-1] = 19;
 break;
 case 2:
 alText[3] = BCD2LowerCh(Binary2BCD(alarmNo));
 inputTime(2, alText);
 break;
 case 4:
 alarmTunes[alarmNo-1] += set;
 if(alarmTunes[alarmNo-1] >3) alarmTunes[alarmNo-1] = 1;
 break;

 }
 populateAlarm(alarmNo);

 }

 loopcount ++;
 if(loopcount > 10) loopcount = 0;
 if(loopcount < 5)
 {
 Lcd_out(1,1, menuAlarmText[0]);
 Lcd_out(2,1, menuAlarmText[1]);
 }
 else
 {
 if (set_count ==1) Lcd_out(1,9, "___");
 else if (set_count ==2) Lcd_out(1,13, "____");
 else if (set_count ==3) Lcd_out(2,8, "__");
 else if (set_count ==4) Lcd_out(2,16, "_");
 }

 }

 if(PORTA.F3 == 0)
 {
 Delay_ms(100);
 if(PORTA.F3 == 0)
 {
 while(PORTA.F3 == 0) {}
 break;
 }
 }

 if(goBackAlarm) break;


 Delay_ms(100);
 }

 Lcd_Cmd(_LCD_CLEAR);
 set = 0;
 set_count = 0;
 loopcount = 0;
 menuAlarmText[0][6] = "_";
}


void menuMain2()



{
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 loopcount = 0;
 set_count = 0;
 while(1)
 {


 loopcount++;
 if(loopcount > 10) loopcount = 0;
 if((loopcount < 5)||(!set_count))
 {
 Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
 }

 set = 0;
 if(PORTA.F0 == 0)
 {
 Delay_ms(100);
 if(PORTA.F0 == 0)
 {
 while(PORTA.F0 == 0) {}
 set_count++;
 if(set_count > 5) set_count = 1;
 }
 }

 if(set_count)
 {
 if(PORTA.F4 == 0)
 {
 Delay_ms(100);
 if(PORTA.F4 == 0)
 {
 while(PORTA.F4 == 0) {}
 set = 1;
 }
 }
 if(set_count && set)
 {
 switch(set_count)
 {
 case 1:
 menuAlarm2(1);
 break;
 case 2:
 menuAlarm2(2);
 break;
 case 3:
 menuAlarm2(3);
 break;
 case 4:
 inputTime(0, "Time:");
 break;
 case 5:
 inputDate();
 break;
 }
 }



 if(loopcount >=5)
 {
 if (set_count ==1) Lcd_out(1,12, "_");
 else if (set_count ==2) Lcd_out(1,14, "_");
 else if (set_count ==3) Lcd_out(1,16, "_");
 else if (set_count ==4) Lcd_out(2,6, "____");
 else if (set_count ==5) Lcd_out(2,13, "____");
 }

 }

 if(PORTA.F3 == 0)
 {
 Delay_ms(100);
 if(PORTA.F3 == 0) break;
 }
 Delay_ms(100);

 if(goBackAlarm) break;
 }


 Lcd_Cmd(_LCD_CLEAR);
 set = 0;
 set_count = 0;
 loopcount = 0;
}

void playTone()
{
 ringAlarmText[6] = BCD2LowerCh(Binary2BCD(goBackAlarm));
 Lcd_out(2,1, ringAlarmText);
 loopcount = 0;

 while(1)
 {

 if(goBackAlarm == 1)
 {
 Sound_Play(tune1[loopcount], 100*interval1[loopcount]);

 if (loopcount < 8) Lcd_out(2,10, "       ");
 else if (loopcount <16) Lcd_out(2,10, "RINGING");
 else
 { loopcount = 0;
 Delay_ms(1000);
 }
 }
 else if(goBackAlarm == 2)
 {
 Sound_Play(tune2[loopcount], 100*interval2[loopcount]);

 if (loopcount < 1) Lcd_out(2,10, "       ");
 else if (loopcount < 2) Lcd_out(2,10, "RINGING");
 else
 { loopcount = 0;
 Delay_ms(1000);
 }
 }
 else if(goBackAlarm == 3)
 {
 Sound_Play(tune3[loopcount], 100*interval3[loopcount]);

 if (loopcount < 1) Lcd_out(2,10, "       ");
 else if (loopcount < 2) Lcd_out(2,10, "RINGING");
 else
 { loopcount = 0;
 Delay_ms(1000);
 }
 }
 else return;

 if(PORTA.F1 == 0)
 {
 Delay_ms(100);
 if(PORTA.F1 == 0)
 {

 Lcd_out(2,1, "SNOOZING - 00:00");
 snoozeMax = snoozeTimes[goBackAlarm-1]*600;
 snoozeCounter = snoozeMax;
 while(snoozeCounter >=1)
 {
 if(!(snoozeCounter%10))
 {
 snoozeCounter = snoozeCounter/10;

 snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter/60));
 snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter/60));
 Lcd_out(2,12, snoozeTime);

 snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter%60));
 snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter%60));

 Lcd_out(2,15, snoozeTime);

 snoozeCounter = snoozeCounter*10;
 }

 if(PORTA.F1 == 0)
 {
 Delay_ms(100);
 if(PORTA.F1 == 0) snoozeCounter = snoozeMax+1;
 }

 if(PORTA.F2 == 0)
 {
 Delay_ms(100);
 if(PORTA.F2 == 0)
 {
 stopCounter = 1;
 goBackAlarm = 0;
 snoozeCounter = 0;
 snoozeMax = 0;
 Lcd_Cmd(_LCD_CLEAR);
 return;
 }
 }
 snoozeCounter--;
 Delay_ms(100);
 }
 snoozeTime = "00";
 Lcd_out(2,1, ringAlarmText);
 snoozeCounter = 0;
 }

 }

 if(PORTA.F2 == 0)
 {
 Delay_ms(100);
 if(PORTA.F2 == 0)
 {
 stopCounter = 1;
 goBackAlarm = 0;
 snoozeCounter = 0;
 snoozeMax = 0;
 Lcd_Cmd(_LCD_CLEAR);
 return;
 }
 }


 loopcount++;
 Delay_ms(100);
 }

 goBackAlarm = 0;
 snoozeCounter = 0;
 snoozeMax = 0;
 Lcd_Cmd(_LCD_CLEAR);
}

void interrupt(void)
{
 if (TMR0IF_bit)
 {

 TMR0IF_bit = 0;
 TMR0H = 0x0B;
 TMR0L = 0xDC;


 secondbin++;
 if(secondbin >= 60)
 {
 secondbin = 0;
 minutebin++;
 }
 if (minutebin >= 60)
 {
 hrbin++;
 minutebin = 0;
 }
 if (hrbin > 12)
 {
 hrbin = 1;
 minutebin = 0;
 }
 if (hrbin ==12 && minutebin == 0 && secondbin == 0) ap = !ap;


 if(stopCounter)
 {
 if(stopCounter > 90) stopCounter = 0;
 else stopCounter += 1;
 }




 else if(!gobackAlarm)
 {

 if (alarmStatus[0] && (hrbin == alarmHr[0]) && (minutebin == alarmMinute[0]) && (ap == alarmAP[0]))
 goBackAlarm = 1;
 else if (alarmStatus[1] && (hrbin == alarmHr[1]) && (minutebin == alarmMinute[1]) && (ap == alarmAP[1]))
 goBackAlarm = 2;
 else if (alarmStatus[2] && (hrbin == alarmHr[2]) && (minutebin == alarmMinute[2]) && (ap == alarmAP[2]))
 goBackAlarm = 3;

 }
 }
}

void main()
{
 I2C1_Init(100000);

 CMCON = 0x07;
 ADCON1 = 0x0F;
 LATB = 0x00;


 TRISA = 0xFF;
 PORTA = 0xFF;
 TRISC = 0x00;


 Sound_Init(&PORTC,2);


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 T0CON = 0x84;
 TMR0H = 0x0B;
 TMR0L = 0xDC;
 GIE_bit = 1;
 TMR0IE_bit = 1;

 while(1)
 {
 Lcd_out(1,1,"Time:");
 Lcd_out(2,1,"Date:");


 time2Str(0);
 date2Str();

 Lcd_out(1,6,time);
 Lcd_out(2,6,datestr);
 set = 0;

 if(gobackAlarm)
 {
 playTone();
 goBackAlarm = 0;
 }

 if(PORTA.F3 == 0)
 {
 Delay_ms(50);
 if(PORTA.F3 == 0)
 {
 while(PORTA.F3 != 1) {}
 menuMain2();
 }
 }

 Delay_ms(100);
 }
}
