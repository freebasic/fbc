/* MMX version of the PRESET drawing mode for PUT */

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

