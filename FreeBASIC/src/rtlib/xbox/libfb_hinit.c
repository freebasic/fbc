/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * init.c -- libfb initialization for xbox
 *
 * chng: jul/2005 written [DrV]
 *
 */

#include <stdlib.h>
#include "../fb.h"
#include "../fb_rterr.h"
#include "fb_xbox.h"

#ifdef MULTITHREADED
CRITICAL_SECTION fb_global_mutex;
CRITICAL_SECTION fb_string_mutex;
#endif

void DrawPixel(SDL_Surface *screen, int x, int y, unsigned char R, unsigned char G, unsigned char B)
{
	unsigned int color = SDL_MapRGB(screen->format, R, G, B);
	unsigned int *bufp;
	bufp = (unsigned int *)screen->pixels + y*screen->pitch/4 + x;
	*bufp = color;
}

void drawScreen(int width, int height, int bpp)
{
	SDL_Init(SDL_INIT_VIDEO);
	SDL_Surface *screen = SDL_SetVideoMode(width, height, bpp, SDL_HWSURFACE | SDL_DOUBLEBUF);
	for(int x=0; x<width; x++)
	{
		for(int y=0; y<height; y++)
		{
			DrawPixel(screen, x, y, y/2, y/2, x/3);
		}
	}
	SDL_Flip(screen);
	XSleep(1000);
}

/*:::::*/
void fb_hInit ( int argc, char **argv )
{
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );


#ifdef MULTITHREADED

	/* !!!FIXME!!! replace with xbox/openxdk equivalents */

	InitializeCriticalSection(&fb_global_mutex);
	InitializeCriticalSection(&fb_string_mutex);

#endif

    drawScreen(640, 480, 8);
}
