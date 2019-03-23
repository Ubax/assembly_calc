data1 segment
	input		db	255 	;Maximum number of charactes entered by user
				db 	?	;Number of charactes entered
	inputstr	db	256 dup('$')
	newLine 	db 	10, 13, '$'
	
	;******** ERROR MESSAGES ********
	bad_input	db	"Bad input$"
	in_num		db	"in number: $"
	in_opera	db	"in operation: $"
	wrg_ord		db	"wrong numbers order in subtract operation$"
	
	m_welcome	db	"Wirte your operation: $"
	m_result	db 	"This is result: $"
	
	number1		db	20 dup('$')
	number2		db	20 dup('$')
	operation	db	20 dup('$')
	
	wh_min		db	'a'
	wh_max		db	'z'
	
	;******** OPERATIONS ********
	plus		db "plus$"
	minus		db "minus$"
	multiply	db "times$"
	
	
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
	tens_array	dw	offset twenty, offset thirty, offset fourty, offset fifty, offset sixty, offset seventy, offset ninety
	digit_array	dw	offset zero, offset one, offset two, offset three, offset four, offset five, offset six, offset seven, offset eight, offset nine
	teen_array	dw	offset ten, offset eleven, offset twelve, offset thirteen, offset fourteen, offset fifteen, offset sixteen, offset seventeen, offset eighteen, offset nineteen
	
data1 ends

code1 segment
start1:
    ;Stack initiation
    mov sp, offset wstosu
    mov ax, seg wstosu
    mov ss, ax
	
	mov dx, offset m_welcome
	call my_print
	
	call my_get_word
	mov dx, offset inputstr
	call my_println
	
	call processInput
	
	
	mov bx, offset number1
	call compareNumbers
	
	push bx
	
	mov bx, offset number2
	call compareNumbers
	
	push bx

	pop dx
	pop bx
	mov ax, offset operation
	call doOperation
	
	mov dx, offset m_result
	call my_print
	call printNumbers

end1:
    mov ax,4c00h
    int 21h

log_error:
	mov dx, offset bad_input
	call my_println
	ret
	
print_char:
	mov ah, 2
	mov dl, al
	int 21h
	ret
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

printNumbers: ;bl - number
		cmp bx, 99
			jg log_error
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
		mov bx, ax
		
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
		call log_error
		mov dx, offset in_num
		call my_print
		mov dx, bx
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
	ret
code1 ENDS

STOS1 SEGMENT STACK
        dw 200 dup(?)
wstosu  dw ?
STOS1 ENDS

END start1