RAM_INI		EQU	$0080		
FLASH_INI	EQU	$EE00		
VECTORES	EQU	$FFDE
led_1           EQU     7
led_2           EQU     6
led_3           EQU     5
led_4           EQU     4
		

$base		10t			
$Include        'QTQY_registers.inc'	



	org	FLASH_INI
start:
        rsp
	clra				
	clrh				
	clrx				
	sei				
        
        mov     #%10000000,CONFIG2
        mov     #%00001101,CONFIG1
        nop
        nop
        nop
        
        mov     #%00100000,OSCSC
        mov     #$81,OSCTRIM
        
        jsr     demora_qy
        jsr     demora_qy
        jsr     demora_qy
        jsr     demora_qy
        jsr     demora_qy
        jsr     demora_qy
        
        
        
	bset    imaskk,KBSCR		
	mov     #%00000001,KBIER	
	bset    2,KBSCR	        
	bclr    0,KBSCR		
	bclr    1,KBSCR		  

        mov     #%11111111,PORTB         
        mov     #%11111111,DDRB		 
        mov     #%11111111,PORTB
        nop
        nop
                 

        mov     #%11100111,PORTA	
        mov     #%11111110,DDRA	
        mov     #%11100111,PORTA
        nop
        nop
        
        cli


start_00:

	bclr	led_1,PORTB
	jsr	demora_1000ms
        bset	led_1,PORTB
	jsr	demora_1000ms

        bra	start_00		
        
        
demora_qy:
        ldx     #$FF
dem_2:
        lda     #$FF
dem_1:
        deca
        bne     dem_1
        decx
        bne     dem_2
        rts

demora_tecla:
        ldx	#$E0		
dem_02:
	lda	#$E0			
dem_01:
	deca				
        cmp     #$00
	bne	dem_01			
	decx				
        cpx     #$00
    	bne	dem_02		
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
CONTROL_TECLA:
        jsr      demora_tecla
        brclr     0,PORTA,jumper2
        jmp       fin_00

jumper2:
        jsr     ENC_01
        jmp     fin_00

ENC_01:
        bclr	LED_3,PORTB
        jsr	demora_1000ms
        bset	LED_3,PORTB
        bclr	LED_4,PORTB
        jsr	demora_1000ms
        bclr	LED_3,PORTB
        bset	LED_4,PORTB
        jsr	demora_1000ms
        bset	LED_3,PORTB
        rts
fin_00:
        bset    ackk,kbscr              
        bclr    imaskk,kbscr            
        rti


tim1_ov_isr:
	nop
        rti

tim1_1_isr:
        nop
	rti			

tim1_0_isr:
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
