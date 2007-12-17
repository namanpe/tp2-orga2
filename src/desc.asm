;void monocromatizar(char*, char*, int, int)
global _desc

section .text

_desc:

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
		;shr edx, 4
		cicloColumnas:
		
		mov al, [esi]
		mov ah, al
		
		mov [edi], ax
		mov [edi + 2], al

		inc esi
		add edi, 3
		
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