// Project Alarm Clock
// Group 01
// PIC 18 Family (Pic 16 has memory problems)


// Button Configuration
// A0  :      Mode
// A1  :      UP   / Snooze / Select
// A2  :      DOWN / Stop   / Select
// A3  :      Menu / Return

void time2Str(int); void date2Str();

// LCD module connections
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
// End LCD module connections


// ********************************************** VARIABLE DECLARATIONS *******************************

// All in BCD
short second; short minute; int hour; short day; short month; short year;
short dday;
int hr;
short ap;

short second2; short minute2; int hour2;
int hr2;
short ap2;

int nowHrBin; 
short nowMinBin; nowSecBin; nowAP;

//For Set Menus
unsigned short set_count = 0;
short set = 0;

//String Times and Dates
char time[] = "00:00:00 PM";
char date[] = "00-00-00";

//Alarms Memory
short alarmTunes[3] = {3,2,1};          //0-OFF, 1,2,3
short snoozeTimes[3] = {15,2,5};         //in minutes
short alarmStatus[3] = {1,1,1};
int alarmHr[3] = {0,0,0};            //in Binary
short alarmMinute[3] = {0,0,0};          //in Binary
short alarmAP[3] = {0,0,0};              //In Binary

//Menu Text
char *menuAlarmText[2] = {"Alarm-1:O_ |Time","Snooze:__|Tone:_"};

//Temporary variables
short loopcount;
char alText[] = "AL-1:";

//Check Alarm Variables
short goBackAlarm = 0;
int stopCounter = 0;
char* ringAlarmText = "Alarm 1: RINGING";
int snoozeCounter = 0;
int snoozeMax = 0;
char* snoozeTime = "00";



//*********************************** VAR-DECLARE - ENDS *************************************************
//*********************************** SYSTEM FUNCTIONS BEGIN**********************************************


