C_SOURCES = $(wildcard kernel/*c drivers/*.c, cpu/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h, cpu/*.h)
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
GDB = /usr/bin/gdb
CFLAGS= -g # use debug symbols on gcc

os_image.bin: boot/bootsector.bin kernel.bin
	cat $^ > $@

kernel.bin: boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.elf: boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^

run: os_image.bin
	qemu-system-x86_64 -fda $< 

debug: os_image.bin kernel.elf
	qemu-system-x86_64 -s -fda os_image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.nasm
	nasm $< -f elf -o $@

%.bin: %.nasm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o

