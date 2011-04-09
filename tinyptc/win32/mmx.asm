;
; TinyPTC by Gaffer
; www.gaffer.org/tinyptc
;

bits 32

global _mmx_memcpy
global _mmx_convert_32_to_32_bgr888
global _mmx_convert_32_to_24_rgb888
global _mmx_convert_32_to_24_bgr888
global _mmx_convert_32_to_16_rgb565
global _mmx_convert_32_to_16_bgr565
global _mmx_convert_32_to_16_rgb555
global _mmx_convert_32_to_16_bgr555



section .data
	


align 16

mmx_rgb888_mask dd 00ffffffh,00ffffffh

mmx_rgb565_b dd 000000f8h, 000000f8h
mmx_rgb565_g dd 0000fc00h, 0000fc00h
mmx_rgb565_r dd 00f80000h, 00f80000h

mmx_rgb555_rb dd 00f800f8h,00f800f8h
mmx_rgb555_g dd 0000f800h,0000f800h
mmx_rgb555_mul dd 20000008h,20000008h
mmx_bgr555_mul dd 00082000h,00082000h



section .text



align 16

_mmx_memcpy:

    push ebp
    mov ebp,esp

    pushad

    mov edi,[ebp+8]       ; destination
    mov esi,[ebp+12]      ; source
    mov ecx,[ebp+16]      ; bytes

    mov eax,ecx
    shr ecx,6
    mov ebx,ecx
    shl ebx,6
    sub eax,ebx

align 16
             
    .loop

        movq mm0,[esi]
        movq mm1,[esi+8]
        movq mm2,[esi+16]
        movq mm3,[esi+24]
        movq mm4,[esi+32]
        movq mm5,[esi+40]
        movq mm6,[esi+48]
        movq mm7,[esi+56]
        movq [edi],mm0
        movq [edi+8],mm1
        movq [edi+16],mm2
        movq [edi+24],mm3
        movq [edi+32],mm4
        movq [edi+40],mm5
        movq [edi+48],mm6
        movq [edi+56],mm7
        add esi,8*8
        add edi,8*8
        dec ecx
        jnz .loop

    mov ecx,eax
    rep movsb

    emms

    popad
    
    pop ebp
    ret




align 16

_mmx_convert_32_to_32_bgr888:

    ret




align 16

_mmx_convert_32_to_24_rgb888:

    push ebp
    mov ebp,esp

    pushad

    mov edi,[ebp+8]       ; destination
    mov esi,[ebp+12]      ; source
    mov ecx,[ebp+16]      ; bytes

    ; set up mm6 as the mask, mm7 as zero
    movq mm6, qword [mmx_rgb888_mask]
    pxor mm7, mm7

    mov edx, ecx                    ; save ecx
    and ecx, 0fffffffch             ; clear lower two bits
    jnz .L1
    jmp .L2

.L1:

    movq mm0, [esi]                 ; A R G B a r g b
    pand mm0, mm6                   ; 0 R G B 0 r g b
    movq mm1, [esi+8]               ; A R G B a r g b
    pand mm1, mm6                   ; 0 R G B 0 r g b

    movq mm2, mm0                   ; 0 R G B 0 r g b
    punpckhdq mm2, mm7              ; 0 0 0 0 0 R G B
    punpckldq mm0, mm7              ; 0 0 0 0 0 r g b
    psllq mm2, 24                   ; 0 0 R G B 0 0 0
    por mm0, mm2                    ; 0 0 R G B r g b

    movq mm3, mm1                   ; 0 R G B 0 r g b
    psllq mm3, 48                   ; g b 0 0 0 0 0 0
    por mm0, mm3                    ; g b R G B r g b

    movq mm4, mm1                   ; 0 R G B 0 r g b
    punpckhdq mm4, mm7              ; 0 0 0 0 0 R G B
    punpckldq mm1, mm7              ; 0 0 0 0 0 r g b
    psrlq mm1, 16                   ; 0 0 0 R G B 0 r
    psllq mm4, 8                    ; 0 0 0 0 R G B 0
    por mm1, mm4                    ; 0 0 0 0 R G B r

    movq [edi], mm0
    add esi, BYTE 16
    movd [edi+8], mm1
    add edi, BYTE 12
    sub ecx, BYTE 4
    jnz .L1

.L2:
    mov ecx, edx
    and ecx, BYTE 3
    jz .L4
