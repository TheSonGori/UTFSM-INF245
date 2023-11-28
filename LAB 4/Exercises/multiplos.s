.data
dimension: .word 5
vector: .word 0, 2, 4, 14, 12

.text
@ (3) MULTIPLOS DE 2 -------------------------------------------------------------------------------------------------------------------------
multiplos:
	mov r0, #0
	mov r1, #0
	
	ldr r5, =dimension
	ldr r5, [r5]
	
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

	ldr r3, [r3, r1]
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
	str r3, [r0, r6]

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

	ldr r2, [r6, r3]

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
