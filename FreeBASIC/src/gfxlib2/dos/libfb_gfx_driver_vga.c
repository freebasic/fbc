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
 * libfb_gfx_driver_vga.c -- direct VGA hardware gfx driver for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include "fb_gfx.h"


#include <stdlib.h>
#include <go32.h>
#include <dpmi.h>
#include <pc.h>
#include <sys/farptr.h>
#include <sys/movedata.h>

#define WRITE_ALL_PLANES	(0x0F)
#define WRITE_PLANE_1		(0x01)
#define WRITE_PLANE_2		(0x02)
#define WRITE_PLANE_3		(0x04)
#define WRITE_PLANE_4		(0x08)

#define READ_PLANE_1		(0x00)
#define READ_PLANE_2		(0x01)
#define READ_PLANE_3		(0x02)
#define READ_PLANE_4		(0x03)

#define VIDEO	(0x10)
#define MOUSE	(0x33)

/*** helper procs ***/

void vga_set_write_planes(int planes);
void vga_set_read_plane(int plane);

/*** mouse procs ***/

int vga_mouse_init(void);
void vga_mouse_set_range(int minx, int miny, int maxx, int maxy);

/*** mode-specific procs ***/

/* 1-bpp modes */
void vga_1_cls(void);
void vga_1_pset(int x, int y, int c);

/* 4-bpp modes */
void vga_4_cls(void);
void vga_4_pset(int x, int y, int c);

/* 8-bpp chain4 modes (13h, mode-q) */
void vga_8_cls(void);
void vga_8_pset(int x, int y, int c);

/* 8-bpp unchained modes (mode-x) */
void vga_x_cls(void);
void vga_x_pset(int x, int y, int c);

/*** mode data ***/

typedef struct _vga_tweak_t {
	int port;
	int index;
	int value;
} vga_tweak_t;

typedef struct _vga_vtable_t {
	void (*cls)(void);
	void (*pset)(int x, int y, int c);
} vga_vtable_t;

/* vga_mode_t flags */
#define VM_PLANAR		0x00000001
#define VM_X			0x00000002

typedef struct _vga_mode_t {
	int w;
	int h;
	int bpp;
	int mode;
	int flags;
	int phys_w;
	unsigned long addr;
	vga_tweak_t *tweaks;
	vga_vtable_t *vtable;
} vga_mode_t;

/* NO_VAL in vga_tweak_t.value causes an outportb instead of outportw */
#define NO_VAL	0x100

static vga_tweak_t vga_modeq[] = {
	{0x3D4, 0x00, 0x5F},	/* horizontal total */
	{0x3D4, 0x01, 0x3F},	/* horizontal display enable end */
	{0x3D4, 0x02, 0x40},	/* blank start */
	{0x3D4, 0x03, 0x82},	/* blank end */
	{0x3D4, 0x04, 0x4E},	/* retrace start */
	{0x3D4, 0x05, 0x9A},	/* retrace end */
	{0x3D4, 0x06, 0x23},	/* vertical total */
	{0x3D4, 0x07, 0xB2},	/* overflow register */
	{0x3D4, 0x08, 0x00},	/* preset row scan */
	{0x3D4, 0x09, 0x61},	/* max scan line/char height */
	{0x3D4, 0x10, 0x0A},	/* vertical retrace start */
	{0x3D4, 0x11, 0xAC},	/* vertical retrace end */
	{0x3D4, 0x12, 0xFF},	/* vertical display enable end */
	{0x3D4, 0x13, 0x20},	/* offset/logical width */
	{0x3D4, 0x14, 0x40},	/* underline location */
	{0x3D4, 0x15, 0x07},	/* vertical blank start */
	{0x3D4, 0x16, 0x17},	/* vertical blank end */
	{0x3D4, 0x17, 0xA3},	/* mode control */
	{0x3C4, 0x01, 0x01},	/* clock mode */
	{0x3C4, 0x04, 0x0E},	/* memory mode */
	{0x3CE, 0x05, 0x40},	/* mode register */
	{0x3CE, 0x06, 0x05},	/* misc. register */
	{0x3C0, 0x30, 0x41},	/* mode control */
	{0,	0,	0}	/* end of list */
};

