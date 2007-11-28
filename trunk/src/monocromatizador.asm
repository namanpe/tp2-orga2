;monocromatizar(char*, char*, int, int)
global _monocromatizar

section .text

_monocromatizar:

push ebp
mov ebp, esp
push ebx
push edi
push esi

mov esi, [ebp + 8] ; esi es el puntero a matriz de datos
mov edi, [ebp + 12] ; edi es el puntero a matriz resultante

mov edx, [ebp + 20] ; edx : columnas
mov ebx, [ebp + 16] ; ebx : filas
add esi, edx

inc ebx
inc ebx

cicloFilas:

	mov edx, [ebp + 20] ; edx : columnas
	inc esi
	inc edx
	inc edx
	
	cicloColumnas:

		movq mm0, [esi] ; mm0 : |R1|G1|B1|R2|G2|B2|R3|G3|
		movq mm1, mm0
		movq mm2, mm0
		psllq mm1, 1	; mm1 : |G1|B1|R2|G2|B2|R3|G3|0H|
		psllq mm1, 2	; mm2 : |B1|R2|G2|B2|R3|G3|0H|0H|

		pmaxub mm0, mm1
		pmaxub mm0, mm2 ; mm0 : |max(1)|X|X|max(2)|X|X|X|X|
		psrlq mm0, 32
		movd eax, mm0

		xchg ah, al
		shr eax, 8
		xchg ah, al
		shr eax, 8
		mov [edi], ax

		add esi, 2
		add edi, 2
	dec edx
	cmp edx, 0
	jmp cicloColumnas

	inc esi
	
dec ebx
cmp ebx, 0
jmp cicloFilas

pop esi
pop edi
pop ebx

pop ebp
ret