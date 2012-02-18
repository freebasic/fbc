/* color (console, no gfx) function for Windows */

#include "fb.h"
#include "fb_private_console.h"

/*:::::*/
int fb_ConsoleGetColorAttEx( HANDLE hConsole )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info )==0 )
        return 7;
	return info.wAttributes;

}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
    return fb_ConsoleGetColorAttEx( __fb_out_handle );
}

