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


.text


/*:::::*/
FUNC(fb_hMemCpyMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %esi
	movl ARG3, %ecx
	movl %edi, %eax
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
	emms
	
LABEL(memcpy_end)
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
	movl %edi, %edx
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
	emms
	
LABEL(memset_end)
	popl %edi
	popl %ebp
	ret
