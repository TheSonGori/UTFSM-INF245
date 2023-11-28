.global main
.data

@(1) Verificar Anagrama
string1: .asciz "amor"
string2: .asciz "mora"

@(2) Funcion Recursiva
n: .word 5
k: .word 2

@(3) Multiplos de 2
dimension: .word 5
vector: .word 0, 2, 4, 14, 12

/*
Elige la operacion a realizar
 (1) Verificar Anagrama
 (2) Funcion Recursiva
 (3) Multiplos de 2
*/
operacion: .word 1


.text
main:		
	ldr r0,=operacion
	ldrb r1,[r0]

	cmp r1,#1
	beq anagrama

	cmp r1,#2
	beq recursiva

	cmp r1,#3
	beq multiplos

	b end

@(1) VERIFICAR ANAGRAMA ----------------------------------------------------------------------------------------------------------------------
anagrama:
	mov r0, #0
	mov r1, #0

	ldr r1, =string1
	ldr r2, =string2

	mov r3, #0
	mov r4, #0

	bl string1count
	bl string2count

	cmp r3, r4
	beq anagramreset
	b notanagrama

string1count:
	ldrb r5, [r1, r3]

	cmp r5, #0
	beq endcount
	
	add r3, r3, #1	

	b string1count

string2count:
	ldrb r6, [r2, r4]

	cmp r6, #0
	beq endcount
		
	add r4, r4, #1	

	b string2count

endcount:
	bx lr

anagramreset:
	mov r3, #0 @CONTADOR STRING1
	b anagramaloop1

anagramaloop1:
	ldrb r5, [r1, r3]
	mov r4, #0 @CONTADOR STRING2

	add r3, r3, #1

	cmp r5, #0
	bne anagramaloop2
	beq yesanagrama

        b anagramaloop1

anagramaloop2:
	ldrb r6, [r2, r4]

	cmp r6, #0
	beq notanagrama
	
	cmp r5, r6
	beq equal

	add r4, r4, #1	
	b anagramaloop2

equal:
	mov  r6, #36
	add r7, r2, r4

	strb r6, [r7]

	b anagramaloop1
   
yesanagrama:
	mov r0, #0
	mov r1, #0
	mov r2, #1
	bl printInt
	b end

notanagrama:
	mov r0, #0
	mov r1, #0
	mov r2, #0
	bl printInt
	b end

@ (2) FUNCION RECURSIVA ----------------------------------------------------------------------------------------------------------------------
recursiva:
	mov r0, #0
	mov r1, #0

	@CONTADOR RETURNS
	mov r7, #0 

	@NUMERO N
	ldr r3, =n
	ldrb r3, [r3]
	
	@NUMERO K
	ldr r4, =k
	ldrb r4, [r4]

	bl recursivaloop

	mov r0, #0
	mov r1, #0
	mov r2, r7

	bl printInt

	b end

recursivaloop:
	push {r3, r4, lr}

	@IF
	cmp r4, r3 @ K > N
	bgt return0

	@ELIF
	cmp r3, r4 @ N == K
	beq return1

	cmp r4, #0 @ K == 0
	beq return1

	@ELSE
	sub r3, r3, #1 	@ RECURSIVE(N-1,K)
	bl recursivaloop

	pop {r3, r4, r5}
	push {r3, r4, r5}
	
	sub r3, r3, #1	@ RECURSIVE(N-1,K-1)
	sub r4, r4, #1 	
	bl recursivaloop
	
return0:
	pop {r3, r4, r5}
	mov lr, r5
	mov pc, lr

return1:
	pop {r3, r4, r5}
	mov lr, r5
	add r7, r7, #1	
	mov pc, lr

