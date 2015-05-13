/* size of the screen buffer */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleGetScreenSizeEx( HANDLE hConsole, int *cols, int *rows )
{
   	CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info )==0 ) {
        if( cols != NULL )
            *cols = FB_SCRN_DEFAULT_WIDTH;
        if( rows != NULL )
            *rows = FB_SCRN_DEFAULT_HEIGHT;
    } else {
        if( cols != NULL )
            *cols = info.dwSize.X;
        if( rows != NULL )
            *rows = info.dwSize.Y;
    }
}

FBCALL void fb_ConsoleGetScreenSize( int *cols, int *rows )
{
    fb_ConsoleGetScreenSizeEx( __fb_out_handle, cols, rows );
}
