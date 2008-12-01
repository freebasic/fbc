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
 * draw.c -- DRAW command
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"
#include <ctype.h>

#ifdef NAN
#undef NAN
#endif
#define NAN		0x80000000

#define SQRT_2		1.4142135623730950488016


static float base_scale = 1.0, base_angle = 0.0;


/*:::::*/
static intptr_t parse_number(char **str)
{
	char *c = *str;
	intptr_t n = NAN;
	int negative = FALSE;

	while ((*c == ' ') || (*c == '\t') || (*c == '+') || (*c == '-'))
	{
		if (*c == '-')
			negative = !negative;
		c++;
	}
	while ((*c >= '0') && (*c <= '9')) {
		if (n == NAN)
			n = 0;
		n = (n * 10) + (*c - '0');
		c++;
	}
	*str = c;
	if ((negative) && (n != NAN))
		n = -n;

	return n;
}


/*:::::*/
FBCALL void fb_GfxDraw(void *target, FBSTRING *command)
{
	FB_GFXCTX *context = fb_hGetContext();
	float x, y, dx, dy, ax, ay, x2, y2, scale = 1.0, angle = 0.0;
	char *c;
	intptr_t value1;
	int draw = TRUE, move = TRUE, length = 0, value2, flags, rel, ix, iy;

	if ((!__fb_gfx) || (!command) || (!command->data)) {
		if (command)
			fb_hStrDelTemp(command);
		return;
	}
	
	fb_hPrepareTarget(context, target);
	fb_hSetPixelTransfer(context, MASK_A_32);

	x = context->last_x + 0.5;
	y = context->last_y + 0.5;

	DRIVER_LOCK();

	flags = context->flags;
	context->flags |= CTX_VIEW_SCREEN;

	for (c = command->data; *c;) {
		switch (toupper(*c)) {

			case 'B':
				c++;
				draw = FALSE;
				break;

			case 'N':
				c++;
				move = FALSE;
				break;

			case 'C':
				c++;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				context->fg_color = fb_hFixColor(context->target_bpp, value1);
				break;

			case 'S':
				c++;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				base_scale = (float)value1 / 4.0;
				break;

			case 'A':
				c++;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				base_angle = (float)(value1 & 0x3) * PI * 0.5;
				break;

			case 'T':
				c++;
				if (toupper(*c) != 'A')
					goto error;
				c++;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				base_angle = (float)value1 * PI / 180.0;
				break;

			case 'X':
				c++;
				/* Here we could be more severe with checking, but it's unlikely our substring
				 * resides at location NAN (0x80000000) */
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				context->last_x = x - 0.5;
				context->last_y = y - 0.5;
				DRIVER_UNLOCK();
				fb_GfxDraw(target, (FBSTRING *)value1);
				DRIVER_LOCK();
				x = context->last_x + 0.5;
				y = context->last_y + 0.5;
				break;

			case 'P':
				c++;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				value2 = value1;
				if (*c == ',') {
					c++;
					if ((value2 = parse_number(&c)) == NAN)
						goto error;
				}
				DRIVER_UNLOCK();
				fb_GfxPaint(target, x, y, value1 & __fb_gfx->color_mask, value2 & __fb_gfx->color_mask, NULL, PAINT_TYPE_FILL, COORD_TYPE_A);
				DRIVER_LOCK();
				break;

			case 'M':
				c++;
				rel = FALSE;
				while ((*c == ' ') || (*c == '\t'))
					c++;
				if ((*c == '+') || (*c == '-'))
				{
					rel = TRUE;
				}
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				if (*c++ != ',')
					goto error;
				if ((value2 = parse_number(&c)) == NAN)
					goto error;
				x2 = (float)value1;
				y2 = (float)value2;
				if (rel) {
					ax = cos(base_angle);
					ay = -sin(base_angle);
					dx = x2;
					dy = y2;
					x2 = (((dx * ax) - (dy * ay)) * base_scale) + x;
					y2 = (((dy * ax) + (dx * ay)) * base_scale) + y;
				}
				else {
					x2 += 0.5;
					y2 += 0.5;
				}
				if (draw) {
					DRIVER_UNLOCK();
					fb_GfxLine(target, (int)x, (int)y, (int)x2, (int)y2, 0, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA | DEFAULT_COLOR_1);
					DRIVER_LOCK();
				}
				if (move) {
					x = floor(x2) + 0.5;
					y = floor(y2) + 0.5;
				}
				move = draw = TRUE;
				break;

			case 'F': angle += PI * 0.25;
			case 'D': angle += PI * 0.25;
			case 'G': angle += PI * 0.25;
			case 'L': angle += PI * 0.25;
			case 'H': angle += PI * 0.25;
			case 'U': angle += PI * 0.25;
			case 'E': angle += PI * 0.25;
			case 'R':
				if ((toupper(*c) >= 'E') && (toupper(*c) <= 'H'))
					scale = SQRT_2;
				c++;
				if ((value1 = parse_number(&c)) != NAN)
					length = value1;
				else
					length = 1;
				break;
			
			default:
				c++;
				break;
		}

		if (length) {
			length = (int)(((float)length * (base_scale * scale)) + 0.5);
			if (length < 0) {
				angle += PI;
				length = -length;
			}
			angle += base_angle;
			dx = x;
			dy = y;

			for (; length >= 0; length--) {
				if (draw) {
					ix = dx;
					iy = dy;
					if ((ix >= context->view_x) && (ix < context->view_x + context->view_w) &&
					    (iy >= context->view_y) && (iy < context->view_y + context->view_h)) {
					    	context->put_pixel(context, ix, iy, context->fg_color);
						if (__fb_gfx->framebuffer == context->line[0])
							__fb_gfx->dirty[iy] = TRUE;
					}
				}
				if (length) {
					dx += cos(angle);
					dy -= sin(angle);
				}
			}
			if (move) {
				x = floor(dx) + 0.5;
				y = floor(dy) + 0.5;
			}
			angle = 0.0;
			scale = 1.0;
			length = 0;
			move = draw = TRUE;
		}
	}

	context->last_x = floor(x);
	context->last_y = floor(y);

error:
	context->flags = flags;

	DRIVER_UNLOCK();

	/* del if temp */
	fb_hStrDelTemp( command );
}
