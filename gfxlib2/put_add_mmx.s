/* MMX version of the ADD drawing mode for PUT */

#include "fb_gfx_mmx.h"


.text


/*:::::*/
FUNC(fb_hPutAdd2MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG3, %ebx
	shll $1, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	addl $7, ARG7
	movl ARG1, %esi
	shrl $3, ARG7
	movl ARG6, %edx
	movd ARG7, %mm7
	movl ARG2, %edi
	punpcklwd %mm7, %mm7
	subl %ebx, %edx
	punpckldq %mm7, %mm7
	shrl $1, %ebx
	movq GLOBL(__fb_gfx_msb_16), %mm6

LABEL(add2_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc add2_skip_1

	movw (%esi), %ax
	movd %eax, %mm0
	movw (%edi), %ax
	movd %eax, %mm1
	movq %mm0, %mm2
	pcmpeqw GLOBL(__fb_gfx_mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand GLOBL(__fb_gfx_mask_16), %mm4
	pand GLOBL(__fb_gfx_mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand GLOBL(__fb_gfx_g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand GLOBL(__fb_gfx_mask_16), %mm4
	psrlw $5, %mm0
	pand GLOBL(__fb_gfx_g_16), %mm0
	por %mm4, %mm0
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm6, %mm4
	pand %mm6, %mm5
	pxor %mm4, %mm0
	pxor %mm5, %mm1
	paddw %mm1, %mm0
	movq %mm5, %mm1
	por %mm4, %mm5
	pand %mm1, %mm4
	movq %mm5, %mm1
	pand %mm0, %mm5
	por %mm5, %mm4
	movq %mm6, %mm5
	psrlq $4, %mm4
	addl $2, %edi
	psubw %mm4, %mm5
	por %mm0, %mm1
	pxor %mm6, %mm5
	addl $2, %esi
	por %mm5, %mm1
	movd %mm1, %eax
	movw %ax, -2(%edi)

LABEL(add2_skip_1)
	shrl $1, %ecx
	jnc add2_skip_2
	
	movd (%esi), %mm0
	movd (%edi), %mm1
	movq %mm0, %mm2
	pcmpeqw GLOBL(__fb_gfx_mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand GLOBL(__fb_gfx_mask_16), %mm4
	pand GLOBL(__fb_gfx_mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand GLOBL(__fb_gfx_g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand GLOBL(__fb_gfx_mask_16), %mm4
	psrlw $5, %mm0
	pand GLOBL(__fb_gfx_g_16), %mm0
	por %mm4, %mm0
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm6, %mm4
	pand %mm6, %mm5
	pxor %mm4, %mm0
	pxor %mm5, %mm1
	paddw %mm1, %mm0
	movq %mm5, %mm1
	por %mm4, %mm5
	pand %mm1, %mm4
	movq %mm5, %mm1
	pand %mm0, %mm5
	por %mm5, %mm4
	movq %mm6, %mm5
	psrlq $4, %mm4
	addl $4, %edi
	psubw %mm4, %mm5
	por %mm0, %mm1
	pxor %mm6, %mm5
	addl $4, %esi
	por %mm5, %mm1
	movd %mm1, -4(%edi)

LABEL(add2_skip_2)
	orl %ecx, %ecx
	jz add2_next_line

LABEL(add2_x_loop)
	movq (%esi), %mm0
	movq (%edi), %mm1
	movq %mm0, %mm2
	pcmpeqw GLOBL(__fb_gfx_mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand GLOBL(__fb_gfx_mask_16), %mm4
	pand GLOBL(__fb_gfx_mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand GLOBL(__fb_gfx_g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand GLOBL(__fb_gfx_mask_16), %mm4
	psrlw $5, %mm0
	pand GLOBL(__fb_gfx_g_16), %mm0
	por %mm4, %mm0
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm6, %mm4
	pand %mm6, %mm5
	pxor %mm4, %mm0
	pxor %mm5, %mm1
	paddw %mm1, %mm0
	movq %mm5, %mm1
	por %mm4, %mm5
	pand %mm1, %mm4
	movq %mm5, %mm1
	pand %mm0, %mm5
	por %mm5, %mm4
	movq %mm6, %mm5
	psrlq $4, %mm4
	addl $8, %edi
	psubw %mm4, %mm5
	por %mm0, %mm1
	pxor %mm6, %mm5
	addl $8, %esi
	por %mm5, %mm1
	movq %mm1, -8(%edi)
	
	decl %ecx
	jnz add2_x_loop
	
LABEL(add2_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz add2_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutAdd4MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG3, %ebx
	shll $2, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	movd ARG7, %mm7
	subl %ebx, %edx
	punpcklwd %mm7, %mm7
	shrl $2, %ebx
	punpckldq %mm7, %mm7
	pxor %mm6, %mm6
	
LABEL(add4_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc add4_skip_1
	
	movd (%esi), %mm0
	movd (%edi), %mm1
	movq %mm0, %mm2
	movq %mm0, %mm3
	punpcklbw %mm6, %mm0
	pand GLOBL(__fb_gfx_rgb_32), %mm3
	pcmpeqd GLOBL(__fb_gfx_mask_32), %mm3
	pmullw %mm7, %mm0
	psrlw $8, %mm0
	packuswb %mm0, %mm0
	addl $4, %edi
	pandn %mm0, %mm3
	paddusb %mm3, %mm1
	addl $4, %esi
	movd %mm1, -4(%edi)

LABEL(add4_skip_1)
	shrl $1, %ecx
	jnc add4_skip_2
	
	movq (%esi), %mm0
	movq (%edi), %mm1
	movq %mm0, %mm2
	movq %mm0, %mm3
	punpcklbw %mm6, %mm0
	pand GLOBL(__fb_gfx_rgb_32), %mm3
	punpckhbw %mm6, %mm2
	pcmpeqd GLOBL(__fb_gfx_mask_32), %mm3
	pmullw %mm7, %mm0
	pmullw %mm7, %mm2
	psrlw $8, %mm0
	psrlw $8, %mm2
	packuswb %mm2, %mm0
	addl $8, %edi
	pandn %mm0, %mm3
	paddusb %mm3, %mm1
	addl $8, %esi
	movq %mm1, -8(%edi)
	
LABEL(add4_skip_2)
	orl %ecx, %ecx
	jz add4_next_line

LABEL(add4_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm1
	movq (%edi), %mm2
	movq 8(%edi), %mm3
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand GLOBL(__fb_gfx_rgb_32), %mm4
	pand GLOBL(__fb_gfx_rgb_32), %mm5
	pcmpeqd GLOBL(__fb_gfx_mask_32), %mm4
	pcmpeqd GLOBL(__fb_gfx_mask_32), %mm5
	pandn %mm0, %mm4
	pandn %mm1, %mm5
	movq %mm4, %mm0
	movq %mm5, %mm1
	punpcklbw %mm6, %mm4
	punpckhbw %mm6, %mm0
	punpcklbw %mm6, %mm5
	punpckhbw %mm6, %mm1
	pmullw %mm7, %mm4
	pmullw %mm7, %mm0
	pmullw %mm7, %mm5
	pmullw %mm7, %mm1
	psrlw $8, %mm4
	psrlw $8, %mm0
	psrlw $8, %mm5
	psrlw $8, %mm1
	packuswb %mm0, %mm4
	packuswb %mm1, %mm5
	addl $16, %esi
	addl $16, %edi
	paddusb %mm4, %mm2
	paddusb %mm5, %mm3
	movq %mm2, -16(%edi)
	movq %mm3, -8(%edi)

	decl %ecx
	jnz add4_x_loop

LABEL(add4_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz add4_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret
