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
 * io_getsize.c -- get size (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
#if 0
    int toprow, botrow;
#endif

	fb_hResize();
	
	if (cols) {
		if (fb_con.inited)
			*cols = fb_con.w;
		else
			*cols = 80;
	}
	
    if( rows != NULL )
    {
#if 0
    	fb_ConsoleGetView( &toprow, &botrow );

        *rows = botrow - toprow + 1;
#else
		if (fb_con.inited)
			*rows = fb_con.h;
		else
			*rows = 24;
#endif
    }
}