static vga_tweak_t vga_12[] = {
	{0x3CE, 0x04, NO_VAL},	/* graphics address register */
	{0x3C4, 0x02, NO_VAL},	/* sequential memory mode */
	{0,	0,	0}	/* end of list */
};

/* tweaked mode 12 by Adigun Azikiwe Polack */
static vga_tweak_t vga_12_512x480[] = {
	{0x3C2, 0xE3, NO_VAL},	/* dot clock */
	{0x3D4, 0x00, 0x5F},	/* horizontal total */
	{0x3D4, 0x01, 0x3F},	/* horizontal display enable end */
	{0x3D4, 0x02, 0x42},	/* blank start */
	{0x3D4, 0x03, 0x9F},	/* blank end */
	{0x3D4, 0x04, 0x4C},	/* retrace start */
	{0x3D4, 0x05, 0x00},	/* retrace end */
	{0, 0, 0}		/* end of list */
};

/* mode-x 320x240 */
static vga_tweak_t vga_x_320x240[] = {
   { 0x3C2, 0x0,  0xE3 },  { 0x3D4, 0x0,  0x5F },  { 0x3D4, 0x1,  0x4F },
   { 0x3D4, 0x2,  0x50 },  { 0x3D4, 0x3,  0x82 },  { 0x3D4, 0x4,  0x54 },
   { 0x3D4, 0x5,  0x80 },  { 0x3D4, 0x6,  0xD  },  { 0x3D4, 0x7,  0x3E },
   { 0x3D4, 0x8,  0x0  },  { 0x3D4, 0x9,  0x41 },  { 0x3D4, 0x10, 0xEA },
   { 0x3D4, 0x11, 0xAC },  { 0x3D4, 0x12, 0xDF },  { 0x3D4, 0x14, 0x0  }, 
   { 0x3D4, 0x15, 0xE7 },  { 0x3D4, 0x16, 0x6  },  { 0x3D4, 0x17, 0xE3 }, 
   { 0x3C4, 0x1,  0x1  },  { 0x3CE, 0x5,  0x40 },  { 0x3CE, 0x6,  0x5  }, 
   { 0x3C0, 0x10, 0x41 },  { 0,     0,    0    } 
};

/*** vtables ***/

/* 1-bpp modes */
static vga_vtable_t vga_1_vt = {
	vga_1_cls,
	vga_1_pset
};

/* 4-bpp modes */
static vga_vtable_t vga_4_vt = {
	vga_4_cls,
	vga_4_pset
};

/* 8-bpp chain4 modes (13h, mode-q) */
static vga_vtable_t vga_8_vt = {
	vga_8_cls,
	vga_8_pset
};

/* 8-bpp unchained modes (mode-x) */
static vga_vtable_t vga_x_vt = {
	vga_x_cls,
	vga_x_pset
};

