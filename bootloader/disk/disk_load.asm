disk_load:
	push dx
	
	mov ah,0x02
	mov al,dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl,0x02
	
	int 0x13
	
	jc disk_error
	
	pop dx
	cmp dh,al
	jne disk_error
	ret
print_string:
	mov dx,bx
	int 0x21

disk_error:
		mov bx,DISK_ERROR_MSG
		call print_string
		jmp $
		
DISK_ERROR_MSG db "Disk read error !",0
