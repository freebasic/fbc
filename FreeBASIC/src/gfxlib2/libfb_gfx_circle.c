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

#define QUADRANT_START		0x1
#define QUADRANT_END		0x2
#define QUADRANT_USED		0x4
#define QUADRANT_UR_START	0x0001
#define QUADRANT_UR_END		0x0002
#define QUADRANT_UR_START_END	0x0003
#define QUADRANT_UR_USED	0x0004
#define QUADRANT_UL_START	0x0010
#define QUADRANT_UL_END		0x0020
#define QUADRANT_UL_START_END	0x0030
#define QUADRANT_UL_USED	0x0040
#define QUADRANT_DL_START	0x0100
#define QUADRANT_DL_END		0x0200
#define QUADRANT_DL_START_END	0x0300
#define QUADRANT_DL_USED	0x0400
#define QUADRANT_DR_START	0x1000
#define QUADRANT_DR_END		0x2000
#define QUADRANT_DR_START_END	0x3000
#define QUADRANT_DR_USED	0x4000


static int x_start, y_start;
static int x_end, y_end;
static int y_center, quadrant;

static void (*draw_scanline)(int, int, int, unsigned int, int);


/*:::::*/
static void draw_ellipse_scanline(int y, int x1, int x2, unsigned int color, int fill)
{
	if ((x2 < fb_mode->view_x) || (x1 >= fb_mode->view_x + fb_mode->view_w))
		return;
	
	if ((y >= fb_mode->view_y) && (y < fb_mode->view_y + fb_mode->view_h)) {
		if (fill) {
			x1 = MAX(x1, fb_mode->view_x);
			x2 = MIN(x2, fb_mode->view_x + fb_mode->view_w - 1);
			fb_hPixelSet(fb_mode->line[y] + x1, color, x2 - x1 + 1);
		}
		else {
			if (x1 >= fb_mode->view_x)
				fb_hPutPixel(x1, y, color);
			if (x2 < fb_mode->view_x + fb_mode->view_w)
				fb_hPutPixel(x2, y, color);
		}
	}
}


/*:::::*/
static void draw_arc_scanline(int y, int x1, int x2, unsigned int color, int fill)
{
	if ((x2 < fb_mode->view_x) || (x1 >= fb_mode->view_x + fb_mode->view_w))
		return;
	
	if ((y >= fb_mode->view_y) && (y < fb_mode->view_y + fb_mode->view_h)) {
		if ((x1 >= fb_mode->view_x) && (x1 < fb_mode->view_x + fb_mode->view_w)) {
			if (y > y_center) {
				if ((quadrant & QUADRANT_DL_USED) ||
				    (((quadrant & QUADRANT_DL_START_END) == QUADRANT_DL_START) && (x1 >= x_start) && (y >= y_start)) ||
				    (((quadrant & QUADRANT_DL_START_END) == QUADRANT_DL_END) && (x1 <= x_end) && (y <= y_end)) ||
				    (((quadrant & QUADRANT_DL_START_END) == QUADRANT_DL_START_END) && (x1 >= x_start) && (y >= y_start) && (x1 <= x_end) && (y <= y_end)))
					fb_hPutPixel(x1, y, color);
			}
			else {
				if ((quadrant & QUADRANT_UL_USED) ||
				    (((quadrant & QUADRANT_UL_START_END) == QUADRANT_UL_START) && (x1 <= x_start) && (y >= y_start)) ||
				    (((quadrant & QUADRANT_UL_START_END) == QUADRANT_UL_END) && (x1 >= x_end) && (y <= y_end)) ||
				    (((quadrant & QUADRANT_UL_START_END) == QUADRANT_UL_START_END) && (x1 <= x_start) && (y >= y_start) && (x1 >= x_end) && (y <= y_end)))
					fb_hPutPixel(x1, y, color);
			}
		}
		if ((x1 >= fb_mode->view_x) && (x2 < fb_mode->view_x + fb_mode->view_w)) {
			if (y > y_center) {
				if ((quadrant & QUADRANT_DR_USED) ||
				    (((quadrant & QUADRANT_DR_START_END) == QUADRANT_DR_START) && (x2 >= x_start) && (y <= y_start)) ||
				    (((quadrant & QUADRANT_DR_START_END) == QUADRANT_DR_END) && (x2 <= x_end) && (y >= y_end)) ||
				    (((quadrant & QUADRANT_DR_START_END) == QUADRANT_DR_START_END) && (x2 >= x_start) && (y <= y_start) && (x2 <= x_end) && (y >= y_end)))
					fb_hPutPixel(x2, y, color);
			}
			else {
				if ((quadrant & QUADRANT_UR_USED) ||
				    (((quadrant & QUADRANT_UR_START_END) == QUADRANT_UR_START) && (x2 <= x_start) && (y <= y_start)) ||
				    (((quadrant & QUADRANT_UR_START_END) == QUADRANT_UR_END) && (x2 >= x_end) && (y >= y_end)) ||
				    (((quadrant & QUADRANT_UR_START_END) == QUADRANT_UR_START_END) && (x2 <= x_start) && (y <= y_start) && (x2 >= x_end) && (y >= y_end)))
					fb_hPutPixel(x2, y, color);
			}
		}
	}
}