#if 0
static const MODEINFO mode_info[NUM_MODES] = {
 { 320, 200, 2, 1, &fb_palette_16,  &fb_font_8x8,   40, 25 },		/* CGA mode 1 */
 { 640, 200, 1, 2, &fb_palette_16,  &fb_font_8x8,   80, 25 },		/* CGA mode 2 */
 { -1 }, { -1}, { -1 }, { -1 },						/* Unsupported modes (3, 4, 5, 6) */
 { 320, 200, 4, 1, &fb_palette_16,  &fb_font_8x8,   40, 25 },		/* EGA mode 7 */
 { 640, 200, 4, 2, &fb_palette_16,  &fb_font_8x8,   80, 25 },		/* EGA mode 8 */
 { 640, 350, 4, 1, &fb_palette_64,  &fb_font_8x14,  80, 25 },		/* EGA mode 9 */
 { -1 },								/* Unsupported mode (10) */
 { 640, 480, 1, 1, &fb_palette_256, &fb_font_8x16,  80, 30 },		/* VGA mode 11 */
 { 640, 480, 4, 1, &fb_palette_256, &fb_font_8x16,  80, 30 },		/* VGA mode 12 */
 { 320, 200, 8, 1, &fb_palette_256, &fb_font_8x8,   40, 25 },		/* VGA mode 13 */

									/* New modes */
 { 320, 240, 8, 1, &fb_palette_256, &fb_font_8x8,   40, 30 },		/* 14: 320x240 */
 { 400, 300, 8, 1, &fb_palette_256, &fb_font_8x8,   50, 37 },		/* 15: 400x300 */
 { 512, 384, 8, 1, &fb_palette_256, &fb_font_8x16,  64, 24 },		/* 16: 512x384 */
 { 640, 400, 8, 1, &fb_palette_256, &fb_font_8x16,  80, 25 },		/* 17: 640x400 */
 { 640, 480, 8, 1, &fb_palette_256, &fb_font_8x16,  80, 30 },		/* 18: 640x480 */
 { 800, 600, 8, 1, &fb_palette_256, &fb_font_8x16, 100, 37 },		/* 19: 800x600 */
 {1024, 768, 8, 1, &fb_palette_256, &fb_font_8x16, 128, 48 },		/* 20: 1024x768 */
 {1280,1024, 8, 1, &fb_palette_256, &fb_font_8x16, 160, 64 },		/* 21: 1280x1024 */
};
#endif

/* modes list */
static vga_mode_t vga_modes[] = {
	/* w,	h,	bpp,	mode,	flags,		phys_w,	addr,		tweaks,		vtable */
	{320,	200,	4,	0x0D,	VM_PLANAR,	320,	0xA0000,	NULL,		&vga_4_vt},	/* qb mode 7 */
	{640,	200,	4,	0x0E,	VM_PLANAR,	640,	0xA0000,	NULL,		&vga_4_vt},	/* qb mode 8 */
	{640,	350,	4,	0x10,	VM_PLANAR,	640,	0xA0000,	NULL,		&vga_4_vt},	/* qb mode 9 */

	{640,	480,	1,	0x11,	0,		640,	0xA0000,	NULL,		&vga_1_vt},	/* qb mode 11 */
	{640,	480,	4,	0x12,	VM_PLANAR,	640,	0xA0000,	vga_12,		&vga_4_vt},	/* qb mode 12 */
	{512,	480,	4,	0x12,	VM_PLANAR,	640,	0xA0000,	vga_12_512x480,	&vga_4_vt},
	{320,	200,	8,	0x13,	0,		320,	0xA0000,	NULL,		&vga_8_vt},	/* qb mode 13 */
	{256,	256,	8,	0x13,	0,		256,	0xA0000,	vga_modeq,	&vga_8_vt},	/* mode q */
	
	{320,	240,	8,	0x13,	VM_PLANAR|VM_X,	320,	0xA0000,	vga_x_320x240,	&vga_x_vt},	/* new mode 14 */
	
	{0}	/* end of list */
};

/** file globals **/
static __dpmi_regs regs;
static vga_mode_t vga_mode;
static int vga_mode_bytes;
static int vga_plane_bytes;
static int vga_stride;

int vga_init(void)
{
	/* clear mode info struct */
	memset(&vga_mode, 0, sizeof(vga_mode_t));
	
	/* install atexit handler */
}

void vga_exit(void)
{
	/* reset text mode */
	vga_unset_mode();
}

