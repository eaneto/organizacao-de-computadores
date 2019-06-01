;************************************************************ 
; Processor: PIC16F628 at 4 MHz using internal RC oscillator 
; Function:  Flash a LED connected to RA2 
; Hardware:  Testboard K4 
; Filename:  628LED.asm 
; Author:    Lars Petersen, oz1bxm@pobox.com 
; Website:   www.qsl.net/oz1bxm/PIC/pic.htm 
; Credit:    Tony Nixon's LED flasher 
;************************************************************ 

        LIST P=16F628A, R=DEC    ; Use the PIC16F628 and decimal system 

        #include <P16F628A.INC>  ; Include header file 

        __config  _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF & _PWRTE_ON & _BODEN_ON 

        CBLOCK 0x20             ; Declare variable addresses starting at 0x20
          Loop1,Loop2 
        ENDC 
; 
; ----------- 
; INITIALIZE 
; ----------- 
; 
        ORG    0x000           ; Program starts at 0x000 
 
        CLRF   PORTA           ; Initialize port A 
        CLRF   PORTB           ; Initialize port B 
 
        BSF    STATUS,RP0      ; RAM bank 1 
 
        CLRF   TRISA           ; All pins port A output 
        CLRF   TRISB           ; All pins port B output 

        BCF    STATUS,RP0      ; RAM bank 0 
; 
; ------------------------ 
; FUNCTION OF PORT A PINS 
; ------------------------ 
; 
        MOVLW    7 
        MOVWF    CMCON         ; Comparators off, all pins digital I/O 
; 
; ---------- 
; MAIN LOOP 
; ---------- 
; 
Main    BSF     PORTA, 0      ; Turn on LED connected to RA2 
        CALL    delay 
        BCF     PORTA, 0        ; Turn off LED connected to RA2 
        CALL    delay 
        GOTO    Main 
; 
; --------------- 
; DELAY 250 MSEC 
; --------------- 
; 
delay   MOVLW   250 
        MOVWF   Loop1 
Outer   MOVLW   200 
        MOVWF   Loop2 
Inner   NOP 
        NOP 
        DECFSZ  Loop2,F 
        GOTO    Inner          ; Inner loop = 5 usec. 
        DECFSZ  Loop1,F 
        GOTO    Outer 
        RETURN 

        END
 