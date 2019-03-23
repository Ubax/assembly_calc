processWhitespaces:
	inc si
	mov bl, byte ptr ds:[si]
	;call print_char
	cmp bl, '$'
		je end_processWhitespaces
	cmp bl, byte ptr ds:[wh_min] 		; czy mniejsze od a
		jl processWhitespaces 
	cmp bl, byte ptr ds:[wh_max]		;czy wieksze od z
		jg processWhitespaces
	end_processWhitespaces:
	ret
	
processInput:
	mov ax, seg data1
	mov ds, ax
	mov si, offset input + 1
	call processWhitespaces
	mov cx, offset number1
	beg_reading_number1:
		mov bl, byte ptr ds:[si]
		;call print_char
		cmp bl, '$'
			je log_error
		cmp bl, byte ptr ds:[wh_min]			; czy mniejsze od a
			jl end_reading_number1 
		cmp bl, byte ptr ds:[wh_max]			;czy wieksze od z
			jg end_reading_number1
		mov ax, si
		mov si, cx
		mov byte ptr ds:[si], bl
		mov si, ax
		inc si
		inc cx
		jmp beg_reading_number1
	end_reading_number1:
		mov dl, '$'
		mov byte ptr ds:[number1 + 5], dl
		
	call processWhitespaces
	mov cx, offset operation
	beg_reading_operation:
		mov bl, byte ptr ds:[si]
		;call print_char
		cmp bl, '$'
			je log_error
		cmp bl, byte ptr ds:[wh_min] 		; czy mniejsze od a
			jl end_reading_operation 
		cmp bl, byte ptr ds:[wh_max]		;czy wieksze od z
			jg end_reading_operation
		mov ax, si
		mov si, cx
		mov byte ptr ds:[si], bl
		mov si, ax
		inc si
		inc cx
		jmp beg_reading_operation
	end_reading_operation:
		mov dl, '$'
		mov byte ptr ds:[number1 + 5], dl
		
	call processWhitespaces
	mov cx, offset number2
	beg_reading_number2:
		mov bl, byte ptr ds:[si]
		;call print_char
		cmp bl, '$'
			je end_reading_number2
		cmp bl, byte ptr ds:[wh_min] 		; czy mniejsze od a
			jl end_reading_number2 
		cmp bl, byte ptr ds:[wh_max]			;czy wieksze od z
			jg end_reading_number2
		mov ax, si
		mov si, cx
		mov byte ptr ds:[si], bl
		mov si, ax
		inc si
		inc cx
		jmp beg_reading_number2
	end_reading_number2:
		mov dl, '$'
		mov byte ptr ds:[number1 + 5], dl
	end_processInput:
		ret