int vga_set_mode(int w, int h, int bpp)
{
	vga_mode_t *mode;
	vga_tweak_t *tweak;
	
	memset(&vga_mode, 0, sizeof(vga_mode_t));
	
	for (mode = vga_modes; mode->w != 0; mode++) {
		if ((mode->w == w) && (mode->h == h) && (mode->bpp == bpp)) {
			memcpy(&vga_mode, mode, sizeof(vga_mode_t));
			break;
		}
	}
	
	if (vga_mode.w == 0) return VGA_FAILURE;
	
	/* set base vga mode */
	regs.x.ax = vga_mode.mode;
	__dpmi_int(VIDEO, &regs);
	
	/* tweak */
	if (vga_mode.tweaks) {
		/* synchronous reset */
		outportw(0x3C4, 0x0100);
		
		/* remove write protect from VGA regs */
		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5) & 0x7F);

		/* disable chain-4 */
		if (vga_mode.flags & VM_X)
			outportw(0x3C4, 0x0604);
		
		for (tweak = vga_mode.tweaks; tweak->port != 0; tweak++) {
			if (tweak->value != NO_VAL) {
				if (tweak->port == 0x3C0) {
					inportb(0x3DA);
					outportb(0x3C0, tweak->index | 0x20);
					outportb(0x3C0, tweak->value);
				} else if (tweak->port == 0x3C2) {
					outportb(tweak->port, tweak->value);
				} else {
					outportb(tweak->port, tweak->index); 
					outportb(tweak->port+1, tweak->value);
				}
			} else
				outportb(tweak->port, tweak->index);
		}

		if (vga_mode.flags & VM_X) {

			outportb(0x3D4, 0x13);                       /* set scanline length */
			outportb(0x3D5, vga_mode.w / 8);
		}
		
		outportw(0x3C4, 0x0300);                     /* restart sequencer */
		
		/* reprotect regs */
		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5) | 0x80);
	}
	
	vga_stride = vga_mode.phys_w * vga_mode.bpp / 8;
	vga_mode_bytes = vga_stride * vga_mode.h;
	
	if (vga_mode.flags & VM_PLANAR) {
		vga_plane_bytes = vga_mode_bytes / 4;
		vga_stride /= 4;
	}
	
	if (vga_mouse_init())
		vga_mouse_set_range(0, 0, vga_mode.w - 1, vga_mode.h - 1);
	
	return VGA_SUCCESS;
}

void vga_unset_mode(void)
{
	if (vga_mode.w == 0) return;
	
	/* reset original text mode */
	regs.x.ax = 0x03;
	__dpmi_int(VIDEO, &regs);
	
	memset(&vga_mode, 0, sizeof(vga_mode_t));

}

int vga_mouse_init(void)
{
	regs.x.ax = 0;
	__dpmi_int(MOUSE, &regs);
	return (regs.x.ax == 0 ? VGA_FAILURE : VGA_SUCCESS);
}

int vga_mouse_x(void)
{
	regs.x.ax = 3;
	__dpmi_int(MOUSE, &regs);
	return regs.x.cx;
}

int vga_mouse_y(void)
{
	regs.x.ax = 3;
	__dpmi_int(MOUSE, &regs);
	return regs.x.dx;
}

int vga_mouse_b(void)
{
	regs.x.ax = 3;
	__dpmi_int(MOUSE, &regs);
	return regs.x.bx;
}

void vga_mouse_set_range(int minx, int miny, int maxx, int maxy)
{
	regs.x.ax = 7;
	regs.x.cx = minx;
	regs.x.dx = maxx;
	__dpmi_int(MOUSE, &regs);

	regs.x.ax = 8;
	regs.x.cx = miny;
	regs.x.dx = maxy;
	__dpmi_int(MOUSE, &regs);
}

void vga_set_write_planes(int planes)
{
	outportw(0x3C4, 0x02 | (planes << 8));
}

void vga_set_read_plane(int plane)
{
	outportw(0x3CE, 0x04 | (plane << 8));
}

void vga_cls(void)
{
	vga_mode.vtable->cls();
}

void vga_pset(int x, int y, int c)
{
	if ((x < 0) || (y < 0) || (x >= vga_mode.w) || (y >= vga_mode.h)) return;
	vga_mode.vtable->pset(x, y, c);
}

void vga_8_cls(void)
{
	unsigned long i;
	unsigned char c;
	
	c = 6; // fixme - use bgcolor
	
	_farsetsel(_dos_ds);
	for (i = vga_mode.addr; i < vga_mode.addr + vga_mode_bytes; i++)
		_farnspokeb(i, c);
}

