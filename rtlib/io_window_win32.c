#include <stdlib.h>
#include <float.h>
#include "fb.h"

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

/*:::::*/
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

/*:::::*/
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


