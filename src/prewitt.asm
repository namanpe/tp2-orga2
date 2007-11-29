;void monocromatizar(char*, char*, int, int)
global _prewitt

section .text

_prewitt:

	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	
	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	mov ebx, [ebp + 16] ;ebx : Filas
	mov edx, [ebp + 20] ;edx : Columnas

	add esi, edx
	add edi, edx
	inc ebx
	inc ebx
	
	cicloFilas:
		mov edx, [ebp + 20] ;edx : Columnas
		;shr edx, 1
		cicloColumnas:
		
			pxor mm7, mm7
			movd mm0, [esi]
			movd mm1, [esi + edx]
			movd mm2, [esi + 2 * edx]

			punpcklbw mm0, mm7
			punpcklbw mm1, mm7
			punpcklbw mm2, mm7
			
			movq mm3, mm0
			paddw mm3, mm1
			paddw mm3, mm2

			pxor mm4, mm4
			psubw mm4, mm0
			paddw mm4, mm2
			
			psllq mm3, 16
			psllq mm4, 16
			psrlq mm3, 16
			psrlq mm4, 16

			xor eax, eax
			pinsrw mm3, eax, 1
			
			psubw mm3, mm4
			pxor mm4,mm4
			
			mov eax, 00010001h
			movd mm4, eax
			psllq mm4, 32
			movd mm5, eax
			paddq mm4, mm5
			pmaddwd mm3, mm4
			
			movd eax, mm3
			psrlq mm3, 32
			movd ecx, mm3
			
			sub ax, cx
			
			;mov [edi], ax
			
			mov [edi], ax
			add esi, 1
			add edi, 1

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