/*
 * mmx.s -- MMX detection and memory copy/set routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.data

.balign 16

VAR(__fb_gfx_mask_16)		.short	MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16
VAR(__fb_gfx_mask_32)		.long	MASK_COLOR_32, MASK_COLOR_32
VAR(__fb_gfx_rgb_32)		.long	MASK_RGB_32, MASK_RGB_32
VAR(__fb_gfx_rb_32)			.long	MASK_RB_32, MASK_RB_32
VAR(__fb_gfx_ga_32)			.long	MASK_GA_32, MASK_GA_32
VAR(__fb_gfx_r_16)			.short	MASK_R_16, MASK_R_16, MASK_R_16, MASK_R_16
VAR(__fb_gfx_g_16)			.short	MASK_G_16, MASK_G_16, MASK_G_16, MASK_G_16
VAR(__fb_gfx_b_16)			.short	MASK_B_16, MASK_B_16, MASK_B_16, MASK_B_16
VAR(__fb_gfx_msb_16)		.long	0x84108410, 0x84108410


.text

FUNC(fb_MMX_code_start)


/*:::::*/
FUNC(fb_hMemCpyMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %esi
	movl ARG3, %ecx
	shrl $1, %ecx
	jnc memcpy_skip_1
	movsb

LABEL(memcpy_skip_1)
	shrl $1, %ecx
	jnc memcpy_skip_2
	movsw

LABEL(memcpy_skip_2)
	shrl $1, %ecx
	jnc memcpy_skip_4
	movsd

LABEL(memcpy_skip_4)
	orl %ecx, %ecx
	jz memcpy_end

LABEL(memcpy_loop)
	addl $8, %edi
	movq (%esi), %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)
	decl %ecx
	jnz memcpy_loop
	
LABEL(memcpy_end)
	emms
	popl %edi
	popl %esi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hMemSetMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %eax
	movl ARG3, %ecx
	movb %al, %ah
	movw %ax, %dx
	shll $16, %eax
	movw %dx, %ax
	shrl $1, %ecx
	jnc memset_skip_1
	stosb

LABEL(memset_skip_1)
	shrl $1, %ecx
	jnc memset_skip_2
	stosw

LABEL(memset_skip_2)
	shrl $1, %ecx
	jnc memset_skip_4
	stosl

LABEL(memset_skip_4)
	orl %ecx, %ecx
	jz memset_end
	movd %eax, %mm0
	punpckldq %mm0, %mm0
	
LABEL(memset_loop)
	movq %mm0, (%edi)
	addl $8, %edi
	decl %ecx
	jnz memset_loop
	
