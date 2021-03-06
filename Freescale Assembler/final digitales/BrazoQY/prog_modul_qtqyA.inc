*******************************************************************************
* 			PROG_MODUL_QTQYA - ARCHIVO INCLUDE
* Contiene la Programacion de los Modulos del MC68HC908QTxxA/QYxxA
*******************************************************************************
prog_modulos:
;-------------- Programo el CONFIG --------------------------------------------
	mov	#%10000000,CONFIG2	;Configuracion del registro
;		   \\\\\\\\_____________;RSTEN= 0 Funcion inactiva en pin
;		    \\\\\\\_____________;OSCENINSTOP= 0 Oscilador desab en STOP
;		     \\\\\\_____________;none
;		      \\\\\_____________;none
;		       \\\\_____________;none
;		        \\\_____________;none
;		         \\_____________;IRQEN= 0 IRQ desabilitada
;		          \_____________;IRQPUD= 1 Pull Up desconectada


        mov	#%00001101,CONFIG1	;Configuracion del registro
;                  \\\\\\\\_____________;COPD= 1 COP desabilitado
;                   \\\\\\\_____________;STOP= 0 instruccion STOP desabilitada
;                    \\\\\\_____________;SSREC= 1 Recup de modo STOP 32 ciclos
;                     \\\\\_____________;LVITRIP= 1 LVI operate en 5V
;                      \\\\_____________;LVIPWRD= 0 LVI habilitado
;                       \\\_____________;LVIRSTD= 0 Reset desde LVI habilitado
;                        \\_____________;LVISTOP= 0 LVI desabilitado en STOP
;                         \_____________;COPRS= 0 COP reset long cycle

	nop				; aseguran la configuracion
	nop				;
	nop				;

;-------------- Programacion del OSCILADOR QTA/QYA-----------------------------
; Fclock=12.8 MHz -> Fbus=3.2 MHz -> Ciclo T=312,50 nseg
;------------------------------------------------------------------------------
	mov	#%00100000,OSCSC	; OSCILLATOR STATUS & CONTROL REGISTER
;		   \\\\\\\\_____________;ECGST= Read Only
;		    \\\\\\\_____________;ECGON= 0 Oscilador Externo desabilitado
;		     \\\\\\_____________;ECFS0= 0 \ 00= Xtal Externo 8-32 MHz
;		      \\\\\_____________;ECFS1= 0 /
;		       \\\\_____________;ICFS0= 0 \ 10= Osc 12.8 MHz
;		        \\\_____________;ICSF1= 1 /
;		         \\_____________;OSCOPT0= 0 \ 00= Oscilador Interno
;		          \_____________;OSCOPT1= 0 /

	mov	#$81,OSCTRIM		;Ajuste Fino del Oscilador

;-------------- Programacion del OSCILADOR No Version A -----------------------
;	mov	#%00000000,OSCSTAT	; OSCILLATOR STATUS REGISTER
;
;------------------------------------------------------------------------------
	jsr	demora_qy		;Demora de 81,761 mseg
	jsr	demora_qy		;Demora de 81,761 mseg
	jsr	demora_qy		;Demora de 81,761 mseg
	jsr	demora_qy		;Demora de 81,761 mseg
	jsr	demora_qy		;Demora de 81,761 mseg
	jsr	demora_qy		;Demora de 81,761 mseg

;******************************************************************************
; 	DEFINICION DE LOS PINES DE ENTRADA/SALIDA DEL EQUIPO
;******************************************************************************
;---------------------- Puerto B
        led1    equ  0		;Salida Control de Led 1
        led_2	equ  1		;Salida Control de Led 2
        led_3	equ  2		;Salida Control de Led 3
        led_4	equ  3		;Salida Control de Led 4
        led_5	equ  4		;Salida Control de Led 5
        led_6	equ  5		;Salida Control de Led 6
        led_7	equ  6		;Salida Control de Led 7
        led_8	equ  7		;Salida Control de Led 8

;-------------- Programo los PUERTOS I/O --------------------------------------
        mov     #%11100111,PORTA		;Programo el PTA y luego el DDRA
        mov     #%11111010,DDRA		;
        mov     #%11100111,PORTA		;Escribo Valores por default

        mov     #%11111111,PORTB		;Programo el PTA y luego el DDRA
        mov     #%11111111,DDRB		;
        mov     #%11111111,PORTB		;Escribo Valores por default

;---------------------------------------;--------------------------------------

	rts
