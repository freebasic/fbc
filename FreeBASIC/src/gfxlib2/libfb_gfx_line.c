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
 * line.c -- LINE statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


#define CLIP_LEFT_EDGE		0x1
#define CLIP_RIGHT_EDGE		0x2
#define CLIP_BOTTOM_EDGE	0x4
#define CLIP_TOP_EDGE		0x8
#define CLIP_INSIDE(a)		(!a)
#define CLIP_REJECT(a,b)	((a) & (b))
#define CLIP_ACCEPT(a,b)	(!((a) | (b)))


/*:::::*/
static int encode(int x, int y)
{
	int code = 0;

	if (x < fb_mode->view_x)
		code |= CLIP_LEFT_EDGE;
	else if (x >= fb_mode->view_x + fb_mode->view_w)
		code |= CLIP_RIGHT_EDGE;
	if (y < fb_mode->view_y)
		code |= CLIP_TOP_EDGE;
	else if (y >= fb_mode->view_y + fb_mode->view_h)
		code |= CLIP_BOTTOM_EDGE;
	return code;
}


/*:::::*/
static int reverse_mask(int mask)
{
	int new_mask = 0, i;
	
	for (i = 0; i < 8; i++) {
		new_mask |= (mask & (1 << i)) ? (1 << (15 - i)) : 0;
		new_mask |= (mask & (1 << (15 - i))) ? (1 << i) : 0;
	}
	return new_mask;
}


/*:::::*/
static int clip_line(int *x1, int *y1, int *x2, int *y2)
{
	int code1, code2;
	float m;

	while (1) {
		code1 = encode(*x1, *y1);
		code2 = encode(*x2, *y2);

		if (CLIP_ACCEPT(code1, code2))
			break;
		if (CLIP_REJECT(code1, code2))
			return -1;
		if (CLIP_INSIDE(code1)) {
			SWAP(*x1, *x2);
			SWAP(*y1, *y2);
			SWAP(code1, code2);
		}
		if (*x1 != *x2)
			m = (*y2 - *y1) / (float)(*x2 - *x1);
		else
			m = 1.0;
		if (code1 & CLIP_LEFT_EDGE) {
			*y1 += (fb_mode->view_x - *x1) * m;
			*x1 = fb_mode->view_x;
		}
		else if (code1 & CLIP_RIGHT_EDGE) {
			*y1 += (fb_mode->view_x + fb_mode->view_w - 1 - *x1) * m;
			*x1 = fb_mode->view_x + fb_mode->view_w - 1;
		}
		else if (code1 & CLIP_TOP_EDGE) {
			if (*x1 != *x2)
				*x1 += (fb_mode->view_y - *y1) / m;
			*y1 = fb_mode->view_y;
		}
		else if (code1 & CLIP_BOTTOM_EDGE) {
			if (*x1 != *x2)
				*x1 += (fb_mode->view_y + fb_mode->view_h - 1 - *y1) / m;
			*y1 = fb_mode->view_y + fb_mode->view_h - 1;
		}
	}

	return 0;
}


/*:::::*/
FBCALL void fb_GfxLine(void *target, float fx1, float fy1, float fx2, float fy2, unsigned int color, int type, unsigned int style, int coord_type)
{
	int x1, y1, x2, y2;
	int x, y, len, d, dx, dy, ax, ay, bit = 0x8000;

	if (!fb_mode)
		return;

	if (color == DEFAULT_COLOR)
		color = fb_mode->fg_color;
	else
		color = fb_hFixColor(color);
	style &= 0xFFFF;

	fb_hPrepareTarget(target);
	
	fb_hFixRelative(coord_type, &fx1, &fy1, &fx2, &fy2);

	fb_hTranslateCoord(fx1, fy1, &x1, &y1);
	fb_hTranslateCoord(fx2, fy2, &x2, &y2);

	if (type == LINE_TYPE_LINE) {
		if (clip_line(&x1, &y1, &x2, &y2))
			return;

		DRIVER_LOCK();
		if (x1 == x2) {
			if (y1 > y2) {
				SWAP(y1, y2);
				style = reverse_mask(style);
				bit = 1 << ((y2 - y1) & 0xF);
			}
			for (y = y1; y <= y2; y++) {
				if (style & bit)
					fb_hPutPixel(x1, y, color);
				RORW1(bit);
			}
		}
		else if (y1 == y2) {
			if (x1 > x2) {
				SWAP(x1, x2);
				style = reverse_mask(style);
				bit = 1 << ((x2 - x1) & 0xF);
			}
			if (style == 0xFFFF)
				fb_hPixelSet(fb_mode->line[y1] + (x1 * fb_mode->bpp), color, x2 - x1 + 1);
			else {
				for (x = x1; x <= x2; x++) {
					if (style & bit)
						fb_hPutPixel(x, y1, color);
					RORW1(bit);
				}
			}
		}
		else {
			dx = x2 - x1;
			dy = y2 - y1;
			ax = ay = 1;
			if (dx < 0) {
				dx = -dx;
				ax = -1;
			}
			if (dy < 0) {
				dy = -dy;
				ay = -1;
			}
			x = x1;
			y = y1;
			if (dx >= dy) {
				len = dx + 1;
				dy <<= 1;
				d = dy - dx;
				dx <<= 1;
				for (; len; len--) {
					if (style & bit)
						fb_hPutPixel(x, y, color);
					RORW1(bit);
					if (d >= 0) {
						y += ay;
						d -= dx;
					}
					d += dy;
					x += ax;
				}
			}
			else {
				len = dy + 1;
				dx <<= 1;
				d = dx - dy;
				dy <<= 1;
				for (; len; len--) {
					if (style & bit)
						fb_hPutPixel(x, y, color);
					RORW1(bit);
					if (d >= 0) {
						x += ax;
						d -= dy;
					}
					d += dx;
					y += ay;
				}
			}
		}
		if (y1 > y2)
			SWAP(y1, y2);
		SET_DIRTY(y1, y2 - y1 + 1);
		DRIVER_UNLOCK();
	}
	else {
		fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);
		fb_hGfxBox(x1, y1, x2, y2, color, (type == LINE_TYPE_BF), style);
	}
}
