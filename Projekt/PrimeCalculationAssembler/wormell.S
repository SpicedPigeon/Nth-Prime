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

	push {r4-r7,lr}        

	//Initialisierung
	mov r2, #0
	mov r1, #1
	
	//q2 init
	mov r4, #4
	vmov.U32 d4, r4, r4
	vmov.U32 d5, r4, r4

	trueloop:
		//Dividend (x) erhoehen und laden
		add r1, r1, #1
		vmov d2, r1, r1
		vmov d3, r1, r1
		
		// Divisor laden
		mov r4, #2
		mov r7, #3
		vmov.U32 d0, r4, r7
		mov r4, #4
		mov r7, #5
		vmov.U32 d1, r4, r7
		
		// x/2 als Obergrenze
		mov r3, #2
		mov r5, r1
		lsr r5, #1
		mov r6, #0
		aloop:
			//x / a = ganz Zahl?
			vdiv.F32 s12, s4, s0
			vdiv.F32 s13, s5, s1
			vdiv.F32 s14, s6, s2
			vdiv.F32 s15, s7, s3	

			//Einzeln konvertieren ist Performanter?		
			vcvt.U32.F32 s12, s12			
			vcvt.U32.F32 s13, s13	
			vcvt.U32.F32 s14, s14	
			vcvt.U32.F32 s15, s15
			
			//Check ob ergebnis ganze Zahl

			vmov r7, s12
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1

			vmov r7, s13
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
			
			vmov r7, s14
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
			
			vmov r7, s15
			mul r7, r3
			cmp r7, r1
			addeq r6, #1
			cmp r3, r1
			subeq r6, #1
			add r3, #1
						
			vadd.U32 q0, q0, q2			
			
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
                pop {r4-r7,pc}
