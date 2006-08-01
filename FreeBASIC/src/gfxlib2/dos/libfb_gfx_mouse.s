/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * libfb_gfx_mouse.s -- dos mouse isr
 *
 * chng: jul/2006 written [DrV]
 *
 */

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
