;void monocromatizar(char*, char*, int, int)
global _comp

section .text

_comp:

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
		shr edx, 4
		cicloColumnas:
		
		mov al, [esi]
		shl eax, 8
		
		mov al, [esi + 3]
		shl eax, 8

		mov al, [esi + 6]
		shl eax, 8
		
		mov al, [esi + 12]
		shl eax, 8
		
		mov [edi], eax
		
		add esi, 12
		add edi, 4
		
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