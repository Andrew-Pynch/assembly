TITLE Program Template     (template.asm)

INCLUDE Irvine32.inc

.data
string BYTE " ", 0


.code
main PROC
	push 1
	push 3
	push 4
	call rfinal
	exit
main ENDP

rfinal PROC
	push ebp
	mov ebp, esp
	mov eax, [ebp + 16]
	mov ebx, [ebp + 12]
	mov ecx, [ebp + 8]
	mul ebx
	mov [ebp + 16], eax
	cmp ebx, ecx
	jge unwind

	inc ebx
	push eax
	push ebx
	push ecx
	call rfinal
unwind:
	mov eax, [ebp + 16]
	call WriteDec
	mov edx, OFFSET string
	call WriteString
	pop ebp
	ret 12
rfinal ENDP
END main