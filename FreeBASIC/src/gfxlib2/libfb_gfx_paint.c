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
 * paint.c -- PAINT statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


typedef struct SPAN
{
	int y, x1, x2;
	struct SPAN *row_next;
	struct SPAN *next;
} SPAN;


/*:::::*/
static SPAN *add_span(SPAN **span, int *x, int y, unsigned int border_color)
{
	SPAN *s;
	int x1, x2;

	x1 = x2 = *x;
	while ((x1 > fb_mode->view_x) && (fb_hGetPixel(x1 - 1, y) != border_color))
		x1--;
	while ((x2 < fb_mode->view_x + fb_mode->view_w - 1) && (fb_hGetPixel(x2 + 1, y) != border_color))
		x2++;
	*x = x2 + 1;
	for (s = span[y]; s; s = s->row_next) {
		if ((x1 == s->x1) && (x2 == s->x2))
			return NULL;
	}
	s = (SPAN *)malloc(sizeof(SPAN));
	s->x1 = x1;
	s->x2 = x2;
	s->y = y;
	s->next = NULL;
	s->row_next = span[y];
	span[y] = s;

	return s;
}


/*:::::*/
FBCALL void fb_GfxPaint(void *target, float fx, float fy, unsigned int color, unsigned int border_color, FBSTRING *pattern, int mode, int coord_type)
{
	int size, x, y;
	unsigned char data[256], *dest, *src;
	SPAN **span, *s, *tail, *head;

	if (!fb_mode)
		return;

	if (color == DEFAULT_COLOR)
		color = fb_mode->fg_color;
	else
		color = fb_hFixColor(color);
	if (border_color == DEFAULT_COLOR)
		border_color = color;
	else
		border_color = fb_hFixColor(border_color);

	fb_hPrepareTarget(target);

	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);

	fb_hTranslateCoord(fx, fy, &x, &y);

	fb_hMemSet(data, 0, sizeof(data));
	if ((mode == PAINT_TYPE_PATTERN) && (pattern)) {
		fb_hMemCpy(data, pattern->data, MIN(256, FB_STRSIZE(pattern)));
    }
    if (pattern) {
        /* del if temp */
        fb_hStrDelTemp( pattern );
    }

	if ((x < fb_mode->view_x) || (x >= fb_mode->view_x + fb_mode->view_w) ||
	    (y < fb_mode->view_y) || (y >= fb_mode->view_y + fb_mode->view_h))
		return;

	if (fb_hGetPixel(x, y) == border_color)
		return;

	size = sizeof(SPAN *) * fb_mode->view_h;
	span = (SPAN **)malloc(size);
	fb_hMemSet(span, 0, size);

	tail = head = add_span(span, &x, y, border_color);

	/* Find all spans to paint */
	while (tail) {
		if (tail->y - 1 >= fb_mode->view_y) {
			for (x = tail->x1; x <= tail->x2; x++) {
				if (fb_hGetPixel(x, tail->y - 1) != border_color) {
					s = add_span(span, &x, tail->y - 1, border_color);
					if (s) {
						head->next = s;
						head = s;
					}
				}
			}
		}
		if (tail->y + 1 < fb_mode->view_y + fb_mode->view_h) {
			for (x = tail->x1; x <= tail->x2; x++) {
				if (fb_hGetPixel(x, tail->y + 1) != border_color) {
					s = add_span(span, &x, tail->y + 1, border_color);
					if (s) {
						head->next = s;
						head = s;
					}
				}
			}
		}
		tail = tail->next;
	}

	DRIVER_LOCK();

	/* Fill spans */
	for (y = 0; y < fb_mode->h; y++) {
		for (s = tail = span[y]; s; s = s->row_next, free(tail), tail = s) {

			dest = fb_mode->line[s->y] + (s->x1 * fb_mode->bpp);

			if (mode == PAINT_TYPE_FILL)
				fb_hPixelSet(dest, color, s->x2 - s->x1 + 1);
			else {
				src = data + (((s->y & 0x7) << 3) * fb_mode->bpp);
				if (s->x1 & 0x7) {
					if ((s->x1 & ~0x7) == (s->x2 & ~0x7))
						size = s->x2 - s->x1 + 1;
					else
						size = 8 - (s->x1 & 0x7);
					fb_hPixelCpy(dest, src + ((s->x1 & 0x7) * fb_mode->bpp), size);
					dest += size * fb_mode->bpp;
				}
				s->x2++;
				for (x = (s->x1 + 7) >> 3; x < (s->x2 & ~0x7) >> 3; x++) {
					fb_hPixelCpy(dest, src, 8);
					dest += 8 * fb_mode->bpp;
				}
				if ((s->x2 & 0x7) && ((s->x1 & ~0x7) != (s->x2 & ~0x7)))
					fb_hPixelCpy(dest, src, s->x2 & 0x7);
			}

			if (fb_mode->framebuffer == fb_mode->line[0])
				fb_mode->dirty[y] = TRUE;
		}
	}
	free(span);

	DRIVER_UNLOCK();

}
