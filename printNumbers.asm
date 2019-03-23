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
		cmp bl, 10
		jl print_digit
		cmp bl, 20
		jl print_teen
		jge print_tens
	print_digit:
		push ax
		push dx
		mov al, bl
		mov dl, 2
		mul dl
		mov bl, al
		mov ax, seg data1
		mov ds, ax
		mov dx, word ptr ds:[digit_array + bx]
		call my_println
		pop dx
		pop ax
		ret
	print_teen:
		push ax
		push dx
		sub bl, 10
		mov al, bl
		mov dl, 2
		mul dl
		mov bl, al
		mov ax, seg data1
		mov ds, ax
		mov dx, word ptr ds:[teen_array + bx]
		call my_println
		pop dx
		pop ax
		ret
	print_tens:
		push ax
		push dx
		mov ax, seg data1
		mov ds, ax
		
		xor ah,ah
		mov al, bl 					;Wyciaganie liczby dziesiatek
		mov bx,10					;podziel ax przez 10 
		xor dx,dx					;dzielenie wymaga wyzerowanego dx
		div bx						;cyfra jedności w dx, dziesiątek w ax
		
		push dx		;Odlozenie wyniku na stos (al - 10, ah - jednosci)
		
		sub al, 2	;Odjecie od wyniku 2 bo tablica zaczyna sie od 20
		
		shl al, 1	;Mnozenie wyniku przez dwa (bo word)
		
		xor bx, bx
		mov bl, al
		
		mov ax, seg data1 ;Wyswietlenie dziesiatek slownie
		mov ds, ax
		mov dx, word ptr ds:[tens_array + bx]
		call my_print
		
		pop ax	;Wyswietlenie jednosci slownie
		mov bl, al
		pop dx
		pop ax
		jmp print_digit
		ret
	log_error_num:
		pop ax
		pop ax
		mov dx, offset ninety
		call my_println
		ret