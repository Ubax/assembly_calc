data1 segment
	input		db	20 dup(?)
	newLine 	db 	10, 13, '$'
	bad_input	db	"Bad input$"
	
	;******** OPERATIONS ********
	plus		db "add$"
	minus		db "subtract$"
	multiply	db "multiply$"
	
	
	;******** DIGITS *********
	zero		db	"zero$"
	one			db	"one$"
	two			db	"two$"
	three		db	"three$"
	four		db	"four$"
	five		db	"five$"
	six			db	"six$"
	seven		db 	"seven$"
	eight		db	"eight$"
	nine		db	"nine$"
	
	;******** TEN TO NINETEEN *********
	ten			db	"ten$"
	eleven		db	"eleven$"
	twelve		db	"twelve$"
	thirteen	db	"thirteen$"
	fourteen	db	"fourteen$"
	fifteen		db	"fifteen$"
	sixteen		db	"sixteen$"
	seventeen	db 	"seventeen$"
	eighteen	db	"eighteen$"
	nineteen	db	"nineteen$"
	
	;******* TENS *******
	twenty		db 	"twenty $"
	thirty		db	"thirty $"
	fourty		db	"fourty $"
	fifty		db	"fifty $"
	sixty		db	"sixty $"
	seventy		db 	"seventy $"
	eighty		db	"eighty $"
	ninety		db	"ninety $"
	
	;****** NUMBERS ARRAY ******
	digit_array	dw	offset zero, offset one, offset two, offset three, offset four, offset five, offset six, offset seven, offset eight, offset nine
	teen_array	dw	offset ten, offset eleven, offset twelve, offset thirteen, offset fourteen, offset fifteen, offset sixteen, offset seventeen, offset eighteen, offset nineteen
	tens_array	dw	offset twenty, offset thirty, offset fourty, offset fifty, offset sixty, offset seventy, offset ninety
data1 ends

code1 segment
start1:
    ;inicjacja stosu
    mov sp, offset wstosu
    mov ax, seg wstosu
    mov ss, ax
	
	call my_get_word
	mov dx, offset input
	call my_println
	mov bx, offset input
	call compareNumbers
	
	push bx
	
	call my_get_word
	mov bx, offset input
	call compareNumbers
	
	push bx

	call my_get_word
	pop dx
	pop bx
	mov ax, offset input
	call doOperation
	
	call printNumbers

end1:
    mov ax,4c00h
    int 21h

printNumbers: ;bl - number
		cmp bx, 10
		jl print_digit
		cmp bx, 20
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
		
		mov al, bl 	;Wyciaganie liczby dziesiatek
		mov bl, 10
		div bl
		
		push ax		;Odlozenie wyniku na stos (al - 10, ah - jednosci)
		
		sub al, 2	;Odjecie od wyniku 2 bo tablica zaczyna sie od 20
		
		mov dl, 2	;Mnozenie wyniku przez dwa (bo word)
		mul dl
		
		mov ax, seg data1 ;Wyswietlenie dziesiatek slownie
		mov ds, ax
		mov dx, word ptr ds:[tens_array + bx]
		call my_print
		
		pop ax	;Wyswietlenie jednosci slownie
		mov bl, ah
		pop dx
		pop ax
		jmp print_digit
		ret

doOperation: ; bx - num1, dx-num2, ax-operation offset
		push bx
		push dx
		
		mov bx, ax
		
		mov ax, seg data1
		mov ds, ax
		mov es, ax
		
		cld
		mov cx, 4
		mov si, bx
		mov di, offset plus
		repe cmpsb
		je plus_operation
		
		mov cx, 9
		mov si, bx
		mov di, offset minus
		repe cmpsb	
		je minus_operation
		
		mov cx, 9
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
		pop bx
		pop ax
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
		mov dx, offset bad_input
		call my_println
		ret
		
	
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
		jne compareNumbers_end
		mov bx, 9 
		ret
	compareNumbers_end:
		mov dx, offset bad_input
		call my_println
		ret

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
	mov al, 0
	lea dx, input
	mov ah, 0ah
	int 21h
	ret
	; ; beg_whitespace_my_get_word:
		; ; call my_getc
		; ; cmp al, 'a' 		; czy mniejsze od a
		; ; jl beg_whitespace_my_get_word 
		; ; cmp al, 'z'		;czy wieksze od z
		; ; jg beg_whitespace_my_get_word
		
		; mov dx, 0 ;dx - iterator
		; mov ax, seg data1 ;Wyswietlenie dziesiatek slownie
		; mov ds, ax
	; beg_reading_my_get_word:
		; mov cl, 'a'
		; cmp al, cl; czy mniejsze od a
		; jl end_my_get_word 
		; ; mov dx, offset ninety
		; ; call my_print
		; ; cmp al, 'z'		;czy wieksze od z
		; ; jg end_my_get_word 
		; mov byte ptr ds:[input + dx], al
		; call my_getc
		; inc dx
		; jmp beg_reading_my_get_word
	; end_my_get_word:
		; mov al, '$'
		; mov byte ptr ds:[input + dx], al
		; mov dx, offset input
		; call my_println
		; ret
		
	
my_getc:
	mov ah, 01H
	int 21h
	ret
code1 ENDS

STOS1 SEGMENT STACK
        dw 200 dup(?)
wstosu  dw ?
STOS1 ENDS

END start1