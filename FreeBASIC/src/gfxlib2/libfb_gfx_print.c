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
 * print.c -- graphical mode text output
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
static void print_char(unsigned char ch)
{
	int bit, x, y, text_x, text_y;
	unsigned int color;
	const unsigned char *src;
	
	text_x = fb_mode->cursor_x << 3;
	text_y = fb_mode->cursor_y * fb_mode->font->h;
	src = &fb_mode->font->data[ch * fb_mode->font->h];
	for (y = 0; y < fb_mode->font->h; y++) {
		for (x = 0, bit = 1; x < 8; x++, bit <<= 1) {
			color = (*src & bit) ? fb_mode->fg_color : fb_mode->bg_color;
			fb_hPutPixel(text_x + x, text_y + y, color);
		}
		src++;
	}
}


/*:::::*/
static void check_scroll(int *dirty_start, int *dirty_len)
{
	if (fb_mode->cursor_y >= fb_mode->text_h) {
		*dirty_start = 0;
		*dirty_len = fb_mode->text_h;
		fb_hPixelCpy(fb_mode->line[0], fb_mode->line[fb_mode->font->h],
			     (fb_mode->text_h - 1) * fb_mode->font->h * fb_mode->w);
		fb_hPixelSet(fb_mode->line[(fb_mode->text_h - 1) * fb_mode->font->h],
			     fb_mode->bg_color, fb_mode->font->h * fb_mode->w);
		fb_mode->cursor_y = fb_mode->text_h - 1;
	}
}


/*:::::*/
void fb_GfxPrintBuffer(char *buffer, int mask)
{
	int i, j, new_x;
	int dirty_start = fb_mode->cursor_y, dirty_len = 0;
	unsigned char *dest;
	
	fb_mode->driver->lock();
	
	check_scroll(&dirty_start, &dirty_len);
	
	for (i = 0; i < strlen(buffer); i++) {
		switch (buffer[i]) {
			case '\t':
				new_x = (fb_mode->cursor_x + 8) & ~0x7;
				dest = fb_mode->line[fb_mode->cursor_y << 3] + ((fb_mode->cursor_x << 3) * fb_mode->bpp);
				for (j = 0; j < fb_mode->font->h; j++) {
					fb_hPixelSet(dest, fb_mode->bg_color, (new_x - fb_mode->cursor_x) << 3);
					dest += fb_mode->pitch;
				}
				fb_mode->cursor_x = new_x;
				break;
			
			case '\n':
			case '\r':
				fb_mode->cursor_x = 0x100;
				break;
			
			default:
				print_char((unsigned char)buffer[i]);
				fb_mode->cursor_x++;
				if (!dirty_len)
					dirty_len = 1;
				break;
		}
		if (fb_mode->cursor_x >= fb_mode->text_w) {
			fb_mode->cursor_y++;
			dirty_len++;
			fb_mode->cursor_x = 0;
			check_scroll(&dirty_start, &dirty_len);
		}
	}
	fb_hMemSet(fb_mode->dirty + (dirty_start * fb_mode->font->h), TRUE, dirty_len * fb_mode->font->h);
	
	fb_mode->driver->unlock();
}


/*:::::*/
void fb_GfxLocate(int y, int x, int cursor)
{
	if (x > 0)
		fb_mode->cursor_x = x - 1;
	if (y > 0)
		fb_mode->cursor_y = y - 1;
}


/*:::::*/
int fb_GfxGetX(void)
{
	return fb_mode->cursor_x + 1;
}


/*:::::*/
int fb_GfxGetY(void)
{
	return fb_mode->cursor_y + 1;
}