.L3:
    mov al, [esi]
    mov bl, [esi+1]
    mov dl, [esi+2]
    mov [edi], al
    mov [edi+1], bl
    mov [edi+2], dl
    add esi, BYTE 4
    add edi, BYTE 3
    dec ecx
    jnz .L3
.L4:

    emms

    popad
    
    pop ebp
    ret




align 16

_mmx_convert_32_to_24_bgr888:

    ret




align 16

_mmx_convert_32_to_16_rgb565:

    push ebp
    mov ebp,esp

    pushad

    mov edi,[ebp+8]       ; destination
    mov esi,[ebp+12]      ; source
    mov ecx,[ebp+16]      ; bytes

    ; set up masks
    movq mm5, [mmx_rgb565_b]
    movq mm6, [mmx_rgb565_g]
    movq mm7, [mmx_rgb565_r]

    mov edx, ecx
    shr ecx, 2
    jnz .L1
    jmp .L2         ; not necessary at the moment, but doesn't hurt (much)

.L1:
    movq mm0, [esi]         ; argb
    movq mm1, mm0           ; argb
    pand mm0, mm6           ; 00g0
    movq mm3, mm1           ; argb
    pand mm1, mm5           ; 000b
    pand mm3, mm7           ; 0r00
    pslld mm1, 2            ; 0 0 000000bb bbb00000
    por mm0, mm1            ; 0 0 ggggggbb bbb00000
    psrld mm0, 5            ; 0 0 00000ggg gggbbbbb

    movq mm4, [esi+8]       ; argb
    movq mm2, mm4           ; argb
    pand mm4, mm6           ; 00g0
    movq mm1, mm2           ; argb
    pand mm2, mm5           ; 000b
    pand mm1, mm7           ; 0r00
    pslld mm2, 2            ; 0 0 000000bb bbb00000
    por mm4, mm2            ; 0 0 ggggggbb bbb00000
    psrld mm4, 5            ; 0 0 00000ggg gggbbbbb

    packuswb mm3, mm1       ; R 0 r 0
    packssdw mm0, mm4       ; as above.. ish
    por mm0, mm3            ; done.
    movq [edi], mm0

    add esi, 16
    add edi, 8
    dec ecx
    jnz .L1

.L2:
    mov ecx, edx
    and ecx, BYTE 3
    jz .L4
.L3:
    mov al, [esi]
    mov bh, [esi+1]
    mov ah, [esi+2]
    shr al, 3
    and eax, 0F81Fh            ; BYTE?
    shr ebx, 5
    and ebx, 07E0h             ; BYTE?
    add eax, ebx
    mov [edi], al
    mov [edi+1], ah
    add esi, BYTE 4
    add edi, BYTE 2
    dec ecx
    jnz .L3

.L4:

    emms

    popad
    
    pop ebp
    ret




align 16

_mmx_convert_32_to_16_bgr565:

    push ebp
    mov ebp,esp

    pushad

    mov edi,[ebp+8]       ; destination
    mov esi,[ebp+12]      ; source
    mov ecx,[ebp+16]      ; bytes

    movq mm5, [mmx_rgb565_r]
    movq mm6, [mmx_rgb565_g]
    movq mm7, [mmx_rgb565_b]

    mov edx, ecx
    shr ecx, 2
    jnz .L1
    jmp .L2

.L1:
    movq mm0, [esi]                 ; a r g b
    movq mm1, mm0                   ; a r g b
    pand mm0, mm6                   ; 0 0 g 0
    movq mm3, mm1                   ; a r g b
    pand mm1, mm5                   ; 0 r 0 0
    pand mm3, mm7                   ; 0 0 0 b

    psllq mm3, 16                   ; 0 b 0 0
    psrld mm1, 14                   ; 0 0 000000rr rrr00000
    por mm0, mm1                    ; 0 0 ggggggrr rrr00000
    psrld mm0, 5                    ; 0 0 00000ggg gggrrrrr

    movq mm4, [esi+8]               ; a r g b
    movq mm2, mm4                   ; a r g b
    pand mm4, mm6                   ; 0 0 g 0
    movq mm1, mm2                   ; a r g b
    pand mm2, mm5                   ; 0 r 0 0
    pand mm1, mm7                   ; 0 0 0 b

    psllq mm1, 16                   ; 0 b 0 0
    psrld mm2, 14                   ; 0 0 000000rr rrr00000
    por mm4, mm2                    ; 0 0 ggggggrr rrr00000
    psrld mm4, 5                    ; 0 0 00000ggg gggrrrrr

    packuswb mm3, mm1               ; BBBBB000 00000000 bbbbb000 00000000
    packssdw mm0, mm4               ; 00000GGG GGGRRRRR 00000GGG GGGRRRRR
    por mm0, mm3                    ; BBBBBGGG GGGRRRRR bbbbbggg gggrrrrr
    movq [edi], mm0

    add esi, BYTE 16
    add edi, BYTE 8
    dec ecx
    jnz .L1

