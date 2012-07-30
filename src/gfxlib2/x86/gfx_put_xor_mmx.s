/* MMX version of the XOR drawing mode for PUT */

#include "fb_gfx_mmx.h"


.text


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
