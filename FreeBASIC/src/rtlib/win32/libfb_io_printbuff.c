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
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

#define OUTPUT_BUFFER_SIZE 128

static __inline__
int fb_hConsoleCheckScroll( HANDLE hConsoleOutput,
                            SMALL_RECT *pBorder,
                            COORD *pCoord )
{
    if( pBorder->Bottom!=-1 ) {
        if( pCoord->Y > pBorder->Bottom ) {
            int nRows = pCoord->Y - pBorder->Bottom;
            fb_ConsoleScrollRawEx( hConsoleOutput,
                                   pBorder->Left,
                                   pBorder->Top,
                                   pBorder->Right,
                                   pBorder->Bottom,
                                   nRows );
            pCoord->Y = pBorder->Bottom;
            return TRUE;
        }
    }
    return FALSE;
}

static
void fb_hConsolePrintRaw( HANDLE hConsoleOutput,
                          const char *pachText,
                          size_t TextLength,
                          SMALL_RECT *pBorder,
                          COORD *pCoord )
{
    while( TextLength!=0 ) {
        size_t RemainingWidth = pBorder->Right - pCoord->X + 1;
        size_t MaxCopySize = (TextLength > RemainingWidth) ? RemainingWidth : TextLength;
        size_t CopySize = MaxCopySize;
        DWORD dwBytesWritten;

        TextLength -= MaxCopySize;

        fb_hConsoleCheckScroll( hConsoleOutput, pBorder, pCoord );
        SetConsoleCursorPosition( hConsoleOutput, *pCoord );

        while( CopySize!=0 &&
               WriteFile( hConsoleOutput,
                          pachText,
                          CopySize,
                          &dwBytesWritten,
                          NULL ) == TRUE )
        {
            pachText += dwBytesWritten;
            CopySize -= dwBytesWritten;
        }

        pCoord->X += MaxCopySize - CopySize;
        if( pCoord->X==(pBorder->Right + 1) ) {
            pCoord->X = pBorder->Left;
            pCoord->Y += 1;
        }

        if( CopySize!=0 )
            break;
    }
}

