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
void fb_GfxPrintBufferEx(const void *buffer, size_t len, int mask)
{
    size_t i;
	int j, new_x;
	int dirty_start = fb_mode->cursor_y, dirty_len = 0;
    unsigned char *dest;
    const char *pachText = (const char *) buffer;

	fb_hPrepareTarget(NULL);

	DRIVER_LOCK();

	check_scroll(&dirty_start, &dirty_len);

	for (i = 0; i != len; ++i) {

		if (fb_mode->cursor_x >= fb_mode->text_w) {
			fb_mode->cursor_y++;
			if (i == 0)
				dirty_start++;
			dirty_len++;
			fb_mode->cursor_x = 0;
			check_scroll(&dirty_start, &dirty_len);
		}

		switch (pachText[i]) {
			case '\t':
				new_x = (fb_mode->cursor_x + 8) & ~0x7;
				dest = fb_mode->line[fb_mode->cursor_y * fb_mode->font->h] + ((fb_mode->cursor_x << 3) * fb_mode->bpp);
				for (j = 0; j < fb_mode->font->h; j++) {
					fb_hPixelSet(dest, fb_mode->bg_color, (new_x - fb_mode->cursor_x) << 3);
					dest += fb_mode->pitch;
				}
				fb_mode->cursor_x = new_x;
				break;

			case '\r':
				if (pachText[i+1] == '\n')
					i++;
			case '\n':
				fb_mode->cursor_x = 0;
				fb_mode->cursor_y++;
				dirty_len++;
				check_scroll(&dirty_start, &dirty_len);
				break;

			default:
				print_char((unsigned char)pachText[i]);
				fb_mode->cursor_x++;
				if (!dirty_len)
					dirty_len = 1;
				break;
		}
	}
	SET_DIRTY(dirty_start * fb_mode->font->h, dirty_len * fb_mode->font->h);

	DRIVER_UNLOCK();
}


/*:::::*/
void fb_GfxPrintBuffer(const char *buffer, int mask)
{
    fb_GfxPrintBufferEx(buffer, strlen(buffer), mask);
}


/*:::::*/
int fb_GfxLocate(int y, int x, int cursor)
{
	if (x > 0)
		fb_mode->cursor_x = x - 1;
	if (y > 0)
		fb_mode->cursor_y = y - 1;

    fb_SetPos( FB_HANDLE_SCREEN , fb_mode->cursor_x );

	return ((fb_mode->cursor_x + 1) & 0xFF) | (((fb_mode->cursor_y + 1) & 0xFF) << 8);
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

/*:::::*/
void fb_GfxGetXY( int *col, int *row )
{
	if( col != NULL )
		*col = fb_GfxGetX( );

	if( row != NULL )
		*row = fb_GfxGetY( );

}

/*:::::*/
void fb_GfxGetSize( int *cols, int *rows )
{
	if( cols != NULL )
		*cols = fb_mode->text_w;

	if( rows != NULL )
		*rows = fb_mode->text_h;

}

