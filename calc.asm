data1 segment
	include data.asm
data1 ends

code1 segment
start1:
    ;Stack initiation
    mov sp, offset wstosu
    mov ax, seg wstosu
    mov ss, ax
	
	mov dx, offset m_welcome
	call my_print
	
	; call my_get_word
	; mov dx, offset inputstr
	; call my_println
	
	; call processInput
	
	
	; mov bx, offset number1
	; call compareNumbers
	
	; push bx
	
	; mov bx, offset number2
	; call compareNumbers
	
	; push bx

	; pop dx
	; pop bx
	; mov ax, offset operation
	; call doOperation
	
	; mov dx, offset m_result
	; call my_print
	
	mov bx,1
	call printNumbers
	
	mov bx,5
	call printNumbers

	mov bx,10
	call printNumbers
	
	mov bx,15
	call printNumbers
	
	mov bx,20
	call printNumbers
	
	mov bx,25
	call printNumbers
	
	mov bx,33
	call printNumbers
end1:
    mov ax,4c00h
    int 21h

include io.asm
include processInput.asm
include printNumbers.asm
include doOperation.asm
include compareNumbers.asm

code1 ENDS

STOS1 SEGMENT STACK
        dw 200 dup(?)
wstosu  dw ?
STOS1 ENDS

END start1