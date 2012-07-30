/* MMX versions of the blitter routines. */

#include "fb_gfx_mmx.h"

.data

.balign 16

FUNC(fb_hBlitMMX_data_start)

const16to15_r:		.int	0x001F001F, 0x001F001F
const16to15_g:		.int	0x07C007C0, 0x07C007C0
const16to15_gb:		.int	0xFFC0FFC0, 0xFFC0FFC0

const16to16_g:		.int	0x07E007E0, 0x07E007E0

const32to15_rb:		.int	0x00F800F8, 0x00F800F8
const32to15_mul_bgr:	.int	0x04000001, 0x04000001
const32to15_mul_rgb:	.int	0x00010400, 0x00010400
const32to15_g:		.int	0x0000F800, 0x0000F800

const32to16_rb:		.int	0x00F800F8, 0x00F800F8
const32to16_mul_bgr:	.int	0x08000001, 0x08000001
const32to16_mul_rgb:	.int	0x00010800, 0x00010800
const32to16_g:		.int	0x0000FC00, 0x0000FC00

const32to32_g:		.int	0x0000FF00, 0x0000FF00
const32to32_b:		.int	0x00FF0000, 0x00FF0000

FUNC(fb_hBlitMMX_data_end)

.text

FUNC(fb_hBlitMMX_code_start)

/*:::::*/
FUNC(fb_hBlit8to15RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_bgr), %mm3
	movq (const32to15_g), %mm6

LABEL(blit8to15RGB_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to15RGB_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to15RGB_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm4
	shrl $16, %eax
	movb %al, %dl
	addl $8, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm5
	punpckldq %mm4, %mm0
	punpckldq %mm5, %mm1
	popl %ecx
	
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $6, %mm0
	psrld $6, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	packssdw %mm1, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit8to15RGB_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to15RGB_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to15RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to15BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_rgb), %mm3
	movq (const32to15_g), %mm6

LABEL(blit8to15BGR_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to15BGR_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to15BGR_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm4
	shrl $16, %eax
	movb %al, %dl
	addl $8, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm5
	punpckldq %mm4, %mm0
	punpckldq %mm5, %mm1
	popl %ecx
	
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $6, %mm0
	psrld $6, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	packssdw %mm1, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit8to15BGR_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to15BGR_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to15BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to16RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_bgr), %mm3
	movq (const32to16_g), %mm6

LABEL(blit8to16RGB_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to16RGB_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to16RGB_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	movb %al, %dl
	addl $8, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm4
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm5
	punpckldq %mm4, %mm0
	punpckldq %mm5, %mm1
	popl %ecx
	
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $5, %mm0
	psrld $5, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	movq %mm0, %mm7
	punpcklwd %mm1, %mm0
	punpckhwd %mm1, %mm7
	punpckldq %mm7, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit8to16RGB_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to16RGB_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to16RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to16BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_rgb), %mm3
	movq (const32to16_g), %mm6

