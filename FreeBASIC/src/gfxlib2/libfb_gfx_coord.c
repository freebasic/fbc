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
 * coord.c -- coordinates management routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
void fb_hTranslateCoord(float fx, float fy, int *x, int *y)
{
	if (fb_mode->flags & WINDOW_ACTIVE) {
		fx = (fx - fb_mode->win_x) * (fb_mode->view_w - 1) / fb_mode->win_w;
		fy = (fy - fb_mode->win_y) * (fb_mode->view_h - 1) / fb_mode->win_h;
	}
	
	*x = (int)(fx + 0.5);
	*y = (int)(fy + 0.5);
	
	if (fb_mode->flags & (WINDOW_ACTIVE | WINDOW_SCREEN) == WINDOW_ACTIVE)
		*y = fb_mode->view_h - 1 - *y;
		
	if ((fb_mode->flags & VIEW_SCREEN) == 0) {
		*x += fb_mode->view_x;
		*y += fb_mode->view_y;
	}
}


/*:::::*/
void fb_hFixRelative(int coord_type, float *x1, float *y1, float *x2, float *y2)
{
	switch (coord_type) {
		
		case COORD_TYPE_R:
			*x1 = fb_mode->last_x;
			*y1 = fb_mode->last_y;
			break;
		
		case COORD_TYPE_RA:
			*x1 += fb_mode->last_x;
			*y1 += fb_mode->last_y;
			break;
		
			*x1 += fb_mode->last_x;
			*y1 += fb_mode->last_y;
			break;
		
		case COORD_TYPE_RR:
			*x1 += fb_mode->last_x;
			*y1 += fb_mode->last_y;
			/* fallthrough */
		
		case COORD_TYPE_AR:
			*x2 += *x1;
			*y2 += *y1;
			break;
	}
	
	if (x2) {
		fb_mode->last_x = *x2;
		fb_mode->last_y = *y2;
	}
	else {
		fb_mode->last_x = *x1;
		fb_mode->last_y = *y1;
	}
}


/*:::::*/
void fb_hFixCoordsOrder(int *x1, int *y1, int *x2, int *y2)
{
	if (*x2 < *x1)
		SWAP(*x1, *x2);
	
	if (*y2 < *y1)
		SWAP(*y1, *y2);
}