LABEL(memset_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSet2MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %eax
	movl ARG3, %ecx
	movw %ax, %dx
	shll $16, %eax
	movw %dx, %ax
	shrl $1, %ecx
	jnc pixelset2_skip_1
	stosw

LABEL(pixelset2_skip_1)
	shrl $1, %ecx
	jnc pixelset2_skip_2
	stosl

LABEL(pixelset2_skip_2)
	movd %eax, %mm0
	punpckldq %mm0, %mm0
	shrl $1, %ecx
	jnc pixelset2_skip_4
	movq %mm0, (%edi)
	addl $8, %edi

LABEL(pixelset2_skip_4)
	orl %ecx, %ecx
	jz pixelset2_end
	
LABEL(pixelset2_loop)
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	addl $16, %edi
	decl %ecx
	jnz pixelset2_loop
	
LABEL(pixelset2_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSet4MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %eax
	movl ARG3, %ecx
	shrl $1, %ecx
	jnc pixelset4_skip_1
	stosl

LABEL(pixelset4_skip_1)
	movd %eax, %mm0
	punpckldq %mm0, %mm0
	shrl $1, %ecx
	jnc pixelset4_skip_2
	movq %mm0, (%edi)
	addl $8, %edi

LABEL(pixelset4_skip_2)
	shrl $1, %ecx
	jnc pixelset4_skip_4
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	addl $16, %edi

LABEL(pixelset4_skip_4)
	orl %ecx, %ecx
	jz pixelset4_end
	
LABEL(pixelset4_loop)
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	movq %mm0, 16(%edi)
	movq %mm0, 24(%edi)
	addl $32, %edi
	decl %ecx
	jnz pixelset4_loop
	
LABEL(pixelset4_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSetAlpha4MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG2, %esi
	movl ARG1, %edi
	movd %esi, %mm6
	movl ARG3, %ecx

	shrl $1, %ecx
	jnc pixelsetalpha4_skip_1
	
	addl $4, %edi
	movl %esi, %eax
	movl -4(%edi), %ebx
	movl %eax, %ecx
	movl %ebx, %edx
	andl $MASK_RB_32, %eax
	andl $MASK_RB_32, %edx
	shrl $24, %esi
	subl %edx, %eax
	imull %esi
	xchg %eax, %ecx
	movl %ebx, %edx
	andl $MASK_GA_32, %eax
	andl $MASK_GA_32, %edx
	subl %edx, %eax
	shrl $8, %eax
	imull %esi
	shrl $8, %ecx
	movl %ebx, %edx
	andl $MASK_RB_32, %ebx
	andl $MASK_GA_32, %edx
	addl %ecx, %ebx
	addl %edx, %eax
	andl $MASK_RB_32, %ebx
	andl $MASK_GA_32, %eax
	orl %ebx, %eax
	movl %eax, -4(%edi)

LABEL(pixelsetalpha4_skip_1)
	movl ARG3, %ecx
	shrl $1, %ecx
	jz pixelsetalpha4_end
	punpckldq %mm6, %mm6
	movq GLOBL(__fb_gfx_rb_32), %mm5

LABEL(pixelsetalpha4_x_loop)
	movq %mm6, %mm0
	movq (%edi), %mm1
	movq %mm0, %mm2
	movq %mm0, %mm3
	movq %mm1, %mm4
	psrld $24, %mm2
	psrlw $8, %mm3
	psrlw $8, %mm4
	packssdw %mm2, %mm2
	pand %mm5, %mm0
	pand %mm5, %mm1
	punpcklwd %mm2, %mm2
	psubw %mm1, %mm0
	psubw %mm4, %mm3
	pmullw %mm2, %mm0
	pmullw %mm2, %mm3
	psraw $8, %mm0
	psraw $8, %mm3
	paddw %mm1, %mm0
	paddw %mm4, %mm3
	pand %mm5, %mm0
	psllw $8, %mm3
	addl $8, %edi
	por %mm3, %mm0
	movq %mm0, -8(%edi)
	decl %ecx
	jnz pixelsetalpha4_x_loop

LABEL(pixelsetalpha4_end)
	emms
	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutPixelAlpha4MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi
	movl ARG4, %edx
	movl ARG3, %ecx
	movl ARG2, %eax
	movl CTX_LINE(%edi), %ebp
	movd %edx, %mm1
	movl (%ebp, %ecx, 4), %edi
	shrl $24, %edx
	leal (%edi, %eax, 4), %edi
	pxor %mm2, %mm2
	movd (%edi), %mm0
	movd %edx, %mm3
	punpcklbw %mm2, %mm1			/* mm1 = | ca | cr | cg | cb | */
	punpcklbw %mm2, %mm0			/* mm0 = | da | dr | dg | db | */
	punpcklwd %mm3, %mm3
	psubw %mm0, %mm1				/* mm1 = | ca-da | cr-dr | cg-dg | cb-db | */
	punpcklwd %mm3, %mm3			/* mm3 = |  a |  a |  a |  a | */
	psllw $8, %mm0
	pmullw %mm3, %mm1
	paddw %mm1, %mm0
	psrlw $8, %mm0
	packuswb %mm0, %mm0
	movd %mm0, (%edi)

	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutAlphaMaskMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl ARG3, %ebx
	movl ARG6, %edx
	subl %ebx, ARG5
	pxor %mm7, %mm7
	shll $2, %ebx
	movl ARG2, %edi
	subl %ebx, %edx
	movl ARG1, %esi
	movl ARG4, %ebx
	movq GLOBL(__fb_gfx_rgb_32), %mm6

LABEL(alpha_mask_y_loop)
	movl ARG3, %ecx
	pxor %mm7, %mm7
	shrl $1, %ecx
	jnc alpha_mask_skip_1
	
	lodsb
	shll $24, %eax
	andl $MASK_RGB_32, (%edi)
	orl %eax, (%edi)
	addl $4, %edi

LABEL(alpha_mask_skip_1)
	shrl $1, %ecx
	jnc alpha_mask_skip_2
	
	lodsw
	movq (%edi), %mm1
	movd %eax, %mm0
	punpcklbw %mm7, %mm0
	punpcklwd %mm7, %mm0
	pslld $24, %mm0
	pand GLOBL(__fb_gfx_rgb_32), %mm1
	addl $8, %edi
	por %mm0, %mm1
	movq %mm1, -8(%edi)

LABEL(alpha_mask_skip_2)
	shrl $1, %ecx
	jnc alpha_mask_skip_4
	
	lodsl
	movq (%edi), %mm2
	movd %eax, %mm0
	movq 8(%edi), %mm3
	punpcklbw %mm7, %mm0
	addl $16, %edi
	movq %mm0, %mm1
	punpcklwd %mm7, %mm0
	punpckhwd %mm7, %mm1
	pslld $24, %mm0
	pslld $24, %mm1
	pand GLOBL(__fb_gfx_rgb_32), %mm2
	pand GLOBL(__fb_gfx_rgb_32), %mm3
	por %mm0, %mm2
	por %mm1, %mm3
	movq %mm2, -16(%edi)
	movq %mm3, -8(%edi)

LABEL(alpha_mask_skip_4)
	orl %ecx, %ecx
	jz alpha_mask_next_line

LABEL(alpha_mask_x_loop)
	movq (%esi), %mm0
	movq (%esi), %mm2
	punpcklbw %mm7, %mm0
	punpckhbw %mm7, %mm2
	movq %mm0, %mm1
	movq %mm2, %mm3
	punpcklwd %mm7, %mm0
	punpckhwd %mm7, %mm1
	punpcklwd %mm7, %mm2
	punpckhwd %mm7, %mm3
	movq (%edi), %mm4
	movq 8(%edi), %mm5
	movq 16(%edi), %mm6
	movq 24(%edi), %mm7
	pslld $24, %mm0
	pslld $24, %mm1
	pslld $24, %mm2
	pslld $24, %mm3
	addl $32, %edi
	addl $8, %esi
	pand GLOBL(__fb_gfx_rgb_32), %mm4
	pand GLOBL(__fb_gfx_rgb_32), %mm5
	pand GLOBL(__fb_gfx_rgb_32), %mm6
	pand GLOBL(__fb_gfx_rgb_32), %mm7
	por %mm0, %mm4
	por %mm1, %mm5
	por %mm2, %mm6
	por %mm3, %mm7
	movq %mm4, -32(%edi)
	movq %mm5, -24(%edi)
	movq %mm6, -16(%edi)
	movq %mm7, -8(%edi)
	decl %ecx
	jnz alpha_mask_x_loop
	
LABEL(alpha_mask_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl %ebx
	jnz alpha_mask_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	ret


FUNC(fb_MMX_code_end)
