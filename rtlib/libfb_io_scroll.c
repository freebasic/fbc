/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * io_scroll.c -- console scrolling for when VIEW is used
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

/*:::::*/
void fb_ConsoleScroll( int nrows )
{
    int toprow, botrow;
    int cols, rows;

    if( nrows <= 0 )
    	return;

    fb_ConsoleGetSize( &cols, &rows );
    fb_ConsoleGetView( &toprow, &botrow );

#ifdef WIN32
    SMALL_RECT srec;
    COORD dcoord;
    CHAR_INFO cinf;

    srec.Left 	= 0;
    srec.Right 	= cols-1;
    srec.Top 	= toprow-1 + nrows;
    srec.Bottom = botrow-1;

    dcoord.X = 0;
    dcoord.Y = toprow-1;

    cinf.Char.AsciiChar	= ' ';
    cinf.Attributes 	= fb_ConsoleGetColorAtt( );

    ScrollConsoleScreenBuffer( GetStdHandle( STD_OUTPUT_HANDLE ), &srec, NULL, dcoord, &cinf );

#else /* WIN32 */

	!!!WRITEME!!! use gnu curses here !!!WRITEME!!!

#endif /* WIN32 */


	fb_ConsoleLocate( botrow - (nrows-1), -1 );

}
