/* view print (console, no gfx) */

#include "fb.h"

/*:::::*/
int fb_ConsoleViewEx( int toprow, int botrow, int set_cursor )
{
    int do_update = FALSE;
    int maxrow, minrow;


    minrow = 1;
    fb_GetSize( NULL, &maxrow );
    if( maxrow==0 )
        maxrow = FB_SCRN_DEFAULT_HEIGHT;

    if( toprow > 0 ) {
        do_update = TRUE;
    } else if ( toprow == 0 ) {
        do_update = TRUE;
        toprow = minrow;
    } else {
        toprow = fb_ConsoleGetTopRow() + 1;
    }

    if( botrow > 0 ) {
        do_update = TRUE;
    } else if ( botrow == 0 ) {
        do_update = TRUE;
        botrow = maxrow;
    } else {
        botrow = fb_ConsoleGetBotRow() + 1;
    }

    if( toprow > botrow
        || toprow < 1
        || botrow < 1
        || toprow > maxrow
        || botrow > maxrow )
    {
        /* This is an error ... */
        do_update = FALSE;
        botrow = toprow = 0;
    }

    if( do_update ) {
        fb_ConsoleSetTopBotRows( toprow - 1, botrow - 1 );
        fb_ViewUpdate( );
        if( set_cursor ) {
            /* set cursor to top row */
            fb_Locate( toprow, 1, -1, 0, 0 );
        }
    }

    return toprow + (botrow << 16);
}

/*:::::*/
FBCALL int fb_ConsoleView( int toprow, int botrow )
{
    return fb_ConsoleViewEx( toprow, botrow, TRUE );
}

