doOperation: ; bx - num1, dx-num2, ax-operation offset
		push bx
		push dx
		
		mov bx, ax
		
		mov ax, seg data1
		mov ds, ax
		mov es, ax
		
		cld
		mov cx, 5
		mov si, bx
		mov di, offset plus
		repe cmpsb
			je plus_operation
		
		mov cx, 6
		mov si, bx
		mov di, offset minus
		repe cmpsb	
			je minus_operation
		
		mov cx, 6
		mov si, bx
		mov di, offset multiply
		repe cmpsb
			je multiply_operation
			jmp unknown_operation
		
	plus_operation:
		pop bx
		pop ax
		add bx, ax
		ret
	minus_operation:
		pop ax
		pop bx
		cmp ax,bx
			jg minus_wrong_numbers_order
		sub bx, ax
		ret
	multiply_operation:
		pop bx
		pop ax
		mul bl
		mov bx,ax
		ret
	unknown_operation:
		pop bx
		pop ax
		call log_error
		mov dx, offset in_opera
		call my_print
		mov dx, bx
		call my_println
		ret
	minus_wrong_numbers_order:
		mov bx, 99
		call log_error
		mov dx, offset wrg_ord
		call my_println
		ret