// Project Alarm Clock
// Group 01
// PIC 18 Family (Pic 16 has memory problems)


// Button Configuration
// A0  :      Switch Mode
// A1  :      UP   / Snooze
// A2  :      DOWN / Stop
// A3  :      Menu / Return
// A4  :      OK

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
unsigned short secondbin  = 36;
unsigned short minutebin =42;
unsigned short hrbin = 5;
unsigned short ap = 0;
unsigned short month =1;
unsigned short date = 1;
unsigned short year = 16;

unsigned short secondbin2; minutebin2; hrbin2; ap2;

//For Set Menus
unsigned short set_count = 0;
short set = 0;

//String Times and Dates
char time[] = "00:00:00 PM";
char datestr[] = "00-00-00";

//Alarms Memory
short alarmTunes[3] = {3,2,1};          //0-OFF, 1,2,3
short snoozeTimes[3] = {15,2,5};         //in minutes
short alarmStatus[3] = {0,1,1};
unsigned short alarmHr[3] = {7,8,9};     //in Bin
short alarmMinute[3] = {10,45,15};          //in Bin
unsigned short alarmAP[3] = {0,0,0};

//Tune Memory
unsigned int tune1[] = {1047,1175,1319,1397,1568,1760,1975,2093,1975,1760,1568,1397,1319,1175,1047};
unsigned int tune2[] = {1760,1760,1760,2637,1975,2093,1975,1760,1568,1975,1760,1975,1760,1568,1760,1975,2093,1975,1760,1568,1318};
unsigned int tune3[] = {2093,2637,3136,4186,4186,3136,2637,2093};

