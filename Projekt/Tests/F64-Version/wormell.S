.global wormell

wormell:
	//r0 = n
	//r1 = x
	//r2 = primeCounter
	//r3 = a
	//r4 = tmp1
	//r5 = x/2
	//r6 = anzahlTeiler
	//r7 = tmp2

	//q0 = divisor = a, a+1, a+2, a+3
	//q1 = dividend = x
	//q2 = ergebnis

	push {r4-r8,lr}        

	//Initialisierung
	mov r2, #0
	mov r1, #1
	mov r8, #0
	//q2 init
	mov r4, #4
	vmov d0 ,r4, r2
		
	trueloop:
		//Dividend (x) erhoehen und laden
		
		add r1, r1, #1
		vmov d4, r1,r8
		vmov d5, r1,r8
		vmov d6, r1,r8
		vmov d7, r1,r8

		// Divisor laden
		mov r4, #2
		mov r7, #3
		
		vmov d8, r4,r8
		vmov d9, r7,r8
		mov r4, #4
		mov r7, #5
		vmov d10, r4,r8
		vmov d11, r7,r8
		
		// x/2 als Obergrenze
		mov r3, #2
		mov r5, r1
		lsr r5, #1
		mov r6, #0
		aloop:
			//x / a = ganz Zahl?
			vdiv.F64 d12, d4, d8
			vdiv.F64 d13, d5, d9
			vdiv.F64 d14, d6, d10
			vdiv.F64 d15, d7, d11			

			vcvt.U32.F64 s24, d12			
			vcvt.U32.F64 s26, d13	
			vcvt.U32.F64 s28, d14	
			vcvt.U32.F64 s30, d15
			
			//Check ob ergebnis ganze Zahl

			vmov r7, s24
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1

			vmov r7, s26
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
			
			vmov r7, s28
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
			
			vmov r7, s30
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
						
			vadd.F64 d8, d0
			vadd.F64 d9, d0
			vadd.F64 d10, d0
			vadd.F64 d11, d0			
			
			//Teiler gefunden?	
			cmp r6, #1
			bge trueloop

			//Schleifenende erreicht
			cmp r3, r5
			ble aloop	

		//aloop End
		isPrimeEnd:
			//Primzahl gefunden
			add r2, #1
			cmp r2, r0
			beq end
			b trueloop
		
        	//trueloop End
	end:		
		mov r0, r1
                pop {r4-r8,pc}
