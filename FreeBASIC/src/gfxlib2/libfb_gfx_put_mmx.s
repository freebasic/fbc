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


.text


/*:::::*/
FUNC(fb_hPutPSetMMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(1)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl GLOBL(fb_mode), %eax
	movl ARG3, %ebx
	movl BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
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
	orl %ecx, %ecx
	jz pset_next_line

LABEL(pset_x_loop)
	addl $8, %edi
	movq (%esi), %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)
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
	
	movl GLOBL(fb_mode), %eax
	movl ARG3, %ebx
	movl BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
	movl ARG2, %edi
	movl $0xFFFFFFFF, %eax
	subl %ebx, %edx
	movd %eax, %mm1
	punpckldq %mm1, %mm1

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
	orl %ecx, %ecx
	jz preset_next_line

LABEL(preset_x_loop)
	addl $8, %edi
	movq (%esi), %mm0
	pxor %mm1, %mm0
	addl $8, %esi
	movq %mm0, -8(%edi)
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
	
	movl GLOBL(fb_mode), %eax
	movl ARG3, %ebx
	movl BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
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
	orl %ecx, %ecx
	jz and_next_line

LABEL(and_x_loop)
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	pand -8(%esi), %mm0
	movq %mm0, -8(%edi)
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
	
	movl GLOBL(fb_mode), %eax
	movl ARG3, %ebx
	movl BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
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
	orl %ecx, %ecx
	jz or_next_line

LABEL(or_x_loop)
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	por -8(%esi), %mm0
	movq %mm0, -8(%edi)
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
	
	movl GLOBL(fb_mode), %eax
	movl ARG3, %ebx
	movl BPP(%eax), %ecx
	shrl $1, %ecx
	shll %cl, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
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
	orl %ecx, %ecx
	jz xor_next_line

LABEL(xor_x_loop)
	addl $8, %esi
	movq (%edi), %mm0
	addl $8, %edi
	pxor -8(%esi), %mm0
	movq %mm0, -8(%edi)
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
	movl GLOBL(fb_mode), %eax
	movl ARG1, %esi
	movl MODE_W(%eax), %edx
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
	movl GLOBL(fb_mode), %eax
	shll $1, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
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
	movl GLOBL(fb_mode), %eax
	shll $2, %ebx
	movl ARG4, %edx
	subl %ebx, ARG5
	movl %edx, LOCAL1
	movl ARG1, %esi
	movl TARGET_PITCH(%eax), %edx
	movl ARG2, %edi
	subl %ebx, %edx
	movq (mask_32), %mm1
	shrl $2, %ebx

LABEL(trans4_y_loop)
	movl %ebx, %ecx
	shrl $1, %ecx
	jnc trans4_skip_1
	addl $4, %edi
	lodsl
	cmpl $MASK_COLOR_32, %eax
	je trans4_skip_1
	movl %eax, -4(%edi)

LABEL(trans4_skip_1)
	shrl $1, %ecx
	jnc trans4_skip_2
	movq (%esi), %mm0
	movq (%edi), %mm2
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
