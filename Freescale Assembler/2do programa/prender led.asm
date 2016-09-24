RAM_INI         EQU     $0080
FLASH_INI       EQU     $EE00
VECTORES        EQU     $FFDE
LED_1           EQU     7
LED_2           EQU     6
LED_3           EQU     5
LED_4           EQU     4

  
$base   10t
$include   'QTQY_Registers.inc'

                org     FLASH_INI
start:
                rsp
                clra
                clrh
                clrx
                sei


                mov	#%10000000,CONFIG2
                mov	#%00001101,CONFIG1
                nop
                nop
                nop
                
                mov	#%00100000,OSCSC
                mov	#$81,OSCTRIM
                
                jsr	demora_qy	
                jsr	demora_qy		
                jsr	demora_qy		
                jsr	demora_qy		
                jsr	demora_qy		
                jsr	demora_qy
                              
                mov     #%11111111,DDRB
                mov	#%11111111,PORTB
                nop
                nop
                nop
	
                mov	#%00000010,kbscr        
                mov	#%00000001,kbier                                   
                mov	#%00000000,kbscr       
                cli

start_00:
                bclr    LED_1,PORTB
                jsr	demora_1000ms
                bset	LED_2,PORTB
                bra	start_00

demora_qy:
                ldx	#$ff
dem_2:
                lda	#$ff
dem_1:
                deca
                bne	dem_1
                decx
                bne	dem_2
                rts


demora_1000ms:
                jsr	demora_qy
                jsr	demora_qy
                jsr	demora_qy
                jsr	demora_qy
                jsr	demora_qy
                jsr	demora_qy
demora_500ms:
                jsr	demora_qy
                jsr	demora_qy
demora_320ms:
                jsr	demora_qy
demora_240ms:
                jsr	demora_qy
demora_rapida:
                jsr	demora_qy
                jsr	demora_qy
                rts

adc_isr:
                nop
                rti

keyb_isr:
	        bclr	LED_3,PORTB
	        bset	LED_4,PORTB
                jsr	demora_1000ms
                bset	LED_3,PORTB
                bclr	LED_4,PORTB
                jsr	demora_1000ms
                bclr	LED_3,PORTB
                bset	LED_4,PORTB
                jsr	demora_1000ms
                bset	LED_3,PORTB
                bclr	LED_4,PORTB
        	
                bset  ackk,KBSCR
        	mov #%00000001,KBIER
         	bclr  ackk,KBSCR
         	bclr  imaskk,KBSCR
                nop
                nop
                rti
               
                

tim1_ov_isr:
                nop
                rti

tim1_0_isr:
                nop
                rti

tim1_1_isr:
                nop
                rti

irq_isr:
                nop
                rti
swi_isr:
                nop
                rti

dummy_isr:
                nop
                rti

                org	VECTORES
                fdb	adc_isr		; ADC Vector
                fdb	keyb_isr	; KEYBOARD Vector

                org	$FFF2
                fdb	tim1_ov_isr	; TIM1 Overflow Vector
                fdb	tim1_1_isr	; TIM1 Channel 1 Vector
                fdb	tim1_0_isr	; TIM1 Channel 0 Vector

                org	$FFFA
                fdb	irq_isr		; IRQ1	Vector
                fdb	swi_isr		; SWI Vector
                fdb	Start		; Reset


end

