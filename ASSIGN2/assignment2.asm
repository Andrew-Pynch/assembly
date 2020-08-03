TITLE Program Template     (template.asm)

; Author: Andrew Pynch
; Last Modified: 7/12/2020
; OSU email address: pyncha@oregonstate.edu
; Course number/section: CS271 SEC 1
; Assignment Number: 2                
; Due Date: 7/12/2020
; Description: Assignment 2
; - Getting string input
; - Designing and implementing a counted loop
; - Keeping track of a previous value
; - Implementing data validation

INCLUDE Irvine32.inc

; CONSTS
LOWERBOUND = 1
UPPERBOUND = 46




.data
; Placeholder for my name and assignment number
student					BYTE		"Student: Andrew James Pynch", 0
assignment				BYTE		"Assignment: 2", 0
extraCreditMessage		BYTE		"EXTRA CREDIT: Dear TA / Professor: Since other parts of my program are not functional, I added aligned rows / columns in my program! "

; Placeholder for the program users name
namePrompt				BYTE		"Please enter your full name here: ", 0
numPrompt				BYTE		"Please enter a whole integer: ", 0
user					BYTE		50 DUP(0)
userByte				DWORD		?		  ; counter

; Placeholder for greeting the user and the manual string
greeting				BYTE		"Greetings: ", 0
manual					BYTE		"This assembly program generaates a sequence of fibonaci numbers based off of parameters you generate.", 0

; Placeholder for user input for nums / fib
getFibs					DWORD		? 
getNum1					BYTE		"Please enter an integer in the range of [1-46]: ", 0
revalidate				BYTE		"Please ensure the integer enetered lies in the range of [1-46]: ", 0

; Placeholder for terminationg messages
terminationMessage		BYTE		"Thank you for utilizing this program. This message is sponsored by Gabe Newell. We appreciate your patronage ", 0		

; Rows / Columns
prev					DWORD		?
space					BYTE		"	", 0
col						DWORD		?
row						DWORD		?
curr					DWORD		?
new						DWORD		?




.code
main PROC
INTRODUCTION:
; Introduce myself, the assignment number, get the users name and say hello.
	; Display assignment number
	mov						edx, OFFSET assignment
	call					WriteString
	call					CrLf

	; Introduce myself 
	mov						edx, OFFSET student
	call					WriteString
	call					CrLf

	; Extra Credit Message
	mov						edx, OFFSET extraCreditMessage
	call					WriteString
	call					CrLf

	; Get program users name
	mov						edx, OFFSET namePrompt
	call					WriteString
	mov						edx, OFFSET user ; pointer
	mov						ecx, SIZEOF user ; max chars
	call					ReadString		 ; Actually get the users name

	; Say hello to the user
	mov						edx, OFFSET greeting
	call					WriteString
	mov						edx, OFFSET user
	call					WriteString
	call					CrLf




DISPLAYINSTRUCTIONS:
; Literally just display the instructions for the program
	; Display manual var
	mov						edx, OFFSET manual
	call					WriteString
	call					CrLf




GETUSERINFO:
; Get some user generated parameters and perform some super simple data validation
	fibInput:
		; Get user generated params
		mov						edx, OFFSET getNum1
		call					WriteString		; Display the prompt
		call					ReadInt			; Read in the number the user enters
		mov						getFibs, eax
		; Lower bound validation
		cmp						eax, LOWERBOUND
		jb						invalid			; if inp < lowerbound, jump to revalidate
		; Upperbound validation
		cmp					    eax, UPPERBOUND
		ja						invalid			; if  inp > upperbound, jump to revalidate
		; Continue if everything lookin guchi
		jmp proceed

	invalid:
	; error / reprompt user
		mov						edx, OFFSET revalidate
		call					WriteString
		call					CrLf

	proceed:
		call					CrLf   ; Procedure for advancing the program is user input was within bounds




DISPLAYFIBS:
	; Manual printing of 0 & 1 + incrementing of the columns
	; Init 0 & 1 
	mov						curr, 1
	mov						prev, 0
	mov						eax, prev
	; Print 0
	call					WriteDec 
	; Space
	mov						edx, OFFSET space
	call					WriteString
	; Print 1
	mov						eax, curr
	call					WriteDec
	; Next space
	mov						edx, OFFSET space
	call					WriteString
	; Increment cols
	inc						col 
	inc						col

	; FIB
	cmp						getFibs, 0			; If user input == 1, then we are already done since we manually printed 1 
	jbe						goodbye             ; Terminate the program if user input was 1 
	dec						getFibs				; Only because we already manually printed 0...
	mov						ecx, getFibs		; ELSE: counter = getFibs

	first:
		mov						eax, prev		; get prev eax val
		mov						ebx, curr		
		add						eax, ebx
		call					WriteDec		; Display the fib we just generated

		mov						prev, ebx		; copy curr to prev
		mov						curr, eax		; copy new to curr

		mov						edx, OFFSET space
		call					WriteString		; Pretty printing...

		inc						col				
		cmp						col, 5
		jae						newR
		cmp ecx, 0
		jbe						goodbye
		loop					first
		jmp						goodbye


		; Proc to generate new rows
		newR:
			call					CrLf
			mov						col, 0
			dec						ecx
			cmp						ecx, 0
			ja						first
		

	; GOODBYE
	goodbye:
		call					CrLf
		mov						edx, OFFSET terminationMessage
		call					WriteString
		mov						edx, OFFSET user
		call					WriteString
		call					CrLf




exit

main ENDP
END main