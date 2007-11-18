; prototipo
; char* comprimir(char* matriz, unsigned int cantBytes);

global _comprimir
extern  malloc

section .text

_comprimir:
  push ebp
  mov ebp, esp
  push ebx
  push edi
  push esi


mov esi, [ebp + 8] 	; puntero a la matriz original
mov eax, [ebp + 12] ; tamEnBytes

shr eax, 2			; divido por 4

push eax
call malloc			; reservo memoria
add esp, 4

mov edx, eax		; edx <- puntero a la matriz comprimida.
mov edi, eax 		; edi <- puntero a la matriz comprimida.

mov ecx, [ebp + 12]	; ecx <- cantidad de bytes.


; utilizo la tecnica de loop unrolling
filling:
	cmp ecx, 4
	jb fin

	mov eax, [esi] ; load
	mov bl, al
	shl ebx, 8
	add esi, 4

	mov eax, [esi] ; load
	mov bl, al
	shl ebx, 8
	add esi, 4

	mov eax, [esi] ; load
	mov bl, al
	shl ebx, 8
	add esi, 4

	mov eax, [esi] ; load
	mov bl, al

	add esi, 4

	bswap ebx
	mov [edi], ebx ; STORE!
	add edi, 4

	sub ecx, 4
	jmp filling
   
unoPorUno: ; TOOD

fin:
  mov eax, edx ; retorno el puntero a la matriz comprimida


pop esi
pop edi
pop ebx

pop ebp
ret
