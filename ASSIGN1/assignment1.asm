TITLE Program Template     (template.asm)

; Author: Andrew Pynch
; Last Modified: 7/6/2020
; OSU email address: pyncha@oregonstate.edu
; Course number/section: CS271 SEC 1
; Assignment Number: 1                
; Due Date: 7/5/2020
; Description: Assignment 1
; - Display name and program title
; - Display instructions for user
; - Prompt user to enter two numbers
; - Calculate sum, difference, product, int quotient, and remainder of said numbers
; - Display a terminating message

INCLUDE Irvine32.inc

; (insert constant definitions here)
.data
assignment							Byte    "Assignment Title: Assignment 1", 0
fullname							BYTE	"Full Name: Andrew James Pynch", 0

manual								BYTE    "Please enter two real integers. These will be used in compliance with the assingment requirements to compute the sum, difference, quotient, and remainder of both integers", 0

terminate_program					BYTE    "Thank you for utilizing this program. This message is sponsored by Gabe Newell", 0

; Placeholder format strings for showing our users what they are entering
input1								BYTE	"First Integer: ", 0
input2								BYTE    "Second Integer: ", 0

; Placeholders for human readable results
read_sum							BYTE	"Sum: ", 0
read_diff							BYTE    "Difference: ", 0
read_prod							BYTE    "Product: ", 0
read_quot							BYTE    "Quotient: ", 0
read_remain							BYTE    "Remainder: ", 0

; Placeholders for ints
num1								DWORD	?
num2								DWORD	?
sum									DWORD	?
diff								DWORD	?
prod								DWORD	?
quot								DWORD	?
remain								DWORD	?

; (insert variable definitions here)
.code
main PROC
INTRODUCTION:
	call Clrscr ; remove the default crap that displays in the console window
	; Print my name to le screen
		mov		edx, OFFSET fullname
		call	WriteString
		call	CrLf

	; Display assignment number
		mov		edx, OFFSET assignment
		call	WriteString
		call	CrLf	
		
	; Display user manual
		mov		edx, OFFSET manual
		call	WriteString
		call	CrLf


INPUT:
	; Get num1
		mov		edx, OFFSET input1
		call	WriteString
		call	ReadInt
		mov		num1, eax

	; Get num1
		mov		edx, OFFSET input2
		call	WriteString
		call	ReadInt
		mov		num2, eax


COMPUTATIONS:
	; +
		mov		eax, num1 ; num1 --> eax reg
		add		eax, num2 ; add num2 to the value of num1 stored in the eax register
		mov		sum, eax  ; eax  --> sum
		mov		eax, 0	  ; reset the value of eax to 0 
	; -
		mov		eax, num1 ; num1 --> eax reg
		sub		eax, num2 ; add num2 to the value of num1 stored in the eax register
		mov		diff, eax ; eax  --> diff
		mov		eax, 0	  ; reset the value of eax to 0 

	; *
		mov		eax, num1 ; num1 --> eax reg
		mov		ebx, num2 ; num2 --> ebx reg
		mul		ebx		  ; Compute : eax * ebx
		mov		prod, eax ; eax  --> prod
		mov		eax, 0	  ; reset the value of eax to 0 

	; ÷
		mov		edx, 0    ; init edx to 0 to prevent overflow
		mov		edx, num1 ; num1 --> edx reg
		mov		eax, num2 ; num2 --> eax reg
		div		ebx		  ; Compute : eax / ebx
		mov		quot, eax ; eax  --> quot
		mov		remain, edx;edx  --> remain
		mov		eax, 0	  ; reset the value of eax to 0 

RESULTS:
	; Print + 
		mov		edx, OFFSET read_sum
		call	WriteString
		mov		eax, sum
		call	WriteDec
		call	CrLf

	; Print -
		mov		edx, OFFSET read_diff
		call	WriteString
		mov		eax, diff
		call	WriteDec
		call	CrLf

	; Print *
		mov		edx, OFFSET read_prod
		call	WriteString
		mov		eax, prod
		call	WriteDec
		call	CrLf

	; Print ÷
		mov		edx, OFFSET read_quot
		call	WriteString
		mov		eax, quot
		call	WriteDec
		call	CrLf

	; Print r
		mov		edx, OFFSET read_remain
		call	WriteString
		mov		eax, remain
		call	WriteDec
		call	CrLf


TERMINATE:
	; Thank the user and close the program
		mov		edx, OFFSET terminate_program
		call	WriteString
		call	CrLf


; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main

; Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not. It’s not a story the Jedi would tell you. It’s a Sith legend. Darth Plagueis was a Dark Lord of the Sith, 
; so powerful and so wise he could use the Force to influence the midichlorians to create life… He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. 
; The dark side of the Force is a pathway to many abilities some consider to be unnatural. He became so powerful… the only thing he was afraid of was losing his power, which eventually, of course, he did. 
; Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself.
