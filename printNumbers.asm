printNumbers_prepareRegister:
	mov al, bl
	mov bx, 0
	mov dl, 2				;Multipling by 2 (word) 
	mul dl
	mov bl, al
	mov ax, seg data1
	mov ds, ax
	ret

printNumbers: ;bl - number
		mov bh, 0
		cmp bx, 10
			jl print_digit
		cmp bx, 20
			jl print_teen
			jge print_tens
	print_digit:
		push ax
		push dx
		call printNumbers_prepareRegister
		mov dx, word ptr ds:[digit_array + bx]
		call my_println
		pop dx
		pop ax
		ret
	print_teen:
		push ax
		push dx
		sub bl, 10
		call printNumbers_prepareRegister
		mov dx, word ptr ds:[teen_array + bx]
		call my_println
		pop dx
		pop ax
		ret
	print_tens:
		push ax
		push dx
		
		mov al, bl
		mov bl, 10
		div bl
		mov bx, 0
		mov bl, ah
		mov al, ah
		mov ah, 0
		push ax
		;sub bl, 2
		call printNumbers_prepareRegister
		mov dx, word ptr ds:[tens_array + bx]
		call my_print
		
		pop ax
		mov bl, al
		pop dx
		pop ax
		jmp print_digit
		ret