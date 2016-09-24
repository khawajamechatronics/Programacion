RAM_START  EQU  $0080
ROM_START  EQU  $EE00
VECTORS    EQU  $FFDE
E          EQU   0
RWR        EQU   5
RS         EQU   4

$BASE 10T
$include   'QTQY_Registers.inc'

***********VARIABLES DE RAM**********
           ORG  RAM_START

**************************************************************************************************************************
           ORG  ROM_START
START:
           CLR  OSCSC	; Oscilador interno a 4 MHz
           RSP          ;INICIALIZACION DEL MICROCONTROLADOR
           CLRA
           CLRH
           CLRX
           CLC

           MOV  #%00001001,CONFIG1   ;PROGRAMACION DE LOS CONFIGS
           NOP
           NOP
           MOV  #%10000000,CONFIG2
           NOP
           NOP

           MOV  #$FF,DDRB             ;PUERTO B TODO COMO SALIDA
           MOV  #%00110001,DDRA       ;PTA5, PTA4 Y PTA0 SON SALIIDAS. 
           CLR  PTA
           CLR  PTB
           JSR  RETARDO


**************************************************************************************************************************
INICIO_LCD:                           ;PREPARA AL MODULO LCD PARA MODO 8 BITS
           LDA  #%00111000
           JSR  ESCRIBE_IR
           LDA  #%00001110
           JSR  ESCRIBE_IR
           LDA  #%00000001
           JSR  ESCRIBE_IR
           LDA  #%00000110
           JSR  ESCRIBE_IR
           LDA  #%01000000
           JSR  ESCRIBE_IR
           LDA  #%00001100
           JSR  ESCRIBE_IR
**************************************************************************************************************************
SALUDO:
           LDA  #$01                 ;CLEAR DISPLAY
           JSR  ESCRIBE_IR
           LDA  #$0C                 ;DISPLAY ON
           JSR  ESCRIBE_IR

           ;LDA  #%10000000            ;SET DDRAM $00. Va a la posicion 0 de la primera fila
           ;LDA  #%10000001            ;SET DDRAM $01. Va a la posicion 1 de la primera fila
           ;LDA  #%10000010            ;SET DDRAM $02. Va a la posicion 2 de la primera fila
           ;LDA  #%10000011            ;SET DDRAM $03. Va a la posicion 3 de la primera fila
           ;LDA  #%10000100            ;SET DDRAM $04. Va a la posicion 4 de la primera fila
           ;LDA  #%10000101            ;SET DDRAM $05. Va a la posicion 5 de la primera fila
           ;LDA  #%10010010            ;SET DDRAM $12. Va a la posicion 18 de la primera fila
           ;LDA  #%10010011            ;SET DDRAM $13. Va a la posicion 19 de la primera fila

           ;LDA  #%11000000            ;SET DDRAM $40. Va a la posicion 0 de la segunda fila
           ;LDA  #%11000001            ;SET DDRAM $41. Va a la posicion 1 de la segunda fila
           ;LDA  #%11000010            ;SET DDRAM $42. Va a la posicion 2 de la segunda fila
           ;LDA  #%11000011            ;SET DDRAM $43. Va a la posicion 3 de la segunda fila
           ;LDA  #%11000100            ;SET DDRAM $44. Va a la posicion 4 de la segunda fila
           ;LDA  #%11000101            ;SET DDRAM $45. Va a la posicion 5 de la segunda fila
           ;LDA  #%11010010            ;SET DDRAM $52. Va a la posicion 18 de la segunda fila
           ;LDA  #%11010011            ;SET DDRAM $53. Va a la posicion 19 de la segunda fila
           
           ;LDA  #%10010100            ;SET DDRAM $14. Va a la posicion 0 de la tercera fila
           ;LDA  #%10010101            ;SET DDRAM $15. Va a la posicion 1 de la tercera fila
           ;LDA  #%10010110            ;SET DDRAM $16. Va a la posicion 2 de la tercera fila
           ;LDA  #%10010111            ;SET DDRAM $17. Va a la posicion 3 de la tercera fila
           ;LDA  #%10011000            ;SET DDRAM $18. Va a la posicion 4 de la tercera fila
           ;LDA  #%10011001            ;SET DDRAM $19. Va a la posicion 5 de la tercera fila
           ;LDA  #%10100110            ;SET DDRAM $26. Va a la posicion 18 de la tercera fila
           ;LDA  #%10100111            ;SET DDRAM $27. Va a la posicion 19 de la tercera fila

           ;LDA  #%11010100            ;SET DDRAM $54. Va a la posicion 0 de la cuarta fila
           ;LDA  #%11010101            ;SET DDRAM $55. Va a la posicion 1 de la cuarta fila
           ;LDA  #%11010110            ;SET DDRAM $56. Va a la posicion 2 de la cuarta fila
           ;LDA  #%11010111            ;SET DDRAM $57. Va a la posicion 3 de la cuarta fila
           ;LDA  #%11011000            ;SET DDRAM $58. Va a la posicion 4 de la cuarta fila
           ;LDA  #%11011001            ;SET DDRAM $59. Va a la posicion 5 de la cuarta fila
           ;LDA  #%11100110            ;SET DDRAM $66. Va a la posicion 18 de la cuarta fila
           ;LDA  #%11100111            ;SET DDRAM $67. Va a la posicion 19 de la cuarta fila

           JSR  ESCRIBE_IR
           LDX  #$0B
           LDA  TABLA,X                ;R
           JSR  ESCRIBE_DR
           LDX  #$1E
           LDA  TABLA,X                ;u
           JSR  ESCRIBE_DR             ;termina siempre con este salto, sino borra la ultima letra



           ;JSR  RETARDO               ;Retardo para dar tiempo a que se lea el nombre
           ;JSR  RETARDO
           ;JSR  RETARDO
           ;JSR  RETARDO
           ;JSR  RETARDO
           ;JSR  RETARDO
           ;JSR  RETARDO
