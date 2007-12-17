;void monocromatizar(char*, char*, int, int)
global _monocromatizar

section .text

_monocromatizar:

	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	
	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	mov ebx, [ebp + 16] ;ebx : Filas
	
	cicloFilas:
		mov edx, [ebp + 20] ;edx : Columnas
		shr edx, 1
		cicloColumnas:
		
			movq mm0, [esi]
			movq mm1, mm0
			movq mm2, mm1
			psrlq mm1, 8
			psrlq mm2, 16
			
			pmaxub mm0, mm1
			pmaxub mm0, mm2 ; en los bytes 1 y 4 se encuentran los bytes correspondientes a los maximos de los 2 pixels

			movd eax, mm0	; eax = |DATO|X|X|DATO|
			xchg ah, al		; eax = |DATO|X|DATO|X|
			shr eax, 8		; eax = |0|DATO|X|DATO|
			xchg ah, al		; eax = |0|DATO|DATO|X|
			shr eax, 8		; eax = |0|0|DATO|DATO|
			
			;mov [edi], ah
			;mov [edi+1], ah
			;mov [edi+2], ah
			;mov [edi+3], al
			;mov [edi+4], al
			;mov [edi+5], al
			mov [edi], ax
			
			add esi, 6
			;add edi, 6
			add edi, 2
			
			;inc esi
			;inc edi
		dec edx
		cmp edx, 0
		jg cicloColumnas
		
	dec ebx
	cmp ebx, 0
	jg cicloFilas

	pop esi
	pop edi
	pop ebx
	pop ebp
ret