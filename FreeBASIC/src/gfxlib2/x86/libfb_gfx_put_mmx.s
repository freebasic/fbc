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
 * put_mmx.s -- MMX versions of the put routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.data

.balign 16

mask_16:	.short	MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16
mask_32:	.long	MASK_COLOR_32, MASK_COLOR_32
rgb_32:		.long	0x00FFFFFF, 0x00FFFFFF
rb_32:		.long	MASK_RB_32, MASK_RB_32
ga_32:		.long	MASK_GA_32, MASK_GA_32
r_16:		.short	MASK_R_16, MASK_R_16, MASK_R_16, MASK_R_16
g_16:		.short	MASK_G_16, MASK_G_16, MASK_G_16, MASK_G_16
b_16:		.short	MASK_B_16, MASK_B_16, MASK_B_16, MASK_B_16
msb_16:		.long	0x84108410, 0x84108410


.text


/*:::::*/
FUNC(fb_hPutPSetMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	call GLOBL(fb_hGetContext)
	movl ARG3, %ebx
	movl CTX_TARGET_BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx

LABEL(pset_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc pset_skip_1
	movsb

LABEL(pset_skip_1)
	shrl $1, %ecx
	jnc pset_skip_2
	movsw

LABEL(pset_skip_2)
	shrl $1, %ecx
	jnc pset_skip_4
	movsd

LABEL(pset_skip_4)
	shrl $1, %ecx
	jnc pset_skip_8
	addl $8, %edi
	movq (%esi), %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)

LABEL(pset_skip_8)
	orl %ecx, %ecx
	jz pset_next_line

LABEL(pset_x_loop)
	addl $16, %esi
	addl $16, %edi
	movq -16(%esi), %mm0
	movq -8(%esi), %mm1
	movq %mm0, -16(%edi)
	movq %mm1, -8(%edi)
	decl %ecx
	jnz pset_x_loop

LABEL(pset_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz pset_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutPResetMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	call GLOBL(fb_hGetContext)
	movl ARG3, %ebx
	movl CTX_TARGET_BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	movl $0xFFFFFFFF, %eax
	subl %ebx, %edx
	movd %eax, %mm2
	punpckldq %mm2, %mm2

LABEL(preset_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc preset_skip_1
	lodsb
	xorb $0xFF, %al
	stosb

LABEL(preset_skip_1)
	shrl $1, %ecx
	jnc preset_skip_2
	lodsw
	xorw $0xFFFF, %ax
	stosw

LABEL(preset_skip_2)
	shrl $1, %ecx
	jnc preset_skip_4
	lodsl
	xorl $0xFFFFFFFF, %eax
	stosl

LABEL(preset_skip_4)
	shrl $1, %ecx
	jnc preset_skip_8
	addl $8, %edi
	movq (%esi), %mm0
	pxor %mm2, %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)

LABEL(preset_skip_8)
	orl %ecx, %ecx
	jz preset_next_line

LABEL(preset_x_loop)
	addl $16, %esi
	addl $16, %edi
	movq -16(%esi), %mm0
	movq -8(%esi), %mm1
	pxor %mm2, %mm0
	pxor %mm2, %mm1
	movq %mm0, -16(%edi)
	movq %mm1, -8(%edi)
	decl %ecx
	jnz preset_x_loop

LABEL(preset_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz preset_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutAndMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	call GLOBL(fb_hGetContext)
	movl ARG3, %ebx
	movl CTX_TARGET_BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx

LABEL(and_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc and_skip_1
	lodsb
	andb %al, (%edi)
	incl %edi

LABEL(and_skip_1)
	shrl $1, %ecx
	jnc and_skip_2
	lodsw
	andw %ax, (%edi)
	addl $2, %edi

LABEL(and_skip_2)
	shrl $1, %ecx
	jnc and_skip_4
	lodsl
	andl %eax, (%edi)
	addl $4, %edi

LABEL(and_skip_4)
	shrl $1, %ecx
	jnc and_skip_8
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	pand -8(%esi), %mm0
	movq %mm0, -8(%edi)

LABEL(and_skip_8)
	orl %ecx, %ecx
	jz and_next_line

LABEL(and_x_loop)
	addl $16, %edi
	addl $16, %esi
	movq -16(%edi), %mm0
	movq -8(%edi), %mm1
	pand -16(%esi), %mm0
	pand -8(%esi), %mm1
	movq %mm0, -16(%edi)
	movq %mm1, -8(%edi)
	decl %ecx
	jnz and_x_loop

LABEL(and_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz and_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutOrMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	call GLOBL(fb_hGetContext)
	movl ARG3, %ebx
	movl CTX_TARGET_BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx

LABEL(or_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc or_skip_1
	lodsb
	orb %al, (%edi)
	incl %edi

LABEL(or_skip_1)
	shrl $1, %ecx
	jnc or_skip_2
	lodsw
	orw %ax, (%edi)
	addl $2, %edi

LABEL(or_skip_2)
	shrl $1, %ecx
	jnc or_skip_4
	lodsl
	orl %eax, (%edi)
	addl $4, %edi

LABEL(or_skip_4)
	shrl $1, %ecx
	jnc or_skip_8
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	por -8(%esi), %mm0
	movq %mm0, -8(%edi)

LABEL(or_skip_8)
	orl %ecx, %ecx
	jz or_next_line

LABEL(or_x_loop)
	addl $16, %edi
	addl $16, %esi
	movq -16(%edi), %mm0
	movq -8(%edi), %mm1
	por -16(%esi), %mm0
	por -8(%esi), %mm1
	movq %mm0, -16(%edi)
	movq %mm1, -8(%edi)
	decl %ecx
	jnz or_x_loop

LABEL(or_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz or_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutXorMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	call GLOBL(fb_hGetContext)
	movl ARG3, %ebx
	movl CTX_TARGET_BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx

LABEL(xor_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc xor_skip_1
	lodsb
	xorb %al, (%edi)
	incl %edi

LABEL(xor_skip_1)
	shrl $1, %ecx
	jnc xor_skip_2
	lodsw
	xorw %ax, (%edi)
	addl $2, %edi

LABEL(xor_skip_2)
	shrl $1, %ecx
	jnc xor_skip_4
	lodsl
	xorl %eax, (%edi)
	addl $4, %edi

LABEL(xor_skip_4)
	shrl $1, %ecx
	jnc xor_skip_8
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	pxor -8(%esi), %mm0
	movq %mm0, -8(%edi)

LABEL(xor_skip_8)
	orl %ecx, %ecx
	jz xor_next_line

LABEL(xor_x_loop)
	addl $16, %edi
	addl $16, %esi
	movq -16(%edi), %mm0
	movq -8(%edi), %mm1
	pxor -16(%esi), %mm0
	pxor -8(%esi), %mm1
	movq %mm0, -16(%edi)
	movq %mm1, -8(%edi)
	decl %ecx
	jnz xor_x_loop

LABEL(xor_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz xor_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutTrans1MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG3, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl ARG6, %edx
	movl ARG2, %edi
	subl %ebx, %edx
	pxor %mm1, %mm1

LABEL(trans1_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc trans1_skip_1
	incl %edi
	lodsb
	orb %al, %al
	jz trans1_skip_1
	movb %al, -1(%edi)

LABEL(trans1_skip_1)
	shrl $1, %ecx
	jnc trans1_skip_2
	addl $2, %edi
	lodsw
	orb %al, %al
	jz trans1_skip_1a
	movb %al, -2(%edi)
	
LABEL(trans1_skip_1a)
	orb %ah, %ah
	jz trans1_skip_2
	movb %ah, -1(%edi)

LABEL(trans1_skip_2)
	shrl $1, %ecx
	jnc trans1_skip_4
	addl $4, %edi
	lodsl
	orb %al, %al
	jz trans1_skip_2a
	movb %al, -4(%edi)

LABEL(trans1_skip_2a)
	orb %ah, %ah
	jz trans1_skip_2b
	movb %ah, -3(%edi)

LABEL(trans1_skip_2b)
	shrl $16, %eax
	orb %al, %al
	jz trans1_skip_2c
	movb %al, -2(%edi)

LABEL(trans1_skip_2c)
	orb %ah, %ah
	jz trans1_skip_4
	movb %ah, -1(%edi)

LABEL(trans1_skip_4)
	shrl $1, %ecx
	jnc trans1_skip_8
	movq (%esi), %mm0
	movq (%edi), %mm2
	movq %mm0, %mm3
	pcmpeqb %mm1, %mm0
	pand %mm0, %mm2
	addl $8, %edi
	por %mm3, %mm2
	addl $8, %esi
	movq %mm2, -8(%edi)
	
LABEL(trans1_skip_8)
	orl %ecx, %ecx
	jz trans1_next_line

LABEL(trans1_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq (%edi), %mm2
	movq 8(%edi), %mm6
	movq %mm0, %mm3
	movq %mm4, %mm7
	pcmpeqb %mm1, %mm0
	pcmpeqb %mm1, %mm4
	pand %mm0, %mm2
	pand %mm4, %mm6
	addl $16, %edi
	por %mm3, %mm2
	por %mm7, %mm6
	addl $16, %esi
	movq %mm2, -16(%edi)
	movq %mm6, -8(%edi)
	decl %ecx
	jnz trans1_x_loop

LABEL(trans1_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz trans1_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutTrans2MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
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
	movq (mask_16), %mm1
	shrl $1, %ebx

LABEL(trans2_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc trans2_skip_1
	addl $2, %edi
	lodsw
	cmpw $MASK_COLOR_16, %ax
	je trans2_skip_1
	movw %ax, -2(%edi)

LABEL(trans2_skip_1)
	shrl $1, %ecx
	jnc trans2_skip_2
	addl $4, %edi
	lodsw
	cmpw $MASK_COLOR_16, %ax
	je trans2_skip_1a
	movw %ax, -4(%edi)

LABEL(trans2_skip_1a)
	lodsw
	cmpw $MASK_COLOR_16, %ax
	je trans2_skip_2
	movw %ax, -2(%edi)

LABEL(trans2_skip_2)
	shrl $1, %ecx
	jnc trans2_skip_4
	movq (%esi), %mm0
	movq (%edi), %mm2
	movq %mm0, %mm3
	pcmpeqw %mm1, %mm0
	pand %mm0, %mm2
	pandn %mm3, %mm0
	addl $8, %edi
	por %mm0, %mm2
	addl $8, %esi
	movq %mm2, -8(%edi)

LABEL(trans2_skip_4)
	orl %ecx, %ecx
	jz trans2_next_line

LABEL(trans2_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq (%edi), %mm2
	movq 8(%edi), %mm6
	movq %mm0, %mm3
	movq %mm4, %mm7
	pcmpeqw %mm1, %mm0
	pcmpeqw %mm1, %mm4
	pand %mm0, %mm2
	pand %mm4, %mm6
	pandn %mm3, %mm0
	pandn %mm7, %mm4
	addl $16, %edi
	por %mm0, %mm2
	por %mm4, %mm6
	addl $16, %esi
	movq %mm2, -16(%edi)
	movq %mm6, -8(%edi)
	decl %ecx
	jnz trans2_x_loop

LABEL(trans2_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz trans2_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutTrans4MMX)
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
	subl %ebx, %edx
	movq (mask_32), %mm1
	movq (rgb_32), %mm5
	shrl $2, %ebx

LABEL(trans4_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc trans4_skip_1
	addl $4, %edi
	lodsl
	andl $0xFFFFFF, %eax
	cmpl $MASK_COLOR_32, %eax
	je trans4_skip_1
	movl %eax, -4(%edi)

LABEL(trans4_skip_1)
	shrl $1, %ecx
	jnc trans4_skip_2
	movq (%esi), %mm0
	movq (%edi), %mm2
	pand %mm5, %mm0
	movq %mm0, %mm3
	pcmpeqd %mm1, %mm0
	pand %mm0, %mm2
	pandn %mm3, %mm0
	addl $8, %edi
	por %mm0, %mm2
	addl $8, %esi
	movq %mm2, -8(%edi)

LABEL(trans4_skip_2)
	orl %ecx, %ecx
	jz trans4_next_line

LABEL(trans4_x_loop)
	movq (%esi), %mm0
	movq 8(%esi), %mm4
	movq (%edi), %mm2
	movq 8(%edi), %mm6
	pand %mm5, %mm0
	pand %mm5, %mm4
	movq %mm0, %mm3
	movq %mm4, %mm7
	pcmpeqd %mm1, %mm0
	pcmpeqd %mm1, %mm4
	pand %mm0, %mm2
	pand %mm4, %mm6
	pandn %mm3, %mm0
	pandn %mm7, %mm4
	addl $16, %edi
	por %mm0, %mm2
	por %mm4, %mm6
	addl $16, %esi
	movq %mm2, -16(%edi)
	movq %mm6, -8(%edi)
	decl %ecx
	jnz trans4_x_loop

LABEL(trans4_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl LOCAL1
	jnz trans4_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(1)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutAlpha4MMX)
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
	movq (rb_32), %mm5

LABEL(alpha4_y_loop)
	movl ARG3, %ecx
	shrl $1, %ecx
	jnc alpha4_skip_1
	addl $4, %edi
	lodsl
	movl %eax, LOCAL3
	movl -4(%edi), %ebx
	movl %eax, %ecx
	movl %ebx, %edx
	andl $MASK_RB_32, %eax
	andl $MASK_RB_32, %edx
	shrl $24, LOCAL3
	subl %edx, %eax
	imull LOCAL3
	xchg %eax, %ecx
	movl %ebx, %edx
	andl $MASK_GA_32, %eax
	andl $MASK_GA_32, %edx
	subl %edx, %eax
	shrl $8, %eax
	imull LOCAL3
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

LABEL(alpha4_skip_1)
	movl ARG3, %ecx
	shrl $1, %ecx
	jz alpha4_next_line

LABEL(alpha4_x_loop)
	movq (%esi), %mm0
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
	addl $8, %esi
	movq %mm0, -8(%edi)
	decl %ecx
	jnz alpha4_x_loop

LABEL(alpha4_next_line)
	addl ARG5, %esi
	addl LOCAL2, %edi
	decl LOCAL1
	jnz alpha4_y_loop

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret


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
	movq (rb_32), %mm5
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
	pcmpeqw (mask_16), %mm0
	pand %mm0, %mm5
	pandn %mm3, %mm0
	por %mm5, %mm0
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand (r_16), %mm0
	pand (r_16), %mm4
	pand (g_16), %mm1
	pand (g_16), %mm5
	psrlw $5, %mm0
	psrlw $5, %mm4
	pand (b_16), %mm2
	pand (b_16), %mm6
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
	pand (r_16), %mm0
	paddw %mm5, %mm1
	paddw %mm6, %mm2
	pand (g_16), %mm1
	pand (b_16), %mm2
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
	pcmpeqw (mask_16), %mm0
	pand %mm0, %mm5
	pandn %mm3, %mm0
	por %mm5, %mm0
	movq %mm0, %mm1
	movq %mm4, %mm5
	movq %mm0, %mm2
	movq %mm4, %mm6
	pand (r_16), %mm0
	pand (r_16), %mm4
	pand (g_16), %mm1
	pand (g_16), %mm5
	psrlw $5, %mm0
	psrlw $5, %mm4
	pand (b_16), %mm2
	pand (b_16), %mm6
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
	pand (r_16), %mm0
	paddw %mm5, %mm1
	paddw %mm6, %mm2
	pand (g_16), %mm1
	pand (b_16), %mm2
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
	movq (rb_32), %mm5
	movq (ga_32), %mm6
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
	pand (rgb_32), %mm0
	movq %mm1, %mm4
	pcmpeqd (mask_32), %mm0
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
	movq (msb_16), %mm6

LABEL(add2_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc add2_skip_1

	movw (%esi), %ax
	movd %eax, %mm0
	movw (%edi), %ax
	movd %eax, %mm1
	movq %mm0, %mm2
	pcmpeqw (mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand (mask_16), %mm4
	pand (mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand (g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand (mask_16), %mm4
	psrlw $5, %mm0
	pand (g_16), %mm0
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
	pcmpeqw (mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand (mask_16), %mm4
	pand (mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand (g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand (mask_16), %mm4
	psrlw $5, %mm0
	pand (g_16), %mm0
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
	pcmpeqw (mask_16), %mm0
	pandn %mm2, %mm0
	movq %mm0, %mm4
	movq %mm0, %mm5
	pand (mask_16), %mm4
	pand (mask_16), %mm5
	psrlw $5, %mm4
	pmullw %mm7, %mm5
	pmullw %mm7, %mm4
	pand (g_16), %mm0
	psrlw $5, %mm5
	por %mm5, %mm4
	pmullw %mm7, %mm0
	pand (mask_16), %mm4
	psrlw $5, %mm0
	pand (g_16), %mm0
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
	pand (rgb_32), %mm3
	pcmpeqd (mask_32), %mm3
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
	pand (rgb_32), %mm3
	punpckhbw %mm6, %mm2
	pcmpeqd (mask_32), %mm3
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
	pand (rgb_32), %mm4
	pand (rgb_32), %mm5
	pcmpeqd (mask_32), %mm4
	pcmpeqd (mask_32), %mm5
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
