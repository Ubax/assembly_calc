my_print:
    mov ax, seg data1
    mov ds, ax
    mov ah, 9h
    int 21h
	ret
	
my_println:
    call my_print
	
	mov dx, offset newLine
    call my_print
	ret
	
my_get_word:
	mov ax, seg data1
    mov ds, ax
	mov ah, 0ah
	mov dx, offset input
	int 21h
	
	mov ax, seg data1
	mov ds, ax
	mov si, offset input + 1 ;NUMBER OF CHARACTERS ENTERED.
	mov cl, [ si ] ;MOVE LENGTH TO CL.
	mov ch, 0      ;CLEAR CH TO USE CX. 
	inc cx ;TO REACH CHR(13).
	add si, cx ;NOW SI POINTS TO CHR(13).
	mov al, '$'
	mov [ si ], al ;REPLACE CHR(13) BY '$'

log_error:
	mov dx, offset bad_input
	call my_println
	ret
	
print_char:
	mov ah, 2
	mov dl, al
	int 21h
	ret