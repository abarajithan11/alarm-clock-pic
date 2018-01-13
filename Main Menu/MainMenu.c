
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

// Buttons: A0=ModeOk ; A1=(++) ; A2= (--) ; A3= Menu;  A4 = Snooze;


// ********************************************** VARIABLE DECLARATIONS *******************************

// All in BCD
int second; int minute; int hour; int day; int month; int year;
int dday;
int hr;
int ap;

int second2; int minute2; int hour2;
int hr2;
int ap2;

//For Set Menus
unsigned short set_count = 0;
short set = 0;

//String Times and Dates
char time[] = "00:00:00 PM";
char date[] = "00-00-00";

//Alarms Memory
int alarmTunes[3] = {3,0,0};          //0-OFF, 1,2,3
int snoozeTimes[3] = {15,0,0};         //in minutes
int alarmStatus[3] = {0,0,0};
char *alarmTimes[3] = { "00:00:00 PM", "00:00:00 PM", "00:00:00 PM"};

//Menu Text
char *menuAlarmText[2] = {"Alarm-1:O_ |Time","Snooze:__|Tune:_"};

//Temporary variables
char *alTime;
char *tempChar;
int loopcount;



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

inputTime(int mode, char *text)   //Dummy function
{
   while(1){
   Lcd_Cmd(_LCD_CLEAR);
   Lcd_out(1,1, "Time Input Mode ");
   Lcd_out(1,1, "It is working   ");}
}

inputDate()   //Dummy function
{
   while(1){
   Lcd_Cmd(_LCD_CLEAR);
   Lcd_out(1,1, "Date Input Mode ");
   Lcd_out(1,1, "It is working   ");}
}



 //"Edit Alarm:1|2|3"
 //"Set: Time | Date"
void menuMain2()
{
   Lcd_Cmd(_LCD_CLEAR);

   loopcount = 0;
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
              case 1: // Alarm1
                   //menuAlarm2(1);
                   //populateMenu();
                   break;
              case 2: //Alarm2
                   //menuAlarm2(2);
                   //populateMenu();
                   break;
              case 3: //Alarm3
                   //menuAlarm2(3);
                   //populateMenu();
                   break;
              case 4: //Time
                   inputTime(1, "Time:");
                   //populateMenu();
                   break;
              case 5: //Date
                   inputDate();
                   //populateMenu();
                   break;
            }

          }
           //"Edit Alarm:1|2|3"
           //"Set: Time | Date"

          // ------------Blink Code
         loopcount++;
         if(loopcount > 10) loopcount = 0; // For blinking
         if(loopcount < 5)
         {
            Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Edit Alarm:1|2|3");
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
   }

   Lcd_Cmd(_LCD_CLEAR);
   set = 0;
   set_count = 0;
   loopcount = 0;
}

void menuMain()
{
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");

   loopcount = 0;
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
                   //menuAlarm2(1);

                   break;
              case 2: //Alarm2
                   //menuAlarm2(2);
                   //populateMenu();
                   break;
              case 3: //Alarm3
                   //menuAlarm2(3);
                   //populateMenu();
                   break;
              case 4: //Time
                   inputTime(1, "Time:");
                   //populateMenu();
                   break;
              case 5: //Date
                   inputDate();
                   //populateMenu();
                   break;
            }

          }
           //"Edit Alarm:1|2|3"
           //"Set: Time | Date"

          // ------------Blink Code
         loopcount++;
         if(loopcount > 10) loopcount = 0; // For blinking
         if(loopcount < 5)
         {
            Lcd_out(1,12, "1");
            Lcd_out(1,14, "2");
            Lcd_out(1,16, "3");
            Lcd_out(2,6, "Time");
            Lcd_out(2,13, "Date");//                       Lcd_out(1,1, "Edit Alarm:1|2|3"); Lcd_out(2,1, "Set: Time | Date");
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
   }

   Lcd_Cmd(_LCD_CLEAR);
   set = 0;
   set_count = 0;
   loopcount = 0;
}


void main() 
{
    I2C1_Init(100000); //DS1307 I2C is running at 100KHz
   CMCON = 0x07;   // To turn off comparators
   ADCON1 = 0x06;  // To turn off analog to digital converters
   TRISA = 0xFF;   //Port A Set output
   PORTA = 0x00;

   Lcd_Init();                        // Initialize LCD
   Lcd_Cmd(_LCD_CLEAR);               // Clear display
   Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off


   while(1)                                   //*********************Main Loop *****************************
   {
     Lcd_out(1,1,"Initial New");
     Lcd_out(2,1,"Second New");
     set = 0;

     if(PORTA.F3 == 0)              //Menu Pressed
       {
           Delay_ms(100);
           if(PORTA.F3 == 0)
           {
               menuMain();
           }
       }

     Delay_ms(100);
   }
}