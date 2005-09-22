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
 * io_cls.c -- cls (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>
#include <pc.h>


/*:::::*/
void fb_ConsoleClear( int mode )
{
	int toprow, botrow;

	if( (mode == 1) || (mode == 0xFFFF0000) ) {	/* same as gfxlib's DEFAULT_COLOR */
        fb_ConsoleGetView( &toprow, &botrow );
        --toprow;
        --botrow;
    } else {
        toprow = 0;
        botrow = ScreenRows() - 1;
	}

    fb_ConsoleScroll_BIOS( 0, toprow, ScreenCols()-1, botrow, 0 );
	fb_ConsoleLocate_BIOS( toprow, 0, -1 );
}


