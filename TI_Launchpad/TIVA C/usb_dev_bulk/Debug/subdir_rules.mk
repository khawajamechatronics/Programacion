################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
startup_ccs.obj: ../startup_ccs.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv5/tools/compiler/arm_5.0.4/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 --abi=eabi -me -O2 -g --include_path="C:/ti/ccsv5/tools/compiler/arm_5.0.4/include" --include_path="C:/ti/TivaWare_C_Series-2.1.0.12573" --gcc --define=ccs="ccs" --define=PART_TM4C123GH6PM --define=TARGET_IS_TM4C123_RB1 --define=UART_BUFFERED --diag_warning=225 --display_error_number --diag_wrap=off --gen_func_subsections=on --ual --preproc_with_compile --preproc_dependency="startup_ccs.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

usb_bulk_structs.obj: ../usb_bulk_structs.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv5/tools/compiler/arm_5.0.4/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 --abi=eabi -me -O2 -g --include_path="C:/ti/ccsv5/tools/compiler/arm_5.0.4/include" --include_path="C:/ti/TivaWare_C_Series-2.1.0.12573" --gcc --define=ccs="ccs" --define=PART_TM4C123GH6PM --define=TARGET_IS_TM4C123_RB1 --define=UART_BUFFERED --diag_warning=225 --display_error_number --diag_wrap=off --gen_func_subsections=on --ual --preproc_with_compile --preproc_dependency="usb_bulk_structs.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

usb_dev_bulk.obj: ../usb_dev_bulk.c $(GEN_OPTS) $(GEN_SRCS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv5/tools/compiler/arm_5.0.4/bin/armcl" -mv7M4 --code_state=16 --float_support=FPv4SPD16 --abi=eabi -me -O2 -g --include_path="C:/ti/ccsv5/tools/compiler/arm_5.0.4/include" --include_path="C:/ti/TivaWare_C_Series-2.1.0.12573" --gcc --define=ccs="ccs" --define=PART_TM4C123GH6PM --define=TARGET_IS_TM4C123_RB1 --define=UART_BUFFERED --diag_warning=225 --display_error_number --diag_wrap=off --gen_func_subsections=on --ual --preproc_with_compile --preproc_dependency="usb_dev_bulk.pp" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


