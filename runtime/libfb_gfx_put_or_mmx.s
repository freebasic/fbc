/* MMX version of the OR drawing mode for PUT */

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
