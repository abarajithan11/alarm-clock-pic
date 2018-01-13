#line 1 "E:/Abarajithan/Desktop/Alarm Clock/ToneTest/ToneTest.c"
#line 8 "E:/Abarajithan/Desktop/Alarm Clock/ToneTest/ToneTest.c"
void pause(unsigned short i){
 unsigned short j;
 for (j = 0; j < i; j++){
 Delay_ms(10);
 }
}
#line 31 "E:/Abarajithan/Desktop/Alarm Clock/ToneTest/ToneTest.c"
unsigned char noteSong[] = {294, 294, 330, 349, 349, 349, 392, 330, 330, 294, 262, 262, 294, 220, 262, 294};
unsigned char intervalSong[] = {10, 5, 5, 10, 10, 5, 5, 10, 10, 5, 5, 5, 15, 5, 5, 10};






void tune(){
unsigned short k;
 for(k = 0; k<25; k++){
 Sound_Play(noteSong[k], 50*intervalSong[k]);
 pause(6);
 }
 pause(100);
 }

unsigned short k;
void main() {
 CMCON = 0x07;
 TRISD = 0b00000000;
 Sound_Init(&PORTD,0);
 while(1)
 {
 tune();

 Delay_ms(100);
 }
}