**************************************************************************************************************************
           ;LDA  #$01         ;CLEAR DISPLAY
           ;JSR  ESCRIBE_IR
**************************************************************************************************************************
ESCRIBE_IR:                  ;SUBRUTINA QUE SIRVE PARA MANDARLE INSTRUCCIONES AL MODULO LCD
           BCLR  RS,PTA
           BCLR  RWR,PTA
           BSET  E,PTA
           STA   PTB
           JSR   DEMORA100
           BCLR  E,PTA
           JSR   DEMORA100
           BCLR  RS,PTA
           RTS
**************************************************************************************************************************
ESCRIBE_DR:                  ;SUBRUTINA QUE SIRVE PARA MANDARLE DATOS (CARACTERES) AL MODULO LCD
           BSET  RS,PTA
           BCLR  RWR,PTA
           BSET  E,PTA
           STA   PTB
           JSR   DEMORA100
           BCLR  E,PTA
           JSR   DEMORA100
           BCLR  RS,PTA
           RTS
**************************************************************************************************************************
RETARDO
        PSHA
        PSHH
        PSHX
        LDA     #$FF
DELAY
        LDHX    #$00EF
LOOP1
        AIX     #-1
        CPHX    #0
        BNE     LOOP1
        DECA
        BNE     DELAY
        PULX
        PULH
        PULA
        RTS
**************************************************************************************************************************
DEMORA100:                        ;RUTINA QUE GENERA UNA DEMORA DE APROX.
           PSHA
           LDA  #$FF
RESTA3:
           DECA
           BNE  RESTA3

           PULA
           RTS
**************************************************************************************************************************
TABLA:                                ;TABLA EN DONDE SE DEFINEN LOS CARACTERES QUE SE USARAN
           DB  %00110000;0 X = $00
           DB  %00110001;1 X = $01
           DB  %00110010;2 X = $02
           DB  %00110011;3 X = $03
           DB  %00110100;4 X = $04
           DB  %00110101;5 X = $05
           DB  %00110110;6 X = $06
           DB  %00110111;7 X = $07
           DB  %00111000;8 X = $08
           DB  %00111001;9 X = $09
           DB  %01010000;P X = $0A
           DB  %01010010;R X = $0B
           DB  %01010100;T X = $0C
           DB  %01010101;U X = $0D
           DB  %01000011;C X = $0E
           DB  %01000101;E X = $0F
           DB  %01000110;F X = $10
           DB  %01001000;H X = $11
           DB  %01001100;L X = $12
           DB  %01001110;N X = $13
           DB  %01100001;a X = $14
           DB  %01100011;c X = $15
           DB  %01100111;g X = $16
           DB  %01101001;i X = $17
           DB  %01101010;j X = $18
           DB  %01101100;l X = $19
           DB  %01101111;o X = $1A
           DB  %01110000;p X = $1B
           DB  %01110010;r X = $1C
           DB  %01110011;s X = $1D
           DB  %01110101;u X = $1E
           DB  %00101110;punto X = $1F
           DB  %00101100;coma X = $20
           DB  %00111111;pregunta X = $21
           DB  %00111101;igual X = $22
           DB  %00000000; mu X=$23
           DB  %00100000;ESPACIO X=$24
           DB  %00000001; Yaz X=$25
           DB  %01100101;e  X = $26
           DB  %00111010;dos puntos X = $27
           DB  %01101110;n  X = $28
           DB  %01000010;B  X = $29
           DB  %01100100;d  X = $2A
           DB  %01001010;J  X = $2B
           DB  %01110110;v  X = $2C
**************************************************************************************************************************
BOBO                       ;Rutina para los vectores no utilizados. Se pone "por las dudas"
           NOP
           RTI
*************************************TABLA DE VECTORES*******************************************************************

           ORG  VECTORS

           DW   BOBO  ;FFDE-FFDF
           DW   BOBO  ;FFE0-FFE1
           DW   BOBO  ;FFE2-FFE3
           DW   BOBO  ;FFE4-FFE5
           DW   BOBO  ;FFE6-FFE7
           DW   BOBO  ;FFE8-FFE9
           DW   BOBO  ;FFEA-FFEB
           DW   BOBO  ;FFEC-FFED
           DW   BOBO  ;FFEE-FFEF
           DW   BOBO  ;FFF0-FFF1
           DW   BOBO  ;FFF2-FFF3
           DW   BOBO  ;FFF4-FFF5
           DW   BOBO  ;FFF6-FFF7
           DW   BOBO  ;FFFF8-FFF9
           DW   BOBO  ;FFFA-FFFB
           DW   BOBO  ;FFFC-FFFD
           DW   START ;FFFE-FFFF
**************************************************************************************************************************
END
**************************************************************************************************************************














