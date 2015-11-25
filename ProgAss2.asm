TITLE Fibonacci's Numbers     (ProgAss2.asm)

; Author: Frank Eslami
; Course / Project ID: CS 271-400 / Programming Assignment #2                 Date: 10/19/2014
; Description: Calculate Fibonacci's numbers based on user's input between the range of 1-46.

INCLUDE Irvine32.inc

MIN_NUM = 1					;minimum integer input allowed from user
MAX_NUM = 46					;maximum integer input allowed from user

.data
intro1			BYTE		"Hello, my name is Frank Eslami. What is your name? ", 0					;display programmer and program title
intro2			BYTE		", welcome to Fibonacci's Numbers program. I will ask you for a number"		;greet user and explain program
				BYTE		" between 1-46 and return that many terms of Fibonacci's numbers. Let's get"
				BYTE		" started.", 0
buffer			BYTE		20 DUP(0)															;input buffer
getUserInt		BYTE		"How many Fibonacci's terms would you like displayed? Please enter a"			;user's keyboard input for int 
				BYTE		" number between 1-46: ", 0											
invalidMinNum		BYTE		" is not a valid integer. ", 0										;warn user of invalid integer input. Request another input.
spacing			BYTE		"     ", 0														;output spacing format for displaying Fibonacci's numbers
goodbye			BYTE		"Thank you for checking out my new program. Have a great day. And don't"		;say goodbye, kiss butt
				BYTE		" forget to be kind in grading. Much hair pulling was performed :)", 0

userIntInput		Dword	?																;user's integer input for Fibonacci's numbers
fibOne			Dword	?																;1st of Fibonacci's number
fibTwo			Dword	?																;2nd of Fibonacci's number
counter			Dword	?																;loop counter			

.code
main PROC
	;Introduction
	mov		edx, OFFSET intro1				;display programmer and program title.
	call		WriteString

	;Obtain user's name
	mov		edx, OFFSET buffer				;point to the buffer for user input
	mov		ecx, SIZEOF buffer				;specify max buffer characters
	call		ReadString					;input user's name
	call		Crlf
		
	;User Instructions
	call		WriteString
	mov		edx, OFFSET intro2				;greet user and explain program
	call		WriteString
	call		Crlf
	call		Crlf

	;Get User's Data
	mov		edx, OFFSET getUserInt			;ask user for int input 	
	call		WriteString
	call		ReadInt
	mov		userIntInput, eax				;store user's input
	call		Crlf

	;Validate user's data
decide:
	mov		ebx, userIntInput				
	cmp		ebx, MIN_NUM					;compare user's int input to the minimum constant allowed
	jl		invalid						;if user's input is less than the min constant, jump to invalid segment
	cmp		ebx, MAX_NUM					;compare user's int input to the maximum constant allowed
	jg		invalid						;if user's input is greater than the max constant, jump to invalid segment
valid:
	jmp		endDecide						;if input is valid, jump to the end of comparison segment
invalid:
	mov		eax, userIntInput				;display user's input back to them
	call		WriteInt
	mov		edx, OFFSET invalidMinNum		;warn user of invalid integer input. 
	call		WriteString
	mov		edx, OFFSET getUserInt			;ask user for int input 	
	call		WriteString
	call		ReadInt
	mov		userIntInput, eax				;store user's input
	jmp		decide
endDecide:


	;Display Fibonacci's Numbers
	mov		ecx, userIntInput				;set loop iteration to user's term count (outer loop counter)
	dec		ecx							;decrement by 1 to account for hard key input of Fibonacci's 1st number input
	mov		counter, 5					;set counter to display 5 Fibonacci's numbers per line

	mov		fibOne, 0						;store 1st of Fibonacci's numbers
	mov		eax, 1						;store 2nd of Fibonacci's numbers

decid2:									
	cmp		userIntInput, 1				 
	jg		notOne						;if user's term count > 1, display 1 and continue with loop
term1:
	call		WriteDec						;dispaly eax, which has 1
	call		Crlf
	jmp		endDecide2					;bypass all loops and say farewell	
notOne:									;if user's term count > 1, continue with loop
	call		WriteDec						;display 1 and proceed with loop
	mov		edx, OFFSET spacing				;add 5 blank spaces for formatting
	call		WriteString
	dec		counter						;decrease number of words left per line
					
	;Loop until user's term count is met

L1:
	mov		ebx, eax						;Fibonacci's latest sum stored to become 1st number later (fibOne)
	add		eax, fibOne					;Add Fibonacci's 1st and 2nd numbers
	mov		fibOne, ebx					;store Fibonacci's new 1st number	
	mov		fibTwo, eax					;store Fibonacci's new 2nd number
					
decide3:									;format output with 5 Fibonacci's numbers per line
	cmp		counter, 1					;if only 1 more word is allowed in a line create new line
	je		newLine
sameLine:									;if less than 5 words exist in the line and this is not the 5th word
	dec		counter						;decrease number of words left per line
	call		WriteDec
	mov		edx, OFFSET spacing				;add 5 blank spaces for formatting
	call		WriteString
	jmp		endDecide3						
newLine:									;create new line
	call		WriteDec						;display Fibonacci's number on the same line to make 5 displays
	call		Crlf							;create new line
	mov		counter, 5					;reset inner loop's counter to display 5 Fibonacci's numbers in the new line
endDecide3:

	loop		L1							;loop until user's term count is met

endDecide2:

	;Farewell
	call		Crlf
	mov		edx, OFFSET goodbye				;say goodbye, kiss butt
	call		WriteString		
	call		Crlf
	call		Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