void vga_8_pset(int x, int y, int c)
{
	_farpokeb(_dos_ds, vga_mode.addr + (y * vga_mode.w) + x, (unsigned char)c);
}


void vga_4_cls(void)
{
	unsigned long i;
	unsigned char c;
	int planes;
	
	_farsetsel(_dos_ds);
	
	c = 4; // fixme - use bgcolor
	
	/* write to 1 planes */
	planes = c;
	if (planes) {
		vga_set_write_planes(planes);
		
		/* fill vidmem with 1s */
		for (i = vga_mode.addr; i < vga_mode.addr + vga_plane_bytes; i++)
			_farnspokeb(i, 0xFF);
	}
	
	/* write to 0 planes */
	planes = (~c) & 0xF;
	if (planes) {
		vga_set_write_planes(planes);
		
		/* fill vidmem with 0s */
		for (i = vga_mode.addr; i < vga_mode.addr + vga_plane_bytes; i++)
			_farnspokeb(i, 0x00);
	}

}


void vga_4_pset(int x, int y, int c)
{
	unsigned long offset;
	int bit, bitmask, b;
	
	offset = vga_mode.addr + (y * vga_stride) + (x >> 3);
	
	bit = 1 << (~x & 7);
	bitmask = ~bit;
	
	_farsetsel(_dos_ds);
	

	/* plane 1 */
	vga_set_write_planes(WRITE_PLANE_1);
	vga_set_read_plane(READ_PLANE_1);
	b = _farnspeekb(offset) & bitmask;
	if (c & 1)
		b |= bit;
	_farnspokeb(offset, b);
	
	/* plane 2 */
	vga_set_write_planes(WRITE_PLANE_2);
	vga_set_read_plane(READ_PLANE_2);
	b = _farnspeekb(offset) & bitmask;
	if (c & 2)
		b |= bit;
	_farnspokeb(offset, b);
	
	/* plane 3 */
	vga_set_write_planes(WRITE_PLANE_3);
	vga_set_read_plane(READ_PLANE_3);
	b = _farnspeekb(offset) & bitmask;
	if (c & 4)
		b |= bit;
	_farnspokeb(offset, b);
	
	/* plane 4 */
	vga_set_write_planes(WRITE_PLANE_4);
	vga_set_read_plane(READ_PLANE_4);
	b = _farnspeekb(offset) & bitmask;
	if (c & 8)
		b |= bit;
	_farnspokeb(offset, b);
}


void vga_1_cls(void)
{
	unsigned long i;
	unsigned char c;
	int planes;
	
	// fixme - use bgcolor
	if (0)
		c = 0xFF;
	else
		c = 0x00;
	
	/* fill vidmem with c */
	_farsetsel(_dos_ds);
	for (i = vga_mode.addr; i < vga_mode.addr + vga_mode_bytes; i++)
		_farnspokeb(i, c);
}

void vga_1_pset(int x, int y, int c)
{
	unsigned long offset;
	int bit, bitmask, b;
	
	offset = vga_mode.addr + (y * vga_stride) + (x >> 3);
	
	bit = 1 << (~x & 7);
	bitmask = ~bit;
	
	_farsetsel(_dos_ds);
	b = _farnspeekb(offset) & bitmask;
	if (c & 1)
		b |= bit;
	_farnspokeb(offset, b);

}

void vga_x_cls(void)
{
	unsigned long i;
	unsigned char c;
	
	c = 2; // fixme - use bgcolor

	vga_set_write_planes(WRITE_ALL_PLANES);
	
	_farsetsel(_dos_ds);
	for (i = vga_mode.addr; i < vga_mode.addr + vga_plane_bytes; i++)
		_farnspokeb(i, c);
}

void vga_x_pset(int x, int y, int c)
{
	unsigned long offset;

	offset = vga_mode.addr + (y * vga_stride) + (x >> 2);

	vga_set_write_planes(1 << (x & 3));
	_farpokeb(_dos_ds, offset, c);
}
