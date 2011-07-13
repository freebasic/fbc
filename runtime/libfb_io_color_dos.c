/*
 * io_color.c -- color (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include "fb_colors.h"
#include <pc.h>

static int last_bc = FB_COLOR_BLACK,
		   last_fc = FB_COLOR_WHITE;

/*:::::*/
int fb_ConsoleColor( int fc, int bc, int flags )
{
	int cur = last_fc | (last_bc << 16);

	if( !( flags & FB_COLOR_FG_DEFAULT ) )
		last_fc = fc & 15;

	if( !( flags & FB_COLOR_BG_DEFAULT ) )
		last_bc = bc & 15;

	ScreenAttrib = last_fc | (last_bc << 4);

	return cur;
}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
	/* !!!FIXME!!! there must be an attribute for each page */

	return ScreenAttrib;

}
