################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/platform.c \
../src/xtmrctr_intr_example.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/platform.o \
./src/xtmrctr_intr_example.o 

C_DEPS += \
./src/platform.d \
./src/xtmrctr_intr_example.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../hello_world_bsp/microblaze_0/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.50.b -mno-xl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