@ (3) MULTIPLOS DE 2 -------------------------------------------------------------------------------------------------------------------------
multiplos:
	mov r0, #0
	mov r1, #0
	
	ldr r5, =dimension
	ldrb r5, [r5]
	
	@STR R6
	mov r6, #0 
	add r6, r6, #0x20
	lsl r6, r6, #8
	add r6, r6, #0x07
	lsl r6, r6, #8 
	add r6, r6, #0x05
	lsl r6, r6, #8
	add r6, r6, #0x00
	
	mov r1, #0 @Contador para movernos en el arreglo
	mov r2, #0 @Contador de números pares

	mov r3, #0

	mov r4, #1 

multiplosloop:
	ldr r3, =vector

	ldrb r3, [r3, r1]
	push {r3}
	
	and r3, r3, r4 

	cmp r3, #0
	beq par @PAR

	@IMPAR
	pop {r3}
	add r1, r1, #4
	sub r5, r5, #1

	cmp r5, #0
	bne multiplosloop
	b next

par:
	pop {r3}
	strb r3, [r0, r6]

	add r2, r2, #1 

	add r0, r0, #4 

	add r1, r1, #4 
	sub r5, r5, #1

	cmp r5, #0
	bne multiplosloop 
	b next 

next:
	mov r0, #0
	mov r1, #0

	mov r4, r2 @R4 - CANT. PARES
	bl printInt
	
	mov r0, #0
	mov r1, #0
	mov r3, #0
	mov r7, #0
	mov r5, #0
	
	cmp r2, #0
	bne printarray
	b end

firstfive:
	mov r1, #0
	mov r0, #5
	mov r5, #0

	add r1, r5, #1
	add r5, r5, #1

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

firstten:
	mov r1, #0
	mov r0, #10
	mov r5, #0

	add r1, r5, #1
	add r5, r5, #1

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

firstfifteen:
	mov r1, #0
	mov r0, #15
	mov r5, #0

	add r1, r5, #1
	add r5, r5, #1

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

firsttwenty:
	mov r1, #0
	mov r0, #20
	mov r5, #0

	add r1, r5, #1
	add r5, r5, #1

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

five:
	mov r0, #5
	mov r1, #0

	mov r1, r5

	push {r3}
	bl printInt
	pop {r3}
	add r7, r7, #1
	add r3, r3, #4

	b printarray

ten:
	mov r0, #10
	mov r1, #0

	mov r1, r5

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

fifteen:
	mov r0, #15
	mov r1, #0

	mov r1, r5

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

twenty:
	mov r0, #20
	mov r1, #0

	mov r1, r5

	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

printarray:
	mov r0, #0

	add r1, r5, #1
	add r5, r5, #1

	ldrb r2, [r6, r3]

	cmp r7, r4
	beq end

	@SALTO EN CONSOLA

	@PRINT CONSOLA	(5-9)
	cmp r7, #5
	beq firstfive

	cmp r7, #6
	beq five

	cmp r7, #7
	beq five

	cmp r7, #8
	beq five

	cmp r7, #9
	beq five

	@PRINT CONSOLA	(10-14)
	cmp r7, #10
	beq firstten

	cmp r7, #11
	beq ten

	cmp r7, #12
	beq ten

	cmp r7, #13
	beq ten

	cmp r7, #14
	beq ten

	@PRINT CONSOLA	(15-19)
	cmp r7, #15
	beq firstfifteen

	cmp r7, #16
	beq fifteen

	cmp r7, #17
	beq fifteen

	cmp r7, #18
	beq fifteen

	cmp r7, #19
	beq fifteen

	@PRINT CONSOLA	(20-24)
	cmp r7, #20
	beq firsttwenty

	cmp r7, #21
	beq twenty

	cmp r7, #22
	beq twenty

	cmp r7, #23
	beq twenty

	cmp r7, #24
	beq twenty
	
	@PRINT CONSOLA	(0-4)
	push {r3}
	bl printInt
	pop {r3}

	add r7, r7, #1
	add r3, r3, #4

	b printarray

@ END ---------------------------------------------------------------------------------------------------------------------------------------
end:
	mov r0, #0
	mov r1, #0
	mov r2, #0
	mov r3, #0
	mov r4, #0
	mov r5, #0
	mov r6, #0
	mov r7, #0
	wfi
