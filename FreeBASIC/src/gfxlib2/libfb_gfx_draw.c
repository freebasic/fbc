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

#ifdef NAN
#undef NAN
#endif
#define NAN		0x80000000

#define SQRT_2		1.4142135623730950488016


static float base_scale = 4.0, base_angle = 0.0;


/*:::::*/
static int parse_number(char **str)
{
	char *c = *str;
	int n = NAN, negative = FALSE;

	while ((*c == ' ') || (*c == '\t'))
		c++;
	if (*c == '-') {
		negative = TRUE;
		c++;
	}
	if (*c == '+')
		c++;
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
	float x, y, dx, dy, ax, ay, x2, y2, scale = 1.0, angle = 0.0;
	char *c = command->data;
	int draw = TRUE, move = TRUE, length = 0, value1, value2, flags, rel, ix, iy;

	if (!fb_mode)
		return;
	
	fb_hPrepareTarget(target);

	x = fb_mode->last_x + 0.5;
	y = fb_mode->last_y + 0.5;

	DRIVER_LOCK();

	flags = fb_mode->flags;
	fb_mode->flags = VIEW_SCREEN;

	while (*c) {
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
				fb_mode->fg_color = fb_hFixColor(value1);
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
				fb_GfxDraw(target, (FBSTRING *)value1);
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
				fb_GfxPaint(target, x, y, value1 & fb_mode->color_mask, value2 & fb_mode->color_mask, NULL, PAINT_TYPE_FILL, COORD_TYPE_A);
				DRIVER_LOCK();
				break;

			case 'M':
				c++;
				rel = FALSE;
				if (*c == '+')
					rel = TRUE;
				if ((value1 = parse_number(&c)) == NAN)
					goto error;
				if (*c++ != ',')
					goto error;
				if ((value2 = parse_number(&c)) == NAN)
					goto error;
				if ((value1 < 0) || (value2 < 0))
					rel = TRUE;
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
					fb_GfxLine(target, (int)x, (int)y, (int)x2, (int)y2, DEFAULT_COLOR, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA);
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
					if ((ix >= fb_mode->view_x) && (ix < fb_mode->view_x + fb_mode->view_w) &&
					    (iy >= fb_mode->view_y) && (iy < fb_mode->view_y + fb_mode->view_h)) {
					    	fb_hPutPixel(ix, iy, fb_mode->fg_color);
						if (fb_mode->framebuffer == fb_mode->line[0])
							fb_mode->dirty[iy] = TRUE;
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

	fb_mode->last_x = floor(x);
	fb_mode->last_y = floor(y);

error:
	fb_mode->flags = flags;

	DRIVER_UNLOCK();

	/* del if temp */
	fb_hStrDelTemp( command );
}
