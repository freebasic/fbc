        .intel_syntax noprefix
        
        /* This is the ISR handler for DOS. It has to be written in ASM because
         * DJGPP/GCC doesn't know something like __declspec(naked) or
         * __interrupt for x86 targets.
         */

#define FUNC(name)              .globl _##name ; .balign 8, 0x90 ; _##name :
#define GLOBL(name)             _##name
#define LABEL(name)             .balign 4, 0x90 ; name :

.section .text

FUNC(__fb_hDrvIntHandler_start)

/* This stores all pointers to the old IRQ handlers */
FUNC(__fb_hDrvIntHandler_OldIRQs)
        .fill 16, 8, 0

/* This stores all pointers to the current IRQ handlers */
FUNC(__fb_hDrvIntHandler)
        .fill 16, 4, 0

/* This stores all ISR stack informations (position and size) */
FUNC(__fb_hDrvIntStacks)
        .fill 16, 8, 0

/* This stores a flag for all ISR's that shows if the ISR was called
 * -> nested IRQs */
FUNC(fb_hDrvIntInISR)
        .fill 16, 1, 0

/* DS selector */
FUNC(__fb_hDrvSelectors)
        .fill 5, 4, 0

/* DOS cli level for nested CLI/STI */
FUNC(__fb_dos_cli_level)
        .fill 1, 4, 0





FUNC(fb_dos_cli)
	push eax

	mov eax, [GLOBL(__fb_dos_cli_level)]
	inc dword ptr [GLOBL(__fb_dos_cli_level)]
	test eax, eax
	jnz 1f
	cli
1:
	pop eax
	ret

FUNC(fb_dos_sti)
	push eax

	dec dword ptr [GLOBL(__fb_dos_cli_level)]
	mov eax, [GLOBL(__fb_dos_cli_level)]
	test eax, eax
	jnz 1f
	sti
1:
	pop eax
	ret





.macro __fb_hDrvIntHandler_STD INT_HANDLER_NAME, PIC_PORT_BASE
/* Interrupt handler for PIC1 */
FUNC(\INT_HANDLER_NAME)
	/* Reserve space for the address of the old ISR */
	sub esp, 8

	/* Backup some variables this ISR might modify */
	pushad

	/* Get the mask of emitted interrupts */
	mov al, 0x0B
	out \PIC_PORT_BASE, al
	in al, \PIC_PORT_BASE

	/* Find the first bit set */
	bsf ebx, eax
	jz 9f                 /* No interrupt bit set ... do an EOI our own */

.ifeq \PIC_PORT_BASE-0xA0
	add ebx, 8            /* Adjust offset by 8 for PIC2 */
.endif

	/* Calculate offsets to the pointers to the ISRs */
	lea eax, [GLOBL(__fb_hDrvIntHandler_OldIRQs) + ebx * 8]
	lea ecx, [GLOBL(__fb_hDrvIntHandler) + ebx * 4]

	/* Test if the ISR is already executed to avoid clobbering of
	 * ISR stack */
	mov dl, cs:[GLOBL(fb_hDrvIntInISR) + ebx]
	test dl, dl
	jnz 2f

	/* Test if the we have a service-routine for this IRQ
	 * IOW: When the ISR pointer is NULL, we call the old ISR directly
	 */
	mov edx, cs:[ecx]       /* Test offset */
	test edx, edx
	jz 2f

1:
	/* We have a user-defined IRQ handler ... so we have to call our own
	 * first and then we've to call the old one ... */
	push eax

	/* Backup selectors */
	push ds
	push es
	push fs
	push gs

	/* Load the applications selectors */
	mov eax, cs:[GLOBL(__fb_hDrvSelectors) + 12]
	mov gs, ax
	mov eax, cs:[GLOBL(__fb_hDrvSelectors) + 8]
	mov fs, ax
	mov eax, cs:[GLOBL(__fb_hDrvSelectors) + 4]
	mov es, ax
	mov eax, cs:[GLOBL(__fb_hDrvSelectors)]
	mov ds, ax
        
	/* Switch to user-stack */
	mov edi, esp
	mov ax, ss
	nop
        
	lea esi, [GLOBL(__fb_hDrvIntStacks) + ebx * 8]
	mov ecx, [esi]        /* Stack offset */
	test ecx, ecx
	jz 3f                 /* OFFSET==0 -> no stack switch */

	add ecx, [esi + 4]    /* Add stack size to stack offset */
        
	/* Set the new stack ...
	 * It seems to be legal to use the DS selector here ... */
	mov si, ds
	mov ss, si
	mov esp, ecx
	nop

