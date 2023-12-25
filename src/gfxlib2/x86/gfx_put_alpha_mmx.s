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

	/* ARG1: unsigned char *src   */
	/* ARG2: unsigned char *dest  */
	/* ARG3: int w                */
	/* ARG4: int h                */
	/* ARG5: int src_pitch        */
	/* ARG6: int dest_pitch       */
	/* ARG7: int alpha            */
	/* ARG8: BLENDER *blender     */
	/* ARG9: void *param          */
	
	movl ARG3, %ebx                /* ebx = w                           */
	shll $2, %ebx                  /* ebx = w * 4                       */
	movl ARG4, %edx                /* edx = h                           */
	subl %ebx, ARG5                /* src_pitch = src_pitch - w * 4     */
	movl %edx, LOCAL1              /* LOCAL1 = h                        */
	movl ARG1, %esi                /* esi = src                         */
	movl ARG6, %edx                /* edx = dest_pitch                  */
	movl ARG2, %edi                /* edi = dst                         */
	subl %ebx, %edx                /* edx = dest_pitch - w * 4          */
	movl %edx, LOCAL2              /* LOCAL2 = dest_pitch - w * 4       */
	movq GLOBL(__fb_gfx_rb_32), %mm5

LABEL(alpha4_y_loop)
	movl ARG3, %ecx                /* ecx = w                           */
	shrl $1, %ecx                  /* ecx = w \ 2                       */
	jnc alpha4_skip_1              /* if w \ 2 mod 2 = 0 skip           */
	addl $4, %edi                  /* dst += 4                          */
	lodsl                          /* eax = *src                        */
	movl %eax, LOCAL3              /* LOCAL3 = *src                     */
	movl -4(%edi), %ebx            /* ebx = *dst                        */
	movl %eax, %ecx                /* ecx = *src                        */
	movl %ebx, %edx                /* edx = *dst                        */
	andl $MASK_RB_32, %eax         /* eax = __sr__sb     (srb)          */
	andl $MASK_RB_32, %edx         /* edx = __dr__db     (drb)          */
	shrl $24, LOCAL3               /* LOCAL3 = ______aa  (*src alpha)   */
	subl %edx, %eax                /* eax = __sr__sb - __dr__db         */
	imull LOCAL3                   /* eax = (srb - drb) * a             */
	xchg %eax, %ecx                /* ecx = (srb - drb) * a, eax = *src */
	movl %ebx, %edx                /* edx = *dst                        */
	andl $MASK_GA_32, %eax         /* eax = sa__sg__     (sga)          */
	andl $MASK_GA_32, %edx         /* edx = da__dg__     (dga)          */
	subl %edx, %eax                /* eax = sa__sg__ - da__dg__         */
	shrl $8, %eax                  /* eax = (sga - dga) >> 8            */
	imull LOCAL3                   /* eax = ((sga - dga) >> 8) * a      */
	shrl $8, %ecx                  /* ecx = ((srb - drb) * a) >> 8      */
	movl %ebx, %edx                /* edx = *dst                        */
	andl $MASK_RB_32, %ebx         /* ebx = __dr__db                    */
	andl $MASK_GA_32, %edx         /* edx = aa__gg__                    */
	addl %ecx, %ebx                /* ebx += ((srb - drb) * a) >> 8     */
	addl %edx, %eax                /* eax += aa__gg__                   */
	andl $MASK_RB_32, %ebx         /* ebx = __rr__bb                    */
	andl $MASK_GA_32, %eax         /* eax = aa__gg__                    */
	orl %ebx, %eax                 /* eax == aarrggbb                   */
	movl %eax, -4(%edi)            /* *(dst-4) = aarrggbb               */

