/* console window stuff */

#include "../fb.h"
#include "fb_private_console.h"

static SMALL_RECT srRealConsoleWindow;

static __inline__ void hReadConsoleRect( SMALL_RECT *pRect, int GetRealWindow )
{
    CONSOLE_SCREEN_BUFFER_INFO info;

    if( GetConsoleScreenBufferInfo( __fb_out_handle, &info )==0 ) {
        memset( pRect, 0, sizeof(SMALL_RECT) );
    } else {
        if( GetRealWindow ) {
            memcpy( pRect, &info.srWindow, sizeof(SMALL_RECT) );
        } else {
            pRect->Left = 0;
            pRect->Top = info.srWindow.Top;
            pRect->Right = info.dwSize.X - 1;
            pRect->Bottom = info.srWindow.Bottom;
        }
    }
}

/** Remembers the current console window coordinates.
 *
 * This function remembers the current console window coordinates. This is
 * required because some applications showing using a SAA interface doesn't
 * use WIDTH first to reduce the console screen buffer size which means that
 * the scroll bar of the console window is always visible/accessible which
 * also implies that the user might scroll up and down while the application
 * is running.
 *
 * When this library would always use the current console window coordinates,
 * the application might show trash when the user scrolled up or down the
 * buffer. But this is not what we want so we're only updating the console
 * window coordinates under the following conditions:
 *
 * - Initialization
 * - After screen buffer size change (using WIDTH)
 * - After printing text
 */
FBCALL void fb_hUpdateConsoleWindow( void )
{
    /* Whenever the console was set by the user, we MUST NOT query this
     * information again because this would cause a mess with SAA
     * applications otherwise. */
    if (__fb_con.setByUser)
        return;

    hReadConsoleRect( &__fb_con.window, FALSE );
    hReadConsoleRect( &srRealConsoleWindow, TRUE );
}

void fb_InitConsoleWindow( void )
{
    static int inited = FALSE;
    if( !inited )
    {
    	inited = TRUE;
    	/* query the console window position/size only when needed */
    	fb_hUpdateConsoleWindow( );
    }
}

FBCALL void fb_hRestoreConsoleWindow( void )
{
    SMALL_RECT sr;

    /* Whenever the console was set by the user, there's no need to
     * restore the original window console because we don't have to
     * mess around with scrollable windows */
    if (__fb_con.setByUser)
        return;

    fb_InitConsoleWindow( );

    /* Update only when changed! */
    hReadConsoleRect( &sr, TRUE );
    if( (sr.Top != srRealConsoleWindow.Top)
        || (sr.Bottom != srRealConsoleWindow.Bottom) )
    {
        /* Keep the left/right coordinate of the console */
        sr.Top = srRealConsoleWindow.Top;
        sr.Bottom = srRealConsoleWindow.Bottom;
    	int i;
    	for( i = 0; i < FB_CONSOLE_MAXPAGES; i++ )
    	{
       		if( __fb_con.pgHandleTb[i] != NULL )
        		SetConsoleWindowInfo( __fb_con.pgHandleTb[i], TRUE, &srRealConsoleWindow );
        }
    }
}

void fb_ConsoleGetMaxWindowSize( int *cols, int *rows )
{
    COORD max = GetLargestConsoleWindowSize( __fb_out_handle );
    if( cols != NULL )
        *cols = (max.X==0 ? FB_SCRN_DEFAULT_WIDTH : max.X);
    if( rows != NULL )
        *rows = (max.Y==0 ? FB_SCRN_DEFAULT_HEIGHT : max.Y);
}

FBCALL void fb_hConvertToConsole( int *left, int *top, int *right, int *bottom )
{
    int win_left, win_top;

    fb_InitConsoleWindow();

    if( FB_CONSOLE_WINDOW_EMPTY() )
        return;

    fb_hConsoleGetWindow( &win_left, &win_top, NULL, NULL );
    if( left != NULL )
        *left += win_left - 1;
    if( top != NULL )
        *top += win_top - 1;
    if( right != NULL )
        *right += win_left - 1;
    if( bottom != NULL )
        *bottom += win_top - 1;
}

FBCALL void fb_hConvertFromConsole( int *left, int *top, int *right, int *bottom )
{
    int win_left, win_top;

    fb_InitConsoleWindow();

    if( FB_CONSOLE_WINDOW_EMPTY() )
        return;

    fb_hConsoleGetWindow( &win_left, &win_top, NULL, NULL );
    if( left != NULL )
        *left -= win_left - 1;
    if( top != NULL )
        *top -= win_top - 1;
    if( right != NULL )
        *right -= win_left - 1;
    if( bottom != NULL )
        *bottom -= win_top - 1;
}

void fb_hConsoleGetWindow( int *left, int *top, int *cols, int *rows )
{
    fb_InitConsoleWindow( );

    if( FB_CONSOLE_WINDOW_EMPTY() )
    {
        if( left != NULL )
            *left = 0;
        if( top != NULL )
            *top = 0;
        if( cols != NULL )
            *cols = 0;
        if( rows != NULL )
            *rows = 0;
    }
    else
    {
        if( left != NULL )
            *left = __fb_con.window.Left;
        if( top != NULL )
            *top = __fb_con.window.Top;
        if( cols != NULL )
            *cols = __fb_con.window.Right - __fb_con.window.Left + 1;
        if( rows != NULL )
            *rows = __fb_con.window.Bottom - __fb_con.window.Top + 1;
    }
}
