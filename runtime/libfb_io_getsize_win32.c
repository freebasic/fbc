/*
 * io_getsize.c -- get size (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: use previously remembered console window size [mjs]
 *
 */

#include <stdio.h>
#include "fb.h"

void fb_InitConsoleWindow( void );

/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
    int nrows, ncols;

    fb_InitConsoleWindow();

    if( FB_CONSOLE_WINDOW_EMPTY() )
    {
        ncols = FB_SCRN_DEFAULT_WIDTH;
        nrows = FB_SCRN_DEFAULT_HEIGHT;
    }
    else
    {
        fb_hConsoleGetWindow( NULL, NULL, &ncols, &nrows );
    }

    if( cols != NULL )
        *cols = ncols;
    if( rows != NULL )
        *rows = nrows;
}
