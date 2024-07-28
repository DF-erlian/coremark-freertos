CC = arm-none-eabi-gcc
CFLAGS = $(INCLUDE_DIRS)  -DTEST_PRINTF\
        -nostartfiles -ffreestanding \
        -mcpu=cortex-m3 -mthumb -O2 -Wall -Wextra -g3 -ffunction-sections -fdata-sections\
		-DPERFORMANCE_RUN=1 -DITERATIONS=1000 -DFLAGS_STR=\""-O2 -DPERFORMANCE_RUN=1 "\" \
        -MMD -MP -MF"$(@:%.o=%.d)" -MT $@
LDFLAGS = -Xlinker --gc-sections -Xlinker -T mps2_m3.ld \
            -Xlinker -Map=RTOSDemo.map -specs=nano.specs -specs=nosys.specs -specs=rdimon.specs

INCLUDE_DIRS =  -I FreeRTOS/Source/include \
                -I FreeRTOS/Source/portable/GCC/ARM_CM3 \
                -I ./ \
                -I coremark 
                # -I CMSIS


# SRCS = FreeRTOS/portable/GCC/ARM_CM3/port.c FreeRTOS/portable/MemMang/heap_4.c coremark/coremark.c main.c
SRCS += FreeRTOS/Source/tasks.c
SRCS += FreeRTOS/Source/queue.c
SRCS += FreeRTOS/Source/list.c
SRCS += FreeRTOS/Source/portable/GCC/ARM_CM3/port.c
SRCS += FreeRTOS/Source/portable/MemMang/heap_4.c
SRCS += coremark/core_list_join.c 
SRCS += coremark/core_main.c 
SRCS += coremark/core_matrix.c 
SRCS += coremark/core_state.c
SRCS += coremark/core_util.c
SRCS += coremark/core_portme.c
SRCS += main.c

SRCS += startup_gcc.c
SRCS += printf-stdarg.c
# SRCS += IntQueueTimer.c

OUTPUT = coremark_freertos_qemu.elf

all: $(OUTPUT)

$(OUTPUT): $(SRCS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@

clean:
	rm -f $(OUTPUT)
