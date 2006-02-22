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
 * drawstring.c -- advanced graphical string drawing routine
 *
 * chng: feb/2006 written [lillo]
 *
 */

#include "fb_gfx.h"

/*
 *	User font format:
 *
 *	Basically a GET/PUT buffer, where the first pixels data line holds the
 *	font header:
 *
 *	offset	|	description
 *	--------+--------------------------------------------------------------
 *	0		|	Font header version (currently must be 0)
 *	1		|	First ascii character supported
 *	2		|	Last ascii character supported
 *	3-(3+n)	|	n-th supported character width
 *
 *	The font height is computed as the height of the buffer minus 1, and the
 *	actual glyph shapes start on the second buffer line, one after another in
 *	the same row, starting with first supported ascii character up to the
 *	last one.
 *
 */

typedef struct CHAR
{
	int width;
	unsigned char *data;
} CHAR;



/*:::::*/
FBCALL int fb_GfxDrawString(void *target, float fx, float fy, int coord_type, FBSTRING *string, unsigned int color, void *font)
{
	CHAR char_data[256], *ch;
	PUTTER *put;
	int font_height, x, y, px, py, i, w, h, pitch, bpp, first, last;
	int offset, bytes_count, res = FB_RTERROR_OK;
	unsigned char *data;
	
	if ((!fb_mode) || (!string) || (!string->data))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	if (color == DEFAULT_COLOR)
		color = fb_mode->fg_color;
	else
		color = fb_hFixColor(color);
	
	fb_hPrepareTarget(target);
	
	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(fx, fy, &x, &y);
	
	DRIVER_LOCK();
	
	if (font) {
		/* user passed a custom font */
		
		put = fb_hGetPutter(PUT_MODE_TRANS, 0, NULL);
		
		bpp = (int)*(unsigned short *)font;
		pitch = (bpp >> 3) * fb_mode->bpp;
		font_height = (int)*(unsigned short *)(font + 2) - 1;

		if ((y + font_height <= fb_mode->view_y) || (y >= fb_mode->view_y + fb_mode->view_h))
			goto exit_error;
		
		bpp &= 0x7;
		if (((bpp) && (bpp != fb_mode->bpp)) || (pitch < 4) || (font_height <= 0) || (*((unsigned char *)font + 4) != 0)) {
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			goto exit_error;
		}
		
		first = (int)*(unsigned char *)(font + 5);
		last = (int)*(unsigned char *)(font + 6);
		if (first > last)
			SWAP(first, last);
		fb_hMemSet(char_data, 0, sizeof(CHAR) * 256);
		data = font + 4 + pitch;
		if (y < fb_mode->view_y) {
			data += (pitch * (fb_mode->view_y - y));
			font_height -= (fb_mode->view_y - y);
			y = fb_mode->view_y;
		}
		if (y + font_height > fb_mode->view_y + fb_mode->view_h)
			font_height -= ((y + font_height) - (fb_mode->view_y + fb_mode->view_h));
		
		for (w = 0, i = first; i <= last; i++) {
			char_data[i].width = (int)*(unsigned char *)(font + 7 + i - first);
			char_data[i].data = data;
			data += (char_data[i].width * fb_mode->bpp);
			w += char_data[i].width;
		}
		if (w > ((int)*(unsigned short *)font >> 3)) {
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			goto exit_error;
		}
		
		for (i = 0; i < FB_STRSIZE(string); i++) {
			
			if (x >= fb_mode->view_x + fb_mode->view_w)
				break;
			
			ch = &char_data[(unsigned char)string->data[i]];
			data = ch->data;
			if (!data) {
				/* character not found */
				x += font_height;
				continue;
			}
			w = ch->width;
			h = font_height;
			px = x;
			
			if (x + w >= fb_mode->view_x) {
				
				if (x < fb_mode->view_x) {
					data += ((fb_mode->view_x - x) * fb_mode->bpp);
					w -= (fb_mode->view_x - x);
					px = fb_mode->view_x;
				}
				if (x + w > fb_mode->view_x + fb_mode->view_w)
					w -= ((x + w) - (fb_mode->view_x + fb_mode->view_w));
				put(data, fb_mode->line[y] + (px * fb_mode->bpp), w, h, pitch, 0);
				
			}
			x += ch->width;
		}
	}
	else {
		/* use default font */
		
		font_height = fb_mode->font->h;
		w = fb_mode->font->w;
		bytes_count = BYTES_PER_PIXEL(w);
		offset = 0;
		
		if ((x + (w * FB_STRSIZE(string)) <= fb_mode->view_x) || (x >= fb_mode->view_x + fb_mode->view_w) ||
		    (y + font_height <= fb_mode->view_y) || (y >= fb_mode->view_y + fb_mode->view_h)) {
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			goto exit_error;
		}
		
		if (y < fb_mode->view_y) {
			offset = (bytes_count * (fb_mode->view_y - y));
			font_height -= (fb_mode->view_y - y);
			y = fb_mode->view_y;
		}
		if (y + font_height > fb_mode->view_y + fb_mode->view_h)
			font_height -= ((y + font_height) - (fb_mode->view_y + fb_mode->view_h));
		
		first = 0;
		if (x < fb_mode->view_x) {
			first = (fb_mode->view_x - x) / w;
			x += (first * w);
		}
		last = FB_STRSIZE(string);
		if (x + ((last - first) * w) > fb_mode->view_x + fb_mode->view_w)
			last -= ((x + ((last - first) * w) - (fb_mode->view_x + fb_mode->view_w)) / w);
		
		for (i = first; i < last; i++, x += w) {
			
			if (x + w <= fb_mode->view_x)
				continue;
			
			if (x >= fb_mode->view_x + fb_mode->view_w)
				break;
			
			data = (unsigned char *)fb_mode->font->data + ((unsigned char)string->data[i] * bytes_count * fb_mode->font->h) + offset;
			for (py = 0; py < font_height; py++) {
				for (px = 0; px < w; px++) {
					if ((*data & (1 << (px & 0x7))) && (x + px >= fb_mode->view_x) && (x + px < fb_mode->view_x + fb_mode->view_w))
						fb_hPutPixel(x + px, y + py, color);
					if ((px & 0x7) == 0x7)
						data++;
				}
			}
		}
	}
	
	SET_DIRTY(y, font_height);
	
exit_error:
	DRIVER_UNLOCK();
	
	fb_hStrDelTemp(string);
	
	if (res != FB_RTERROR_OK)
		return fb_ErrorSetNum(res);
	else
		return res;
}

