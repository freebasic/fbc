/* console COLOR statement */

#include "../fb.h"
#include "fb_private_console.h"
#include <pc.h>

static unsigned int last_bc = FB_COLOR_BLACK, last_fc = FB_COLOR_WHITE;

unsigned int fb_ConsoleColor( unsigned int fc, unsigned int bc, int flags )
{
	unsigned int cur = last_fc | (last_bc << 16);

	if( !( flags & FB_COLOR_FG_DEFAULT ) )
		last_fc = fc & 15;

	if( !( flags & FB_COLOR_BG_DEFAULT ) )
		last_bc = bc & 15;

	ScreenAttrib = last_fc | (last_bc << 4);

	return cur;
}

unsigned int fb_ConsoleGetColorAtt( void )
{
	/* !!!FIXME!!! there must be an attribute for each page */
	return ScreenAttrib;
}
