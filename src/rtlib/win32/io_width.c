/* console width() for Windows */
/* code based on PDCurses, Win32 port by Chris Szurgot (szurgot@itribe.net) */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleWidth( int cols, int rows )
{
    COORD size, max;
    int cur, do_change = FALSE;
    int ncols, nrows;

    fb_InitConsoleWindow( );

    if( FB_CONSOLE_WINDOW_EMPTY() )
        return 0;

    max = GetLargestConsoleWindowSize( __fb_out_handle );
    fb_hConsoleGetWindow( NULL, NULL, &ncols, &nrows );

    if( cols > 0 )
    {
        size.X = cols;
        do_change = TRUE;
    }
    else
    {
        size.X = (SHORT) ncols;
    }

    if( rows > 0 )
    {
        size.Y = rows;
        do_change = TRUE;
    }
    else
    {
        size.Y = (SHORT) nrows;
    }

    cur = size.X | (size.Y << 16);

    if( do_change == FALSE )
    	return cur;

    SMALL_RECT rect;
    rect.Left = rect.Top = 0;
    rect.Right = size.X - 1;
    if( rect.Right > max.X )
        rect.Right = max.X;

    rect.Bottom = rect.Top + size.Y - 1;
    if( rect.Bottom > max.Y )
        rect.Bottom = max.Y;

    /* Ensure that the window isn't larger than the destination screen
     * buffer size */
    int do_resize = FALSE;
    SMALL_RECT rectRes;
    if( rect.Bottom < (nrows-1) )
    {
        do_resize = TRUE;
        memcpy( &rectRes, &rect, sizeof(SMALL_RECT) );
        if( rectRes.Right >= ncols )
            rectRes.Right = ncols - 1;
    }
    else if( rect.Right < (ncols-1) )
    {
        do_resize = TRUE;
        memcpy( &rectRes, &rect, sizeof(SMALL_RECT) );
        if( rectRes.Bottom >= nrows )
            rectRes.Bottom = nrows - 1;
    }

    if( do_resize )
    {
        int i;
        for( i = 0; i < FB_CONSOLE_MAXPAGES; i++ )
        {
            if( __fb_con.pgHandleTb[i] != NULL )
                SetConsoleWindowInfo( __fb_con.pgHandleTb[i], TRUE, &rectRes );
        }
    }

    /* Now set the screen buffer size and ensure that the window is
     * large enough to show the whole buffer */
    int i;
    for( i = 0; i < FB_CONSOLE_MAXPAGES; i++ )
    {
       	if( __fb_con.pgHandleTb[i] != NULL )
       	{
       		SetConsoleScreenBufferSize( __fb_con.pgHandleTb[i], size );
       		SetConsoleWindowInfo( __fb_con.pgHandleTb[i], TRUE, &rect );
       	}
    }

    /* Re-enable updating */
    __fb_con.setByUser = FALSE;
    fb_hUpdateConsoleWindow( );
    __fb_con.setByUser = TRUE;

    return cur;
}
