TITLE Program Template     (template.asm)
; ===========================================
; Author: Andrew Pynch
; Last Modified: 7/25/2020
; OSU email address: pyncha@oregonstate.edu
; Course number/section: CS271 SEC 1
; Assignment Number: 2 3              
; Due Date: 7/26/2020
; Description: Assignment 2
; - Generate composite numbers in the range of [1-300]. Continue to prompt the user until they enter a number within that range. 
; - Generate composite numbers up to the acceptable value provided by the user

; Objectives:
; - Designing and implementing procedures
; - Designing and implementing loops
; - Writing nested loops
; - Understanding more about data validation
; ===========================================

INCLUDE Irvine32.inc

UPPERBOUND					EQU 300	
LOWERBOUND					EQU 1


.data
; Introduction messages
	programmer					BYTE	"Programmer: Andrew James Pynch", 0
	assignment					BYTE    "Assignment: 3 - Composite Numbers", 0
	notice						BYTE    "Apologies... The formatting is a little weird and you actually have to enter the number twice?!?!?! but I have  been working on this awhile and cant find the mistakes :-("

; Instruction messages
	program_purpose				BYTE	"This program generates composite numbers up to a number you specify in the range [1-300].", 0
	number_prompt				BYTE	"Please enter a number in the range [1-300]: ", 0
	reminder					BYTE    "REMEMBER!!!!!!!!!!, The number must be > 1, and < 300!!!!!!!!!", 0

; Data validation messages
	out_of_range				BYTE	"The number you entered is not in the range [1-300]. Please enter a valid number: ", 0
	gthanmin					BYTE    "The number you entered is greater than the minimum of 1 ", 0
	lthanmax					BYTE    "The number you entered is less than the maximum of 300 ", 0

; Placeholders for the integers the user eneters / other counters. 
	num1						DWORD	?        ; User generated integer
	numcount					DWORD	?	
	currnum						DWORD	4        ; First possible composite number
	idx							BYTE	"We are currently at number: ", 0
	spaces						BYTE    "   ", 0 ; 3 Spaces

; Formatting variables
	rows						BYTE    0	     ; Do we start a new line here?

; Termination messages
	terminationmessage			BYTE	"Ladies and gentlemen, thank you for using the compositerererer. Hope you had a blast! I had a lot of fun making this program", 0
	thank_you_video				BYTE    "I made this thank you video to express my appreciation for this assignment! https://www.youtube.com/watch?v=oHg5SJYRHA0", 0

.code
main PROC
	; Call the procedures to get the program up and running
	call					INTRO
	call					GETDATA
	call					composites
	call					TERMINATEPROGRAM
	exit
main ENDP




; ========================
; ===== INTRODUCTION =====
; ========================
INTRO PROC
; Print programmer
	mov						edx, OFFSET programmer
	call					WriteString
	call					CrLf

; Print assignment number
	mov						edx, OFFSET assignment
	call					WriteString
	call					CrLf

; Print program purpose 
	call					CrLf
	call					CrLf
	mov						edx, OFFSET program_purpose
	call					WriteString
	call					CrLf

; Print notice of a couple of bugs to the TA / Professor
	call					CrLf
	call					CrLf
	mov						edx, OFFSET notice
	call					WriteString
	call					CrLf
INTRO ENDP



; ========================
; ======= GET DATA =======
; ========================
GETDATA PROC
call					CrLf
call					CrLf
; Print the number prompt
	mov						edx, OFFSET number_prompt
	call					WriteString
	call					CrLf

; Remind the user to MIND THE INSTRUCTIONS SMH
	mov						edx, OFFSET reminder
	call					WriteString
	call					CrLf

; Get the user input
	call					ReadInt
	mov						num1, eax					; Move the users number into the eax register
	call					validation					; Call the validate proc to see if the users value is in the allowed range

	ret
GETDATA ENDP




