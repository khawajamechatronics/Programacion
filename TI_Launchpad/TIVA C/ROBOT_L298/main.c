#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "inc/hw_types.h"
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "driverlib/debug.h"
#include "driverlib/pwm.h"
#include "driverlib/pin_map.h"
#include "inc/hw_gpio.h"
#include "inc/tm4c123gh6pm.h"

#define PWM_FREQUENCY 50//Se define la frecuencia del PWM
volatile uint32_t ui32Load;
volatile uint32_t ui32PWMClock;
volatile uint8_t ui32Adjust;//nos permitir� ajustar la posici�n del ancho.


#define IN1_I 0x01
#define IN2_I 0x02
#define IN1_D 0x04
#define IN2_D 0x08


void configPWM(){
	ui32Adjust = 50;
	SysCtlPWMClockSet(SYSCTL_PWMDIV_64);//El modulo PWM esta sincronizado por el reloj del sistema a traves de un divisor. Al fijarlo en 64 al divisor, el reloj del PWM es 625Khz
	SysCtlPeripheralEnable(SYSCTL_PERIPH_PWM1);//Habilita PWM
	SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOD);//Pin de salida para PWM
	GPIOPinTypePWM(GPIO_PORTD_BASE, GPIO_PIN_0);//Port D pin 0 (PD0) debe estar configurado como un pin de salida PWM para el m�dulo 1
	GPIOPinConfigure(GPIO_PD0_M1PWM0);//generador de PWM n� 0
	ui32PWMClock = SysCtlClockGet() / 64;//Para obtener el reloj del PWM, se divide el reloj del sistema en 64;
	ui32Load = (ui32PWMClock / PWM_FREQUENCY) - 1;//Se divide el reloj del PWM en la frecuencia para cargarlo en el registro LOAD, se resta uno porque cuenta hasta 0
	PWMGenConfigure(PWM1_BASE, PWM_GEN_0, PWM_GEN_MODE_DOWN);//Se configura el modulo1 del PWM para que haga cuenta descendente
	PWMGenPeriodSet(PWM1_BASE, PWM_GEN_0, ui32Load);//Se carga el valor del contador
//	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 1000);//Define el ancho del pulso
	PWMOutputState(PWM1_BASE, PWM_OUT_0_BIT, true);//Habilita el generador 0 como salida
	PWMGenEnable(PWM1_BASE, PWM_GEN_0);//Habilita el generador 0 para funcionar

	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 255);
}

void frenar(){
	GPIO_PORTB_DATA_R = 0xFF;
}

void avanzar(){
	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 255);
	GPIO_PORTB_DATA_R = 0x11;
}

void retroceder(){
	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 255);
	GPIO_PORTB_DATA_R = 0x22;
}

void izquierda(){
	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 255);
	GPIO_PORTB_DATA_R = 0x12;
}

void derecha(){
	PWMPulseWidthSet(PWM1_BASE, PWM_OUT_0, ui32Adjust * ui32Load / 255);
	GPIO_PORTB_DATA_R = 0x21;
}

int main(void)
{
	SysCtlClockSet(SYSCTL_SYSDIV_4|SYSCTL_USE_PLL|SYSCTL_OSC_MAIN|SYSCTL_XTAL_16MHZ);//El sistema corre a 40Mhz
	configPWM();

	SYSCTL_RCGC2_R = SYSCTL_RCGC2_GPIOB; // enable PORT B GPIO
	GPIO_PORTB_DIR_R = IN1_I|IN2_I|IN1_D|IN2_D; // set PORT B as output
	GPIO_PORTB_DEN_R = IN1_I|IN2_I|IN1_D|IN2_D; // enable digital PORT B
	GPIO_PORTB_DATA_R = 0x00; // clear all PORT B

	while(1)
	{
		//izquierda();

	}
}