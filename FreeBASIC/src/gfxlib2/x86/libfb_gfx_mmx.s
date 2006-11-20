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
 * mmx.s -- MMX detection and memory copy/set routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.data

.balign 16

mask_rb_32:	.long	MASK_RB_32, MASK_RB_32
mask_g_32:	.long	MASK_G_32, MASK_G_32
mask_a_32:	.long	MASK_A_32, MASK_A_32
a_32:		.long	0, 0


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
	movd %esi, %mm0
	movl ARG3, %ecx
	punpckldq %mm0, %mm0

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
	andl $MASK_G_32, %eax
	andl $MASK_G_32, %edx
	subl %edx, %eax
	imull %esi
	shrl $8, %ecx
	shrl $8, %eax
	movl %ebx, %edx
	andl $MASK_RB_32, %ebx
	andl $MASK_G_32, %edx
	addl %ecx, %ebx
	addl %edx, %eax
	andl $MASK_RB_32, %ebx
	andl $MASK_G_32, %eax
	shll $24, %esi
	orl %ebx, %eax
	orl %esi, %eax
	movl %eax, -4(%edi)

LABEL(pixelsetalpha4_skip_1)
	movl ARG3, %ecx
	shrl $1, %ecx
	jz pixelsetalpha4_end
	movq %mm0, %mm1
	movq %mm0, %mm2
	movq %mm0, %mm7
	psrld $24, %mm2
	pand (mask_a_32), %mm1
	packssdw %mm2, %mm2
	movq %mm1, (a_32)
	movq (mask_rb_32), %mm5
	punpcklwd %mm2, %mm2
	movq (mask_g_32), %mm6

LABEL(pixelsetalpha4_x_loop)
	movq %mm7, %mm0
	movq (%edi), %mm1
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
	movq %mm6, %mm4
	psrlw $8, %mm0
	pand %mm4, %mm3
	paddb %mm1, %mm0
	paddb %mm1, %mm3
	pand %mm5, %mm0
	pand %mm4, %mm3
	por %mm3, %mm0
	por (a_32), %mm0
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



FUNC(fb_MMX_code_end)
