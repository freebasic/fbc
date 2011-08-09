/* MMX version of the PSET drawing mode for PUT */

#include "fb_gfx_mmx.h"


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

