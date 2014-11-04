[org 0x7c00]

mov bp, 0x9000			; set the stack
mov sp,bp

mov bx, MSG_REAL_MODE
;call print_string

call switch_to_pm			;point of no return

jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print_string_pm.asm"

[bits 32]			;set to 32 bits


BEGIN_PM:			;begin Protected mode

mov ebx, MSG_PROT_MODE
call print_string_pm	;32 bit print routine
;call print

jmp $


;Global Variables

MSG_REAL_MODE db "Started in 16 bit real mode",0
MSG_PROT_MODE db "Succesfully landed in 32 bit Protected mode",0

;boot sector padding
times 510-($-$$) db 0
dw 0xaa55	;boot sector identifier
