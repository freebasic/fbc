/* low-level print to console function */

#include "../fb.h"
#include "fb_private_console.h"

typedef struct _fb_PrintInfo {
    fb_Rect         rWindow;
    fb_Coord        BufferSize;
    WORD            wAttributes;
    HANDLE          hOutput;
    int             fViewSet;
} fb_PrintInfo;

static void fb_hHookConScroll
	(
		fb_ConHooks *handle,
		int x1, int y1,
		int x2, int y2,
		int rows
	)
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    HANDLE hnd = pInfo->hOutput;
    int iBufferHeight, iScrollHeight, iClearFrom, iClearTo, iClearPos;

    SMALL_RECT srScroll;
    COORD dwDest;

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
        iBufferHeight = pInfo->BufferSize.Y;

    } else {
        /* Scroll only the area defined by a previous VIEW PRINT */
        dwDest.X = (SHORT) handle->Border.Left;
        dwDest.Y = (SHORT) handle->Border.Top;
        srScroll.Right = (SHORT) handle->Border.Right;
        srScroll.Bottom = (SHORT) handle->Border.Bottom;
        iBufferHeight = handle->Border.Bottom - handle->Border.Top + 1;
    }

    if( iBufferHeight <= rows ) {
        /* simply clear the buffer */
        iClearFrom = handle->Border.Top;
        iClearTo = handle->Border.Bottom + 1;
    } else {
        /* Move some part of the console screen buffer to another
         * position. */
        CHAR_INFO FillChar;

        srScroll.Left = dwDest.X;
        srScroll.Top = (SHORT) (dwDest.Y + rows);

        iScrollHeight = srScroll.Bottom - srScroll.Top + 1;
        if( iScrollHeight < rows ) {
            /* Don't forget that we have to clear some screen buffer regions
             * not covered by the original scrolling region */
            iClearFrom = dwDest.Y + iScrollHeight;
            iClearTo = srScroll.Bottom + 1;
        } else {
            iClearFrom = iClearTo = 0;
        }

        FillChar.Attributes = pInfo->wAttributes;
        FillChar.Char.AsciiChar = 32;

        ScrollConsoleScreenBuffer( hnd, &srScroll, NULL, dwDest, &FillChar );
    }

    /* Clear all parts of the screen buffer not covered by the scrolling
     * region */
    if( iClearFrom!=iClearTo ) {
        SHORT x1 = handle->Border.Left;
        WORD attr = pInfo->wAttributes;
        DWORD width = handle->Border.Right - x1 + 1;
        for( iClearPos=iClearFrom; iClearPos!=iClearTo; ++iClearPos ) {
            DWORD written;
            COORD coord = { x1, (SHORT) iClearPos };
            FillConsoleOutputAttribute( hnd, attr, width, coord, &written);
            FillConsoleOutputCharacter( hnd, ' ', width, coord, &written );
        }
    }

    handle->Coord.Y = handle->Border.Bottom;
}

static int fb_hHookConWrite
	(
		fb_ConHooks *handle,
		const void *buffer,
		size_t length
	)
{
    fb_PrintInfo *pInfo = (fb_PrintInfo*) handle->Opaque;
    HANDLE hnd = pInfo->hOutput;
    const char *pachText = (const char *) buffer;
    CHAR_INFO *lpBuffer = alloca( sizeof(CHAR_INFO) * length );
    WORD wAttributes = pInfo->wAttributes;
    COORD dwBufferSize = { (SHORT) length, 1 };
    COORD dwBufferCoord = { 0, 0 };
    SMALL_RECT srWriteRegion = {
        (SHORT) handle->Coord.X,
        (SHORT) handle->Coord.Y,
        (SHORT) (handle->Coord.X + length - 1),
        (SHORT) handle->Coord.Y
    };
    size_t i;
    int result;

    for( i=0; i!=length; ++i ) {
        CHAR_INFO *pCharInfo = lpBuffer + i;
        pCharInfo->Attributes = wAttributes;
        pCharInfo->Char.AsciiChar = pachText[i];
    }
    result = WriteConsoleOutput( hnd,
                                 lpBuffer,
                                 dwBufferSize,
                                 dwBufferCoord,
                                 &srWriteRegion );
    return result;
}

void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
    const char *pachText = (const char *) buffer;
    int win_left, win_top, win_cols, win_rows;
    int view_top, view_bottom;
    fb_PrintInfo info;
    fb_ConHooks hooks;

    /* Do we want to correct the console cursor position? */
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
               WriteFile( __fb_out_handle,
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
    hooks.Write         = fb_hHookConWrite ;
    hooks.Border.Left   = win_left;
    hooks.Border.Top    = win_top + view_top - 1;
    hooks.Border.Right  = win_left + win_cols - 1;
    hooks.Border.Bottom = win_top + view_bottom - 1;

    info.hOutput        = __fb_out_handle;
    info.rWindow.Left   = win_left;
    info.rWindow.Top    = win_top;
    info.rWindow.Right  = win_left + win_cols - 1;
    info.rWindow.Bottom = win_top + win_rows - 1;
    info.fViewSet       = hooks.Border.Top!=info.rWindow.Top
        || hooks.Border.Bottom!=info.rWindow.Bottom;

    {
        CONSOLE_SCREEN_BUFFER_INFO screen_info;

        if( !GetConsoleScreenBufferInfo( __fb_out_handle, &screen_info ) ) {
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

        if( __fb_con.scrollWasOff ) {
            __fb_con.scrollWasOff = FALSE;
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
        }
        else
        {
            __fb_con.scrollWasOff = TRUE;
            hooks.Coord.X = hooks.Border.Right;
            hooks.Coord.Y = hooks.Border.Bottom;
        }

        {
            COORD dwCoord = { (SHORT) hooks.Coord.X, (SHORT) hooks.Coord.Y };
            SetConsoleCursorPosition( info.hOutput,
                                      dwCoord );
        }
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

void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
    return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}
