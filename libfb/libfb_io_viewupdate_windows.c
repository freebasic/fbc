/*
 * libfb_io_vwupd.c -- view print update (console, no gfx) for Windows
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleViewUpdate( void )
{
    fb_hUpdateConsoleWindow( );
}
