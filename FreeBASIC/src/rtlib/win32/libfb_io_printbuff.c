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
 * io_printbuff.c -- low-level print to console function for Windows
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

#define FB_USE_VIEW_BUFFER FALSE

#if FB_USE_VIEW_BUFFER
/** Copy the contents from one screen buffer to another.
 */
static void fb_hBufferCopy( HANDLE hDest, int dx, int dy,
                        HANDLE hSource, int x1, int y1, int x2, int y2,
                        int set_env)
{
    PCHAR_INFO lpBuffer;
    COORD dwBufferSize;
    COORD dwBufferCoord;
    SMALL_RECT r;
    size_t BufferSize;

    DBG_ASSERT(x1 <= x2);
    DBG_ASSERT(y1 <= y2);
    DBG_ASSERT( hDest != NULL );
    DBG_ASSERT( hSource != NULL );

    dwBufferSize.X = (SHORT) (x2 - x1 + 1);
    dwBufferSize.Y = (SHORT) (y2 - y1 + 1);

    dwBufferCoord.X = dwBufferCoord.Y = 0;

    /* Copy console contents */
    BufferSize = (x2 - x1 + 1) * (y2 - y1 + 1) * sizeof(CHAR_INFO);
    lpBuffer = (PCHAR_INFO) malloc(BufferSize);
    r.Left = (SHORT) x1;
    r.Top = (SHORT) y1;
    r.Right = (SHORT) x2;
    r.Bottom = (SHORT) y2;
    ReadConsoleOutput( hSource, lpBuffer, dwBufferSize, dwBufferCoord, &r );
    r.Left = (SHORT) dx;
    r.Top = (SHORT) dy;
    r.Right = (SHORT) (r.Left + dwBufferSize.X - 1);
    r.Bottom = (SHORT) (r.Top + dwBufferSize.Y - 1);
    WriteConsoleOutput( hDest, lpBuffer, dwBufferSize, dwBufferCoord, &r );
    free(lpBuffer);

    if( set_env ) {
        int col, row;

        /* Set console color */
        SetConsoleTextAttribute( hDest, (WORD) fb_ConsoleGetColorAttEx( hSource ) );

        /* Set cursor position */
        fb_ConsoleGetRawXYEx( hSource, &col, &row );
        if( col!=-1 && row!=-1 ) {
            COORD cDest;

            if( row > y2 ) {
                fb_ConsoleScrollRawEx( hDest, r.Left, r.Top, r.Right, r.Bottom, row - y2 );
                row = y2;
            }

            cDest.X = (SHORT) (col - x1 + dx);
            cDest.Y = (SHORT) (row - y1 + dy);
            SetConsoleCursorPosition( hDest, cDest );
        }
    }
}

/** Creates a new console screen buffer from a source buffer.
 */
static HANDLE fb_hBufferCreateCopy( HANDLE hSource, int x1, int y1, int x2, int y2 )
{
    CONSOLE_CURSOR_INFO cursor_info;
    HANDLE hDest;
    COORD dwSize;

    DBG_ASSERT(x1 <= x2);
    DBG_ASSERT(y1 <= y2);
    DBG_ASSERT( hSource != NULL );

    hDest = CreateConsoleScreenBuffer( GENERIC_READ | GENERIC_WRITE,
                                       0,
                                       NULL,
                                       CONSOLE_TEXTMODE_BUFFER,
                                       NULL );
    DBG_ASSERT( hDest != NULL );

    /* Always hide cursor in temporary buffer (otherwise we'll get some
     * cursor "artifacts") */
    memset(&cursor_info, 0, sizeof(CONSOLE_CURSOR_INFO) );
    cursor_info.dwSize = 100;
    SetConsoleCursorInfo( hDest, &cursor_info );

    SetConsoleMode( hDest, ENABLE_PROCESSED_OUTPUT );
    /* The following instruction might fail on Win9x/ME systems */
    SetConsoleMode( hDest, ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT );

    dwSize.X = x2 - x1 + 1;
    dwSize.Y = y2 - y1 + 1;
    SetConsoleScreenBufferSize( hDest, dwSize );

    /* Copy screen buffer contents */
    BufferCopy( hDest, 0, 0,
                hSource, x1, y1, x2, y2,
                TRUE );

    return hDest;
}

/** Destroys a screen buffer.
 */
