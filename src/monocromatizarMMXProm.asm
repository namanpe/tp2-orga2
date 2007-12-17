;void monocromatizar(char*, char*, int, int)
global _monocromatizarP

section .text

_monocromatizarP:

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

			pxor mm6, mm6
			punpcklbw mm0, mm6
			punpcklbw mm1, mm6
			punpcklbw mm2, mm6
			
			psllw mm1, 1
			paddw mm0, mm1
			paddw mm0, mm2
			psrlw mm0, 2
			
			movd eax, mm0
			psrlq mm0, 48
			movd ecx, mm0
			
			mov ah, al
			mov ch, cl
			
			;mov ah, cl

			;mov [edi], ax
			
			mov [edi], ax
			mov [edi + 2], al
			mov [edi + 3], cx
			mov [edi + 5], cl
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