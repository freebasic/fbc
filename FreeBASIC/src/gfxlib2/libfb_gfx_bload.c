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
 * bload.c -- BLOAD support.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL int fb_GfxBload(FBSTRING *filename, void *dest)
{
	FILE *f;
	unsigned char id;
	unsigned int data, size;
	int result = FB_RTERROR_OK;
	
	f = fopen(filename->data, "rb");
	if (!f)
		return FB_RTERROR_FILENOTFOUND;
	
	id = fgetc(f);
	switch (id) {
	
		case 0xFD:
			/* QB BSAVEd block */
			fgetc(f); fgetc(f); fgetc(f); fgetc(f);
			size = fgetc(f) | (fgetc(f) << 8);
			break;
		
		case 0xFE:
			/* FB BSAVEd block */
			size = fgetc(f) | (fgetc(f) << 8) | (fgetc(f) << 16) | (fgetc(f) << 24);
			break;
				
		default:
			result = FB_RTERROR_FILEIO;
			break;
	}
	
	if (result == FB_RTERROR_OK) {
		if (!dest) {
			if (!fb_mode)
				result = FB_RTERROR_ILLEGALFUNCTIONCALL;
			else {
				DRIVER_LOCK();
				size = MIN(size, fb_mode->pitch * fb_mode->h);
				if ((!fread(fb_mode->line[0], size, 1, f)) && (!feof(f)))
					result = FB_RTERROR_FILEIO;
				SET_DIRTY(0, fb_mode->h);
				if (!feof(f)) {
					fread(fb_mode->device_palette, 1024, 1, f);
					fb_hRestorePalette();
				}
				DRIVER_UNLOCK();
			}
		}
		else {
			if ((!fread(dest, size, 1, f)) && (!feof(f)))
				result = FB_RTERROR_FILEIO;
		}
	}
	fclose(f);
	
	return result;
}
