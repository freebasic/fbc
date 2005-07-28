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

int fb_ConsoleLocateRaw( int row, int col, int cursor );

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
    int col, row, end_row;
    int toprow, botrow;
	int cols, rows;
	int scrolloff = FALSE;
    int rowsleft, rowstoscroll;
    int win_top, win_left;
    const char *pachText = (const char *) buffer;

	fb_ConsoleGetScreenSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
    fb_ConsoleGetXY( &col, &row );

#if FB_CON_BOUNDS==1 || FB_CON_BOUNDS==2
    fb_ConsoleGetWindow( &win_left, &win_top, NULL, &end_row );
    end_row += win_top - 1;
#elif FB_CON_BOUNDS==3
    fb_ConsoleGetWindow( &win_left, &win_top, NULL, NULL );
    end_row = rows;
#else
    win_left = win_top = 1;
    end_row = fb_ConsoleGetMaxRow();
#endif

    row += win_top - 1;
    col += win_left - 1;
    toprow += win_top - 1;
    botrow += win_top - 1;

	/* scrolling */
	if( (row > botrow) && (botrow == end_row) )
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

	DWORD  mode, byteswritten;

	if( scrolloff )
	{
		GetConsoleMode( fb_out_handle, &mode );
		SetConsoleMode( fb_out_handle, mode & ~ENABLE_WRAP_AT_EOL_OUTPUT );
	}

	/* scrolling if VIEW was set */
	if( (!scrolloff) && (col + len - 1 > cols) && (botrow != end_row) )
	{
    	rowsleft = (botrow - row) /*+ 1*/;
    	rowstoscroll = 1 + (len - (cols - col + 1)) / cols;
    	if( (mask & FB_PRINT_NEWLINE) != 0 )
    		++rowstoscroll;

     	if( rowstoscroll - rowsleft > 0 )
     	{
     		fb_ConsoleScroll( rowstoscroll - rowsleft );
     		fb_ConsoleLocateRaw( botrow - (rowstoscroll - rowsleft), -1, -1 );
     	}
	}

    /* */
	while( WriteFile( fb_out_handle, pachText, len, &byteswritten, NULL ) == TRUE )
	{
		pachText += byteswritten;
		len -= byteswritten;
		if( len <= 0 )
			break;
	}

	if( scrolloff )
		SetConsoleMode( fb_out_handle, mode );

}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}

