;*******************************************************************
; main.s
; Author:
; Date Created:
; Last Modified:
; Section Number:
; Instructor: 
; Homework Number: 5
;   Brief description of the program
;
;*******************************************************************


       AREA    |.text|, CODE, READONLY, ALIGN=2
       THUMB
       EXPORT  Start
Start

main
	BL Question1
	BL Question2
	BL Question3
	BL Question4
	BL Question5
	B loop
loop   

	B    loop


Question1
	MOV R1, #0x4567
	MOVT R1, #0x0123
	MOV R8, #0x00FF
	MOVT R8, #0xFFFF ;Setting up r8 to have bit-clear value of 0x0000FF00
	MOV R9, #0xFFFF
	MOVT R9, #0xFF00 ;Setting up r9 to have bit-clear value of 0x00FF0000
	MOV R2, #0x0000
	MOVT R2, #0x0000 ;r2 should be 0x00000000
	LSL R2, R1, #24; Isolate last byte to put at beginning of r2, r2 is 0x67000000
	LSR r3, R1, #24; Isolate first byte to put at end of r2
	ORR R2, R3, R2 ; r2 now has first and last byte correct, r2 is now 0x67000001
	BIC R4, R1, R8 ; Clear bits to isolate second set of middle bits, r4 is 0x00004500
	LSL R5, R4, #8; r5 is now 0x00450000
	ORR R2, R2, R5; r2 is now 0x67450001
	BIC R6, R1, R9; Clear bits to isolate first set of middle bits, r6 is 0x00230000
	LSR R7, R6, #8; r6 is now 0x00002300
	ORR R2, R7, R2; r2 is now finally correct being 0x67452301
	BX LR

Question2
	BX LR
	
Question3
	;Assume x is stored in r0 and result is stored in r1
	MOV R0, #-79 ;this is setting whatever you want x to be
	CBZ R0, zero ;Branch if 0
	CMP R0, #0 ;Compare with 0
	BLT negativeOne ;Branch less than 0
	MOV R1, #1 ; If not 0 and not less than 0, set r1 (output) to 1
	BX LR ;Back to main
zero
	MOV R1, #0 ;If zero set r1 to 0
	BX LR ;back to main
negativeOne
	MOV R1, #-1 ;If less than 1 set r1 to be -1 (0xffffffff)
	BX LR ;back to main
	
Question4
	;Let r0 be a, r1 be b, r2 be c, and r3 store result
	MOV R0, #4;set r0 to be whatever number
	MOV R1, #3;set r1 to be whatever number
	MOV R2, #1;set r2 to be whatever number
	CMP R0, R1 ; Compare a and b
	BLT aLessThanB;Branch if a is less than b
	BGT aGreaterThanSomething
	BX LR
aLessThanB
	CMP R0, R2;Compare a an c
	BLT aIsTheMin;A is the min so jump to aIsTheMin
	BGT aGreaterThanSomething
aIsTheMin
	MOV R3, R0
	BX LR
aGreaterThanSomething
	CMP R1, R0 ;Compare b and a
	BLT bLessThanA
	BGT bGreaterThanSomething
	BX LR
bLessThanA
	CMP R1, R2;compare b with c
	BLT bIsTheMin
	BGT bGreaterThanSomething
	BX LR
bIsTheMin
	MOV R3, R1
	BX LR
bGreaterThanSomething
	CMP R2, R0 ;Compare c and a
	BLT cLessThanA ;Branch if c is less than a
	BX LR
cLessThanA
	CMP R2, R1;Compare c and b
	BLT cIsTheMin
	BX LR
cIsTheMin
	MOV R3, R2
	BX LR
	
Question5
	;Assume r0 is output, r1 and r2 are x and y respectivly
	MOV R1, #3 ;Put value x into R1
	MOV R2, #4	;Put value y into r2
	CMP R2, #0;Check for negative exponent
	BLT negativeExponent
	MOV R3, R1 ;Make copy of value that is being multiplied by itself
	CBZ R2, exponentIsZero ;Branch if exponent is 0
	CMP R2, #1 ;Compare exponent to 1
	BEQ exponentIsOne ;Branch if exponent is one
	SUB R2, R2, #1 ;Minus 1 from exponent before looping and multiplying
	B powerLoop ;PowerLoop for multiplying power
	BX LR
exponentIsZero
	MOV R0, #1;If exponent is 0, 1 is output so move 1 to output
	BX LR ;back to main
exponentIsOne
	MOV R0, R1;If exponent is 1, R1 (x) is output so move x to output
	BX LR ; Back to main
powerLoop
	MUL R1, R1, R3 ;Multiply R1 by original self and store back into r1
	SUBS R2, R2, #1 ;sub exponent by 1 and compare to 1
	BNE powerLoop ;If exponent does not equal 1 then loop again
	MOV R0, R1 ; Move R1 which should be correct value into output R0
	BX LR ;Return to main
	
negativeExponent
	MOV R0, #0 ;Move 0 into output because any integer to a negative exponent results in a fraction which would be 0 as an unsigned int.
	BX LR

       ALIGN      ; make sure the end of this section is aligned
       END        ; end of file
       