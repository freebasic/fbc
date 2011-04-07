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
 * libfb_gfx_vesa.s -- vesa support functions
 *
 * chng: oct/2006 written [DrV]
 *
 */

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
