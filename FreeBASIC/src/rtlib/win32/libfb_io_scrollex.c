/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_scroll.c -- console scrolling for when VIEW is used for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: only use window width [mjs]
 *                mod: use convert*console functions [mjs]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleScrollRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2, int nrows )
{
    int height = y2 - y1 + 1;

    if( nrows <= 0 )
        return;

    if( nrows >= height ) {
        /* clear view */
        fb_ConsoleClearViewRawEx( hConsole, x1, y1, x2, y2 );

    } else {
        /* scroll view */
        SMALL_RECT srec;
        COORD dcoord;
        CHAR_INFO cinf;

        srec.Left 	= (SHORT) x1;
        srec.Right 	= (SHORT) x2;
        srec.Top 	= (SHORT) (y1 + nrows);
        srec.Bottom = (SHORT) y2;

        dcoord.X = (SHORT) x1;
        dcoord.Y = (SHORT) y1;

        cinf.Char.AsciiChar	= ' ';
        cinf.Attributes 	= fb_ConsoleGetColorAttEx( hConsole );

        ScrollConsoleScreenBuffer( hConsole, &srec, NULL, dcoord, &cinf );
#if 0
        fb_ConsoleLocateRawEx( hConsole, y2 - nrows, -1, -1 );
#endif
    }
}

