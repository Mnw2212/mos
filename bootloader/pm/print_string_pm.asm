[bits 32]					;defining 32 bits
							;defining some constan
							
							
VIDEO_MEMORY equ 0xb8000	; Memory address for VGA mode is oxb800,
							; anything writen into subsequent address
							; will be VGA
							; 0xb800 serves as the base address
WHITE_ON_BLACK equ 0x0f		; white on black 

; prints a null terminated string pointed by EDX

print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY	; edx is started to video memory

print_string_pm_loop:
	mov al,[ebx]			; store char at ebx , al register
	mov ah, WHITE_ON_BLACK	; attribute stored in AH
	
	cmp al,0				; if al==0 , printing is done
	je print_string_pm_done
	
	mov [edx],ax			; store char and attr. at current charecter cell
	
	add ebx,1				;increment ebx to next char				
	add edx,2				; move next char. cell in vid mem
	
	jmp print_string_pm_loop	; loop to print next char
	
print_string_pm_done:
	popa					; pop all registers
	ret						; Return the function
	