LABEL(blit8to16BGR_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to16BGR_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to16BGR_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	movb %al, %dl
	addl $8, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm4
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm5
	punpckldq %mm4, %mm0
	punpckldq %mm5, %mm1
	popl %ecx
	
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $5, %mm0
	psrld $5, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	movq %mm0, %mm7
	punpcklwd %mm1, %mm0
	punpckhwd %mm1, %mm7
	punpckldq %mm7, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit8to16BGR_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to16BGR_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to16BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to24RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	pxor %mm7, %mm7

LABEL(blit8to24RGB_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to24RGB_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to24RGB_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	movb %al, %dl
	addl $12, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm2
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm3
	popl %ecx

	psllq $24, %mm1
	psllq $8, %mm3
	movq %mm2, %mm4
	por %mm1, %mm0		/* mm0 = |       r2 g2 | b2 r1 g1 b1 | */
	psrlq $16, %mm4
	psllq $48, %mm2
	por %mm4, %mm3		/* mm3 = |             | r4 g4 b4 r3 | */
	por %mm2, %mm0		/* mm0 = | g3 b3 r2 g2 | b2 r1 g1 b1 | */

	movq %mm0, -12(%edi)
	movd %mm3, -4(%edi)
	decl %ecx
	jnz blit8to24RGB_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to24RGB_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to24RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to24BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx
	pxor %mm7, %mm7

LABEL(blit8to24BGR_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to24BGR_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to24BGR_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	movb %al, %dl
	addl $12, %edi
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm2
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm3
	popl %ecx

	psllq $16, %mm1
	psrlq $8, %mm0
	movq %mm2, %mm4
	por %mm1, %mm0		/* mm0 = |       r2 g2 | b2 r1 g1 b1 | */
	psrlq $24, %mm4
	psllq $40, %mm2
	por %mm4, %mm3		/* mm3 = |             | r4 g4 b4 r3 | */
	por %mm2, %mm0		/* mm0 = | g3 b3 r2 g2 | b2 r1 g1 b1 | */

	movq %mm0, -12(%edi)
	movd %mm3, -4(%edi)
	decl %ecx
	jnz blit8to24BGR_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to24BGR_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to24BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to32RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx

LABEL(blit8to32RGB_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to32RGB_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to32RGB_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	punpckldq %mm1, %mm0
	movb %al, %dl
	addl $16, %edi
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm2
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	movd %ecx, %mm3
	punpckldq %mm3, %mm2
	popl %ecx
	movq %mm0, -16(%edi)
	movq %mm2, -8(%edi)
	decl %ecx
	jnz blit8to32RGB_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to32RGB_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to32RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit8to32BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	movl GFX_MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %edx
	movl GFX_DEVICE_PALETTE(%ebx), %ebx

LABEL(blit8to32BGR_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%edx)
	jz blit8to32BGR_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %edx
	xorl %edx, %edx

LABEL(blit8to32BGR_x_loop)
	lodsl
	pushl %ecx
	movb %al, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm0
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm1
	shrl $16, %eax
	punpckldq %mm1, %mm0
	movb %al, %dl
	addl $16, %edi
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm2
	movb %ah, %dl
	movl (%ebx, %edx, 4), %ecx
	bswap %ecx
	movd %ecx, %mm3
	punpckldq %mm3, %mm2
	popl %ecx
	psrld $8, %mm0
	psrld $8, %mm2
	movq %mm0, -16(%edi)
	movq %mm2, -8(%edi)
	decl %ecx
	jnz blit8to32BGR_x_loop
	popl %edx
	popl %edi
	
LABEL(blit8to32BGR_next_line)
	incl %edx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit8to32BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit16to15RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $1, %edx
	shrl $3, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 3 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const16to15_g), %mm7

LABEL(blit16to15RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit16to15RGB_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit16to15RGB_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand %mm7, %mm1
	pand %mm7, %mm5
	psrlw $11, %mm0
	psrlw $11, %mm4
	psllw $10, %mm2
	psllw $10, %mm6
	psrlw $1, %mm1
	psrlw $1, %mm5
	por %mm2, %mm0
	por %mm6, %mm4
	addl $16, %esi
	addl $16, %edi
	por %mm1, %mm0
	por %mm5, %mm4
	movq %mm0, -16(%edi)
	movq %mm4, -8(%edi)
	decl %ecx
	jnz blit16to15RGB_x_loop
	popl %edi
	
LABEL(blit16to15RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit16to15RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit16to15BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $1, %edx
	shrl $3, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 3 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const16to15_r), %mm3
	movq (const16to15_gb), %mm7

LABEL(blit16to15BGR_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit16to15BGR_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit16to15BGR_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq %mm0, %mm1
	movq %mm4, %mm5
	pand %mm7, %mm0
	pand %mm7, %mm4
	pand %mm3, %mm1
	pand %mm3, %mm5
	psrlw $1, %mm0
	psrlw $1, %mm4
	addl $16, %esi
	addl $16, %edi
	por %mm1, %mm0
	por %mm5, %mm4
	movq %mm0, -16(%edi)
	movq %mm4, -8(%edi)
	decl %ecx
	jnz blit16to15BGR_x_loop
	popl %edi
	
LABEL(blit16to15BGR_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit16to15BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit16to16RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $1, %edx
	shrl $3, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 3 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const16to16_g), %mm7

LABEL(blit16to16RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit16to16RGB_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit16to16RGB_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand %mm7, %mm1
	pand %mm7, %mm5
	psrlw $11, %mm0
	psrlw $11, %mm4
	psllw $11, %mm2
	psllw $11, %mm6
	por %mm2, %mm0
	por %mm6, %mm4
	addl $16, %esi
	addl $16, %edi
	por %mm1, %mm0
	por %mm5, %mm4
	movq %mm0, -16(%edi)
	movq %mm4, -8(%edi)
	decl %ecx
	jnz blit16to16RGB_x_loop
	popl %edi
	
LABEL(blit16to16RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit16to16RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit16to24MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	shll $1, %eax
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $3, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	xorl %edx, %edx
	movl %eax, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %ebx

LABEL(blit16to24_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%ebx)
	jz blit16to24_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %ebx
	pushl %ebp
	movl GLOBL(__fb_color_conv_16to32), %ebp

LABEL(blit16to24_x_loop)
	movq (%esi), %mm0
	movd %mm0, %eax
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	shrl $16, %eax
	movd %ebx, %mm1		/* mm1 = |             |    r1 g1 b1 | */
	movb %al, %dl
	psrlq $32, %mm0
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	movd %mm0, %eax
	movd %ebx, %mm2		/* mm2 = |             |    r2 g2 b2 | */
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	shrl $16, %eax
	orl 1024(%ebp, %edx, 4), %ebx
	movb %al, %dl
	movd %ebx, %mm3		/* mm3 = |             |    r3 g3 b3 | */
	addl $8, %esi
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	addl $12, %edi
	orl 1024(%ebp, %edx, 4), %ebx	  /* ebx = |    r4 g4 b4 | */
	
	psllq $24, %mm2
	movd %mm3, %eax
	por %mm2, %mm1
	psllq $48, %mm3
	shrl $16, %eax
	por %mm3, %mm1
	shll $8, %ebx
	movq %mm1, -12(%edi)
	orl %ebx, %eax
	movl %eax, -4(%edi)
	decl %ecx
	jnz blit16to24_x_loop
	popl %ebp
	popl %ebx
	popl %edi
	
LABEL(blit16to24_next_line)
	incl %ebx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit16to24_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit16to32MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %eax
	shll $1, %eax
	movl %eax, LOCAL3		/* LOCAL3 = __fb_gfx->pitch */
	shrl $3, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	xorl %edx, %edx
	movl %eax, LOCAL2		/* LOCAL2 = __fb_gfx->GFX_MODE_H */
	movl GFX_DIRTY(%ebx), %ebx

LABEL(blit16to32_y_loop)
	addl LOCAL3, %esi
	cmpb $0, (%ebx)
	jz blit16to32_next_line
	movl LOCAL1, %ecx
	subl LOCAL3, %esi
	pushl %edi
	pushl %ebx
	pushl %ebp
	movl GLOBL(__fb_color_conv_16to32), %ebp

LABEL(blit16to32_x_loop)
	movq (%esi), %mm0
	movd %mm0, %eax
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	shrl $16, %eax
	movd %ebx, %mm1
	psrlq $32, %mm0
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	movd %mm0, %eax
	movd %ebx, %mm2
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	shrl $16, %eax
	movd %ebx, %mm3
	addl $8, %esi
	addl $16, %edi
	movb %al, %dl
	movl (%ebp, %edx, 4), %ebx
	movb %ah, %dl
	orl 1024(%ebp, %edx, 4), %ebx
	movd %ebx, %mm4
	
	punpckldq %mm2, %mm1
	punpckldq %mm4, %mm3
	movq %mm1, -16(%edi)
	movq %mm3, -8(%edi)
	decl %ecx
	jnz blit16to32_x_loop
	popl %ebp
	popl %ebx
	popl %edi
	
LABEL(blit16to32_next_line)
	incl %ebx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit16to32_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to15RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_rgb), %mm3
	movq (const32to15_g), %mm6

LABEL(blit32to15RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to15RGB_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to15RGB_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm1
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	addl $8, %edi
	addl $16, %esi
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $6, %mm0
	psrld $6, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	packssdw %mm1, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit32to15RGB_x_loop
	popl %edi
	
LABEL(blit32to15RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to15RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to15BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_bgr), %mm3
	movq (const32to15_g), %mm6

LABEL(blit32to15BGR_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to15BGR_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to15BGR_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm1
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	addl $8, %edi
	addl $16, %esi
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $6, %mm0
	psrld $6, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	packssdw %mm1, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit32to15BGR_x_loop
	popl %edi
	
LABEL(blit32to15BGR_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to15BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to16RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_rgb), %mm3
	movq (const32to16_g), %mm6

LABEL(blit32to16RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to16RGB_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to16RGB_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm7
	movq %mm0, %mm1
	punpckldq %mm7, %mm0
	punpckhdq %mm7, %mm1
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	addl $8, %edi
	addl $16, %esi
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $5, %mm0
	psrld $5, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	movq %mm0, %mm7
	punpcklwd %mm1, %mm0
	punpckhwd %mm1, %mm7
	punpckldq %mm7, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit32to16RGB_x_loop
	popl %edi
	
LABEL(blit32to16RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to16RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to16BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_bgr), %mm3
	movq (const32to16_g), %mm6

LABEL(blit32to16BGR_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to16BGR_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to16BGR_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm7
	movq %mm0, %mm1
	punpckldq %mm7, %mm0
	punpckhdq %mm7, %mm1
	movq %mm0, %mm4
	movq %mm1, %mm5
	pand %mm2, %mm4
	pand %mm2, %mm5
	addl $8, %edi
	addl $16, %esi
	pmaddwd %mm3, %mm4
	pmaddwd %mm3, %mm5
	pand %mm6, %mm0
	pand %mm6, %mm1
	psrld $3, %mm4
	psrld $3, %mm5
	psrld $5, %mm0
	psrld $5, %mm1
	por %mm4, %mm0
	por %mm5, %mm1
	movq %mm0, %mm7
	punpcklwd %mm1, %mm0
	punpckhwd %mm1, %mm7
	punpckldq %mm7, %mm0
	
	movq %mm0, -8(%edi)
	decl %ecx
	jnz blit32to16BGR_x_loop
	popl %edi
	
LABEL(blit32to16BGR_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to16BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to24RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(2)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movl %eax, LOCAL2		/* LOCAL2 = __fb_gfx->h */

LABEL(blit32to24RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to24RGB_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to24RGB_x_loop)
	lodsl
	andl $0xFFFFFF, %eax
	bswap %eax
	movd %eax, %mm0
	lodsl
	andl $0xFFFFFF, %eax
	bswap %eax
	movd %eax, %mm1
	lodsl
	andl $0xFFFFFF, %eax
	bswap %eax
	movd %eax, %mm2
	lodsl
	bswap %eax
	movd %eax, %mm3
	addl $12, %edi
	psllq $16, %mm1
	psrlq $8, %mm0
	movq %mm2, %mm4
	por %mm1, %mm0		/* mm0 = |       r2 g2 | b2 r1 g1 b1 | */
	psrlq $24, %mm4
	psllq $40, %mm2
	por %mm4, %mm3		/* mm3 = |             | r4 g4 b4 r3 | */
	por %mm2, %mm0		/* mm0 = | g3 b3 r2 g2 | b2 r1 g1 b1 | */
	
	movq %mm0, -12(%edi)
	movd %mm3, -4(%edi)
	decl %ecx
	jnz blit32to24RGB_x_loop
	popl %edi
	
LABEL(blit32to24RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl LOCAL2
	jnz blit32to24RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(2)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to24BGRMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl $0xFFFFFF, %ecx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movd %ecx, %mm5
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx

LABEL(blit32to24BGR_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to24BGR_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to24BGR_x_loop)
	movd (%esi), %mm0
	movd 4(%esi), %mm1
	movd 8(%esi), %mm2
	movd 12(%esi), %mm3
	pand %mm5, %mm0
	pand %mm5, %mm1
	pand %mm5, %mm2
	pand %mm5, %mm3
	addl $12, %edi
	addl $16, %esi
	psllq $24, %mm1
	psllq $8, %mm3
	movq %mm2, %mm4
	por %mm1, %mm0		/* mm0 = |       r2 g2 | b2 r1 g1 b1 | */
	psrlq $16, %mm4
	psllq $48, %mm2
	por %mm4, %mm3		/* mm3 = |             | r4 g4 b4 r3 | */
	por %mm2, %mm0		/* mm0 = | g3 b3 r2 g2 | b2 r1 g1 b1 | */
	
	movq %mm0, -12(%edi)
	movd %mm3, -4(%edi)
	decl %ecx
	jnz blit32to24BGR_x_loop
	popl %edi
	
LABEL(blit32to24BGR_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to24BGR_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hBlit32to32RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(__fb_gfx), %ebx
	movl ARG1, %edi
	movl GFX_FRAMEBUFFER(%ebx), %esi
	movl GFX_MODE_W(%ebx), %edx
	movl %edx, %eax
	shll $2, %edx
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = __fb_gfx->GFX_MODE_W >> 2 */
	movl GFX_MODE_H(%ebx), %eax
	movl GFX_DIRTY(%ebx), %ebx
	movq (const32to32_g), %mm3
	movq (const32to32_b), %mm7

LABEL(blit32to32RGB_y_loop)
	addl %edx, %esi
	cmpb $0, (%ebx)
	jz blit32to24BGR_next_line
	movl LOCAL1, %ecx
	subl %edx, %esi
	pushl %edi

LABEL(blit32to32RGB_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	addl $16, %esi
	addl $16, %edi
	pand %mm3, %mm2
	pand %mm3, %mm6
	pand %mm7, %mm0
	pand %mm7, %mm4
	pslld $16, %mm1
	pslld $16, %mm5
	psrld $16, %mm0
	psrld $16, %mm4
	por %mm1, %mm2
	por %mm5, %mm6
	por %mm0, %mm2
	por %mm4, %mm6
	
	movq %mm2, -16(%edi)
	movq %mm6, -8(%edi)
	decl %ecx
	jnz blit32to32RGB_x_loop
	popl %edi
	
LABEL(blit32to32RGB_next_line)
	incl %ebx
	addl ARG2, %edi
	decl %eax
	jnz blit32to32RGB_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret

FUNC(fb_hBlitMMX_code_end)
