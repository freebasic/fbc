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
#define LOCAL2			-8(%ebp)
#define LOCAL3			-12(%ebp)

#define MASK_COLOR_32		0xFF00FF
#define MASK_COLOR_16		0xF81F

#define MODE_NUM		0
#define PAGE			4
#define NUM_PAGES		8
#define WORK_PAGE		12
#define FRAMEBUFFER		16
#define LINE			20
#define PITCH			24
#define TARGET_PITCH		28
#define LAST_TARGET		32
#define MAX_H			36
#define BPP			40
#define PALETTE			44
#define DEVICE_PALETTE		48
#define COLOR_ASSOCIATION	52
#define DIRTY			56
#define DRIVER			60
#define MODE_W			64
#define MODE_H			68
#define DEPTH			72
#define COLOR_MASK		76
#define DEFAULT_PALETTE		80
#define SCANLINE_SIZE		84
#define FG_COLOR		88
#define BG_COLOR		92
#define LAST_X			96
#define LAST_Y			100
#define CURSOR_X		104
#define CURSOR_Y		108
#define FONT			112
#define VIEW_X			116
#define VIEW_Y			120
#define VIEW_W			124
#define VIEW_H			128
#define WIN_X			132
#define WIN_Y			136
#define WIN_W			140
#define WIN_H			144
#define TEXT_W			148
#define TEXT_H			152
#define KEY			156
#define FLAGS			160


#endif
