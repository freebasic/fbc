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
 * put_preset_mmx.s -- MMX version of the PRESET drawing mode for PUT
 *
 * chng: mar/2007 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.text


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

