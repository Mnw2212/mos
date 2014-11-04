[org 0x7c00]

print_string:
	mov dx,bx
	int 0x21

KERNEL_OFFSET equ 0x1000	; memory offset at which kernel wil be loaded

	mov [BOOT_DRIVE],dl		; stores boot drive in dl

	mov bp,0x9000			; setup stack
	mov sp,bp

	mov bx, MSG_REAL_MODE	; Booting in 16 bit mode
	call print_string

	call load_kernel		; load kernel

	call switch_to_pm		; swith to protected mode

	jmp $

; including the routines

;%include "bootloader/print/print_string.asm"
%include "bootloader/disk/disk_load.asm"
%include "bootloader/pm/gdt.asm"
%include "bootloader/pm/print_string_pm.asm"
%include "bootloader/pm/switch_to_pm.asm"

[bits 16]

load_kernel:
	mov bx,MSG_LOAD_KERNEL
	call print_string

	mov bx,KERNEL_OFFSET		; set up disk load routine
	mov dh,15					; load 15 sectors
	mov dl,[BOOT_DRIVE]			; 
	call disk_load

	ret

[bits 32]					; switch to protected mode

BEGIN_PM:
	mov ebx,MSG_PROT_MODE	; 32 bit print routine
	call print_string_pm

	call KERNEL_OFFSET

	jmp $

	; GLOBAL VARIABLES

	BOOT_DRIVE		db 0
	MSG_REAL_MODE	db "Started in 16 bit Real mode",0
	MSG_PROT_MODE	db "SCCESFULLY LANDED IN 32 PROTECTED MODE"
	MSG_LOAD_KERNEL	db "Load kernel into memory"

	; padding
	times 510($-$$) db 0
	dw 0xaa55
