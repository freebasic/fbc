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
 * get.c -- GET statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL int fb_GfxGet(void *target, float fx1, float fy1, float fx2, float fy2, unsigned char *dest, int coord_type, FBARRAY *array)
{
	int x1, y1, x2, y2, w, h;

	if (!fb_mode)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	fb_hPrepareTarget(target);

	fb_hFixRelative(coord_type, &fx1, &fy1, &fx2, &fy2);

	fb_hTranslateCoord(fx1, fy1, &x1, &y1);
	fb_hTranslateCoord(fx2, fy2, &x2, &y2);

	fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);

	if ((x1 < fb_mode->view_x) || (y1 < fb_mode->view_y) ||
	    (x2 >= fb_mode->view_x + fb_mode->view_w) || (y2 >= fb_mode->view_y + fb_mode->view_h))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	w = x2 - x1 + 1;
	h = y2 - y1 + 1;

	if( array != NULL )
		if ((array->size > 0) && ((int)dest + 4 + (w * h) > (int)array->ptr + array->size))
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	*(unsigned short *)dest = w << 3;
	*(unsigned short *)(dest + 2) = h;
	dest += 4;

	DRIVER_LOCK();

	for (; y1 <= y2; y1++) {
		fb_hPixelCpy(dest, fb_mode->line[y1] + (x1 * fb_mode->bpp), w);
		dest += (w * fb_mode->bpp);
	}

	DRIVER_UNLOCK();
	
	return FB_RTERROR_OK;
}