unsigned char interval1[] = {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
unsigned char interval2[] = {3,1,2,2,1,1,1,2,2,2,1,1,1,1,1,1,2,2,1,1,3};
unsigned char interval3[] = {1,2,3,4,1,2,3,4};

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


/*unsigned short read_ds1307(unsigned short address)
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
}*/

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

/*void readTime()
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
}*/

void time2Str(int temp)            //Mode {0-for permanent memory. If not temp memory
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

void inputTime(int mode, char setStr[])             // Interface for inputting time
{                                                    // Mode: 0: set time, 1: al1, 2:al-2, 3:al-3
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_out(1,1,setStr);
     Lcd_out(2,1," [Save] [Cancel]");

     if(mode == 0)                                  //Setting time
     {                                              //Update the time here.
        //readTime();
        secondbin2 = secondbin; minutebin2 = minutebin; hrbin2 = hrbin; ap2 = ap;
     }
     else                                           // Setting alarm
     {
      secondbin2 = 0; minutebin2 = alarmMinute[mode-1]; hrbin2 = alarmHr[mode-1]; ap2 = alarmAP[mode-1];
     }
     time2Str(mode);
     Lcd_out(1,6, time);

     loopcount = 0;
     set_count = 0;

     while(1)
       {
                                      //Make sure alarm rings here.
         
         set = 0;
         if(PORTA.F0 == 0)                      //Mode Pressed
         {
             Delay_ms(100);
             if(PORTA.F0 == 0)
             {
                 while(PORTA.F0 == 0) {}        //Avoid Overpressing
                 set_count++;
                 if(mode && (set_count == 3)) set_count++;   //Skip the seconds if mode

                 if(set_count > 5)
                 {
                    set_count = 1;
                 }
             }
         }

         if((set_count)&& (set_count != 4) && (set_count!= 5))      // Up down pressed outside Save/ Cancel
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
                          //write_ds1307(0,0x00); //Reset second to 0 sec. and start Oscillator
                          secondbin = 0;
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

         if(PORTA.F4 == 0)                        // OK pressed
           {
               Delay_ms(100);
               if(PORTA.F4 == 0)
               {
                   if(set_count == 4)              //if Save is pressed
                   {
                      if(!mode)                    //Write to RTC
                      {
                        //write_ds1307(2, hour2);
                        //write_ds1307(1, minute2);
                        minutebin = minutebin2;
                        hrbin = hrbin2;

                        break;
                      }
                      else                         //Write to Alarm times    in bin
                      {
                        alarmHr[mode-1] = hrbin2;
                        alarmMinute[mode-1] = minutebin2;
                        break;
                      }
                   }

                   if(set_count == 5) break;
               }
           }
           if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
           {
               Delay_ms(100);
               if(PORTA.F3 == 0) 
               {
                 while(PORTA.F0 == 0) {}
                 break;
               }
           }
           
          if(goBackAlarm) break;            //Break if alarm goes off
       }

     Lcd_Cmd(_LCD_CLEAR);
     set = 0;
     set_count = 0;
     hrbin2 = 0;
     minutebin2 = 0;

}

void inputDate()                      // Interface for input & write Date
{
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_out(1,1,"Date:");
     Lcd_out(1,6, datestr);
     Lcd_out(2,1," [Save] [Cancel]");

     loopcount = 0;
     set_count = 0;

     while(1)
     {
                             //To make sure alarm rings
       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
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
          if(PORTA.F1 == 0)            //Up Down pressed
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

                     if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) // 31 Days
                        {
                           if (date > 31) date =1;
                           if (date < 1) date = 31;
                        }
                     if(month == 4 || month == 6 || month == 9 || month == 11) // 30 Days
                         {
                           if (date > 30) date =1;
                           if (date < 1) date = 30;
                        }
                     if(month == 2) // February
                       {
                           if(year % 100 == 0)                                          // If Divisible by 100
                           {
                                 if(year % 400 == 0) //Leap Year
                                 {
                                    if (date > 29) date =1;
                                    if (date < 1) date = 29;
                                 }
                                 else                          //Not a leap year
                                 {
                                    if (date > 28) date =1;
                                    if (date < 1) date = 28;
                                 }
                           }
                           else
                           {
                                 if(year % 4 == 0) //Leap Year
                                 {
                                    if (date > 29) date =1;
                                    if (date < 1) date = 29;
                                 }
                                 else                          //Not a leap year
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

       if(PORTA.F4 == 0)                         // When OK pressed upon Save/ Cance
         {
             Delay_ms(100);
             if(PORTA.F4 == 0)
             {
                 if(set_count == 4 )             //Write to RTC, if Save is pressed
                 {
                      //write_ds1307(4, day);
                      //write_ds1307(5,month);
                      //write_ds1307(6, year);
                 }
                 break;

                 if(set_count == 5) break;
             }
         }
         if(PORTA.F3 == 0)                        // Break the while loop when menu pressed
         {
             Delay_ms(100);
             if(PORTA.F3 == 0) 
             {
               while(PORTA.F0 == 0) {}
               break;
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
// Confirm Selection         -- OK (4)
// Return to Home Screen     -- Menu(3)
{
   Lcd_Cmd(_LCD_CLEAR);
   populateAlarm(alarmNo);

   loopcount = 0;
   set_count = 0;

   while(1)
   {
                          //To make sure alarm rings inside menu

       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
       {
           Delay_ms(100);
           if(PORTA.F0 == 0)
           {
               while(PORTA.F0 == 0) {}         //To avoid overpressing
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
                while(PORTA.F4 == 0) {}         //To avoid overpressing
                set = 1;
            }
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
             if(PORTA.F3 == 0) 
             {
               while(PORTA.F3 == 0) {}         //To avoid overpressing
               break;
             }
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
// Confirm Selection -- OK - 4
// Return to Home Screen -- Menu(3)
{
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

   loopcount = 0;
   set_count = 0;
   while(1)
   {
                           //To make sure alarm goes off within menu
       
       loopcount++;
       if(loopcount > 10) loopcount = 0; // For blinking
       if((loopcount < 5)||(!set_count))
       {
          Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
       }
       
       set = 0;
       if(PORTA.F0 == 0)              //Mode Pressed
       {
           Delay_ms(100);
           if(PORTA.F0 == 0)
           {
               while(PORTA.F0 == 0) {}         //To avoid overpressing
               set_count++;
               if(set_count > 5)  set_count = 1;
           }
       }

       if(set_count)                   //After Mode pressed, pressing ok.
       {
          if(PORTA.F4 == 0)
          {
            Delay_ms(100);
            if(PORTA.F4 == 0)
            {
                while(PORTA.F4 == 0) {}         //To avoid overpressing
                set = 1;
            }
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

         if(loopcount >=5)
         {
            if      (set_count  ==1) Lcd_out(1,12, "_");
            else if (set_count  ==2) Lcd_out(1,14, "_");
            else if (set_count  ==3) Lcd_out(1,16, "_");
            else if (set_count  ==4) Lcd_out(2,6, "____");
            else if (set_count  ==5) Lcd_out(2,13, "____");
         }
         //---------------
        }

        if(PORTA.F3 == 0)              // Break the while loop when menu pressed
         {
             Delay_ms(100);
             if(PORTA.F3 == 0) break;
         }
        Delay_ms(100);

        if(goBackAlarm) break;         //Immediately return if Alarm goes off
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

        if(goBackAlarm == 1)
        {
             Sound_Play(tune1[loopcount], 100*interval1[loopcount]);
             
             if         (loopcount < 8) Lcd_out(2,10, "       ");               //Blinking
             else if    (loopcount <16) Lcd_out(2,10, "RINGING");
             else
             { loopcount = 0;
               Delay_ms(1000);
             }
        }
        else if(goBackAlarm == 2)
        {
             Sound_Play(tune2[loopcount], 100*interval2[loopcount]);
             
             if         (loopcount < 1) Lcd_out(2,10, "       ");               //Blinking
             else if    (loopcount < 2) Lcd_out(2,10, "RINGING");
             else
             { loopcount = 0;           //Legnth of arrays
               Delay_ms(1000);
             }
        }
        else if(goBackAlarm == 3)
        {
             Sound_Play(tune3[loopcount], 100*interval3[loopcount]);
             
             if         (loopcount < 1) Lcd_out(2,10, "       ");               //Blinking
             else if    (loopcount < 2) Lcd_out(2,10, "RINGING");
             else
             { loopcount = 0;           //Legnth of arrays
               Delay_ms(1000);
             }
        }
        else return;

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
    TMR0H         = 0x0B;
    TMR0L         = 0xDC;
    //******************

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

      if      (alarmStatus[0] && (hrbin == alarmHr[0]) && (minutebin == alarmMinute[0]) && (ap == alarmAP[0]))
        goBackAlarm = 1;
      else if (alarmStatus[1] && (hrbin == alarmHr[1]) && (minutebin == alarmMinute[1]) && (ap == alarmAP[1]))
        goBackAlarm = 2;
      else if (alarmStatus[2] && (hrbin == alarmHr[2]) && (minutebin == alarmMinute[2]) && (ap == alarmAP[2]))
        goBackAlarm = 3;

    }
  }
}
void(


void main()
{
   I2C1_Init(100000); //DS1307 I2C is running at 100KHz
   
   CMCON = 0x07;   // To turn off comparators
   ADCON1 = 0x0F;  // To turn off analog to digital converters
   LATB = 0x00;
   
   //Port Settings
   TRISA = 0xFF;         //Buttons in Port A
   PORTA = 0xFF;
   TRISC = 0x00;   // Sound Output in C
  
  //Initialize sound to C0
   Sound_Init(&PORTC,2);

   //LCD Settings
   Lcd_Init();                        // Initialize LCD
   Lcd_Cmd(_LCD_CLEAR);               // Clear display
   Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

    //Timer0 Settings  (Interrupt every second to check alarm and change the stop counter)
    T0CON         = 0x84;
    TMR0H         = 0x0B;
    TMR0L         = 0xDC;
    GIE_bit       = 1;
    TMR0IE_bit    = 1;

   while(1)                                   //*********************Main Loop *****************************
   {
     Lcd_out(1,1,"Time:");
     Lcd_out(2,1,"Date:");
     
     //Read time & Display in menu
     time2Str(0);
     date2Str();

     Lcd_out(1,6,time);
     Lcd_out(2,6,datestr);
     set = 0;

     if(gobackAlarm)                          //When the gobackAlarm varibale was set by the Timer Interrupt (Alarm goes off),
     {                                        //All other while loops break, and come here.
        playTone();                           //Here we set the alarm
        goBackAlarm = 0;
     }

     if(PORTA.F3 == 0)              //Menu Button Pressed
       {
           Delay_ms(50);
           if(PORTA.F3 == 0)
           {
               while(PORTA.F3 != 1) {}         //To avoid overpressing
               menuMain2();
           }
       }

     Delay_ms(100);
   }
}