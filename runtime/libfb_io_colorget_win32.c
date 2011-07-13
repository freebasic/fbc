/*
 * io_color.c -- color (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_colors.h"

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

