compareNumbers: ; bx - number
		mov ax, seg data1
		mov ds, ax
		mov es, ax
		
		cld
		mov cx, 5
		mov si, bx
		mov di, offset zero
		repe cmpsb
			jne comp_one
		mov bx, 0 
		ret

	comp_one:	
		mov cx, 4
		mov si, bx
		mov di, offset one
		repe cmpsb
			jne comp_two
		mov bx, 1 
		ret

	comp_two:
		mov cx, 4	
		mov si, bx
		mov di, offset two
		repe cmpsb
			jne comp_three
		mov bx, 2 
		ret
	comp_three:
		mov cx, 6	
		mov si, bx
		mov di, offset three
		repe cmpsb
			jne comp_four
		mov bx, 3 
		ret
	comp_four:
		mov cx, 5	
		mov si, bx
		mov di, offset four
		repe cmpsb
			jne comp_five
		mov bx, 4 
		ret
	comp_five:
		mov cx, 5	
		mov si, bx
		mov di, offset five
		repe cmpsb
			jne comp_six
		mov bx, 5 
		ret
	comp_six:
		mov cx, 4	
		mov si, bx
		mov di, offset six
		repe cmpsb
			jne comp_seven
		mov bx, 6 
		ret
	comp_seven:
		mov cx, 6	
		mov si, bx
		mov di, offset seven
		repe cmpsb
			jne comp_eight
		mov bx, 7 
		ret
	comp_eight:
		mov cx, 6	
		mov si, bx
		mov di, offset eight
		repe cmpsb
			jne comp_nine
		mov bx, 8 
		ret
	comp_nine:
		mov cx, 5	
		mov si, bx
		mov di, offset nine
		repe cmpsb
			jne compareNumbers_unknown
		mov bx, 9 
		ret
	compareNumbers_unknown:
		mov dx, offset unknown_num
		call my_print
		mov dx, bx
		call log_error
		ret