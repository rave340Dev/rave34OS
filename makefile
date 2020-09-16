
AS = /home/rave340/opt/cross/bin/i686-elf-as
CC = /home/rave340/opt/cross/bin/i686-elf-gcc

C_SOURCES := $(shell find . -name "*.c")
ASM_SOURCES := $(shell find . -name "*.s")

CFLAGS := -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I. -I./include 

OBJ = ${C_SOURCES:.c=.o} ${ASM_SOURCES:.s=.o}

ISO = rave34OS.iso

all: rave34OS.iso clean

%.o: %.c
	${CC} -c $< -o $@ ${CFLAGS}

%.o: %.s
	${AS} $< -o $@

rave34OS.bin: ${OBJ}
	${CC} -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $^ -lgcc

check-multiboot: rave34OS.bin
	grub-file --is-x86-multiboot rave34OS.bin

rave34OS.iso: check-multiboot
	rm -rf isodir/
	mkdir -p isodir/boot/grub
	cp rave34OS.bin isodir/boot/rave34OS.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) isodir


clean:
	rm -rf isodir/
	rm -rf *.o

qemu:
	qemu-system-i386 -cdrom $(ISO)