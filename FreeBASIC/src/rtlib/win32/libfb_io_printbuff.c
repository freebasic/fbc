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
 * io_printbuff.c -- low-level print to console function for Windows
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

/*:::::*/
void fb_ConsolePrintBuffer( char *buffer, int mask )
{
    int col, row;
    int toprow, botrow;
	int cols, rows;
	int len, scrolloff = FALSE;
	int rowsleft, rowstoscroll;

	len = strlen( buffer );

	fb_ConsoleGetSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
	fb_ConsoleGetXY( &col, &row );

	/* scrolling */
	if( (row > botrow) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
		fb_ConsoleScroll( 1 );
		row = botrow;
	}

	/* if no newline and row at bottom and col+string at right, disable scrolling */
	if( (mask & FB_PRINT_NEWLINE) == 0 )
	{
		if( row == botrow )
			if( col + len - 1 == cols )
				scrolloff = TRUE;
	}

	HANDLE hnd = GetStdHandle( STD_OUTPUT_HANDLE );
	DWORD  mode, byteswritten;

	if( scrolloff )
	{
		GetConsoleMode( hnd, &mode );
		SetConsoleMode( hnd, mode & ~ENABLE_WRAP_AT_EOL_OUTPUT );
	}

	/* scrolling if VIEW was set */
	if( (!scrolloff) && (col + len - 1 > cols) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
    	rowsleft = (botrow - row) /*+ 1*/;
    	rowstoscroll = 1 + (len - (cols - col + 1)) / cols;
    	if( (mask & FB_PRINT_NEWLINE) != 0 )
    		++rowstoscroll;

     	if( rowstoscroll - rowsleft > 0 )
     	{
     		fb_ConsoleScroll( rowstoscroll - rowsleft );
     		fb_ConsoleLocate( botrow - (rowstoscroll - rowsleft), -1, -1 );
     	}
	}

    /* */
	while( WriteFile( hnd, buffer, len, &byteswritten, NULL ) == TRUE )
	{
		buffer += byteswritten;
		len -= byteswritten;
		if( len <= 0 )
			break;
	}

	if( scrolloff )
		SetConsoleMode( hnd, mode );

}

