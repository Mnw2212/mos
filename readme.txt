gcc -ffreestanding -c basic.c -o basic.o	// create basic.o
objdump -d basic.o							// for viewing the file
ld -o basic.bin -Ttext 0x0 --oformat binary basic.o	// Linking file


The involved steps are as follows:
• Write and compile the kernel code.
• Write and assemble the boot sector code
• Create a kernel image that includes not only our boot sector but our compiled
kernel code
• Load our kernel code into memory
• Switch to 32-bit protected mode
• Begin executing our kernel code