3:
	push eax              /* Push old stack segment */
	push edi              /* Push old stack offset */
	push ebx              /* Make a copy of the IRQ number */

	/* Set the "in ISR" flag */
	mov al, 1
	mov [GLOBL(fb_hDrvIntInISR) + ebx], al

	/* Ensure that fb_dos_cli and fb_dos_sti work as expected and
	 * don't enable IF acciedentally */
	inc dword ptr [GLOBL(__fb_dos_cli_level)]

	/* Save FPU state */
	sub esp, 108
	fnsave [esp]

	/* As a nice feature, the ISR gets the interrupt number as first
	 * argument */
	push ebx

	/* The ISR's CS is the same as the applications CS so it's OK to
	 * do a near call here ... */
	call edx

	/* Remove all arguments from stack */
	add esp, 4

	/* Restore FPU state */
	frstor [esp]
	add esp, 108

	pop ebx               /* Restore the IRQ number */

	/* Test if the "__fb_dos_cli_level" was reset manually in the ISR.
	 * This is a tweak to allow debugging of ISRs. */
	mov edx, [GLOBL(__fb_dos_cli_level)]
	test edx, edx
	jz 4f

	/* Reset the CLI level */
	dec dword ptr [GLOBL(__fb_dos_cli_level)]

4:
	/* Restore old stack segment/offset */
	pop edi               /* Old stack offset */
	pop edx               /* Old stack segment */
	mov ss, dx
	mov esp, edi
	nop                   /* Might be required for some strange CPUs */

	/* Reset the "in ISR" flag. We must reset it after we restored
	 * the ISR stack pointers */
	mov dl, 0
	mov [GLOBL(fb_hDrvIntInISR) + ebx], dl

	/* Restore the selectors to the values they had at ISR entry */
	pop gs
	pop fs
	pop es
	pop ds
        
	/* FALSE = continue with old ISR 
	 * TRUE  = don't continue with old ISR
	 *       = signal that ISR was processed completely
	 */
	test eax, eax

	/* Restoring the pointer to the old ISR address ... */
	pop eax
        
	/* Jump for the previous compare ... pop doesn't change the
	 * flags */
	jnz 9f

2:
	/* Store the target address to the space reserved at the beginning
	 * of this ISR */
	movzx ecx, word ptr cs:[eax + 4]   /* selector */
	mov eax, cs:[eax]                  /* offset */
	mov ss:[esp + 0x20], eax
	mov ss:[esp + 0x24], ecx

	/* Call the original ISR */
	popad
	lret

9:
	/* Emit non-specific EOI (End-Of-Interrupt) */
	mov al, 0x20
.ifeq \PIC_PORT_BASE-0xA0
	out 0x20, al          /* Don't forget to send EOI to PIC1 too */
.endif
	out \PIC_PORT_BASE, al

	/* Restore the values of all registers */
	popad

	/* Reserved space was unused ... */
	add esp, 8

	/* Turn it on regardless of the current "__fb_dos_cli_level" value */
	sti         /* IRET doesn't restore the I flag in "virtual" mode
	             * so we have to restore it ourselves */

	iret        /* We're done */
.endm





__fb_hDrvIntHandler_STD  __fb_hDrvIntHandler_PIC1, 0x20
__fb_hDrvIntHandler_STD  __fb_hDrvIntHandler_PIC2, 0xA0

FUNC(__fb_hDrvIntHandler_end)

.end
