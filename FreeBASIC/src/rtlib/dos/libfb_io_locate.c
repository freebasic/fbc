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
 * io_locate.c -- locate (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>
#include <go32.h>
#include <pc.h>
#include <sys/farptr.h>

/*:::::*/
void fb_RestoreCursor(void)
{
	_setcursortype(_NORMALCURSOR);
}

/*:::::*/
int fb_ConsoleLocate( int row, int col, int cursor )
{
	int x, y;
	static int visible = 0x10000;

  	if( col > 0 )
  		x = col;
  	else
  		x = wherex();

  	if( row > 0 )
  		y = row;
  	else
  		y = wherey();

	y -= fb_ConsoleGetTopRow( );

	if (cursor >= 0) {
		visible = cursor ? 0x10000 : 0;
		_setcursortype( cursor ? _NORMALCURSOR : _NOCURSOR );
		fb_AtExit(fb_RestoreCursor);
	}

    fb_FileSetLineLen( 0, x - 1 );

	gotoxy(x, y);

	return (x & 0xFF) | ((y & 0xFF) << 8) | visible;
}


/*:::::*/
int fb_ConsoleGetX( void )
{
	return wherex() + 1;
}

/*:::::*/
int fb_ConsoleGetY( void )
{
	return wherey() + 1;
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int r, c;

	ScreenGetCursor(&r, &c);

	if( col != NULL )
		*col = c + 1;

	if( row != NULL )
		*row = r + 1;
}

/*:::::*/
FBCALL int fb_ConsoleReadXY( int col, int row, int colorflag )
{
	unsigned short word;

	word = _farpeekw(_dos_ds, ScreenPrimary + (((row - 1) * ScreenCols() + (col - 1)) << 1));

	if (colorflag) {
		return (word >> 8) & 0xFF;
	} else {
		return word & 0xFF;
	}
}
