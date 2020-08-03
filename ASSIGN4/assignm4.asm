TITLE Program Template     (template.asm)
; ===========================================
; Author: Andrew Pynch
; Last Modified: 8/2/2020
; OSU email address: pyncha@oregonstate.edu
; Course number/section: CS271 SEC 1
; Assignment Number: 4            
; Due Date: 8/2/2020
;	- Get a user request in the range [min = 15 .. max = 200].
;	- Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements of an array.
;	- Display the list of integers before sorting, 10 numbers per line.
;	- Sort the list in descending order (i.e., largest first).
;	- Calculate and display the median value, rounded to the nearest integer.
;	- Display the sorted list, 10 numbers per line.
; ===========================================

INCLUDE Irvine32.inc

; consts
MIN = 10
MAX = 200
LOWERBOUND = 100
UPPERBOUND = 999

.data
; introduction messages
	programmer_assignment	BYTE	"Assignment: 4 | Programmer: Andrew James Pynch", 0
	msg1					BYTE	"This program generates a pseudo random series of numbers as small as 100 and numbers as large as 999", 0
	msg2					BYTE	"The program then displays this random list neatly. Afterwords it performs sorting of the list and calculates a median list value.", 0 
	msg3					BYTE	"Finally, the program displays the recently sorted list neatly in descending order.", 0
	msg4					BYTE	"This program is also busy computing the answer to life, the universe, and everything", 0 
	ta_messagee				BYTE	" ", 0
; Get data messages
	numlength				BYTE	"What should the length of the array of random numbers be? It must in the range[15, 200]: ", 0
	error					BYTE	"Unnaceptable input. Please make sure your entry is within the specified range. ", 0	
	print_unsorted			BYTE	"The unsorted array of integers is: ", 0
	print_median			BYTE	"The median value of the array of integers is:  ", 0
	print_sorted			BYTE	"The sorted array of integers is: ", 0
	line					BYTE	"----------------------------------", 0

; misc	
	spaces					BYTE	"	", 0		
	num1					DWORD	?			
	array					DWORD	MAX DUP(?)		
	
; the answer
	ta_msg					BYTE	" Unfortunately get stupid joke ascii art to print nicely in asm is really hard so I gave up on this fun easter egg :-(", 0
	aa						BYTE	" Computing the answer to life, the universe, and everything... ", 0
	ab						BYTE	"    ======================"
	a						BYTE	"          _,,--,,    _"
	b						BYTE	"        /`       .`\  "
	ce						BYTE	"       /  '  _.-'   \ "
	d						BYTE	"       |  `'_{}_    | "
	e						BYTE	"       |  /`    `\  | "
	f						BYTE	"        \/ ==  == \/  "
	g						BYTE	"        /| (.)(.) |\  "
	h						BYTE	"        \|  __)_  |/  "
	i						BYTE	"         |\/____\/|   "
	j						BYTE	"         | ` ~~ ` |   "
	k						BYTE	"         \        /   "
	l						BYTE	"          `.____.`    "
	m						BYTE	"    ======================"
	n						BYTE	"    = THE ANSWER IS 42!! ="
	o						BYTE    "    ======================"

		


.code
.code
main PROC
; Call the procedures to get the program up and running
; Init randomly once
	call					Randomize
; Init msgs
	call					intro	
; Get user data stuff
	push					OFFSET num1		
	call					GETDATA		
; Init array with random ints in range
	push					OFFSET array			
	push					num1					
	call					POPULATEARRAY					
; Print the init unsorted arr
	push					OFFSET array			
	push					num1					
	push					OFFSET print_unsorted
	call					PRINTARRAY		
; sort the array
	push					OFFSET array			
	push					num1				
	call					SORTARRAY				
; median calculations + print median value
	push					OFFSET array			
	push					num1					
	call					COMPUTEMEDIAN			
; print sorted array
	push					OFFSET array			
	push					num1					
	push					OFFSET print_sorted		
	call					PRINTARRAY	
; Cleanrup
	call					CrLF	
	call					CrLF
; compute the answer to life, the universe, and everything
	call					THEANSWER
	exit	
main ENDP




; ========================
; ===== INTRODUCTION =====
; ========================
intro PROC
	mov						edx, OFFSET programmer_assignment
	call					WriteString
	call					CrLf
	call					CrLf

	mov						edx, OFFSET msg1
	call					WriteString
	call					CrLf

	mov						edx, OFFSET msg2
	call					WriteString
	call					CrLf

	mov						edx, OFFSET msg3
	call					WriteString
	call					CrLf
	call					CrLf

	ret
intro ENDP




