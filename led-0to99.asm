LIST P=16F628A, R=DEC ; Use the PIC16F628 and decimal system

#include "p16f628a.inc" ; Include header file 

__config _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF & _PWRTE_ON & _BODEN_ON 


ORG 0x00

; Declarações das variáveis
COUNTER1 EQU 0X20       ; Used in DELAY routine
COUNTER2 EQU 0X21       ; Used in DELAY routine
TEMP EQU 0X22           ; O número que vai ser escrito no primeiro display
TEMP2 EQU 0X23          ; O número que vai ser escrito no segundo display

; PORT settings
BANKSEL TRISA           ; Select BANK 1
CLRF TRISA              ; Set PORTA as output
CLRF TRISB              ; Set PORTB as output
BANKSEL PORTA           ; Select BANK 0
MOVLW 0x07 
MOVWF CMCON
CLRF PORTA              ; Clear PORTA
CLRF PORTB              ; Clear PORTB
CLRF TEMP               ; Clear TEMP
BSF PORTA, 0            ; Enable 7 Segment

; Display on 7 Segment
INCREMENT
    MOVF TEMP, W        ; W = TEMP
    CALL SEVENSEG       ; Pega o número pra ser enviado ao primeiro display.
    MOVWF PORTB         ; Send this number to PORTB (data pins)
    BSF PORTB, 4
    CALL DELAY          ; Delay
    INCF TEMP, 1        ; Incrementa o número
    CALL SEGUNDOBIT
    GOTO INCREMENT

; Seta os bits para o primeiro display.
SEVENSEG
    addwf PCL, F
    retlw B'11101110'   ; 0
    retlw B'00101000'   ; 1
    retlw B'11001101'   ; 2
    retlw B'01101101'   ; 3
    retlw B'00101011'   ; 4
    retlw B'01100111'   ; 5
    retlw B'11100111'   ; 6
    retlw B'00101100'   ; 7
    retlw B'11101111'   ; 8
    retlw B'01101111'   ; 9
    retlw B'00000000'   ; apagado

; Seta os bits para o segundo display.
SEVENSEG2
    addwf PCL, F
    retlw B'11111110'   ; 0
    retlw B'00111000'   ; 1
    retlw B'11011101'   ; 2
    retlw B'01111101'   ; 3
    retlw B'00111011'   ; 4
    retlw B'01110111'   ; 5
    retlw B'11110111'   ; 6
    retlw B'00111100'   ; 7
    retlw B'11111111'   ; 8
    retlw B'01111111'   ; 9

SEGUNDOBIT
    MOVF TEMP2, W       ; W = TEMP2
    CALL SEVENSEG2      ; Pega o número pra ser enviado ao segundo display.

    MOVWF PORTB         ; Send this number to PORTB (data pins)
    BCF PORTB, 4
    CALL DELAY          ; Delay

    MOVLW 0X0A          ; Compara o número com 10
    XORWF TEMP, 0
    BTFSC STATUS, Z
    INCF TEMP2, 1       ; Increment the number to be displayed

    MOVLW 0X0A          ; Compara o número com 10
    XORWF TEMP2, 0
    BTFSC STATUS, Z
    CLRF TEMP2          ; Limpa o valor do contador se for 10

    MOVLW 0X0A          ; Compara o número com 10
    XORWF TEMP, 0
    BTFSC STATUS, Z
    CLRF TEMP           ; Limpa o valor do contador se for 10

    RETURN

; Delay
DELAY
    MOVLW 0X66
    MOVWF COUNTER2
    LOOP2
        MOVLW 0XAA
        MOVWF COUNTER1
        LOOP1
            DECFSZ COUNTER1, F
            GOTO LOOP1
        DECFSZ COUNTER2, F
        GOTO LOOP2
    RETURN

END
