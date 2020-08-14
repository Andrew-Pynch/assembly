TITLE Program Template     (template.asm)
; ===========================================
; Author: Andrew Pynch
; Last Modified: 8/14/2020
; OSU email address: pyncha@oregonstate.edu
; Course number/section: CS271 SEC 1
; Assignment Number: FINAL         
; Due Date: 8/14/2020
; Program Description: Create a program which can encrypt and decrypt strings using the substitution encryption method
; Objectives:
; - Working on a project that utilizes a braod spectrum of knowledge from this course
; - Using various forms of indirect addressing
; - Passing parameters on the stack
; - Extensive interaction with arrays
; ===========================================

INCLUDE Irvine32.inc
.data
compute_mode		BYTE	"Initializing Compute Mode ", 0
decoy_mode			BYTE	"Running program in DECOY mode ",0
encrypt_mode		BYTE	"Running program in ENCRYPTION mode ", 0
decrypt_mode		BYTE	"Running program in DECRYPTION mode ", 0

operand1   WORD    46
operand2   WORD    -20
dest       DWORD   0


.code
.code
; EMPTY PROC
main PROC
	;; inside the MAIN procedure
	push   operand1			; ESI + 12
	push   operand2			; ESI + 8
	push   OFFSET dest		; ESI + 4
	call   compute
main ENDP


; =========================
; PROCEDURE NAME:			Compute
; PROCEDURE DESCRIPTION:	'main' equivelant procedure responsible for controlling which operational mode the program assumes.

; PRE-CONDITIONS:			Program is started
; POST-CONDITIONS:			Program assumes Decoy, Encrypt, or Decrypt mode based off of the TA / Professor provided MAIN section
; REGISTERS CHANGED:		TBD
; =========================
compute PROC 
	mov				edx, OFFSET compute_mode
	call			WriteString
	call			CrLf
	
	push			ebp				; push ebp onto the stack
	mov				ebp, esp		; point esp at it
	mov				eax, [esi + 4]
	mov				eax, -2

	cmp				eax, 0			; Decoy mode?
	je				GODECOY

	cmp				eax, -1			; Encryption mode?
	je				GOENCRYPT

	cmp				eax, -2         ; Decryption mode?
	je				GODECRYPT
	exit


	
	GODECOY:
		mov				edx, OFFSET decoy_mode					
		call			WriteString
		call			CrLf
		exit

	GOENCRYPT:
		mov				edx, OFFSET encrypt_mode
		call			WriteString
		call			CrLf
		exit

	GODECRYPT:
		mov				edx, OFFSET decrypt_mode
		call			WriteString
		call			CrLf
		exit
compute ENDP




; =========================
; PROCEDURE NAME:			Decoy
; PROCEDURE DESCRIPTION:	A default "decoy" mode of operation where the procedure accepts two 16-bit operands by value and one 
; operand by OFFSET. The procedure will calculate the sum of the two operands and will store the result into memory at the OFFSET specified.

; PRE-CONDITIONS:			
;							PARAMETERS: Accepts 3 parameters on the stack
;								- 16 bit signed WORD:															operand1
;								- 16 bit signed WORD:															operand2
;								- 32 bit OFFSET of a signed DWORD (sum will be placed into the specified DWORD: dest
; POST-CONDITIONS:			
;							RETURNS:
;								- Outputs operand1 + operand2 and stores result into dest
; REGISTERS CHANGED:		TBD
; =========================
decoy PROC
; Print decoy_mode to screen for debugging purposes

decoy ENDP




; =========================
; PROCEDURE NAME:			encrypt
; PROCEDURE DESCRIPTION:	This operational mode will encrypt the requested message. By the time your function returns, 
; the original plaintext message array will be overwritten with the correctly encrypted message.

; PRE-CONDITIONS:			
;							PARAMETERS: Accepts 3 parameters on the stack
;								- 32 bit OFFSET of a BYTE array (this array contains a 26 character key):						key
;								- 32 bit OFFSET of a BYTE array (this array contains the plaintext message to be encrypted):	message
;								- 32 bit OFFSET of a signed DWORD (the dereferenced value initially contains the integer -1):	???????		
; POST-CONDITIONS:			
;							RETURNS:
;								- Outputs message transformed by our algorithm using the key
; REGISTERS CHANGED:		TBD
; =========================
encrypt PROC

encrypt ENDP




; =========================
; PROCEDURE NAME:			decrypt
; PROCEDURE DESCRIPTION:	This operational mode will decrypt the requested message. By the time your function returns, 
; the encrypted characters (inside the array) will be overwritten with the decrypted message.

; PRE-CONDITIONS:			
;							PARAMETERS: Accepts 3 parameters on the stack
;								- 32 bit OFFSET of a BYTE array (this array contains a 26 character key)						    key
;								- 32 bit OFFSET of a BYTE array (this array contains the encrypted message that is to be decoded):	encrypted_message
;								- 32 bit OFFSET of a signed DWORD (the dereferenced value initially contains the integer -1):		?????????
; POST-CONDITIONS:			
;							RETURNS:
;								- Outputs message transformed by our algorithm using the key
; REGISTERS CHANGED:		TBD
; =========================
decrypt PROC

decrypt ENDP




END main
