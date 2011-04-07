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
	
	if (!__fb_gfx)
		return;
	
	index &= (__fb_gfx->default_palette->colors - 1);
	color = __fb_gfx->device_palette[index];
	if (!g) {
		*r = (color & 0xFCFCFC) >> 2;
	}
	else {
		*r = color & 0xFF;
		*g = (color & 0xFF00) >> 8;
		*b = (color & 0xFF0000) >> 16;
	}
}


FBCALL void fb_GfxPaletteGetUsing(int *data)
{
	int i, imax;
	
	if (!__fb_gfx)
		return;
	
	imax = __fb_gfx->default_palette->colors;
	if(imax > (1 << __fb_gfx->depth))
		imax = (1 << __fb_gfx->depth);
	
	for (i = 0; i < imax; i++)
		data[i] = (__fb_gfx->device_palette[i] & 0xFCFCFC) >> 2;
}
