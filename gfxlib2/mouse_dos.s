/* dos mouse isr */

.intel_syntax noprefix


#define FUNC(name)              .globl _##name ; .balign 8, 0x90 ; _##name :
#define GLOBL(name)             _##name
#define LABEL(name)             .balign 4, 0x90 ; name :

.section .text

FUNC(fb_dos_mouse_isr_start)

/* mouse location and button status */

FUNC(fb_dos_mouse_x)
	.word 0

FUNC(fb_dos_mouse_y)
	.word 0

FUNC(fb_dos_mouse_z)
	.word 0

FUNC(fb_dos_mouse_buttons)
	.byte 0


/* mouse user interrupt routine */

FUNC(fb_dos_mouse_isr)
	
	/* set up real mode return address (simulate real-mode retf) */
	mov eax, [esi]
	mov es:[edi + 42], eax
	add word ptr es:[edi + 46], 4
	
	/* store mouse location and status */

	push ds
	mov ax, cs:[___djgpp_app_DS]
	mov ds, ax
	
	mov ax, es:[edi + 0x18]
	mov [GLOBL(fb_dos_mouse_x)], ax
	
	mov ax, es:[edi + 0x14]
	mov [GLOBL(fb_dos_mouse_y)], ax
	
	mov ax, es:[edi + 0x10]
	mov [GLOBL(fb_dos_mouse_buttons)], al
	movsx ax, ah
	sub [GLOBL(fb_dos_mouse_z)], ax
	
	pop ds
	
	iret


FUNC(fb_dos_mouse_isr_end)

.end