LABEL(alpha4_skip_1)
	movl ARG3, %ecx                /* ecx = w                           */
	shrl $1, %ecx                  /* ecx = w \ 2                       */
	jz alpha4_next_line            /* if w \ 2 = 0 next line            */


	movq %mm6, %mm0                /* mm0 = ssss   ssss | ssss   ssss   */
	movq (%edi), %mm1              /* mm1 = dddd   dddd | dddd   dddd   */
	movq %mm0, %mm2                /* mm2 = ssss   ssss | ssss   ssss   */
	movq %mm0, %mm3                /* mm3 = ssss   ssss | ssss   ssss   */
	movq %mm1, %mm4                /* mm4 = dddd   dddd | dddd   dddd   */
	psrld $24, %mm2                /* mm2 = ____ | __aa | ____ | __aa   */
	psrlw $8, %mm3                 /* mm3 = __sa | __sg | __sa | __sg   */
	psrlw $8, %mm4                 /* mm4 = __da | __dg | __da | __dg   */
	packssdw %mm2, %mm2            /* mm2 = __aa | __aa | __aa | __aa   */

LABEL(alpha4_x_loop)
	movq (%esi), %mm0              /* mm0 = ssss   ssss | ssss   ssss   */
	movq (%edi), %mm1              /* mm1 = dddd   dddd | dddd   dddd   */
	movq %mm0, %mm2                /* mm2 = ssss   ssss | ssss   ssss   */
	movq %mm0, %mm3                /* mm3 = ssss   ssss | ssss   ssss   */
	movq %mm1, %mm4                /* mm4 = dddd   dddd | dddd   dddd   */
	psrld $24, %mm2                /* mm2 = ____ | __sa | ____ | __sa   */
	psrlw $8, %mm3                 /* mm3 = __sa | __sg | __sa | __sg   */
	psrlw $8, %mm4                 /* mm4 = __da | __dg | __da | __dg   */
	packssdw %mm2, %mm2            /* mm2 = __sa | __sa | __sa | __sa   */
	pand %mm5, %mm0                /* mm0 = __sr | __sb | __sr | __sb   */
	pand %mm5, %mm1                /* mm1 = __dr | __db | __dr | __db   */
	punpcklwd %mm2, %mm2           /* mm2 = __sa | __sa | __sa | __sa   */
	psubw %mm1, %mm0               /* mm0 = sr-dr| sb-db| sr-dr| sb-db  */
	psubw %mm4, %mm3               /* mm3 = sa-da| sg-dg| sa-da| sg-dg  */
	pmullw %mm2, %mm0              /* mm0 = rr** | bb** | rr** | bb**   */
	pmullw %mm2, %mm3              /* mm3 = aa** | gg** | aa** | gg**   */
	psraw $8, %mm0                 /* mm0 = __rr | __bb | __rr | __bb   */
	psraw $8, %mm3                 /* mm3 = __aa | __gg | __aa | __gg   */
	paddw %mm1, %mm0               /* mm0 = rr++ | bb++ | rr++ | bb++   */
	paddw %mm4, %mm3               /* mm3 = aa++ | gg++ | aa++ | gg++   */
	pand %mm5, %mm0                /* mm9 = __rr | __bb | __rr | __bb   */
	psllw $8, %mm3                 /* mm3 = aa__ | gg__ | aa__ | gg__   */
	addl $8, %edi                  /* dst += 8                          */
	por %mm3, %mm0                 /* mm0 = aarr   ggbb | aarr   ggbb   */
	addl $8, %esi                  /* src += 8                          */
	movq %mm0, -8(%edi)            /* *(dst-1) = argb, argb             */
	decl %ecx                      /* w -= 1                            */
	jnz alpha4_x_loop              /* if w != 0 goto alpha4_x_loop      */

LABEL(alpha4_next_line)
	addl ARG5, %esi                /* src += src_pitch - w * 4          */
	addl LOCAL2, %edi              /* dst += dest_pitch - w * 4         */
	decl LOCAL1                    /* h -= 1                            */
	jnz alpha4_y_loop              /* if h != 0 goto alpha4_y_loop      */

	emms
	popl %ebx
	popl %edi
	popl %esi
	FREE_LOCALS(3)
	popl %ebp
	ret
