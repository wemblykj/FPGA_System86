################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
System86Supervisor.elf.size \

ELFCHECK += \
System86Supervisor.elf.elfcheck \


# All Target
all: System86Supervisor.elf secondary-outputs

# Tool invocations
System86Supervisor.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze g++ linker'
	mb-g++ -Wl,-T -Wl,../src/lscript.ld -L../../System86Supervisor_bsp/microblaze_0/lib -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.50.c -mno-xl-soft-mul -Wl,--no-relax -Wl,--gc-sections -o "System86Supervisor.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

System86Supervisor.elf.size: System86Supervisor.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size System86Supervisor.elf  |tee "System86Supervisor.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

System86Supervisor.elf.elfcheck: System86Supervisor.elf
	@echo 'Invoking: Xilinx ELF Check'
	elfcheck System86Supervisor.elf -hw ../../system86_hw_platform/system.xml -pe microblaze_0  |tee "System86Supervisor.elf.elfcheck"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(CC_DEPS)$(CPP_DEPS)$(EXECUTABLES)$(ELFSIZE)$(CXX_DEPS)$(C_UPPER_DEPS)$(ELFCHECK)$(S_UPPER_DEPS) System86Supervisor.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE) $(ELFCHECK)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
