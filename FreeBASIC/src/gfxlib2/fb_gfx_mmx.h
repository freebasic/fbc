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

#if defined TARGET_WIN32 || defined TARGET_DOS
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

#define MODE_NUM		0
#define PAGE			4
#define NUM_PAGES		8
#define FRAMEBUFFER		12
#define LINE			16
#define PITCH			20
#define BPP			24
#define PALETTE			28
#define COLOR_ASSOCIATION	32
#define DIRTY			36
#define DRIVER			40
#define MODE_W			44
#define MODE_H			48
#define DEPTH			52
#define COLOR_MASK		56
#define DEFAULT_PALETTE		60
#define SCANLINE_SIZE		64
#define FG_COLOR		68
#define BG_COLOR		72
#define LAST_X			76
#define LAST_Y			80
#define CURSOR_X		84
#define CURSOR_Y		88
#define FONT			92
#define VIEW_X			96
#define VIEW_Y			100
#define VIEW_W			104
#define VIEW_H			108
#define WIN_X			112
#define WIN_Y			116
#define WIN_W			120
#define WIN_H			124
#define TEXT_W			128
#define TEXT_H			132
#define KEY			136
#define FLAGS			140


#endif
