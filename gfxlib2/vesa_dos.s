/* vesa support functions */

.intel_syntax noprefix


#define FUNC(name)              .globl _##name ; .balign 8, 0x90 ; _##name :
#define GLOBL(name)             _##name
#define LABEL(name)             .balign 4, 0x90 ; name :

.section .text

/* protected-mode bank switcher */

FUNC(fb_dos_vesa_set_bank_pm)
	
	mov ecx, GLOBL(fb_dos_vesa_pm_bank_switcher)    /* ecx = pointer to pm bank switching code in our address space */
	xor ebx, ebx                                    /* set window A (bh = 00h, bl = 00h) */
	mov edx, GLOBL(fb_dos_vesa_bank_number)         /* window offset in window granularity units */
	call ecx
	ret

FUNC(fb_dos_vesa_set_bank_pm_end)

.end
