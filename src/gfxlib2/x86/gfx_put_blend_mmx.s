/* MMX version of the BLEND drawing mode for PUT */

#include "fb_gfx_mmx.h"


.text


/*:::::*/
FUNC(fb_hPutBlend2MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(4)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG3, %ebx
	shll $1, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx
	movl %edx, LOCAL2
	movq GLOBL(__fb_gfx_rb_32), %mm5
	movq %mm5, %mm6
	psllw $8, %mm6
	movl ARG7, %ebx
	addl $7, %ebx
	shrl $3, %ebx
	movd %ebx, %mm7
	punpcklwd %mm7, %mm7
	movl %ebx, LOCAL3
	punpckldq %mm7, %mm7

LABEL(blend2_y_loop)
	movl ARG3, %ecx
	shrl $1, %ecx
	jnc blend2_skip_1
	lodsw
	movw (%edi), %cx
	addl $2, %edi
	cmpw $MASK_COLOR_16, %ax
	je blend2_skip_1
	movl %ecx, %edx
	movl %eax, %ebx
	andl $MASK_RB_16, %ecx
	andl $MASK_RB_16, %eax
	andl $MASK_G_16, %edx
	andl $MASK_G_16, %ebx
	movl %edx, LOCAL4
	subl %ecx, %eax
	subl %edx, %ebx
	mull LOCAL3
	xchg %eax, %ebx
	mull LOCAL3
	shrl $5, %ebx
	shrl $5, %eax
	addl %ecx, %ebx
	addl LOCAL4, %eax
	andl $MASK_RB_16, %ebx
	andl $MASK_G_16, %eax
	orl %ebx, %eax
	movw %ax, -2(%edi)

LABEL(blend2_skip_1)
	movl ARG3, %ecx
	shrl $2, %ecx
	jnc blend2_skip_2
	movd (%esi), %mm0
	movd (%edi), %mm4
	movq %mm0, %mm3
	movq %mm4, %mm5
	pcmpeqw GLOBL(__fb_gfx_mask_16), %mm0
	pand %mm0, %mm5
	pandn %mm3, %mm0
	por %mm5, %mm0
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand GLOBL(__fb_gfx_r_16), %mm0
	pand GLOBL(__fb_gfx_r_16), %mm4
	pand GLOBL(__fb_gfx_g_16), %mm1
	pand GLOBL(__fb_gfx_g_16), %mm5
	psrlw $5, %mm0
	psrlw $5, %mm4
	pand GLOBL(__fb_gfx_b_16), %mm2
	pand GLOBL(__fb_gfx_b_16), %mm6
	psubw %mm4, %mm0
	psubw %mm5, %mm1
	psubw %mm6, %mm2
	pmullw %mm7, %mm0
	psllw $5, %mm4
	pmullw %mm7, %mm1
	pmullw %mm7, %mm2
	paddw %mm4, %mm0
	psrlw $5, %mm1
	psrlw $5, %mm2
	pand GLOBL(__fb_gfx_r_16), %mm0
	paddw %mm5, %mm1
	paddw %mm6, %mm2
	pand GLOBL(__fb_gfx_g_16), %mm1
	pand GLOBL(__fb_gfx_b_16), %mm2
	por %mm1, %mm0
	addl $4, %edi
	por %mm2, %mm0
	addl $4, %esi
	movd %mm0, -4(%edi)

LABEL(blend2_skip_2)
	orl %ecx, %ecx
	jz blend2_next_line

LABEL(blend2_x_loop)
	movq (%esi), %mm0
	movq (%edi), %mm4
	movq %mm0, %mm3
	movq %mm4, %mm5
	pcmpeqw GLOBL(__fb_gfx_mask_16), %mm0
	pand %mm0, %mm5
	pandn %mm3, %mm0
	por %mm5, %mm0
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand GLOBL(__fb_gfx_r_16), %mm0
	pand GLOBL(__fb_gfx_r_16), %mm4
	pand GLOBL(__fb_gfx_g_16), %mm1
	pand GLOBL(__fb_gfx_g_16), %mm5
	psrlw $5, %mm0
	psrlw $5, %mm4
	pand GLOBL(__fb_gfx_b_16), %mm2
	pand GLOBL(__fb_gfx_b_16), %mm6
	psubw %mm4, %mm0
	psubw %mm5, %mm1
	psubw %mm6, %mm2
	pmullw %mm7, %mm0
	psllw $5, %mm4
	pmullw %mm7, %mm1
	pmullw %mm7, %mm2
	paddw %mm4, %mm0
	psrlw $5, %mm1
	psrlw $5, %mm2
	pand GLOBL(__fb_gfx_r_16), %mm0
	paddw %mm5, %mm1
	paddw %mm6, %mm2
	pand GLOBL(__fb_gfx_g_16), %mm1
	pand GLOBL(__fb_gfx_b_16), %mm2
	por %mm1, %mm0
	addl $8, %edi
	por %mm2, %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blend2_x_loop

LABEL(blend2_next_line)
	addl ARG5, %esi
	addl LOCAL2, %edi
	decl LOCAL1
	jnz blend2_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(4)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutBlend4MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
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
	subl %ebx, %edx
	movl %edx, LOCAL2
	movq GLOBL(__fb_gfx_rb_32), %mm5
	movq GLOBL(__fb_gfx_ga_32), %mm6
	movl ARG7, %ebx
	incl %ebx
	movd %ebx, %mm2
	punpcklwd %mm2, %mm2
	movl %ebx, LOCAL3
	punpckldq %mm2, %mm2

LABEL(blend4_y_loop)
	movl ARG3, %ecx
	shrl $1, %ecx
	jnc blend4_skip_1
	addl $4, %edi
	lodsl
	movl %eax, %ecx
	andl $0xFFFFFF, %eax
	movl -4(%edi), %ebx
	cmpl $MASK_COLOR_32, %eax
	je blend4_skip_1
	movl %ecx, %eax
	movl %ebx, %edx
	andl $MASK_RB_32, %eax
	andl $MASK_RB_32, %edx
	subl %edx, %eax
	mull LOCAL3
	xchg %eax, %ecx
	movl %ebx, %edx
	andl $MASK_GA_32, %eax
	andl $MASK_GA_32, %edx
	subl %edx, %eax
	shrl $8, %ecx
	shrl $8, %eax
	mull LOCAL3
	movl %ebx, %edx
	andl $MASK_RB_32, %ebx
	andl $MASK_GA_32, %edx
	addl %ecx, %ebx
	addl %edx, %eax
	andl $MASK_RB_32, %ebx
	andl $MASK_GA_32, %eax
	orl %ebx, %eax
	movl %eax, -4(%edi)

LABEL(blend4_skip_1)
	movl ARG3, %ecx
	shrl $1, %ecx
	jz blend4_next_line

LABEL(blend4_x_loop)
	movq (%esi), %mm0
	movq (%edi), %mm1
	movq %mm0, %mm3
	pand GLOBL(__fb_gfx_rgb_32), %mm0
	movq %mm1, %mm4
	pcmpeqd GLOBL(__fb_gfx_mask_32), %mm0
	pand %mm0, %mm4
	pandn %mm3, %mm0
	por %mm4, %mm0
	movq %mm0, %mm3
	movq %mm1, %mm4
	pand %mm5, %mm0
	pand %mm5, %mm1
	psrlw $8, %mm3
	psubw %mm1, %mm0
	psrlw $8, %mm4
	pmullw %mm2, %mm0
	psubw %mm4, %mm3
	psllw $8, %mm4
	pmullw %mm2, %mm3
	por %mm4, %mm1
	addl $8, %edi
	psrlw $8, %mm0
	pand %mm6, %mm3
	paddb %mm1, %mm0
	paddb %mm1, %mm3
	pand %mm5, %mm0
	pand %mm6, %mm3
	por %mm3, %mm0

	addl $8, %esi
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blend4_x_loop

LABEL(blend4_next_line)
	addl ARG5, %esi
	addl LOCAL2, %edi
	decl LOCAL1
	jnz blend4_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret
