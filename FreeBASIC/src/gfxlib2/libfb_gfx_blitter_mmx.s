/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * blitter_mmx.s -- MMX versions of the blitter routines.
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.data

.balign 16

const32to15_rb:		.int	0x00F800F8, 0x00F800F8
const32to15_mul_rgb:	.int	0x04000001, 0x04000001
const32to15_mul_bgr:	.int	0x00010400, 0x00010400
const32to15_g:		.int	0x0000F800, 0x0000F800

const32to16_rb:		.int	0x00F800F8, 0x00F800F8
const32to16_mul_rgb:	.int	0x08000001, 0x08000001
const32to16_mul_bgr:	.int	0x00010800, 0x00010800
const32to16_g:		.int	0x0000FC00, 0x0000FC00


.text


/*:::::*/
FUNC(fb_hBlit8to15RGBMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(3)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_rgb), %mm3
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
	movq (const32to15_rb), %mm2
	movq (const32to15_mul_bgr), %mm3
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_rgb), %mm3
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
	movq (const32to16_rb), %mm2
	movq (const32to16_mul_bgr), %mm3
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
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

	psllq $8, %mm1
	psllq $16, %mm0
	psllq $24, %mm3
	por %mm1, %mm0		/* mm0 = | r1 g1 b1 r2 | g2 b2       | */
	por %mm3, %mm2		/* mm2 = |             | b3 r4 g4 b4 | */
	punpckhdq %mm7, %mm3
	por %mm3, %mm0		/* mm0 = | r1 g1 b1 r2 | g2 b2 r3 g3 | */

	movq %mm0, -12(%edi)
	movd %mm2, -4(%edi)
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx
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

	psllq $8, %mm0
	psrlq $8, %mm2
	psllq $16, %mm3
	por %mm1, %mm0		/* mm0 = | r1 g1 b1 r2 | g2 b2       | */
	por %mm3, %mm2		/* mm2 = |             | b3 r4 g4 b4 | */
	punpckhdq %mm7, %mm3
	por %mm3, %mm0		/* mm0 = | r1 g1 b1 r2 | g2 b2 r3 g3 | */

	movq %mm0, -12(%edi)
	movd %mm2, -4(%edi)
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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx

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
	
	movl GLOBL(fb_mode), %ebx
	movl ARG1, %edi
	movl FRAMEBUFFER(%ebx), %esi
	movl MODE_W(%ebx), %eax
	movl MODE_H(%ebx), %edx
	movl %eax, LOCAL3		/* LOCAL3 = fb_mode->pitch */
	shrl $2, %eax
	movl %eax, LOCAL1		/* LOCAL1 = fb_mode->mode_w >> 2 */
	movl %edx, LOCAL2		/* LOCAL2 = fb_mode->mode_h */
	movl DIRTY(%ebx), %edx
	movl DEVICE_PALETTE(%ebx), %ebx

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
	ret


/*:::::*/
FUNC(fb_hBlit16to15BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit16to16RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit16to24RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit16to24BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit16to32RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit16to32BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to15RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to15BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to16RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to16BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to24RGBMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to24BGRMMX)
	ret


/*:::::*/
FUNC(fb_hBlit32to32RGBMMX)
	ret
