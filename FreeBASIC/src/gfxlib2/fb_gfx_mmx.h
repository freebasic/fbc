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
 * fb_gfx_mmx.h -- assembler definitions for MMX routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#ifndef __FB_GFX_MMX_H__
#define __FB_GFX_MMX_H__

#ifdef WIN32
#define FUNC(name)		.globl _##name ; .balign 8, 0x90 ; _##name:
#define GLOBL(name)		_##name
#else
#define FUNC(name)		.globl name ; .balign 8, 0x90 ; name:
#define GLOBL(name)		name
#endif
#define LABEL(name)		.balign 4, 0x90 ; name :

#define RESERVE_LOCALS(n)	subl $((n)*4), %esp
#define FREE_LOCALS(n)		addl $((n)*4), %esp

#define ARG1			8(%ebp)
#define ARG2			12(%ebp)
#define ARG3			16(%ebp)
#define ARG4			20(%ebp)
#define ARG5			24(%ebp)

#define LOCAL1			-4(%ebp)

#define MASK_COLOR_32		0xFF00FF
#define MASK_COLOR_16		0xF81F

#define PAGE			0
#define NUM_PAGES		4
#define FRAMEBUFFER		8
#define LINE			12
#define PITCH			16
#define BPP			20
#define PALETTE			24
#define DIRTY			28
#define DRIVER			32
#define MODE_W			36
#define MODE_H			40
#define DEPTH			44
#define COLOR_MASK		48
#define DEFAULT_PALETTE		52
#define SCANLINE_SIZE		56
#define FG_COLOR		60
#define BG_COLOR		64
#define LAST_X			68
#define LAST_Y			72
#define CURSOR_X		76
#define CURSOR_Y		80
#define FONT			84
#define VIEW_X			88
#define VIEW_Y			92
#define VIEW_W			96
#define VIEW_H			100
#define WIN_X			104
#define WIN_Y			108
#define WIN_W			112
#define WIN_H			116
#define TEXT_W			120
#define TEXT_H			124
#define KEY			128
#define FLAGS			132


#endif
