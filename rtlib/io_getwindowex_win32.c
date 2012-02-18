/* size of the console window */

#include "fb.h"
#include "fb_private_console.h"

/*:::::*/
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
