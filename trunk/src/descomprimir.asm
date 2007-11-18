;prototipo
; char* descomprimir(char* matriz, unsigned int cantBytes);

global _descomprimir
extern  malloc

section .text

_descomprimir:
  push ebp
  mov ebp, esp
  push ebx
  push edi
  push esi


mov esi, [ebp + 8] 	; puntero a la matriz original
mov eax, [ebp + 12] ; tamEnBytes

shl eax, 2 			; tamDefinitivo

push eax    	; paso el tam multiplicado por cuatro al malloc
call malloc
add esp, 4	; acomodo la pila
mov edx, eax 	; pos de la matriz resultado
mov edi, edx

mov ecx, [ebp + 12] ; ecx <- tamEnBytes

; utilizo la tecnica de loop unrolling
expandir:
cmp ecx, 4
jb unoPorUno

sub ecx, 4 		; decremento el indice.

mov eax, [esi]	; eax = 44332211
add esi, 4

xor ebx, ebx 	; ebx = 00000000
mov bl, al		; ebx = 000000AL
shl ebx, 8		; ebx = 0000AL00
mov bl, al		; ebx = 0000ALAL
shl ebx, 8
mov bl, al		; ebx = 00ALALAL

mov [edi], ebx
add edi, 4

shr eax, 8		; eax = 00443322

xor ebx, ebx	; ebx = 00000000
mov bl, al		; ebx = 000000AL
shl ebx, 8		; ebx = 0000AL00
mov bl, al		; ebx = 0000ALAL
shl ebx, 8
mov bl, al		; ebx = 00ALALAL

mov [edi], ebx
add edi, 4

shr eax, 8		; eax = 00004433

xor ebx, ebx	; ebx = 00000000
mov bl, al		; ebx = 000000AL
shl ebx, 8		; ebx = 0000AL00
mov bl, al		; ebx = 0000ALAL
shl ebx, 8
mov bl, al		; ebx = 00ALALAL

mov [edi], ebx
add edi, 4

shr eax, 8		; eax = 00000044

xor ebx, ebx	; ebx = 00000000
mov bl, al		; ebx = 000000AL
shl ebx, 8		; ebx = 0000AL00
mov bl, al		; ebx = 0000ALAL
shl ebx, 8
mov bl, al		; ebx = 00ALALAL

mov [edi], ebx
add edi, 4


jmp expandir

   
unoPorUno: ; TOOD
	cmp ecx, 0
	je fin

CicloPeque:
	mov al, [esi]
	xor ebx, ebx 	; ebx = 00000000
	mov bl, al		; ebx = 000000AL
	shl ebx, 8		; ebx = 0000AL00
	mov bl, al		; ebx = 0000ALAL
	shl ebx, 8
	mov bl, al		; ebx = 00ALALAL

	mov [edi], ebx
	add edi, 4
	inc esi
	
	dec ecx
	cmp ecx, 0
	ja CicloPeque

fin:
  mov eax, edx ; retorno el puntero a la matriz descomprimida


pop esi
pop edi
pop ebx

pop ebp
ret
