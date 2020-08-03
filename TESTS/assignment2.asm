TITLE Program Template     (template.asm)

INCLUDE Irvine32.inc

.data
y					DWORD		?
gequalmessage		BYTE		"Y >= 200: "
lessmessage			BYTE		"Y < 50:   "
greatermessage		BYTE		"Y > 60:   "



.code
main PROC

compare:
mov					eax, 200
cmp					eax, y
ja					gequal

mov					eax, 50
cmp					eax, y
jb					less

mov					eax, 60
cmp					eax, y
ja					greater



gequal:
	mov					edx, OFFSET gequalmessage
	call				WriteString
	call				CrLf


less:
	mov					edx, OFFSET lessmessage	
	call				WriteString
	call				CrLf

greater:
	mov					edx, OFFSET greatermessage
	call				WriteString
	call				CrLf

	mov					eax, y
	sub					eax, 1
	call				WriteDec ; Print the result of y - 1 


exit

main ENDP
END main