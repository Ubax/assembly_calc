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
			jmp doOperation_unknown
		
	plus_operation:
		pop bx
		pop ax
		add bx, ax
		ret
	minus_operation:
		pop ax
		pop bx
		sub bx, ax
		ret
	multiply_operation:
		pop bx
		pop ax
		mul bl
		mov bx,ax
		ret
	doOperation_unknown:
		pop bx
		pop ax
		mov dx, offset unknown_ope
		call log_error
		mov dx, bx
		call my_println
		ret