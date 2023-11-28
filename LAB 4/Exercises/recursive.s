.data
n: .word 5
k: .word 5

.text
recursiva:
	mov r0, #0
	mov r7, #0 @CONTADOR RETURN

    	ldr r1, =n
	ldr r1, [r1]
    	ldr r2, =k
	ldr r2, [r2]
	
	bl recursive
	
	mov r2, r0
	mov r0, #0
	bl printInt
	b end

recursive:
	push {r1, r2, r14}
	cmp r2, r1
	bgt retZero
	
	cmp r2, #0
	beq retOne
	
	cmp r1, r2
	beq retOne

	b else

else:
	sub r1, r1, #1
	bl recursive
	pop {r1, r2, r7}
	push {r1, r2, r7}
	sub r1, r1, #1
	sub r2, r2, #1
	bl recursive

	pop {r1, r2, r7}
	mov r14, r7
	mov r15, r14

retOne:
	add r0, r0, #1
	pop {r1, r2, r7}
	mov r14, r7
	mov r15, r14
	

retZero:
	pop {r1, r2, r7}
	mov r14, r7
	mov r15, r14


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
