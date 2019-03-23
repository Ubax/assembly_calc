printNumbers: ;bx - number
		cmp bx, 0
			jge doPrintNumbers
		mov dx, offset neg_str
		call my_print
		neg bx
	doPrintNumbers:
		cmp bl, 10
			jl print_digit
		cmp bl, 20
			jl print_teen
			jge print_tens
	print_digit:
		shl bl, 1				;Multipling by 2 (word) 
		mov ax, seg data1
		mov ds, ax
		mov dx, word ptr ds:[digit_array + bx]
		call my_println
		ret
	print_teen:
		sub bl, 10
		shl bl, 1				;Multipling by 2 (word) 
		mov ax, seg data1
		mov ds, ax
		mov dx, word ptr ds:[teen_array + bx]
		call my_println
		ret
	print_tens:
		xor ax,ax
		xor dx,dx					;Dzielenie wymaga wyzerowanego dx
		
		mov al, bl 					;Wyciaganie liczby dziesiatek
		mov bx,10							
		div bx					
		
		push dx						;Odlozenie jednosci na stos
		
		sub al, 2					;Odjecie od wyniku 2 bo tablica zaczyna sie od 20
		
		shl al, 1					;Mnozenie wyniku przez dwa (bo word)
		
		xor bx, bx
		mov bl, al
		
		mov ax, seg data1 			;Wyswietlenie dziesiatek slownie
		mov ds, ax
		mov dx, word ptr ds:[tens_array + bx]
		call my_print
		
		pop bx						;Wyswietlenie jednosci slownie
	
		cmp bl, 0
		jne print_digit
		ret