.L2:
    and edx, BYTE 3
    jz .L4
.L3:
    mov al, [esi+2]
    mov bh, [esi+1]
    mov ah, [esi]
    shr al, 3
    and eax, 0F81Fh                    ; BYTE ?
    shr ebx, 5
    and ebx, 07E0h                     ; BYTE ?
    add eax, ebx
    mov [edi], al
    mov [edi+1], ah
    add esi, BYTE 4
    add edi, BYTE 2
    dec edx
    jnz .L3

.L4:

    emms

    popad
    
    pop ebp
    ret




align 16

_mmx_convert_32_to_16_bgr555:

    ; the 16BGR555 converter is identical to the RGB555 one,
    ; except it uses a different multiplier for the pmaddwd
    ; instruction.  cool huh.

    movq mm7, qword [mmx_bgr555_mul]
    jmp _convert_bgr555_cheat

    ; This is the same as the Intel version.. they obviously went to
    ; much more trouble to expand/coil the loop than I did, so theirs
    ; would almost certainly be faster, even if only a little.
    ; I did rename 'mmx_rgb555_add' to 'mmx_rgb555_mul', which is
    ; (I think) a more accurate name..

align 16

_mmx_convert_32_to_16_rgb555:

    movq mm7,qword [mmx_rgb555_mul]

_convert_bgr555_cheat:

    movq mm6,qword [mmx_rgb555_g]
    push ebp
    mov ebp,esp

    pushad

    mov edi,[ebp+8]       ; destination
    mov esi,[ebp+12]      ; source
    mov ecx,[ebp+16]      ; bytes
        
	mov edx,ecx		           ; Save ecx 

    and ecx,BYTE 0fffffff8h            ; clear lower three bits
	jnz .L_OK
    jmp .L2 

.L_OK:
	
	movq mm2,[esi+8]

	movq mm0,[esi]
	movq mm3,mm2

	pand mm3,qword [mmx_rgb555_rb]
	movq mm1,mm0

	pand mm1,qword [mmx_rgb555_rb]
	pmaddwd mm3,mm7

	pmaddwd mm1,mm7
	pand mm2,mm6

.L1:
	movq mm4,[esi+24]
	pand mm0,mm6

	movq mm5,[esi+16]
	por mm3,mm2

	psrld mm3,6
	por mm1,mm0

	movq mm0,mm4
	psrld mm1,6

	pand mm0,qword [mmx_rgb555_rb]
	packssdw mm1,mm3

	movq mm3,mm5
	pmaddwd mm0,mm7

	pand mm3,qword [mmx_rgb555_rb]
	pand mm4,mm6

	movq [edi],mm1			
	pmaddwd mm3,mm7

        add esi,BYTE 32
	por mm4,mm0

	pand mm5,mm6
	psrld mm4,6

	movq mm2,[esi+8]
	por mm5,mm3

	movq mm0,[esi]
	psrld mm5,6

	movq mm3,mm2
	movq mm1,mm0

	pand mm3,qword [mmx_rgb555_rb]
	packssdw mm5,mm4

	pand mm1,qword [mmx_rgb555_rb]
	pand mm2,mm6

	movq [edi+8],mm5
	pmaddwd mm3,mm7

	pmaddwd mm1,mm7
    add edi,BYTE 16

    sub ecx,BYTE 8
	jz .L2
    jmp .L1

.L2:	
	mov ecx,edx
	
    and ecx,BYTE 7
	jz .L4
	
.L3:	
	mov ebx,[esi]
    add esi,BYTE 4
	
    mov eax,ebx
    mov edx,ebx

    shr eax,3
    shr edx,6

    and eax,BYTE 0000000000011111b
    and edx,     0000001111100000b

    shr ebx,9

    or eax,edx

    and ebx,     0111110000000000b

    or eax,ebx

    mov [edi],ax
    add edi,BYTE 2

    dec ecx
    jnz .L3	

.L4:

    emms

    popad
    
    pop ebp
    ret
