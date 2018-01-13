
_pause:

;ToneTest.c,8 :: 		void pause(unsigned short i){
;ToneTest.c,10 :: 		for (j = 0; j < i; j++){
	CLRF       R1+0
L_pause0:
	MOVF       FARG_pause_i+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_pause1
;ToneTest.c,11 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_pause3:
	DECFSZ     R13+0, 1
	GOTO       L_pause3
	DECFSZ     R12+0, 1
	GOTO       L_pause3
	NOP
;ToneTest.c,10 :: 		for (j = 0; j < i; j++){
	INCF       R1+0, 1
;ToneTest.c,12 :: 		}
	GOTO       L_pause0
L_pause1:
;ToneTest.c,13 :: 		}
L_end_pause:
	RETURN
; end of _pause

_tune:

;ToneTest.c,39 :: 		void tune(){
;ToneTest.c,41 :: 		for(k = 0; k<25; k++){
	CLRF       tune_k_L0+0
L_tune4:
	MOVLW      25
	SUBWF      tune_k_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_tune5
;ToneTest.c,42 :: 		Sound_Play(noteSong[k], 50*intervalSong[k]);
	MOVF       tune_k_L0+0, 0
	ADDLW      _noteSong+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Sound_Play_freq_in_hz+0
	CLRF       FARG_Sound_Play_freq_in_hz+1
	MOVLW      0
	MOVWF      FARG_Sound_Play_freq_in_hz+1
	MOVF       tune_k_L0+0, 0
	ADDLW      _intervalSong+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      50
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_Sound_Play_duration_ms+0
	MOVF       R0+1, 0
	MOVWF      FARG_Sound_Play_duration_ms+1
	CALL       _Sound_Play+0
;ToneTest.c,43 :: 		pause(6);
	MOVLW      6
	MOVWF      FARG_pause_i+0
	CALL       _pause+0
;ToneTest.c,41 :: 		for(k = 0; k<25; k++){
	INCF       tune_k_L0+0, 1
;ToneTest.c,44 :: 		}
	GOTO       L_tune4
L_tune5:
;ToneTest.c,45 :: 		pause(100);
	MOVLW      100
	MOVWF      FARG_pause_i+0
	CALL       _pause+0
;ToneTest.c,46 :: 		}
L_end_tune:
	RETURN
; end of _tune

_main:

;ToneTest.c,49 :: 		void main() {
;ToneTest.c,50 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;ToneTest.c,51 :: 		TRISD = 0b00000000;  // GP5, 5 I/P's, Rest O/P's
	CLRF       TRISD+0
;ToneTest.c,52 :: 		Sound_Init(&PORTD,0); // Initialize sound o/p pin
	MOVLW      PORTD+0
	MOVWF      FARG_Sound_Init_snd_port+0
	CLRF       FARG_Sound_Init_snd_pin+0
	CALL       _Sound_Init+0
;ToneTest.c,53 :: 		while(1)
L_main7:
;ToneTest.c,55 :: 		tune();
	CALL       _tune+0
;ToneTest.c,57 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
;ToneTest.c,58 :: 		}
	GOTO       L_main7
;ToneTest.c,59 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