; ===================
; ===== GETDATA =====
; ===================
GETDATA PROC 
	push					ebp					
	mov						ebp, esp			
	mov						ebx, [ebp + 8]		

	ENTERUSERDATALOOP:
		; Get user input
		mov						edx, OFFSET numlength
		call					WriteString
		call					ReadInt
		
		; Validation
		cmp						eax, MIN			; Check that num > min
		jl						ERRLOOP			; if num < min, jump to error loop
		cmp						eax, MAX
		jg						ERRLOOP			; if num > max, jump to error loop
		jmp						VALIDENTRY			; if its good in the hood, jump to next valid loop
			
	
	ERRLOOP:		; For when the user fucked up on entering a simple number
		mov						edx, OFFSET error
		call					WriteString
		call					CrLf
		jmp						ENTERUSERDATALOOP
	
	VALIDENTRY:
		mov						[ebx], eax			
		pop						ebp					
	
	;clear the stack
	ret 4
GETDATA ENDP




; ========================
; ===== FILLARRAY =====
; ========================
POPULATEARRAY PROC 
	push					ebp				
	mov						ebp, esp		
	mov						edi, [ebp + 12] 
	mov						ecx, [ebp + 8]  ;ecx now holds the num which will count down each loop

	ARRAYFILL:
		mov						eax, UPPERBOUND			
		sub						eax, LOWERBOUND + 1		
		call					RandomRange		        ; Produce numbers only within the range
		add						eax, LOWERBOUND			
		mov						[edi], eax		
		add						edi, 4			
		loop					ARRAYFILL
			
		pop						ebp					

	;clear whats left on the stack
	ret 8
POPULATEARRAY ENDP



; =======================
; ===== DISPLAYLIST =====
; =======================
PRINTARRAY PROC
	push					ebp			
	mov						ebp, esp		
	mov						ecx, [ebp + 12]	
	mov						esi, [ebp + 16]
	mov						ebx, 1		

	mov						edx, [ebp + 8]	
	call					CrLf
	call					WriteString
	call					CrLf
	call					CrLf

	DISPLAYVALUE:
		; Check if we need a new line
		cmp						ebx, MIN	
		jg						NEWROW	
		mov						eax, [esi]  
		call					WriteDec	

		; Pretty printin
		mov						edx, OFFSET spaces
		call					WriteString

		add						esi, 4			
		inc						ebx				
		loop					DISPLAYVALUE	
		jmp						DONE		
		
	NEWROW:
		call					CrLf		
		mov						ebx, 1		
		jmp						DISPLAYVALUE	

	DONE:
		call					CrLf
		pop						ebp		
		ret	12						
PRINTARRAY ENDP




; ====================
; ===== SORTLIST =====
; ====================
SORTARRAY PROC
	push					ebp			
	mov						ebp, esp		
	mov						ecx, [ebp + 8]
	dec						ecx				
		
	; i loop
	L1: 
		push					ecx				
		mov						esi, [ebp + 12]	
	
	; j loop
	L2:
		mov						eax, [esi]			
		cmp						[esi +4], eax		
		jl						L3					
		xchg					eax, [esi+4]		
		mov						[esi], eax									
	
	; k loop
	L3:
		add						esi, 4			
		loop					L2			

		; back to out loop
		pop						ecx					
		loop					L1						

	L4:	
		pop						ebp						
		ret						8					
	ret
SORTARRAY ENDP




; =========================
; ===== DISPLAYMEDIAN =====
; =========================
COMPUTEMEDIAN PROC
	push					ebp				
	mov						ebp, esp	
	mov						eax, [ebp + 8]	
	mov						esi, [ebp + 12]	
	mov						edx, 0		
		
	mov						ebx, 2			
	div						ebx				
	cmp						edx, 0			
	je						CALCULATEMEDIAN

	mov						ebx, 4			
	mul						ebx				
	add						esi, eax		
	mov						eax, [esi]		
	jmp						DISPLAY

	DISPLAY:				
		call					CrLf
		call					CrLf
		mov						edx, OFFSET print_median
		call					WriteString
		call					WriteDec								
		call					CrLf
		call					CrLf
		jmp						DONE

	CALCULATEMEDIAN:
		mov						ebx, 4										
		mul						ebx								
		add						esi, eax								
		mov						edx, [esi]								

		; Get index of lower val
		mov						eax, esi									
		sub						eax, 4						
		mov						esi, eax							
		mov						eax, [esi]									
		
		; Compute avg between two numbers
		add						eax, edx								
		mov						edx, 0									
		mov						ebx, 2										
		div						ebx								

		jmp						DISPLAY										; computation done, move to next proc
		
	DONE:
		pop						ebp		
		ret 8				
COMPUTEMEDIAN ENDP




; =====================
; ===== THEANSWER =====
; =====================
THEANSWER PROC
	mov						eax, 0
THEANSWER ENDP
END main
