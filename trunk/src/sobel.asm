;void prewitt(char*, char*, int, int)
global _sobel

section .text

_sobel:

	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	
	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	mov ebx, [ebp + 16] ;ebx : Filas
	mov edx, [ebp + 20] ;edx : Columnas
	
	mov ebp, edx

	;--- mm4 mascara.------
	pxor mm4, mm4
	mov ax, 01h
	pinsrw mm4, ax, 0
	pinsrw mm4, ax, 3
	inc ax
	pinsrw mm4, ax, 1
	;---------------------------
	
	;--- mm5 mascara.------
	pxor mm5, mm5
	mov ax, 0FFFFh
	pinsrw mm5, ax, 0
	mov ax, 01h
	pinsrw mm5, ax, 2
	;---------------------------

	pxor mm6, mm6					; mm6 = 1
	pinsrw mm6, ax, 0
	pinsrw mm6, ax, 1
	pinsrw mm6, ax, 2
	pinsrw mm6, ax, 3

	pxor mm7, mm7					; mm7 = 0	
	
	; --- salteo la primera fila ---
	;add esi, edx	
	add edi, edx
	inc edi
	dec ebx
	; ----------------------------------
	
	;dec ebx			;salteo la ultima fila
	cicloFilas:

		;mov edx, [ebp + 20] ;edx : Columnas
		mov edx, ebp
		shr edx, 1
		; --- salteo la primera columna ---
		;inc esi
		;inc edi
		dec edx
		; ----------------------------------------
		
		;dec edx			;salteo la ultima columna
		cicloColumnas:

			movd mm0, [esi]					; mm0 = |0|0|0|0|p1|p2|p3|p4|
			movd mm1, [esi + ebp]			; mm1 = |0|0|0|0|p1|p2|p3|p4|
			movd mm2, [esi + 2 * ebp]		; mm2 = |0|0|0|0|p1|p2|p3|p4|

			punpcklbw mm0, mm7				; mm0 = |0|p1|0|p2|0|p3|0|p4|
			punpcklbw mm1, mm7				; mm1 = |0|p1|0|p2|0|p3|0|p4|
			punpcklbw mm2, mm7				; mm2 = |0|p1|0|p2|0|p3|0|p4|
			
			pxor mm3, mm3
			psubw mm3, mm0
			paddw mm3, mm2
			
			paddw mm0, mm1
			paddw mm0, mm1
			paddw mm0, mm2
			
			;----------------------------
			movq mm1, mm0		;
			movq mm2, mm3		;
			
			pmullw mm0, mm5		;aplico la mascara
			pmullw mm3, mm4		;aplico la mascara
			psubw mm0, mm3

			psrlq mm1, 16		;hago un shitf para procesar el segundo pixel
			psrlq mm3, 16		;hago un shitf para procesar el segundo pixel
			
			pmullw mm1, mm5		;aplico la mascara
			pmullw mm2, mm4		;aplico la mascara
			psubw mm1, mm3

			pmaddwd mm0, mm6
			pmaddwd mm1, mm6

			movq mm2, mm1

			pextrw eax, mm0, 0
			pextrw ecx, mm0, 1
			pinsrw mm1, eax, 2
			pinsrw mm1, ecx, 3

			pextrw eax, mm2, 2
			pextrw ecx, mm2, 3
			pinsrw mm0, eax, 0
			pinsrw mm0, ecx, 1			

			paddd mm0, mm1

			pextrw eax, mm0, 0
			pextrw ecx, mm0, 2
			
			;------------------
			cmp ax, 0
			jge mayor
			neg ax
			;jmp seguir
			mayor:

			cmp ax, 255
			jle menor
			xor ax, ax
			not ax
			;jmp seguir
			menor:
			
			seguir:
			;------------------

			;------------------
			cmp cx, 0
			jge mayor2
			neg cx
			;jmp seguir2
			mayor2:

			cmp cx, 255
			jle menor2
			xor cx, cx
			not cx
			;jmp seguir2
			menor2:
			
			seguir2:
			mov ah, cl
			;------------------
			mov [edi], ax

			;sub edx, 2
			dec edx
			add esi, 2
			add edi, 2

		;dec edx
		cmp edx, 0
		jg cicloColumnas
		
		;avanzo punteros porque ya me saltee la ultima columna
		add esi, 2
		add edi, 2
		
		dec ebx
	cmp ebx, 0
	jg cicloFilas

	pop esi
	pop edi
	pop ebx
	pop ebp
ret