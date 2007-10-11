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
 * put_or_mmx.s -- MMX version of the OR drawing mode for PUT
 *
 * chng: mar/2007 written [lillo]
 *
 */

#include "fb_gfx_mmx.h"


.text


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
