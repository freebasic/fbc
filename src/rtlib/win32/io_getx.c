#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetRawXEx( HANDLE hConsole )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info ) == 0 )
        return 0;
    return info.dwCursorPosition.X;
}

int fb_ConsoleGetRawX( void )
{
    return fb_ConsoleGetRawXEx( __fb_out_handle );
}

int fb_ConsoleGetX( void )
{
    int x = fb_ConsoleGetRawX();
    fb_hConvertFromConsole( &x, NULL, NULL, NULL );
    return x;
}