static void fb_hBufferFree( HANDLE hSource )
{
    DBG_ASSERT( hSource != NULL );
    CloseHandle( hSource );
}
#endif

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    CONSOLE_CURSOR_INFO cursor_info;
    BOOL cursor_visible = FALSE;
    int scrolloff = FALSE;
    DWORD mode, byteswritten;
    BOOL is_view_set, is_window_empty;
    HANDLE hView = NULL;
    int col, row;
    int buf_cols, buf_rows;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;

    if( len==0 )
        return;

    is_window_empty = FB_CONSOLE_WINDOW_EMPTY();

	fb_ConsoleGetScreenSize( &buf_cols, &buf_rows );
	fb_ConsoleGetView( &view_top, &view_bottom );
    fb_ConsoleGetXY( &col, &row );
    fb_hConsoleGetWindow( &win_left, &win_top, &win_cols, &win_rows );

    is_view_set = view_top != 1 || view_bottom != win_rows;

    if( !is_window_empty ) {
        /* turn the cursor off */
        GetConsoleCursorInfo( fb_out_handle, &cursor_info );
        cursor_visible = cursor_info.bVisible;
        cursor_info.bVisible = FALSE;
        SetConsoleCursorInfo( fb_out_handle, &cursor_info );

        /* scrolling */
        if( ((row > view_bottom) && is_view_set) || ScrollWasOff )
        {
            int TmpScrollWasOff = ScrollWasOff;
            fb_ConsoleScroll( 1 );
            row = view_bottom;
            if( TmpScrollWasOff ) {
                col = 1;
                ScrollWasOff = FALSE;
                fb_ConsoleLocate( row, col, -1 );
            }
        }

        /* if no newline and row at bottom and col+string at right, disable scrolling */
        if( (mask & FB_PRINT_NEWLINE) == 0 )
        {
            if( row == view_bottom ) {
                /* FIXME: This doesn't work when the line contains control characters. */
                if( col + len - 1 == win_cols ) {
                    scrolloff = TRUE;
                }
            }
        }

        /* disable scrolling? */
        if( scrolloff )
        {
            GetConsoleMode( fb_out_handle, &mode );
            SetConsoleMode( fb_out_handle, mode & ~ENABLE_WRAP_AT_EOL_OUTPUT );
        }

        /* scrolling if VIEW was set */
        if( is_view_set )
        {
#if FB_USE_VIEW_BUFFER
            hView = fb_hBufferCreateCopy( fb_out_handle,
                                          win_left, win_top + view_top - 1,
                                          win_left + win_cols - 1, win_top + view_bottom - 1 );
#else
            int rowsleft = (view_bottom - row) /*+ 1*/;
            int rowstoscroll = 1 + ((int) len - (win_cols - col + 1)) / win_cols;
            if( (mask & FB_PRINT_NEWLINE) != 0 )
                ++rowstoscroll;

            if( rowstoscroll - rowsleft > 0 )
                fb_ConsoleScroll( rowstoscroll - rowsleft );
            hView = fb_out_handle;
#endif
        }
        else
        {
            hView = fb_out_handle;
        }

        if( hView == fb_out_handle )
        {
            /* Ensure that the user didn't do some scrolling/resizing
             * of the window */
            fb_hRestoreConsoleWindow( );
        }
    } else {
        hView = fb_out_handle;
    }

    while( WriteFile( hView, pachText, len, &byteswritten, NULL ) == TRUE )
    {
    	pachText += byteswritten;
        len -= byteswritten;
        if( len <= 0 )
        	break;
	}

    if( !is_window_empty ) {
        if( hView != fb_out_handle )
        {
#if FB_USE_VIEW_BUFFER
            /* copy back from view to normal screen buffer */
            fb_hBufferCopy( fb_out_handle, win_left, win_top + view_top - 1,
                            hView, 0, 0, win_cols - 1, view_bottom - view_top,
                            TRUE );
            fb_hBufferFree( hView );
#endif
        }
        else
            fb_hUpdateConsoleWindow( );

        if( scrolloff ) {
            SetConsoleMode( fb_out_handle, mode );
        }

        /* restore the old cursor mode */
        cursor_info.bVisible = cursor_visible;
        SetConsoleCursorInfo( fb_out_handle, &cursor_info );

        ScrollWasOff = scrolloff;
    }
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}

