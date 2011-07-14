/* MMX version of the TRANS drawing mode for PUT */

#include "fb_gfx_mmx.h"


.text


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
	movq GLOBL(__fb_gfx_mask_16), %mm1
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
	movq GLOBL(__fb_gfx_mask_32), %mm1
	movq GLOBL(__fb_gfx_rgb_32), %mm5
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