; ==========================
; ======= VALIDATION =======
; ==========================
validation PROC
call					CrLf
call					CrLf
; Validate that the number the user entered actually falls between 1 and 300
	BEGINLOOP:
	; Check upper bound
		cmp						num1, UPPERBOUND        ; Check user generated number against UPPERBOUND to make sure its < UPPERBOUND
		jg						ERROR					; Enter error loop if out of range

	; Let the user know there number was below the upperbound :-)
		mov						edx, OFFSET lthanmax
		call					WriteString
		call					CrLf

	; Check lower bound
		cmp						num1, LOWERBOUND        ; Check user generated number against LOWERBOUND to make sure its > LOWERBOUND
		jl						ERROR					; Enter error loop if out of range
		jmp						VALIDNUM				; If we make it this far, we know the number is valid and we can continue the program

	; Let the user know there number was above the lowerbound :-)
		mov						edx, OFFSET gthanmin
		call					WriteString
		call					CrLf

; Error loop for when the user enters an invalid number
	ERROR:
	; Display error message
		mov						edx, OFFSET out_of_range
		call					WriteString
		call					CrLf

	; Re-get the user number
		mov						edx, OFFSET number_prompt
		call					WriteString
		call					CrLf

	; Get the user input
		call					ReadInt
		mov						num1, eax					; Move the users number into the eax register
		call					validation					; Call the validate proc to see if the users value is in the allowed range		

	; If we made it this far, it means the user finally entered a valid number and we can leave this proc
	VALIDNUM:
		ret
validation ENDP




; ==========================
; ======= COMPOSITES =======
; ==========================
composites PROC
	call					CrLf
	call					CrLf
	mov						ecx, num1						; Move user provided num into the ecx reg

	MAINLOOP:
		call					checkIfComposite
		; Print idx string | JK NOT DOING THIS BECAUSE I DIDN"T REALIZE IT WOULD FUCK UP THE FORMATTING LOL
		;mov						edx, OFFSET idx
		;call					WriteString
		;call					CrLf
		; Print idx value
		mov						eax,  currnum
		call					WriteDec
		; Spaces between numbers
		mov						edx, OFFSET spaces
		call					WriteString
		; Increment those numbers BOIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
		inc						currnum
		inc						numcount
		inc						rows
		; New line required at 10 nums in a row
		cmp						rows, 10
		je						newline
		loop					MAINLOOP
		jmp						TERMINATECOMPOSITE

	NEWLINE:
		call					CrLf
		mov						rows, 0		; Reset rows to 0
		loop					MAINLOOP    ; Reset the main loop

	TERMINATECOMPOSITE:
		ret

composites ENDP




; ================================
; ======= CHECKIFCOMPOSITE =======
; ================================
checkIfComposite PROC
	call					CrLf
	call					CrLf
	; if currnum % 2 == 0 then its even and is also a composite
	mov						edx, 0
	mov						eax, currnum
	mov						ebx, 2
	div						ebx
	; Check if currnum % 2 == 0
	cmp						edx, 0
	je						ENDCOMPOSITECHECK

	; if currnum % 3 = 0 then its odd and also a composite
	mov						edx, 0
	mov						eax, currnum
	mov						ebx, 3
	div						ebx
	cmp						edx, 0
	je						ENDCOMPOSITECHECK

	mov						numcount, 5 ; since its not a composite, advance the program to calculate how to make currnum a composite


	COMPOSITECALC:
	; Pre calculation setup
		mov						eax, currnum
		mov						ebx, numcount
		mov						edx, 0			; set edx register to 0
	; Prime comparison
		cmp						eax, ebx		; Compare currnum with numcount. If currnum == numcount, num is prime
		je						PRIMERESULT
	; Cmp check
		div						ebx				; If currnum / numcount, then its a composite
		cmp						edx, 0          
		je						ENDCOMPOSITECHECK

		add				        numcount, 2     
		mov						edx, 0
		mov						eax, currnum
		mov						ebx, numcount
		cmp						eax, ebx

		je						PRIMERESULT
		div						ebx
		cmp						edx, 0
		je						ENDCOMPOSITECHECK

		add						numcount, 4
		mov						edx, 0
		mov						eax, numcount
		mul						numcount
		cmp						eax, numcount
		jle						COMPOSITECALC	

	PRIMERESULT:
		inc						currnum

	ENDCOMPOSITECHECK:
		ret
checkIfComposite ENDP




; ==================================
; ======= TERMINATIONPROGRAM =======
; ==================================
TERMINATEPROGRAM PROC
	call					CrLf
	call					CrLf

	mov						edx, OFFSET terminationmessage
	call					WriteString
	call					CrLf

	mov						edx, OFFSET thank_you_video
	call					WriteString
	call					CrLf
TERMINATEPROGRAM ENDP

END main