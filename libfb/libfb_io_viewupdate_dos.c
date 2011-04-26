/*
 * libfb_io_vwupd.c -- view print update (console, no gfx) for DOS
 *
 * chng: jan/2005 written [DrV]
 *       sep/2005 removed conio dependency [mjs]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleViewUpdate( void )
{
	int top;

	top = fb_ConsoleGetTopRow( );
	if( top >= 0 )
		++top;
	else
		top = 1;

    fb_ConsoleLocate( top, 1, -1 );
}