unsigned short read_ds1307(unsigned short address)
{
  unsigned short r_data;
  I2C1_Start();
  I2C1_Wr(0xD0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
  I2C1_Wr(address);
  I2C1_Repeated_Start();
  I2C1_Wr(0xD1); //0x68 followed by 1 --> 0xD1
  r_data=I2C1_Rd(0);
  I2C1_Stop();
  return(r_data);
}

void write_ds1307(unsigned short address,unsigned short w_data)
{
  I2C1_Start(); // issue I2C start signal
  //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
  I2C1_Wr(0xD0); // send byte via I2C (device address + W)
  I2C1_Wr(address); // send byte (address of DS1307 location)
  I2C1_Wr(w_data); // send data (data to be written)
  I2C1_Stop(); // issue I2C stop signal
}

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

void readTime()
{
    second = read_ds1307(0);
      minute = read_ds1307(1);
      hour = read_ds1307(2);
       hr = hour & 0b00011111;
       ap = hour & 0b00100000;
      dday = read_ds1307(3);
      day = read_ds1307(4);
      month = read_ds1307(5);
      year = read_ds1307(6);

      time2Str(0);
     date2Str();
}

void time2Str(int temp)            //Mode {0-for permanent memory. If not temp memory
{
      if (temp)
      {
        time[0] = BCD2UpperCh(hr2);
        time[1] = BCD2LowerCh(hr2);
        time[3] = BCD2UpperCh(minute2);
        time[4] = BCD2LowerCh(minute2);
        time[6] = BCD2UpperCh(second2);
        time[7] = BCD2LowerCh(second2);

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
        time[0] = BCD2UpperCh(hr);
        time[1] = BCD2LowerCh(hr);
        time[3] = BCD2UpperCh(minute);
        time[4] = BCD2LowerCh(minute);
        time[6] = BCD2UpperCh(second);
        time[7] = BCD2LowerCh(second);

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
      date[0] = BCD2UpperCh(day);
      date[1] = BCD2LowerCh(day);
      date[3] = BCD2UpperCh(month);
      date[4] = BCD2LowerCh(month);
      date[6] = BCD2UpperCh(year);
      date[7] = BCD2LowerCh(year);
}

void inputTime(int mode, char setStr[])             // Interface for inputting time
{                                                    // Mode: 0: set time, 1: al1, 2:al-2, 3:al-3
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_out(1,1,setStr);
     Lcd_out(2,1," [Save] [Cancel]");

     if(mode == 0) //Setting time
     {second2 = second; minute2 = minute; hour2 = hour; hr2 = hr; ap2 = ap;}
     else // Setting alarm
     {
      second2 =Binary2BCD(0); minute2 = Binary2BCD(alarmMinute[mode-1]); hr2 = Binary2BCD(alarmHr[mode-1]);
      ap2 = alarmAP[mode-1];

      time2Str(mode);
     }
     Lcd_out(1,6, time);

     loopcount = 0;
     set_count = 0;

     while(1)
       {
         set = 0;
         if(PORTA.F0 == 0)              //Mode Pressed
         {
             Delay_ms(100);
             if(PORTA.F0 == 0)
             {
                 set_count++;
                 if(mode && (set_count == 3)) set_count++;   //Skip the seconds if mode
                 
                 if(set_count > 5)
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
            if(set_count && set)
            {


              switch(set_count)
              {
                case 1:
                        hour2 = BCD2Binary(hour2);
                        hour2 = hour2 + set;
                        hour2 = Binary2BCD(hour2);
                        if((hour2 & 0x1F) >= 0x13)
                        {
                          hour2 = hour2 & 0b11100001;
                          hour2 = hour2 ^ 0x20;
                        }
                        else if((hour2 & 0x1F) <= 0x00)
                        {
                          hour2 = hour2 | 0b00010010;
                          hour2 = hour2 ^ 0x20;
                        }

                        hr2 = hour2 & 0b00011111;
                        ap2 = hour2 & 0b00100000;

                        break;
                case 2:
                         minute2 = BCD2Binary(minute2);
                         minute2 = minute2 + set;
                         if(minute2 >= 60)
                            minute2 = 0;
                         if(minute2 < 0)
                            minute2 = 59;
                         minute2 = Binary2BCD(minute2);

                         break;
                case 3:
                        if((!mode)&& abs(set))
                        {
                          write_ds1307(0,0x00); //Reset second to 0 sec. and start Oscillator
                          second2 = 0x00;
                          Lcd_out(1,12, "00");
                        }
                        break;
                }

            }
            }
         time2Str(1);

         // ------------Blink Code
         loopcount ++;
         if(loopcount > 10) loopcount = 0; // For blinking
         if(loopcount < 5)                 //Full display for 0.5s
         {
            Lcd_out(1,6, time);
            Lcd_out(2,3, "Save");
            Lcd_out(2,10, "Cancel");
         }
         else                              //Stop display for 0.5s
         {
            if (set_count  ==1) Lcd_out(1,6, "__");
            else if (set_count  ==2) Lcd_out(1,9, "__");
            else if (set_count  ==3) Lcd_out(1,12, "__");
            else if (set_count == 4) Lcd_out(2,3, "____");
            else if (set_count  ==5) Lcd_out(2,10, "______");
         }
         //---------------

         Delay_ms(100);

         if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
           {
               Delay_ms(100);
               if(PORTA.F3 == 0)
               {
                   if(set_count == 4)              //if Save is pressed
                   {
                      if(!mode)                    //Write to RTC
                      {
                        write_ds1307(2, hour2);
                        write_ds1307(1, minute2);
                        break;
                      }
                      else                         //Write to Alarm times
                      {
                        alarmHr[mode-1] = BCD2Binary(hr2);
                        alarmMinute[mode-1] = BCD2Binary(minute2);
                        alarmAP[mode-1] = BCD2Binary(ap2);
                        break;
                      }
                   }

                   if(set_count == 5) break;
               }
           }
          if(goBackAlarm) break;            //Break if alarm goes off
       }

     Lcd_Cmd(_LCD_CLEAR);
     set = 0;
     set_count = 0;

}

void inputDate()                      // Interface for input & write Date
{
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_out(1,1,"Date:");
     Lcd_out(1,6, date);
     Lcd_out(2,1," [Save] [Cancel]");

     loopcount = 0;
     set_count = 0;

     while(1)
     {
       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
       {
           Delay_ms(100);
           if(PORTA.F0 == 0)
           {
               set_count++;
               if(set_count > 5)
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
          if(set_count && set)
          {
            switch(set_count)
            {
              case 3:
                     day = BCD2Binary(day);
                     day = day + set;
                     day = Binary2BCD(day);
                     /*if(day >= 0x32)
                        day = 1;
                     if(day <= 0)
                        day = 0x31;*/

                     if(month == 0x1 || month == 0x3 || month == 0x5 || month == 0x7 || month == 0x8 || month == 0x10 || month == 0x12) // 31 Days
                        {
                           if (day > 0x31) day =1;
                           if (day < 1) day = 0x31;
                        }
                     if(month == 0x4 || month == 0x6 || month == 0x9 || month == 0x11) // 30 Days
                         {
                           if (day > 0x30) day =1;
                           if (day < 1) day = 0x30;
                        }
                     if(month == 0x2) // February
                       {
                           if(BCD2Binary(year) % 100 == 0)                                          // If Divisible by 100
                           {
                                 if(BCD2Binary(year) % 400 == 0) //Leap Year
                                 {
                                    if (day > 0x29) day =1;
                                    if (day < 1) day = 0x29;
                                 }
                                 else                          //Not a leap year
                                 {
                                    if (day > 0x28) day =1;
                                    if (day < 1) day = 0x28;
                                 }
                           }
                           else
                           {
                                 if(BCD2Binary(year) % 4 == 0) //Leap Year
                                 {
                                    if (day > 0x29) day =1;
                                    if (day < 1) day = 0x29;
                                 }
                                 else                          //Not a leap year
                                 {
                                    if (day > 0x28) day =1;
                                    if (day < 1) day = 0x28;
                                 }
                           }
                       }

                     break;

                      break;
              case 2:
                       month = BCD2Binary(month);
                       month = month + set;
                       month = Binary2BCD(month);
                       if(month > 0x12)
                                month = 1;
                       if(month <= 0)
                                month = 0x12;
                       minute = Binary2BCD(minute);

                       break;
              case 1:
                      year = BCD2Binary(year);
                      year = year + set;
                      year = Binary2BCD(year);
                    if(year <= -1)
                       year = 0x99;
                    if(year >= 0x50)
                       year = 0;
                      break;
              }

          }
          }
       date2Str();

       // ------------Blink Code
       loopcount ++;
       if(loopcount > 10) loopcount = 0; // For blinking
       if(loopcount < 5)
       {
          Lcd_out(1,6, date);     //Show full date for 1s
          Lcd_out(2,3, "Save");
          Lcd_out(2,10, "Cancel");
       }
       else
       {
          if (set_count  ==1) Lcd_out(1,12, "__");
          else if (set_count  ==2) Lcd_out(1,9, "__");
          else if (set_count  ==3) Lcd_out(1,6, "__");
          else if (set_count == 4) Lcd_out(2,3, "____");
          else if (set_count  ==5) Lcd_out(2,10, "______");
       }
       //---------------

       Delay_ms(100);

       if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
         {
             Delay_ms(100);
             if(PORTA.F3 == 0)
             {
                 if(set_count == 4 )             //Write to RTC, if Save is pressed
                 {
                      write_ds1307(4, day);
                      write_ds1307(5,month);
                      write_ds1307(6, year);
                 }
                 break;

                 if(set_count == 5) break;
             }
         }
         if(goBackAlarm) break;                  //Break if alarm goes off
     }

     Lcd_Cmd(_LCD_CLEAR);
     set = 0;
     set_count = 0;

}


void populateAlarm(int alarmNo)
{
   switch(alarmNo)  //Add the alarm's number in LCD
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

   if(alarmStatus[alarmNo-1]) //ON
   {
     menuAlarmText[0][9] = 'N';
     menuAlarmText[0][10] = ' ';
   }
   else                       //OFF
   {
     menuAlarmText[0][9] = 'F';
     menuAlarmText[0][10] = 'F';
   }
   //Tunes
   menuAlarmText[1][15] = BCD2LowerCh(Binary2BCD(alarmTunes[alarmNo-1]));

   //Snooze Time
   menuAlarmText[1][7] = BCD2UpperCh(Binary2BCD(snoozeTimes[alarmNo-1]));
   menuAlarmText[1][8] = BCD2LowerCh(Binary2BCD(snoozeTimes[alarmNo-1]));

   //Show in LCD
   Lcd_out(1,1, menuAlarmText[0]);
   Lcd_out(2,1, menuAlarmText[1]);
}



void menuAlarm2(int alarmNo)//****************************** ALARM MENU
// Switch                    -- Mode(0)
// Edit values               -- ^(1) and V(2)
// Confirm Selection         -- ^(1) and V(2)
// Return to Home Screen     -- Menu(3)
{
   Lcd_Cmd(_LCD_CLEAR);
   populateAlarm(alarmNo);

   loopcount = 0;
   set_count = 0;
   
   while(1)
   {
       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
       {
           Delay_ms(100);
           if(PORTA.F0 == 0)
           {
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
          if(set_count && set)
          {

          
            switch(set_count)
            {
              case 1: //On Off
                   alarmStatus[alarmNo-1] = !alarmStatus[alarmNo-1];
                   break;
              case 3: //Snooze
                   snoozeTimes[alarmNo-1] += set;
                   if(snoozeTimes[alarmNo-1] >19) snoozeTimes[alarmNo-1] = 0;
                   if(snoozeTimes[alarmNo-1] <0) snoozeTimes[alarmNo-1] = 19;
                   break;
              case 2: //Time
                   alText[3] = BCD2LowerCh(Binary2BCD(alarmNo));
                   inputTime(2, alText);    //
                   break;
              case 4: //Tune
                   alarmTunes[alarmNo-1] += set;
                   if(alarmTunes[alarmNo-1] >3) alarmTunes[alarmNo-1] = 1;
                   break;

            }
            populateAlarm(alarmNo);

          }
          // ------------Blink Code
         loopcount ++;
         if(loopcount > 10) loopcount = 0; // For blinking
         if(loopcount < 5)
         {
            Lcd_out(1,1, menuAlarmText[0]);
            Lcd_out(2,1, menuAlarmText[1]);     //Show full menu for 0.5s
         }
         else
         {
            if      (set_count  ==1) Lcd_out(1,9, "___");
            else if (set_count  ==2) Lcd_out(1,13, "____");
            else if (set_count  ==3) Lcd_out(2,8, "__");
            else if (set_count  ==4) Lcd_out(2,16, "_");
         }
         //---------------
        }

        if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
         {
             Delay_ms(100);
             if(PORTA.F3 == 0) break;
         }
         
         if(goBackAlarm) break;            //Immediately go back if alarm goes off


        Delay_ms(100);
   }

   Lcd_Cmd(_LCD_CLEAR);
   set = 0;
   set_count = 0;
   loopcount = 0;
   menuAlarmText[0][6] = "_";
}


void menuMain2() //***************************************** MAIN MENU
// Switch -- Mode(0)
// Confirm Selection -- ^(1) and V(2)
// Return to Home Screen -- Menu(3)
{
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");

   loopcount = 0;
   set_count = 0;
   while(1)
   {
       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
       {
           Delay_ms(100);
           if(PORTA.F0 == 0)
           {
               set_count++;
               if(set_count > 5)  set_count = 1;
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
          if(set_count && set)
          {
            switch(set_count)
            {
              case 1: // Alarm1
                   menuAlarm2(1);
                   break;
              case 2: //Alarm2
                   menuAlarm2(2);
                   break;
              case 3: //Alarm3
                   menuAlarm2(3);
                   break;
              case 4: //Time
                   inputTime(0, "Time:");
                   break;
              case 5: //Date
                   inputDate();
                   break;
            }
          }

          // ------------Blink Code
         loopcount++;
         if(loopcount > 10) loopcount = 0; // For blinking
         if(loopcount < 5)
         {
            Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
         }
         else
         {
            if      (set_count  ==1) Lcd_out(1,12, "_");
            else if (set_count  ==2) Lcd_out(1,14, "_");
            else if (set_count  ==3) Lcd_out(1,16, "_");
            else if (set_count  ==4) Lcd_out(2,6, "____");
            else if (set_count  ==5) Lcd_out(2,13, "____");
         }
         //---------------
        }

        if(PORTA.F3 == 0)  // Break the while loop when menu pressed
         {
             Delay_ms(100);
             if(PORTA.F3 == 0) break;
         }
        Delay_ms(100);
        
        if(goBackAlarm) break; //Immediately return if Alarm goes off
   }

   Lcd_Cmd(_LCD_CLEAR);
   set = 0;
   set_count = 0;
   loopcount = 0;
}


void playTone()                              // Runs while ringing/snoozing the alarm. Plays the tone, stops, snooze...etc.
{
  ringAlarmText[6] = BCD2LowerCh(Binary2BCD(goBackAlarm));
  Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
  loopcount = 0;

  while(1)
  {
    //.......Playing tone


    //Blinking Code                        //Alarm 1: RINGING
    if         (loopcount < 5) Lcd_out(2,10, "       ");
    else if    (loopcount <10) Lcd_out(2,10, "RINGING");
    else       loopcount = 0;

    if(PORTA.F1 == 0)              //Up/Snooze Pressed
       {
           Delay_ms(100);
           if(PORTA.F1 == 0)
           {

               Lcd_out(2,1, "SNOOZING - 00:00");
               snoozeMax = snoozeTimes[goBackAlarm-1]*600;   //Max Snooze count = snooze in seconds * 10
               snoozeCounter = snoozeMax;
               while(snoozeCounter >=1)
               {
                   if(!(snoozeCounter%10))                   //Every second
                   {
                    snoozeCounter = snoozeCounter/10;        //Bring the count to second

                    snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter/60));
                    snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter/60));
                    Lcd_out(2,12, snoozeTime);               //Show Minutes left

                    snoozeTime[0] = BCD2UpperCh(Binary2BCD(snoozeCounter%60));
                    snoozeTime[1] = BCD2LowerCh(Binary2BCD(snoozeCounter%60));

                    Lcd_out(2,15, snoozeTime);               //Show Seconds left

                    snoozeCounter = snoozeCounter*10;         //Take it back to count
                  }

                  if(PORTA.F1 == 0)                           //If Snooze Pressed inside snooze, reset snooze count
                   {
                       Delay_ms(100);
                       if(PORTA.F1 == 0) snoozeCounter = snoozeMax+1;
                   }

                  if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
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
               Lcd_out(2,1, ringAlarmText);               //Show Alarm 1: Ringing
               snoozeCounter = 0;
           }

    }

    if(PORTA.F2 == 0)              //If Stop Pressed, start the stop counter and stop the tune.
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
  if (TMR0IF_bit)          //Timer Interrupt (every  1 seconds)
  {

    TMR0IF_bit = 0;
    TMR0H	 = 0x0B;
    TMR0L	 = 0xDC;
    //******************

    
    //Sets the goBack variable if Alarm time matches and the stop counter has expired
    if(stopCounter)                                                                  //If stop counter is activated
    {
      if(stopCounter > 90) stopCounter = 0;                                         //Expire the stop counter after 1.5 minutes
      else stopCounter += 1;                                                         //Increment the counter by 1 second.
    }
        //If  1. stop counter has expired
        //    2. alarm matches,
        //    3. goBackAlarm is not set
        //then set the goBack variable as the alarmNumber
    else if(!gobackAlarm)
    {
      
      if      (alarmStatus[0] && (nowAP == alarmAP[0]) && (nowHrBin == alarmHr[0]) && (nowMinBin == alarmMinute[0]))
        {goBackAlarm = 1;}
      else if (alarmStatus[1] && (nowAP == alarmAP[1]) && (nowHrBin == alarmHr[1]) && (nowMinBin == alarmMinute[1]))
        {goBackAlarm = 2;}
      else if (alarmStatus[2] && (nowAP == alarmAP[2]) && (nowHrBin == alarmHr[2]) && (nowMinBin == alarmMinute[2]))
        goBackAlarm = 3;
        
    }
    
    //Increment the time counters (In case, stuck in the menu)
    nowSecBin ++;
    if(nowSecBin > 59)
    {
      nowSecBin = 0;
      nowMinBin++;

      if(nowMinBin >59)
      {
        nowHrBin ++;                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< COULD GIVE ERROR
        nowMinBin = 0;
      }
    }

  }
}

void main()
{
   I2C1_Init(100000); //DS1307 I2C is running at 100KHz
   CMCON = 0x07;   // To turn off comparators
   ADCON1 = 0x06;  // To turn off analog to digital converters
   TRISA = 0xFF;   //Port A Set output
   PORTA = 0x00;
   
   TRISD = 0x00;
   PORTD = 0x00;

   //LCD Settings
   Lcd_Init();                        // Initialize LCD
   Lcd_Cmd(_LCD_CLEAR);               // Clear display
   Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
   
    //Timer0 Settings  (Interrupt every 6 seconds to check alarm and change the stop counter)
    T0CON	 = 0x84;
  TMR0H	 = 0x0B;
  TMR0L	 = 0xDC;
  GIE_bit	 = 1;
  TMR0IE_bit	 = 1;
  
  readTime();


   while(1)                                   //*********************Main Loop *****************************
   {
     Lcd_out(1,1,"Time:");
     Lcd_out(2,1,"Date:");
     readTime();
     nowHrBin = BCD2Binary(hour); nowMinBin = BCD2Binary(minute); nowSecBin = BCD2Binary(second); nowAP = ap;
     
     Lcd_out(1,6,time);
     Lcd_out(2,6,date);
     set = 0;

     if(gobackAlarm)                          //When the gobackAlarm varibale was set by the Timer Interrupt (Alarm goes off),
     {                                        //All other while loops break, and come here.
        playTone();                           //Here we set the alarm
        goBackAlarm = 0;
     }
      


     if(PORTA.F3 == 0)              //Menu Button Pressed
       {
           Delay_ms(100);
           if(PORTA.F3 == 0)
           {
               menuMain2();
           }
       }

     Delay_ms(100);
   }
}