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
 * bsave.c -- BSAVE support.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL int fb_GfxBsave(FBSTRING *filename, void *src, unsigned int size)
{
	FILE *f;
	int result = FB_RTERROR_OK;
	
	f = fopen(filename->data, "wb");
	if (!f)
		return FB_RTERROR_FILENOTFOUND;
	
	fb_hPrepareTarget(NULL);
	
	fputc(0xFE, f);
	fputc(size & 0xFF, f);
	fputc((size >> 8) & 0xFF, f);
	fputc((size >> 16) & 0xFF, f);
	fputc(size >> 24, f);
	
	if (!src) {
		DRIVER_LOCK();
		size = MIN(size, fb_mode->pitch * fb_mode->h);
		if (!fwrite(fb_mode->line[0], size, 1, f))
			result = FB_RTERROR_FILEIO;
		DRIVER_UNLOCK();
		if (fb_mode->depth <= 8) {
			size = (1 << fb_mode->depth) * sizeof(int);
			if (!fwrite(fb_mode->device_palette, size, 1, f) != size)
				result = FB_RTERROR_FILEIO;
		}
	}
	else if (!fwrite(src, size, 1, f))
		result = FB_RTERROR_FILEIO;
	fclose(f);
	
	return result;
}
