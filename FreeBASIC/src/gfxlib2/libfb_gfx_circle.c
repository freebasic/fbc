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
 * circle.c -- CIRCLE statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
static void draw_scanline(int y, int x1, int x2, unsigned int color, int fill)
{
	if ((y >= fb_mode->view_y) && (y < fb_mode->view_y + fb_mode->view_h)) {
		if (fill) {
			x1 = MAX(x1, fb_mode->view_x);
			x2 = MIN(x2, fb_mode->view_x + fb_mode->view_w - 1);
			fb_hPixelSet(fb_mode->line[y] + (x1 * fb_mode->bpp), color, x2 - x1 + 1);
		}
		else {
			if ((x1 >= fb_mode->view_x) && (x1 < fb_mode->view_x + fb_mode->view_w))
				fb_hPutPixel(x1, y, color);
			if ((x2 >= fb_mode->view_x) && (x2 < fb_mode->view_x + fb_mode->view_w))
				fb_hPutPixel(x2, y, color);
		}
	}
}


/*:::::*/
static void draw_ellipse(int x, int y, float a, float b, unsigned int color, int fill)
{
	int d, x1, y1, x2, y2;
	int dx, dy, aq, bq, r, rx, ry;

	x1 = x - a;
	x2 = x + a;
	y1 = y2 = y;
	
	if (!b) {
		draw_scanline(y, x1, x2, color, TRUE);
		return;
	}
	else
		draw_scanline(y, x1, x2, color, fill);
	
	aq = a * a;
	bq = b * b;
	dx = aq << 1;
	dy = bq << 1;
	r = a * bq;
	rx = r << 1;
	ry = 0;
	d = a;
	
	while (d > 0) {
		if (r > 0) {
			y1++;
			y2--;
			ry += dx;
			r -= ry;
		}
		if (r <= 0) {
			d--;
			x1++;
			x2--;
			rx -= dy;
			r += rx;
		}
		draw_scanline(y1, x1, x2, color, fill);
		draw_scanline(y2, x1, x2, color, fill);
	}
}


/*:::::*/
static void get_arc_point(float angle, float a, float b, int *x, int *y)
{
	float c, s;
	
	c = cos(angle) * a;
	s = sin(angle) * b;
	if (c >= 0)
		*x = (int)(c + 0.5);
	else
		*x = (int)(c - 0.5);
	if (s >= 0)
		*y = (int)(s + 0.5);
	else
		*y = (int)(s - 0.5);
}


/*:::::*/
FBCALL void fb_GfxEllipse(float fx, float fy, float radius, int color, float aspect, float start, float end, int fill, int coord_type)
{
	int x, y, x1, y1, x2, y2;
	float a, b, x_start, y_start, x_end, y_end, points, increment;
	
	if (!fb_mode)
		return;
	
	if (color == DEFAULT_COLOR)
		color = fb_mode->fg_color;
	else
		color = fb_hFixColor(color);
	
	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(fx, fy, &x, &y);
	
	if (aspect == 0.0)
		aspect = (4.0 / 3.0) * ((float)fb_mode->h / (float)fb_mode->w);

	if (aspect > 1.0) {
		a = ((radius / aspect) + 0.5);
		b = radius + 0.5;
	}
	else {
		a = radius + 0.5;
		b = ((radius * aspect) + 0.5);
	}
	if (fb_mode->flags & WINDOW_ACTIVE) {
		a = fabs((float)a - fb_mode->win_x) * (fb_mode->view_w - 1) / fb_mode->win_w;
		b = fabs((float)b - fb_mode->win_y) * (fb_mode->view_h - 1) / fb_mode->win_h;
	}
	
	fb_mode->driver->lock();
	
	if ((start != 0.0) || (end != 3.141593f * 2.0)) {
		
		a -= 0.5;
		b -= 0.5;
		
		if (start < 0) {
			start = -start;
			get_arc_point(start, a, b, &x1, &y1);
			x1 = x + x1;
			y1 = y - y1;
			fb_GfxLine(x, y, x1, y1, color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA);
		}
		if (end < 0) {
			end = -end;
			get_arc_point(end, a, b, &x1, &y1);
			x1 = x + x1;
			y1 = y - y1;
			fb_GfxLine(x, y, x1, y1, color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA);
		}
		
		while (end < start)
			end += 2 * PI;
		while (end - start > 2 * PI)
			start += 2 * PI;
		
		increment = 1 / (sqrt(a) * sqrt(b) * 1.5);
		
		for (; start < end + (increment / 2); start += increment) {
			get_arc_point(start, a, b, &x1, &y1);
			x1 = x + x1;
			y1 = y - y1;
			if ((x1 < fb_mode->view_x) || (x1 >= fb_mode->view_x + fb_mode->view_w) ||
			    (y1 < fb_mode->view_y) || (y1 >= fb_mode->view_y + fb_mode->view_h))
				continue;
			fb_hPutPixel(x1, y1, color);
		}
	}
	else
		draw_ellipse(x, y, a, b, color, fill);
		
	y1 = MID(0, y - b, fb_mode->view_h - 1);
	y2 = MID(0, y + b, fb_mode->view_h - 1);
	if( y1 > y2 )
		SWAP( y1, y2 );
	fb_hMemSet(fb_mode->dirty + y1, TRUE, y2 - y1 + 1);
	
	fb_mode->driver->unlock();
	
	fb_mode->last_x = fx;
	fb_mode->last_y = fy;
}
