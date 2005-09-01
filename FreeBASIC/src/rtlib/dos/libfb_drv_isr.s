        .intel_syntax noprefix
        
        /* This is the ISR handler. It has to be written in ASM because
         * GCC doesn't know something like __declspec(naked) or __interrupt
         * for x86 targets.
         */

#define FUNC(name)              .globl _##name ; .balign 8, 0x90 ; _##name :
#define GLOBL(name)             _##name
#define LABEL(name)             .balign 4, 0x90 ; name :

.section .text

FUNC(fb_hDrvIntHandler_start)

/* This stores all pointers to the old IRQ handlers */
FUNC(fb_hDrvIntHandler_OldIRQs)
        .fill 16, 8, 0

/* This stores all pointers to the current IRQ handlers */
FUNC(fb_hDrvIntHandler)
        .fill 16, 4, 0

/* This stores all ISR stack informations (position and size) */
FUNC(fb_hDrvIntStacks)
        .fill 16, 8, 0

/* DS selector */
FUNC(fb_hDrvSelectors)
        .fill 5, 4, 0








.macro fb_hDrvIntHandler_STD INT_HANDLER_NAME, PIC_PORT_BASE
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
        lea eax, [GLOBL(fb_hDrvIntHandler_OldIRQs) + ebx * 8]
        lea ecx, [GLOBL(fb_hDrvIntHandler) + ebx * 4]

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
        mov eax, cs:[GLOBL(fb_hDrvSelectors) + 12]
        mov gs, ax
        mov eax, cs:[GLOBL(fb_hDrvSelectors) + 8]
        mov fs, ax
        mov eax, cs:[GLOBL(fb_hDrvSelectors) + 4]
        mov es, ax
        mov eax, cs:[GLOBL(fb_hDrvSelectors)]
        mov ds, ax
        
        /* Switch to user-stack */
        mov edi, esp
        mov ax, ss
        nop
        
        lea esi, [GLOBL(fb_hDrvIntStacks) + ebx * 8]
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

        /* As a nice feature, the ISR gets the interrupt number as first
         * argument */
        push ebx

        /* The ISR's CS is the same as the applications CS so it's OK to
         * do a near call here ... */
        call edx

        /* Remove all arguments from stack */
        add esp, 4

        /* Restore old stack segment/offset */
        pop edi               /* Old stack offset */
        pop edx               /* Old stack segment */
        mov ss, dx
        mov esp, edi
        nop                   /* Might be required for some strange CPUs */

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

        sti         /* IRET doesn't restore the I flag in "virtual" mode
                     * so we have to restore it ourselves */

        iret        /* We're done */
.endm





fb_hDrvIntHandler_STD  fb_hDrvIntHandler_PIC1, 0x20
fb_hDrvIntHandler_STD  fb_hDrvIntHandler_PIC2, 0xA0

FUNC(fb_hDrvIntHandler_end)

.end