static
void fb_hConsolePrintTTY( HANDLE hConsoleOutput,
                          const char *pachText,
                          size_t TextLength,
                          SMALL_RECT *pBorder,
                          COORD *pCoord,
                          int is_text_mode )
{
    static const char achTabSpaces[8] = { 32, 32, 32, 32, 32, 32, 32, 32 };
    char OutputBuffer[OUTPUT_BUFFER_SIZE];
    size_t OutputBufferLength = 0;

    COORD dwCurrentCoord, dwConsoleCoord;
    size_t IndexText;
    int fGotNewCoordinate = FALSE;
    SHORT BorderWidth = pBorder->Right - pBorder->Left + 1;

    memcpy( &dwCurrentCoord, pCoord, sizeof( COORD ) );
    memcpy( &dwConsoleCoord, pCoord, sizeof( COORD ) );

    for( IndexText=0; IndexText!=TextLength; ++IndexText ) {
        const char *pachOutputData = pachText + IndexText;
        size_t OutputDataLength = 0;
        int fDoFlush = FALSE;
        int fSetNewCoord = FALSE;
        COORD dwNewCoord;
        switch ( *pachOutputData ) {
        case '\a':
            /* ALARM */
            fb_Beep();
            break;
        case '\b':
            /* BACKSPACE */
            fSetNewCoord = TRUE;
            if( dwCurrentCoord.X > pBorder->Left ) {
                dwNewCoord.X = dwCurrentCoord.X - 1;
            } else {
                dwNewCoord.X = pBorder->Left;
            }
            dwNewCoord.Y = dwCurrentCoord.Y;
            break;
        case '\n':
            /* LINE FEED / NEW LINE */
            fSetNewCoord = TRUE;
            if( is_text_mode ) {
                dwNewCoord.X = pBorder->Left;
                dwNewCoord.Y = dwCurrentCoord.Y + 1;
            } else {
                dwNewCoord.X = dwCurrentCoord.X;
                dwNewCoord.Y = dwCurrentCoord.Y + 1;
            }
            break;
        case '\r':
            /* CARRIAGE RETURN */
            fSetNewCoord = TRUE;
            dwNewCoord.X = pBorder->Left;
            dwNewCoord.Y = dwCurrentCoord.Y;
            break;
        case '\t':
            /* TAB */
            pachOutputData = achTabSpaces;
            OutputDataLength = ((dwCurrentCoord.X - pBorder->Left + 8) & ~7) - (dwCurrentCoord.X - pBorder->Left);
            break;
        default:
            OutputDataLength = 1;
            break;
        }
        if( OutputDataLength + OutputBufferLength > OUTPUT_BUFFER_SIZE ) {
            fDoFlush = TRUE;
        } else if( fSetNewCoord ) {
            fDoFlush = TRUE;
        }
        if( fDoFlush ) {
            fDoFlush = FALSE;
            if( OutputBufferLength!=0 ) {
                fb_hConsolePrintRaw( hConsoleOutput,
                                     OutputBuffer,
                                     OutputBufferLength,
                                     pBorder,
                                     &dwConsoleCoord );
                OutputBufferLength = 0;
                fGotNewCoordinate = FALSE;
            }
        }
        if( fSetNewCoord ) {
            fSetNewCoord = FALSE;
            memcpy( &dwCurrentCoord, &dwNewCoord, sizeof( COORD ) );
            memcpy( &dwConsoleCoord, &dwNewCoord, sizeof( COORD ) );
            fGotNewCoordinate = TRUE;
        }
        if( OutputDataLength!=0 ) {
            dwCurrentCoord.X += OutputDataLength;
            if( dwCurrentCoord.X > pBorder->Right ) {
                SHORT NormalX = dwCurrentCoord.X - pBorder->Left;
                dwCurrentCoord.X = (NormalX % BorderWidth) + pBorder->Left;
                dwCurrentCoord.Y += NormalX / BorderWidth;
            }
            while( OutputDataLength-- ) {
                OutputBuffer[OutputBufferLength++] = *pachOutputData++;
            }
        }
    }

    if( OutputBufferLength!=0 ) {
        fb_hConsolePrintRaw( hConsoleOutput,
                             OutputBuffer,
                             OutputBufferLength,
                             pBorder,
                             &dwConsoleCoord );
    } else if( fGotNewCoordinate ) {
        fb_hConsoleCheckScroll( hConsoleOutput, pBorder, &dwConsoleCoord );
        SetConsoleCursorPosition( hConsoleOutput, dwConsoleCoord );
    }

    memcpy( pCoord, &dwConsoleCoord, sizeof( COORD ) );
}

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    DWORD mode;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;

    if( len==0 )
        return;

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
        return;
    }

	fb_ConsoleGetView( &view_top, &view_bottom );
    fb_hConsoleGetWindow( &win_left, &win_top, &win_cols, &win_rows );

    GetConsoleMode( fb_out_handle, &mode );
    SetConsoleMode( fb_out_handle, mode & ~ENABLE_WRAP_AT_EOL_OUTPUT );

    {
        CONSOLE_SCREEN_BUFFER_INFO info;
        SMALL_RECT srView;

        srView.Left = win_left;
        srView.Right = win_cols - 1;
        srView.Top = win_top + view_top - 1;
        srView.Bottom = win_top + view_bottom - 1;

        if( !GetConsoleScreenBufferInfo( fb_out_handle, &info ) ) {
            info.dwCursorPosition.X = win_left;
            info.dwCursorPosition.Y = win_top;
        }

        if( ScrollWasOff ) {
            ScrollWasOff = FALSE;
            ++info.dwCursorPosition.Y;
            info.dwCursorPosition.X = srView.Left;
            fb_hConsoleCheckScroll( fb_out_handle,
                                    &srView,
                                    &info.dwCursorPosition );
        }

        fb_hConsolePrintTTY( fb_out_handle,
                             pachText,
                             len,
                             &srView,
                             &info.dwCursorPosition,
                             TRUE );

        if( info.dwCursorPosition.X != srView.Left
            || info.dwCursorPosition.Y != (srView.Bottom+1) )
        {
            fb_hConsoleCheckScroll( fb_out_handle, &srView, &info.dwCursorPosition );
        } else {
            ScrollWasOff = TRUE;
            info.dwCursorPosition.X = srView.Right;
            info.dwCursorPosition.Y = srView.Bottom;
        }
        SetConsoleCursorPosition( fb_out_handle, info.dwCursorPosition );
    }

    fb_hUpdateConsoleWindow( );
    SetConsoleMode( fb_out_handle, mode );
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}
