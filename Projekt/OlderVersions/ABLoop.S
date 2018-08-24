.global wormell

wormell:
	//r0 = n
	//r1 = x
	//r2 = primeCounter
	//r3 = a
	//r4 = b
	//r5 = x/2
	//r6 = isNotComposite
	//r7 = tmp

	push {r4-r7,lr}
        

	//init values
	mov r2, #0		
	mov r1, #1
	
	trueloop:
		add r1, r1, #1
		mov r3, #2
		mov r5, r1
		lsr r5, #1

		mov r6, #1
		aloop:
			// b = 2
			mov r4, #2
			bloop:
				mul r7, r3, r4
				cmp r7, r1
				bgt aloopEnd
				moveq r6, #0 
				beq isPrimeEnd
				add r4, r4, #1
				cmp r4, r5
				ble bloop
			aloopEnd:
				add r3, r3,#1
				cmp r3, r5
				ble aloop	
		isPrimeEnd:
			cmp r6, #1
			bne trueloop
			add r2, r2, #1
			cmp r2, r0
			blt trueloop
        end:		
		mov r0, r1
                pop {r4-r7,pc}
