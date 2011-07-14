/* locate (console, no gfx) function for Windows */

#include "fb.h"

/*:::::*/
int fb_ConsoleLocate( int row, int col, int cursor )
{
    int ret_val;
    CONSOLE_CURSOR_INFO info;

    if( col < 1 )
        col = fb_ConsoleGetX();
    if( row < 1 )
        row = fb_ConsoleGetY();

    GetConsoleCursorInfo( __fb_out_handle, &info );
    ret_val =
        (col & 0xFF) | ((row & 0xFF) << 8) | (info.bVisible ? 0x10000 : 0);

    fb_hConvertToConsole( &col, &row, NULL, NULL );

    fb_ConsoleLocateRawEx( __fb_out_handle, row, col, cursor );

    return ret_val;
}

