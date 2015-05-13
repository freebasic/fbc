/* size of the console window */

#include "fb.h"
#include "fb_private_console.h"

/*:::::*/
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
