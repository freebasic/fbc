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
 * setup.c -- internal function tables setup
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
static void fb_hPutPixel1(int x, int y, unsigned int color)
{
	fb_mode->line[y][x] = color;
}


/*:::::*/
static void fb_hPutPixel2(int x, int y, unsigned int color)
{
	((unsigned short *)fb_mode->line[y])[x] = color;
}


/*:::::*/
static void fb_hPutPixel4(int x, int y, unsigned int color)
{
	((unsigned int *)fb_mode->line[y])[x] = color;
}


/*:::::*/
static unsigned int fb_hGetPixel1(int x, int y)
{
	return fb_mode->line[y][x];
}


/*:::::*/
static unsigned int fb_hGetPixel2(int x, int y)
{
	return ((unsigned short *)fb_mode->line[y])[x];
}


/*:::::*/
static unsigned int fb_hGetPixel4(int x, int y)
{
	return ((unsigned int *)fb_mode->line[y])[x];
}


/*:::::*/
static void *fb_hPixelSet2(void *dest, int color, size_t size)
{
	unsigned short *d = (unsigned short *)dest;
	
	for (; size; size--)
		*d++ = color;
	
	return dest;
}


/*:::::*/
static void *fb_hPixelSet4(void *dest, int color, size_t size)
{
	unsigned int *d = (unsigned int *)dest;
	
	for (; size; size--)
		*d++ = color;
	
	return dest;
}


/*:::::*/
static void *fb_hPixelCpy2(void *dest, const void *src, size_t size)
{
	return fb_hMemCpy(dest, src, size << 1);
}


/*:::::*/
static void *fb_hPixelCpy4(void *dest, const void *src, size_t size)
{
	return fb_hMemCpy(dest, src, size << 2);
}


/*:::::*/
void fb_hSetupFuncs(void)
{
	if (fb_hHasMMX()) {
		fb_mode->flags |= HAS_MMX;
		fb_hMemCpy = fb_hMemCpyMMX;
		fb_hMemSet = fb_hMemSetMMX;
	}
	else {
		fb_hMemCpy = memcpy;
		fb_hMemSet = memset;
	}
	switch (fb_mode->depth) {
		case 1:
		case 2:
		case 4:
		case 8:
			fb_hPutPixel = fb_hPutPixel1;
			fb_hGetPixel = fb_hGetPixel1;
			fb_hPixelSet = fb_hMemSet;
			fb_hPixelCpy = fb_hMemCpy;
			break;
		
		case 15:
		case 16:
			fb_hPutPixel = fb_hPutPixel2;
			fb_hGetPixel = fb_hGetPixel2;
			fb_hPixelSet = fb_hPixelSet2;
			fb_hPixelCpy = fb_hPixelCpy2;
			break;
		
		default:
			fb_hPutPixel = fb_hPutPixel4;
			fb_hGetPixel = fb_hGetPixel4;
			fb_hPixelSet = fb_hPixelSet4;
			fb_hPixelCpy = fb_hPixelCpy4;
			break;
	}
}
