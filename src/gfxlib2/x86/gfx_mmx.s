/* MMX detection and memory copy/set routines */

#include "fb_gfx_mmx.h"


.data

.balign 16

VAR(__fb_gfx_mask_16)		.short	MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16, MASK_COLOR_16
VAR(__fb_gfx_mask_32)		.long	MASK_COLOR_32, MASK_COLOR_32
VAR(__fb_gfx_rgb_32)		.long	MASK_RGB_32, MASK_RGB_32
VAR(__fb_gfx_rb_32)			.long	MASK_RB_32, MASK_RB_32
VAR(__fb_gfx_ga_32)			.long	MASK_GA_32, MASK_GA_32
VAR(__fb_gfx_r_16)			.short	MASK_R_16, MASK_R_16, MASK_R_16, MASK_R_16
VAR(__fb_gfx_g_16)			.short	MASK_G_16, MASK_G_16, MASK_G_16, MASK_G_16
VAR(__fb_gfx_b_16)			.short	MASK_B_16, MASK_B_16, MASK_B_16, MASK_B_16
VAR(__fb_gfx_msb_16)		.long	0x84108410, 0x84108410


.text

FUNC(fb_MMX_code_start)


/*:::::*/
FUNC(fb_hMemCpyMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	
	movl ARG1, %edi
	movl ARG2, %esi
	movl ARG3, %ecx
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
	
LABEL(memcpy_end)
	emms
	popl %edi
	popl %esi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hMemSetMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi                /* edi = dst                         */
	movl ARG2, %eax                /* esi = sc                          */
	movl ARG3, %ecx                /* ecx = len                         */
	movb %al, %ah
	movw %ax, %dx
	shll $16, %eax
	movw %dx, %ax
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
	
LABEL(memset_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSet2MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi                /* edi = dst                         */
	movl ARG2, %eax                /* esi = sc                          */
	movl ARG3, %ecx                /* ecx = len                         */
	movw %ax, %dx
	shll $16, %eax
	movw %dx, %ax
	shrl $1, %ecx
	jnc pixelset2_skip_1
	stosw

LABEL(pixelset2_skip_1)
	shrl $1, %ecx
	jnc pixelset2_skip_2
	stosl

LABEL(pixelset2_skip_2)
	movd %eax, %mm0
	punpckldq %mm0, %mm0
	shrl $1, %ecx
	jnc pixelset2_skip_4
	movq %mm0, (%edi)
	addl $8, %edi

LABEL(pixelset2_skip_4)
	orl %ecx, %ecx
	jz pixelset2_end
	
LABEL(pixelset2_loop)
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	addl $16, %edi
	decl %ecx
	jnz pixelset2_loop
	
LABEL(pixelset2_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSet4MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi                /* edi = dst                         */
	movl ARG2, %eax                /* esi = sc                          */
	movl ARG3, %ecx                /* ecx = len                         */
	shrl $1, %ecx
	jnc pixelset4_skip_1
	stosl

LABEL(pixelset4_skip_1)
	movd %eax, %mm0
	punpckldq %mm0, %mm0
	shrl $1, %ecx
	jnc pixelset4_skip_2
	movq %mm0, (%edi)
	addl $8, %edi

LABEL(pixelset4_skip_2)
	shrl $1, %ecx
	jnc pixelset4_skip_4
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	addl $16, %edi

LABEL(pixelset4_skip_4)
	orl %ecx, %ecx
	jz pixelset4_end
	
LABEL(pixelset4_loop)
	movq %mm0, (%edi)
	movq %mm0, 8(%edi)
	movq %mm0, 16(%edi)
	movq %mm0, 24(%edi)
	addl $32, %edi
	decl %ecx
	jnz pixelset4_loop
	
LABEL(pixelset4_end)
	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPixelSetAlpha4MMX)
	pushl %ebp
	movl %esp, %ebp
	RESERVE_LOCALS(2)
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl ARG2, %esi                /* esi = sc                          */
	movl ARG1, %edi                /* edi = dst                         */
	movd %esi, %mm6                /* mm6 = esi                         */
	movl ARG3, %ecx                /* ecx = len                         */

	shrl $1, %ecx
	jnc pixelsetalpha4_skip_1
	
	addl $4, %edi                  /* edi = d+=4                        */
	movl %esi, %ecx                /* ecx = sc                          */
	movl -4(%edi), %ebx            /* ebx = dc                          */
	shrl $24, %esi                 /* esi = a                           */
	movl %ecx, %eax                /* eax = sc                          */
	movl %ebx, %edx                /* edx = dc                          */
	andl $MASK_RB_32, %eax         /* eax = srb                         */
	andl $MASK_RB_32, %edx         /* edx = drb                         */
	subl %edx, %eax                /* eax = srb-drb                     */
	imull %esi                     /* eax = (srb-drb)*a                 */
	shrl $8, %eax                  /* eax = ((srb-drb)*a)>>8      [irb] */
	movl %eax, LOCAL1              /* store irb                         */
	movl %ecx, %eax                /* eax = sc                          */
	movl %ebx, %edx                /* edx = dc                          */
	andl $MASK_G_32, %eax          /* eax = sg                          */
	andl $MASK_G_32, %edx          /* edx = dg                          */
	subl %edx, %eax                /* eax = sg-dg                       */
	imull %esi                     /* eax = (sg-dg)*a                   */
	shrl $8, %eax                  /* eax = ((sg-dg)*a)>>8         [ig] */
	movl %eax, LOCAL2              /* store ig                          */
	movl %ecx, %eax                /* eax = sc                          */
	andl $MASK_A_32, %eax          /* eax = sa                          */
	movl %ebx, %ecx                /* ecx = dc                          */
	andl $MASK_RB_32, %ebx         /* ebx = drb                         */
	andl $MASK_G_32, %ecx          /* ecx = dg                          */
	addl LOCAL1, %ebx              /* ebx = drb+irb                     */
	andl $MASK_RB_32, %ebx         /* ebx = (drb+irb)&MRB32             */
	orl  %ebx, %eax                /* eax = a | _r_b                    */
	addl LOCAL2, %ecx              /* ecx = dg+ig                       */
	andl $MASK_G_32, %ecx          /* ecx = (dg+ig)&MG32                */
	orl  %ecx, %eax                /* eax = ar_b | __g_                 */
	movl %eax, -4(%edi)            /* dc = argb                         */

LABEL(pixelsetalpha4_skip_1)
	movl ARG3, %ecx
	shrl $1, %ecx
	jz pixelsetalpha4_end
	punpckldq %mm6, %mm6
	movq GLOBL(__fb_gfx_rb_32), %mm5
	/*                                mm6 = ssss   ssss | ssss   ssss   */
	/*                                mm5 = __xx   __xx | __xx   __xx   */

LABEL(pixelsetalpha4_x_loop)
	movq %mm6, %mm0                /* mm0 = ssss   ssss | ssss   ssss   */
	movq (%edi), %mm1              /* mm1 = dddd   dddd | dddd   dddd   */
	movq %mm0, %mm2                /* mm2 = ssss   ssss | ssss   ssss   */
	movq %mm0, %mm3                /* mm3 = ssss   ssss | ssss   ssss   */
	movq %mm1, %mm4                /* mm4 = dddd   dddd | dddd   dddd   */
	psrld $24, %mm2                /* mm2 = ____ | __aa | ____ | __aa   */
	psrlw $8, %mm3                 /* mm3 = __sa | __sg | __sa | __sg   */
	psrlw $8, %mm4                 /* mm4 = __da | __dg | __da | __dg   */
	packssdw %mm2, %mm2            /* mm2 = __aa | __aa | __aa | __aa   */
	pand %mm5, %mm0                /* mm0 = __sr | __sb | __sr | __sb   */
	pand %mm5, %mm1                /* mm1 = __dr | __db | __dr | __db   */
	punpcklwd %mm2, %mm2           /* mm2 = __aa | __aa | __aa | __aa   */
	psubw %mm1, %mm0               /* mm0 = sr-dr| sb-db| sr-dr| sb-db  */
	psubw %mm4, %mm3               /* mm3 = sa-da| sg-dg| sa-da| sg-dg  */
	pmullw %mm2, %mm0              /* mm0 = rr** | bb** | rr** | bb**   */
	pmullw %mm2, %mm3              /* mm3 = aa** | gg** | aa** | gg**   */
	psraw $8, %mm0                 /* mm0 =   rr |   bb |   rr |   bb   */
	psraw $8, %mm3                 /* mm3 =   aa |   gg |   aa |   gg   */
	paddw %mm1, %mm0               /* mm0 = rr++ | bb++ | rr++ | bb++   */
	paddw %mm4, %mm3               /* mm3 = aa++ | gg++ | aa++ | gg++   */
	pand %mm5, %mm0                /* mm0 = __rr | __bb | __rr | __bb   */
	psllw $8, %mm3                 /* mm3 = ??__ | gg__ | ??__ | gg__   */
	pslld $8, %mm3                 /* mm3 = __gg | ____ | __gg | ____   */
	psrld $8, %mm3                 /* mm3 = ____ | gg__ | ____ | gg__   */
	pslld $24, %mm2                /* mm2 = aa__ | ____ | aa__ | ____   */
	addl $8, %edi
	por %mm3, %mm0                 /* mm0 = __rr | ggbb | __rr | ggbb   */
	por %mm2, %mm0                 /* mm0 = aarr | ggbb | aarr | ggbb   */
	movq %mm0, -8(%edi)            /* dc  = aarr | ggbb | aarr | ggbb   */
	decl %ecx                      /* next 2 pixels                     */
	jnz pixelsetalpha4_x_loop

LABEL(pixelsetalpha4_end)
	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(2)
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutPixelAlpha4MMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	
	movl ARG1, %edi                /* edi = FB_GFXCTX *ctx                */
	movl ARG4, %edx                /* edx = unsigned int color)           */
	movl ARG3, %ecx                /* ecx = int y                         */
	movl ARG2, %eax                /* eax = int x                         */
	movl CTX_LINE(%edi), %ebp      /* ebp = context->line                 */
	movd %edx, %mm1                /* mm1 = | 0000 | 0000 | cacr | cgcb | */
	movl (%ebp, %ecx, 4), %edi     /* edi = context->line[y]              */
	shrl $24, %edx                 /* edx =               | 0000 | 00aa | */
	leal (%edi, %eax, 4), %edi     /* edi = context->line[y][x]           */
	pxor %mm2, %mm2                /* mm2 = | 0000 | 0000 | 0000 | 0000 | */
	movd (%edi), %mm0              /* mm0 = | 0000 | 0000 | dadr | dgdb | */
	movd %edx, %mm3                /* mm3 = | 0000 | 0000 | 0000 | 00aa | */
	punpcklbw %mm2, %mm1           /* mm1 = | __ca | __cr | __cg | __cb | */
	punpcklbw %mm2, %mm0           /* mm0 = | __da | __dr | __dg | __db | */
	punpcklwd %mm3, %mm3           /* mm3 = | ____ | ____ | __aa | __aa | */
	psubw %mm0, %mm1               /* mm1 = |ca-da |cr-dr |cg-dg |cb-db | */
	punpcklwd %mm3, %mm3           /* mm3 = | __aa | __aa | __aa | __aa | */
	psllw $8, %mm0                 /* mm0 = | ca__ | cr__ | cg__ | cb__ | */
	pmullw %mm3, %mm1              /* mm1 = | aa** | rr** | gg** | bb** | */
	paddw %mm1, %mm0               /* mm0 = | aa++ | rr++ | gg++ | bb++ | */
	psrlw $8, %mm0                 /* mm0 = | __aa | __rr | __gg | __bb | */
	packuswb %mm0, %mm0            /* mm0 = | aarr | ggbb | aarr | ggbb | */
	movd %mm0, %eax                /* eax =               | xxrr | ggbb | */
	shll $24, %edx                 /* edx =               | aa00 | 0000 | */
	shll $8, %eax                  /* eax =               | rrgg | gg__ | */
	shrl $8, %eax                  /* eax =               | 00rr | ggbb | */
	or %edx, %eax                  /* eax =               | aarr | ggbb | */
	movl %eax, (%edi)              /* dst =               | aarr | ggbb | */

	emms
	popl %edi
	popl %ebp
	ret


/*:::::*/
FUNC(fb_hPutAlphaMaskMMX)
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %ebx

	movl ARG3, %ebx
	movl ARG6, %edx
	subl %ebx, ARG5
	pxor %mm7, %mm7
	shll $2, %ebx
	movl ARG2, %edi
	subl %ebx, %edx
	movl ARG1, %esi
	movl ARG4, %ebx
	movq GLOBL(__fb_gfx_rgb_32), %mm6

LABEL(alpha_mask_y_loop)
	movl ARG3, %ecx
	pxor %mm7, %mm7
	shrl $1, %ecx
	jnc alpha_mask_skip_1
	
	lodsb
	shll $24, %eax
	andl $MASK_RGB_32, (%edi)
	orl %eax, (%edi)
	addl $4, %edi

LABEL(alpha_mask_skip_1)
	shrl $1, %ecx
	jnc alpha_mask_skip_2
	
	lodsw
	movq (%edi), %mm1
	movd %eax, %mm0
	punpcklbw %mm7, %mm0
	punpcklwd %mm7, %mm0
	pslld $24, %mm0
	pand GLOBL(__fb_gfx_rgb_32), %mm1
	addl $8, %edi
	por %mm0, %mm1
	movq %mm1, -8(%edi)

LABEL(alpha_mask_skip_2)
	shrl $1, %ecx
	jnc alpha_mask_skip_4
	
	lodsl
	movq (%edi), %mm2
	movd %eax, %mm0
	movq 8(%edi), %mm3
	punpcklbw %mm7, %mm0
	addl $16, %edi
	movq %mm0, %mm1
	punpcklwd %mm7, %mm0
	punpckhwd %mm7, %mm1
	pslld $24, %mm0
	pslld $24, %mm1
	pand GLOBL(__fb_gfx_rgb_32), %mm2
	pand GLOBL(__fb_gfx_rgb_32), %mm3
	por %mm0, %mm2
	por %mm1, %mm3
	movq %mm2, -16(%edi)
	movq %mm3, -8(%edi)

LABEL(alpha_mask_skip_4)
	orl %ecx, %ecx
	jz alpha_mask_next_line

LABEL(alpha_mask_x_loop)
	movq (%esi), %mm0
	movq (%esi), %mm2
	punpcklbw %mm7, %mm0
	punpckhbw %mm7, %mm2
	movq %mm0, %mm1
	movq %mm2, %mm3
	punpcklwd %mm7, %mm0
	punpckhwd %mm7, %mm1
	punpcklwd %mm7, %mm2
	punpckhwd %mm7, %mm3
	movq (%edi), %mm4
	movq 8(%edi), %mm5
	movq 16(%edi), %mm6
	movq 24(%edi), %mm7
	pslld $24, %mm0
	pslld $24, %mm1
	pslld $24, %mm2
	pslld $24, %mm3
	addl $32, %edi
	addl $8, %esi
	pand GLOBL(__fb_gfx_rgb_32), %mm4
	pand GLOBL(__fb_gfx_rgb_32), %mm5
	pand GLOBL(__fb_gfx_rgb_32), %mm6
	pand GLOBL(__fb_gfx_rgb_32), %mm7
	por %mm0, %mm4
	por %mm1, %mm5
	por %mm2, %mm6
	por %mm3, %mm7
	movq %mm4, -32(%edi)
	movq %mm5, -24(%edi)
	movq %mm6, -16(%edi)
	movq %mm7, -8(%edi)
	decl %ecx
	jnz alpha_mask_x_loop
	
LABEL(alpha_mask_next_line)
	addl ARG5, %esi
	addl %edx, %edi
	decl %ebx
	jnz alpha_mask_y_loop
	
	emms
	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	ret


FUNC(fb_MMX_code_end)
