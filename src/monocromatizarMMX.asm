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

			movd eax, mm0
			xchg ah, al
			shr eax, 8
			xchg ah, al
			shr eax, 8

			mov [edi], ax
			
			;mov [edi], al
			;mov [edi + 1], al
			;mov [edi + 2], al
			;mov [edi + 3], ah
			;mov [edi + 4], ah
			;mov [edi + 5], ah
			add esi, 6
			add edi, 6

			;add esi, 6
			;add edi, 2
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