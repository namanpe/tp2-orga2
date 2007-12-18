; como invocar: _umbralizar(tmpDesc, i, j, 100, 30);

global _umbralizar

%define bitmapImage [ebp+8]
%define alto [ebp+16] 
%define ancho [ebp+12] 

%define uSUPERIOR [ebp+20] 
%define uINFERIOR [ebp+24]

section .text

_umbralizar:

	push ebp
	mov ebp,esp
	push ebx
	push edi
	push esi
	
	mov ecx, ancho
	mov edx, alto

	mov al, uSUPERIOR  
	xor eax, 0xFF
	pxor mm3,mm3
	pxor mm1, mm1
	movd mm3, eax	
	punpcklbw mm3, mm1  ; mm3 <- 00 00 00 0u
	punpcklwd mm3,mm3	; mm3 <- 00 00 0u 0u
	punpckldq mm3,mm3   ; mm3 <- 0u 0u 0u 0u
	
	mov al, uINFERIOR
	xor eax, 0xFF
	pxor mm0,mm0
	movd mm0, eax
	pxor mm1, mm1
	punpcklbw mm0,mm1
	punpcklwd mm0,mm0
	punpckldq mm0,mm0  ; mm0 <- umbra inferior

	mov edi, bitmapImage
	mov esi, ecx
	
ciclo_filas:
	dec edx
	cmp edx,0
	je near fin	
	
ciclo_columnas:

	cmp esi,8
	jb near fin_fila
	
	;jmp fin_fila
	
	pxor mm5, mm5
	pxor mm1, mm1
	movd mm5, [edi + ecx]	; fila del medio
	punpcklbw mm5, mm1
 
    movq mm2, mm5
	movq mm7, mm5
	pcmpgtw mm2, mm3        ; comparo con el umbral superior
	pcmpgtw mm7, mm0		; numpad 5
	
	movq mm4, mm5			; numpad 4
	psrlq mm4, 16
	pcmpgtw mm4, mm0
	
	movq mm6, mm4
	
	movq mm4, mm5			; numpad 6
	psllq mm4, 16
	pcmpgtw mm4, mm0
	por mm6, mm4

	pxor mm1, mm1
	movd mm5, [edi]			; fila de arriba
	punpcklbw mm5, mm1

	movq mm4, mm5				; numpad 8
	pcmpgtw mm4, mm0
	por mm6, mm4
		
	movq mm4, mm5				; numpad 7
	psrlq mm4, 16
	pcmpgtw mm4, mm0
	por mm6, mm4

	movq mm4, mm5				; numpad 9
	psllq mm4, 16
	pcmpgtw mm4, mm0
	por mm6, mm4
	
	pxor mm1, mm1
	movd mm5, [edi + 2*ecx]		; fila de abajo
	punpcklbw mm5, mm1

	movq mm4, mm5				; numpad 2
	pcmpgtw mm4, mm0
	por mm6, mm4
		
	movq mm4, mm5				; numpad 1
	psrlq mm4, 16
	pcmpgtw mm4, mm0
	por mm6, mm4

	movq mm4, mm5				; numpad 3
	psllq mm4, 16
	pcmpgtw mm4, mm0
	por mm6, mm4
	
	pand mm7, mm6
	por mm2, mm7
	
	pxor mm1, mm1
	packsswb mm2, mm2
	
	movd eax, mm2
	shr eax, 8
	mov [edi + ecx + 1], ax

	;movd [edi+ecx], mm2
	add edi,2
	sub esi,2
    jmp ciclo_columnas
	
fin_fila:
	sub esi,1
	cmp esi,0
	je avanzar_fila
	
terminar_fila:
		xor ebx,ebx
		
		mov bl, [edi + ecx + 1]
	    cmp bl, uSUPERIOR
       	;ja esBorde
		jb noEsBorde
		
        cmp bl, uINFERIOR
        jb noEsBorde

        mov bl, uINFERIOR
		cmp bl, [edi]	
		ja esBorde
		
		;cmp bl, [edi+1]	
		cmp [edi+1], bl
		ja esBorde
		;cmp bl, [edi+2]
		cmp [edi+2], bl
		ja esBorde
		;cmp bl, [edi+ecx]	
		cmp [edi+ecx], bl
		ja esBorde
		;cmp bl, [edi+ecx+2]	
		cmp [edi+ecx+2], bl
		ja esBorde
;		cmp bl, [edi+ 2*ecx]	
		cmp [edi+ 2*ecx], bl
		ja esBorde
		;cmp bl, [edi+ 2*ecx+1]	
		cmp [edi+ 2*ecx+1], bl
		ja esBorde
		;cmp bl, [edi+ 2*ecx+2]	
		cmp [edi+ 2*ecx+2], bl
		ja esBorde
		
		noEsBorde:
				mov [edi+ecx+1], byte 0
				jmp continuar
	
		esBorde:
				mov [edi+ecx+1], byte 255
		
continuar:		
		dec esi
		cmp esi,0
		je avanzar_fila
		inc edi
		jmp terminar_fila
		
avanzar_fila:
		add edi,2
		mov esi,ecx
		jmp ciclo_filas

fin:
		pop esi
		pop edi
		pop ebx		
		pop ebp
		ret			
	


