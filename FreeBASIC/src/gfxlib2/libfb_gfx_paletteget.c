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
 * paletteget.c -- palette retrieving routines
 *
 * chng: may/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


FBCALL void fb_GfxPaletteGet(int index, int *r, int *g, int *b)
{
	unsigned int color;
	
	if (!fb_mode)
		return;
	
	index &= (fb_mode->default_palette->colors - 1);
	color = (fb_mode->device_palette[index] & 0xFCFCFC) >> 2;
	if (!g) {
		*r = color;
	}
	else {
		*r = color & 0xFF;
		*g = (color & 0xFF00) >> 8;
		*b = (color & 0xFF0000) >> 16;
	}
}


FBCALL void fb_GfxPaletteGetUsing(int *data)
{
	int i;
	
	if (!fb_mode)
		return;
	
	for (i = 0; i < fb_mode->default_palette->colors; i++)
		data[i] = (fb_mode->device_palette[i] & 0xFCFCFC) >> 2;
}
