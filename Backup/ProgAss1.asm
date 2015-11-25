TITLE MASM Introduction   (ProgAss1.asm)

; Author: Frank Eslami
; Course / Project ID: Programming Assignment #1                 Date: 09/30-2014
; Description: Display the author and project title; obtain two numbers as input; calculate the sum, difference, product,
; quotient, and remainder; dispaly the results; say goodbye.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; Text output to user's display
intro	BYTE      "Hello, my name is Frank Eslami, welcome to MASM Introduction! I will ask you for two numbers "
          BYTE      "and return the sum, difference, product, quotient, and remainder of them. Let's get started.", 0
getData1  BYTE      "Please enter a positive number ", 0
getData2  BYTE      "Please enter a second positive number ", 0
resSum    BYTE      "The sum of the two numbers is ", 0
resDiff   BYTE      "The difference of the two numbers is ", 0
resProd   BYTE      "The product of the two numbers is ", 0
resQuot   BYTE      "The quotient of the two numbers is ", 0
resRem    BYTE      "The remainder of the two numbers is ", 0
goodbye   BYTE      "I hope you enjoyed my MASM Introduction. Have a great day!", 0

; Number input from user
inputNum1    DWORD     0
inputNum2    DWORD     0

; Results of calculations
sum       DWORD     0
diff		DWORD	0
prod	     DWORD	0
quot	     DWORD	0
remain    DWORD	0

.code
main PROC

; Introduce the author and the program
	mov       edx, OFFSET intro
     call      WriteString
	call      CrLF			
     call      CrLF		

; Obtain two positive numbers from the user
     mov       edx, OFFSET getData1          ; obtain first number
     call      WriteString
     call      ReadInt
     mov       inputNum1, eax
     
     mov       edx, OFFSET getData2          ; obtain second number
     call      WriteString
     call      ReadInt
     mov       inputNum2, eax     
	call      CrLF			


; Calculate the sum, difference, product, quotient, and remainder of the user's input
     mov       eax, inputNum1           ; sum
     add       eax, inputNum2
     mov       sum, eax

     mov       eax, inputNum1           ; difference
     sub       eax, inputNum2
     mov       diff, eax

     mov       eax, inputNum1           ; product
     mov       ebx, inputNum2
     mul       ebx
     mov       prod, eax

     mov       eax, inputNum1           ; quotient
     cdq
     mov       ebx, inputNum2
     div       ebx
     mov       quot, eax

     mov       eax, inputNum1           ; remainder
     mov       ebx, inputNum2
     div       ebx
     mov       remain, edx
     

; Display the result of the calculations
     mov       edx, OFFSET resSum
     call      WriteString
     mov       eax, sum
     call      WriteInt
     call      CrLF	

     mov       edx, OFFSET resDiff
     call      WriteString
     mov       eax, diff
     call      WriteInt
     call      CrLF	    

     mov       edx, OFFSET resProd
     call      WriteString
     mov       eax, prod
     call      WriteInt
     call      CrLF	 

     mov       edx, OFFSET resQuot
     call      WriteString
     mov       eax, quot
     call      WriteInt
     call      CrLF	 

     mov       edx, OFFSET resRem
     call      WriteString
     mov       eax, remain
     call      WriteInt
     call      CrLF	
     call      CrLF	 

; Say goodbye
     mov       edx, OFFSET goodbye
     call      WriteString
     call      CrLF

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
