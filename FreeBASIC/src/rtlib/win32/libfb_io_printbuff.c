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
 *       nov/2004 fixed scrolling problem if printing at Bottom/Right w/o a newline [v1ctor]
 *       sep/2005 re-implemented all printing stuff [mjs]
 *
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb_con.h"

typedef struct _fb_PrintInfo {
    fb_Rect         rWindow;
    fb_Coord        BufferSize;
    WORD            wAttributes;
    HANDLE          hOutput;
    int             fViewSet;
} fb_PrintInfo;

static
void fb_hHookConScroll(struct _fb_ConHooks *handle,
                       int x1,
                       int y1,
                       int x2,
                       int y2,
                       int rows)
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    HANDLE hnd = pInfo->hOutput;

    SMALL_RECT srScroll;
    COORD dwDest;
    CHAR_INFO FillChar;

    assert( rows==1 );

    if( !pInfo->fViewSet ) {
        /* Try to move the window first ... */
        if( (handle->Border.Bottom+1) < pInfo->BufferSize.Y ) {
            int remaining = pInfo->BufferSize.Y - handle->Border.Bottom - 1;
            int move_size = ((remaining < rows) ? remaining : rows);

            handle->Border.Top += move_size;
            handle->Border.Bottom += move_size;

            rows -= move_size;
            if( rows==0 )
                return;
        }

        /* We're at the end of the screen buffer - so we have to
         * scroll the complete screen buffer */
        dwDest.X = dwDest.Y = 0;
        srScroll.Right = (SHORT) (pInfo->BufferSize.X-1);
        srScroll.Bottom = (SHORT) (pInfo->BufferSize.Y-1);

    } else {
        /* Scroll only the area defined by a previous VIEW PRINT */
        dwDest.X = (SHORT) handle->Border.Left;
        dwDest.Y = (SHORT) handle->Border.Top;
        srScroll.Right = (SHORT) handle->Border.Right;
        srScroll.Bottom = (SHORT) handle->Border.Bottom;
    }

    srScroll.Left = dwDest.X;
    srScroll.Top = (SHORT) (dwDest.Y + rows);

    FillChar.Attributes = pInfo->wAttributes;
    FillChar.Char.AsciiChar = 32;

    ScrollConsoleScreenBuffer( hnd, &srScroll, NULL, dwDest, &FillChar );
}

static
void fb_hHookConLocate( struct _fb_ConHooks *handle )
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    HANDLE hnd = pInfo->hOutput;
    COORD dwCoord = { (SHORT) handle->Coord.X, (SHORT) handle->Coord.Y };
    SetConsoleCursorPosition( hnd,
                              dwCoord );
}

static
int  fb_hHookConWrite (struct _fb_ConHooks *handle,
                       const void *buffer,
                       size_t length,
                       size_t *written )
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    HANDLE hnd = pInfo->hOutput;
    DWORD dwBytesWritten = 0;
    DWORD dwMode = 0;
    int touches_right_bottom =
        ((handle->Coord.X + length - 1)==handle->Border.Right)
        && (handle->Coord.Y==handle->Border.Bottom);
    int result;

    if( touches_right_bottom ) {
        GetConsoleMode( hnd, &dwMode );
        SetConsoleMode( hnd, dwMode & ~ENABLE_WRAP_AT_EOL_OUTPUT );
    }

    result =
        WriteFile( hnd,
                   buffer,
                   length,
                   &dwBytesWritten,
                   NULL )==TRUE;

    if( touches_right_bottom ) {
        SetConsoleMode( hnd, dwMode );
    }

    if( written )
        *written = (size_t) dwBytesWritten;
    return result;
}

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

    /* Do we want to correct the Win32 console cursor position? */
    if( (mask & FB_PRINT_FORCE_ADJUST)==0 ) {
        /* No, we can check for the length to avoid unnecessary stuff ... */
        if( len==0 )
            return;
    }

    FB_LOCK();

    if( FB_CONSOLE_WINDOW_EMPTY() ) {
        /* output was redirected! */
        DWORD dwBytesWritten;
        while( len!=0 &&
               WriteFile( fb_out_handle,
                          pachText,
                          len,
                          &dwBytesWritten,
                          NULL ) == TRUE )
        {
            pachText += dwBytesWritten;
            len -= dwBytesWritten;
        }
        FB_UNLOCK();
        return;
    }

	fb_ConsoleGetView( &view_top, &view_bottom );
    fb_hConsoleGetWindow( &win_left, &win_top, &win_cols, &win_rows );

    hooks.Opaque        = &info;
    hooks.Scroll        = fb_hHookConScroll;
    hooks.Locate        = fb_hHookConLocate;
    hooks.Write         = fb_hHookConWrite ;
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.hOutput        = fb_out_handle;
    info.rWindow.Left   = win_left;
    info.rWindow.Top    = win_top;
    info.rWindow.Right  = win_left + win_cols - 1;
    info.rWindow.Bottom = win_top + win_rows - 1;
    info.fViewSet       = hooks.Border.Top!=info.rWindow.Top
        || hooks.Border.Bottom!=info.rWindow.Bottom;

    {
        CONSOLE_SCREEN_BUFFER_INFO screen_info;

        if( !GetConsoleScreenBufferInfo( fb_out_handle, &screen_info ) ) {
            hooks.Coord.X = hooks.Border.Left;
            hooks.Coord.Y = hooks.Border.Top;
            info.BufferSize.X = FB_SCRN_DEFAULT_WIDTH;
            info.BufferSize.Y = FB_SCRN_DEFAULT_HEIGHT;
            info.wAttributes = 7;
        } else {
            hooks.Coord.X = screen_info.dwCursorPosition.X;
            hooks.Coord.Y = screen_info.dwCursorPosition.Y;
            info.BufferSize.X = screen_info.dwSize.X;
            info.BufferSize.Y = screen_info.dwSize.Y;
            info.wAttributes = screen_info.wAttributes;
        }

        if( ScrollWasOff ) {
            ScrollWasOff = FALSE;
            ++hooks.Coord.Y;
            hooks.Coord.X = hooks.Border.Left;
            fb_hConCheckScroll( &hooks );
        }

        fb_ConPrintTTY( &hooks,
                        pachText,
                        len,
                        TRUE );

        if( hooks.Coord.X != hooks.Border.Left
            || hooks.Coord.Y != (hooks.Border.Bottom+1) )
        {
            fb_hConCheckScroll( &hooks );
        } else {
            ScrollWasOff = TRUE;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }
        fb_hHookConLocate( &hooks );
    }

    if( hooks.Border.Top!=win_top && !info.fViewSet ) {
        /* Now we have to ensure that the window shows the right part
         * of the screen buffer when it was moved previously ... */
        SMALL_RECT srWindow =
        {
            (SHORT) hooks.Border.Left,
            (SHORT) hooks.Border.Top,
            (SHORT) hooks.Border.Right,
            (SHORT) hooks.Border.Bottom
        };
        SetConsoleWindowInfo( info.hOutput, TRUE, &srWindow );
    }

    fb_hUpdateConsoleWindow( );

    FB_UNLOCK();
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}
