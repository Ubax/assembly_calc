data1 segment
	number1		db	"eight$"
	number2		db	"five$"
	operation	db	"plus$"
	newLine 	db 	10, 13, '$'
	bad_input	db	"Bad input$"
	
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
	twenty		db 	"twenty$"
	thirty		db	"thirty$"
	fourty		db	"fourty$"
	fifty		db	"fifty$"
	sixty		db	"sixty$"
	seventy		db 	"seventy$"
	eighty		db	"eighty$"
	ninety		db	"ninety$"
	
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
	
	mov bx, offset number1
	call compareNumbers
	
	push bx
	call printNumbers
	
	mov bx, offset number2
	call compareNumbers
	
	push bx
	call printNumbers

	pop ax
	pop bx
	add bx, ax
	
	cmp bx, 13
	je res
	mov dx, offset eleven
	call my_println
	jmp end1
	
res:
	mov dx, offset nineteen
	call my_println
	jmp end1

end1:
    mov ax,4c00h
    int 21h

printNumbers:
	cmp bx, 10
	jl print_digit
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
print_one:
	
compareNumbers:
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
		
my_println:
    mov ax, seg data1
    mov ds, ax
    mov ah, 9h
    int 21h
	
	mov dx, offset newLine
    int 21h
	ret
code1 ENDS

STOS1 SEGMENT STACK
        dw 200 dup(?)
wstosu  dw ?
STOS1 ENDS

END start1