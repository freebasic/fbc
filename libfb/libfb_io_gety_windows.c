/*
 * io_gety.c -- GetY function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: use convert*console functions [mjs]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleGetRawYEx( HANDLE hConsole )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info ) == 0 )
        return 0;
    return info.dwCursorPosition.Y;
}

/*:::::*/
int fb_ConsoleGetRawY( void )
{
    return fb_ConsoleGetRawYEx( __fb_out_handle );
}

/*:::::*/
int fb_ConsoleGetY( void )
{
    int y = fb_ConsoleGetRawY();
    fb_hConvertFromConsole( NULL, &y, NULL, NULL );
    return y;
}

