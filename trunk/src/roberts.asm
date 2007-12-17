global roberts

%define bitmapImage [ebp+8]
%define bitmapImageM [ebp+12]
%define alto [ebp +16]
%define ancho [ebp+20]

%define contador [ebp-4] 

section .text

roberts:
	push ebp
	mov ebp,esp
	sub esp,4
	push ebx
	push edi
	push esi

	mov esi,alto
	mov contador, esi
	mov edi, bitmapImage   

	mov ebx, bitmapImageM   
	mov eax, 0x01010101
	movd mm6,eax
	movq mm7, mm6
	punpckldq mm7,mm6     
	pxor mm6,mm6
	xor eax,eax
 	mov ecx, ancho

	ciclo_filas:
		mov esi,ecx
		dec dword contador
		cmp contador,dword 0               
		je near fin
		
	ciclo_columnas:
		cmp esi,8 	                    
	    jb near fin_fila

	movq mm0,[edi]      
	movq mm1, [edi+ecx]    
	
	movq mm3,mm0		
	movq mm2,mm1     		
	psrlq mm2,8		
	psubb mm3, mm2  
	
	pxor mm4,mm4 		
	pcmpgtb mm4,mm3  	
	movq mm5,mm4 	
	pandn mm5,mm3   
	pandn mm3,mm4   
	paddb mm3, mm7  
	pand mm3,mm4	
	paddb mm3, mm5   	
	
	movq mm6, mm3   
	movq mm2,mm1  
	movq mm3, mm0 
	psrlq mm3,8	
	psubb mm3,mm2   
		
	pxor mm4,mm4
	pcmpgtb mm4,mm3	 
	movq mm5,mm4 		
	pandn mm5,mm3 
	pandn mm3,mm4
	paddb mm3, mm7
	pand mm3,mm4
	paddb mm3, mm5  

	pxor mm5, mm5		
	punpcklbw mm6,mm5
	punpcklbw mm3,mm5
	paddw mm6,mm3     
	
	mov edx, 0x00ff00ff 		
	movd mm2, edx	    
	movq mm3, mm2
	punpckldq mm3,mm2   
	movq mm4,mm3

	pcmpgtw mm3, mm6     
	
	pand mm6,mm3         
	pandn mm3,mm4       
	paddw mm6,mm3        
	packuswb mm6,mm6

	movd [ebx], mm6	
	
	add edi,4
	add ebx,4
	sub esi,4
	jmp ciclo_columnas
	
fin_fila:
	dec esi
	cmp esi,0                  
	je avanzar_fila

terminar_fila:
	xor eax,eax
	xor edx,edx
	mov al,[edi]
	sub al,[edi+ ecx + 1]
	cmp al,0
    jge mascara_y
	neg al    
	
	mascara_y:
		mov dl, [edi+1]
		sub dl, [edi+ecx]
		cmp dl,0
		jge sumar_mascaras
		neg dl   

	sumar_mascaras:
		add eax, edx
		cmp eax,255
		jle guardarYavanzar
		mov eax,255   
	
	guardarYavanzar:
		mov [ebx],al
		dec esi
		cmp esi,0
		je avanzar_fila

		inc edi
		inc ebx
		jmp terminar_fila
		
avanzar_fila:
	add edi,2
	add ebx,2
	jmp ciclo_filas

fin:
	pop esi
	pop edi
	pop ebx		
	add esp,4
	pop ebp
	ret			
	