/*:::::*/
static void draw_ellipse(int x, int y, int a, int b, unsigned int color, int fill)
{
	int d, x1, y1, x2, y2;
	int dx, dy, aq, bq, r, rx, ry;

	x1 = x - a;
	x2 = x + a;
	y1 = y2 = y_center = y;
	
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
FBCALL void fb_GfxEllipse(float fx, float fy, float radius, int color, float aspect, float start, float end, int fill, int coord_type)
{
	int x, y, y1, y2, a, b, q1, q2;
	float temp;
	
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
		a = (int)((radius / aspect) + 0.5);
		b = (int)radius;
	}
	else {
		a = (int)radius;
		b = (int)((radius * aspect) + 0.5);
	}
	if (fb_mode->flags & WINDOW_ACTIVE) {
		a = fabs((float)a - fb_mode->win_x) * (fb_mode->view_w - 1) / fb_mode->win_w;
		b = fabs((float)b - fb_mode->win_y) * (fb_mode->view_h - 1) / fb_mode->win_h;
	}
	
	if ((y + b < fb_mode->view_y) || (y - b >= fb_mode->view_y + fb_mode->view_h))
		return;
	
	if ((start != 0.0) || (end != PI * 2.0)) {
		x_start = ((x + 0.5) + (cos(fabs(start)) * (float)a));
		y_start = ((y + 0.5) - (sin(fabs(start)) * (float)b));
		if (start < 0.0) {
			start = -start;
			fb_GfxLine(x, y, x_start, y_start, color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA);
		}
		x_end = (int)((float)x + 0.5 + (cos(fabs(end)) * (float)a));
		y_end = (int)((float)y + 0.5 - (sin(fabs(end)) * (float)b));
		if (end < 0.0) {
			end = -end;
			fb_GfxLine(x, y, x_end, y_end, color, LINE_TYPE_LINE, 0xFFFF, COORD_TYPE_AA);
		}
		q1 = (int)(start / (PI * 0.5)) & 0x3;
		q2 = (int)(end / (PI * 0.5)) & 0x3;
		quadrant = (QUADRANT_START << (q1 << 2)) | (QUADRANT_END << (q2 << 2));

		if (q1 != q2) {
			for (q1 = (q1 + 1) & 0x3; q1 != q2; q1 = (q1 + 1) & 0x3)
				quadrant |= (QUADRANT_USED << (q1 << 2));
		}
		draw_scanline = draw_arc_scanline;
	}
	else
		draw_scanline = draw_ellipse_scanline;
	
	fb_mode->driver->lock();
	
	draw_ellipse(x, y, a, b, color, fill);
	
	y1 = y - b;
	y2 = y + b;
	
	if( y1 > y2 )
		SWAP( y1, y2 );
		
	if (y1 < fb_mode->view_y)
		y1 = fb_mode->view_y;
	if (y2 >= fb_mode->view_y + fb_mode->view_h)
		y2 = fb_mode->view_y + fb_mode->view_h - 1;
	fb_hMemSet(fb_mode->dirty + y1, TRUE, y2 - y1 + 1);
	
	fb_mode->driver->unlock();
	
	fb_mode->last_x = fx;
	fb_mode->last_y = fy;
}
