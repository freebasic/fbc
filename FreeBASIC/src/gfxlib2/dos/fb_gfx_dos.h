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
 * fb_gfx_dos.h -- DOS gfxlib include file
 *
 * chng: apr/2005 written [DrV]
 *
 */

#ifndef __FB_GFX_DOS_H__
#define __FB_GFX_DOS_H__

#include "../fb_gfx.h"

#include <conio.h>
#include <dpmi.h>
#include <go32.h>
#include <pc.h>
#include <sys/farptr.h>
#include <sys/movedata.h>

#include "vga.h"
#include "vesa.h"

/* macros */

#define MASK_LINEAR(addr)   ((addr) & 0x000FFFFF)
#define RM_TO_LINEAR(addr)  ((((addr) & 0xFFFF0000) >> 12) + ((addr) & 0xFFFF))
#define RM_OFFSET(addr)     ((addr) & 0xF)
#define RM_SEGMENT(addr)    (((addr) >> 4) & 0xFFFF)

#define SCREENLIST(w, h) ((h) | (w) << 16)


/* globals */

typedef struct fb_dos_pal_t {
	unsigned char r;
	unsigned char g;
	unsigned char b;
	unsigned char pad;
} fb_dos_pal_t;

typedef struct fb_dos_t {
	
	int w;
	int h;
	int depth;
	int refresh;
	
	fb_dos_pal_t pal[256];
	int pal_dirty;
	
	int inited;
	int detected;
	int locked;
	int in_interrupt;
	
	int old_rows;
	int old_cols;
	
	int mouse_ok;
	int mouse_wheel_ok;
	int mouse_cursor;
	int mouse_x;
	int mouse_y;
	int mouse_z;
	int mouse_buttons;
	
	void (*update)(void);
	unsigned int update_len;
	
	void (*draw_mouse)(void);
	void (*undraw_mouse)(void);
	void (*set_palette)(void);
	
	__dpmi_regs regs;
	
	_go32_dpmi_seginfo old_kb_int;
	_go32_dpmi_seginfo new_kb_int;
	_go32_dpmi_seginfo old_timer_int;
	_go32_dpmi_seginfo new_timer_int;
	
	int vesa_ok;
	VbeInfoBlock vesa_info;
	VesaModeInfo vesa_mode_info;
	VesaModeInfo *vesa_modes;
	int num_vesa_modes;
	
	int nearptr_ok;
	
	int Bpp; /* **bytes** per pixel */
	unsigned int w_bytes;	/* bytes per scanline */
	size_t size;
	
} fb_dos_t;

extern fb_dos_t fb_dos;

/* mouse */

extern int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons);
extern void fb_dos_set_mouse(int x, int y, int cursor);
extern void fb_dos_update_mouse(void);

/* VGA */

extern void fb_dos_vga_wait_vsync(void);
extern void fb_dos_vga_set_palette(void);

/* shared */

extern void fb_dos_set_palette(int idx, int r, int g, int b);
extern void fb_dos_detect(void);
extern void fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_dos_exit(void);
extern void fb_dos_set_window_title(char *title);
extern void fb_dos_lock(void);
extern void fb_dos_unlock(void);

#endif	/* #ifndef __FB_GFX_DOS_H__ */
