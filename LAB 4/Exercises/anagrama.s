.data
string1: .asciz "mar"
string2: .asciz "rama"

.text
anagrama:
	mov r0, #0

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
