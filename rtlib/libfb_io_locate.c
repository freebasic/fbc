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
 * io_locate.c -- locate (console, no gfx) function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#ifndef DISABLE_NCURSES
#include <curses.h>
#endif
#endif

/*:::::*/
void fb_ConsoleLocate( int row, int col, int cursor )
{

#ifdef WIN32
	HANDLE handle;
	COORD c;
	CONSOLE_CURSOR_INFO info;

  	if( col > 0 )
  		c.X = col - 1;
  	else
  		c.X = fb_ConsoleGetX() - 1;

  	if( row > 0 )
  		c.Y = row - 1;
  	else
  		c.Y = fb_ConsoleGetY() - 1;

  	handle = GetStdHandle( STD_OUTPUT_HANDLE );
  	GetConsoleCursorInfo( handle, &info );
  	if( cursor >= 0 )
  		info.bVisible = ( cursor ? TRUE : FALSE );

  	SetConsoleCursorPosition( handle, c );
  	SetConsoleCursorInfo( handle, &info );

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	int x, y;
	
	if (col > 0)
		x = col - 1;
	else
		x = getcurx(stdscr);
	
	if (row > 0)
		y = row - 1;
	else
		y = getcury(stdscr);
	
	if (cursor >= 0)
		set_curs(cursor ? 1 : 0);
	
	move(y, x);
	refresh();
#endif

#endif /* WIN32 */

}


/*:::::*/
int fb_ConsoleGetX( void )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.X + 1;

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	return getcurx(stdscr) + 1;
#else
	return 0;
#endif

#endif /* WIN32 */

}

/*:::::*/
int fb_ConsoleGetY( void )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.Y + 1;

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	return getcury(stdscr) + 1;
#else
	return 0;
#endif

#endif /* WIN32 */

}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );

    if( col != NULL )
    	*col = info.dwCursorPosition.X + 1;
    if( row != NULL )
    	*row = info.dwCursorPosition.Y + 1;

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	if (col != NULL)
		*col = getcurx(stdscr) + 1;
	if (row != NULL)
		*row = getcury(stdscr) + 1;
#endif

#endif /* WIN32 */

}

