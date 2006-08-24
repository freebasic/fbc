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
 * softcursor.c -- Software cursor helper routines
 *
 * chng: feb/2006 written [lillo]
 *
 */

#include "fb_gfx.h"

#define CURSOR_W	12
#define CURSOR_H	21

#define BIT_ENCODE(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11)		\
	((p0)|(p1<<2)|(p2<<4)|(p3<<6)|(p4<<8)|(p5<<10)|(p6<<12)|(p7<<14)|(p8<<16)|(p9<<18)|(p10<<20)|(p11<<22))

char fb_hSoftCursor_data_start;

static const unsigned int cursor_data[] = {
	BIT_ENCODE(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
	BIT_ENCODE(2, 1, 1, 1, 2, 1, 1, 2, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 2, 2, 1, 1, 2, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 2, 0, 0, 2, 1, 1, 2, 0, 0, 0),
	BIT_ENCODE(2, 2, 0, 0, 0, 2, 1, 1, 2, 0, 0, 0),
	BIT_ENCODE(2, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0)
};

static unsigned char *cursor_area;
static unsigned int white, black;

char fb_hSoftCursor_data_end;

void fb_hSoftCursor_code_start(void) { }


/*:::::*/
static void copy_cursor_area(int x, int y, int from_area)
{
	unsigned char *s, *d;
	int w, h, s_pitch, d_pitch;
	
	w = (MIN(CURSOR_W, fb_mode->w - x) * fb_mode->bpp);
	h = MIN(CURSOR_H, fb_mode->h - y);
	
	if (from_area) {
		s = cursor_area;
		d = fb_mode->framebuffer + (y * fb_mode->pitch) + (x * fb_mode->bpp);
		s_pitch = w;
		d_pitch = fb_mode->pitch;
	}
	else {
		s = fb_mode->framebuffer + (y * fb_mode->pitch) + (x * fb_mode->bpp);
		d = cursor_area;
		s_pitch = fb_mode->pitch;
		d_pitch = w;
	}
	
	for (; h; h--) {
		fb_hMemCpy(d, s, w);
		s += s_pitch;
		d += d_pitch;
	}
}


/*:::::*/
static int color_distance(int index, int r, int g, int b)
{
	return (((fb_mode->device_palette[index] & 0xFF) - r) * ((fb_mode->device_palette[index] & 0xFF) - r)) +
	       ((((fb_mode->device_palette[index] >> 8) & 0xFF) - g) * (((fb_mode->device_palette[index] >> 8) & 0xFF) - g)) +
	       ((((fb_mode->device_palette[index] >> 16) & 0xFF) - b) * (((fb_mode->device_palette[index] >> 16) & 0xFF) - b));
}


/*:::::*/
void fb_hSoftCursorInit(void)
{
	cursor_area = malloc(CURSOR_W * CURSOR_H * fb_mode->bpp);
	if (fb_mode->bpp == 1) {
		white = 15;
		black = 0;
	}
	else {
		white = fb_hFixColor(0xFFFFFF);
		black = fb_hFixColor(0x000000);
	}
}


/*:::::*/
void fb_hSoftCursorExit(void)
{
	free(cursor_area);
}


/*:::::*/
void fb_hSoftCursorPut(int x, int y)
{
	unsigned char *d;
	int w, h, px, py, pixel;
	unsigned int color = 0;
	
	copy_cursor_area(x, y, FALSE);
	
	w = MIN(CURSOR_W, fb_mode->w - x);
	h = MIN(CURSOR_H, fb_mode->h - y);
	for (py = 0; py < h; py++) {
		for (px = 0; px < w; px++) {
			pixel = (cursor_data[py] >> (px << 1)) & 0x3;
			d = fb_mode->framebuffer + ((y + py) * fb_mode->pitch) + ((x + px) * fb_mode->bpp);
			if (pixel & 0x1)
				color = white;
			else if (pixel & 0x2)
				color = black;
			if (pixel) {
				if (fb_mode->bpp == 1)      *d = color;
				else if (fb_mode->bpp == 2) *(unsigned short *)d = color;
				else                        *(unsigned int *)d = color;
			}
		}
		fb_mode->dirty[y + py] = TRUE;
	}
}


/*:::::*/
void fb_hSoftCursorUnput(int x, int y)
{
	copy_cursor_area(x, y, TRUE);
	fb_hMemSet(fb_mode->dirty + y, TRUE, MIN(CURSOR_H, fb_mode->h - y));
}


/*:::::*/
void fb_hSoftCursorPaletteChanged(void)
{
	int i, dist, min_wdist = 1000000, min_bdist = 1000000;
	
	if (fb_mode->bpp > 1)
		return;
	for (i = 0; i < 256; i++) {
		dist = color_distance(i, 255, 255, 255);
		if (dist < min_wdist) {
			min_wdist = dist;
			white = i;
		}
		dist = color_distance(i, 0, 0, 0);
		if (dist < min_bdist) {
			min_bdist = dist;
			black = i;
		}
	}
}

void fb_hSoftCursor_code_end(void) { }
