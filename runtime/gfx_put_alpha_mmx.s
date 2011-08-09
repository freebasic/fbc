/* MMX version of the ALPHA drawing mode for PUT */

#include "fb_gfx_mmx.h"


.text


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
	movq GLOBL(__fb_gfx_rb_32), %mm5

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
