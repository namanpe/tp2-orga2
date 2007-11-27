;void realzarBordes(char* ptrMatriz, char* ptrDestino, 
;	unsigned int  ancho, unsigned int alto)
;			

global _realzarBordes
	

section .text

%define ptrS		[ebp + 8] ; puntero a la matriz original
%define ptrD		[ebp + 12]
%define columnas	[ebp + 16]
%define filas		[ebp + 20]

_realzarBordes:
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	


	mov esi, ptrS
	mov edi, ptrD
	mov ecx, columnas
	
	lea esi, [esi + ecx]
	lea edi, [edi + ecx]
	
	sub esi, ecx
	movd mm1, [esi]
	add esi, ecx
	movd mm2, [esi]
	movd mm3, [esi + ecx]
	pxor mm0, mm0
	
	punpcklbw mm1, mm0
	punpcklbw mm2, mm0
	punpcklbw mm3, mm0
	
	psrlw mm2, 1

	pxor mm4, mm4
	psubw mm4, mm1
	pxor mm5, mm5
	psubw mm5, mm2
	pxor mm6, mm6
	psubw mm6, mm3
	
	psrlq mm4, 32
	psrlq mm5, 32
	psrlq mm6, 32
	
	paddw mm1, mm2
	paddw mm1, mm3	
	paddw mm1, mm4
	paddw mm1, mm5
	paddw mm1, mm6		; grosa suma



	pop esi
	pop edi
	pop ebx
	pop ebp
ret