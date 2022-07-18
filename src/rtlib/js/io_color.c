/* console COLOR statement */

#include "../fb.h"
#include "fb_private_console.h"

static unsigned int last_bc = FB_COLOR_BLACK, last_fc = FB_COLOR_WHITE;

unsigned int fb_ConsoleColor( unsigned int fc, unsigned int bc, int flags )
{
	unsigned int cur = last_fc | (last_bc << 16);

	if( !( flags & FB_COLOR_FG_DEFAULT ) )
		last_fc = fc & 15;

	if( !( flags & FB_COLOR_BG_DEFAULT ) )
		last_bc = bc & 15;

    char fc_c = __fb_con.color_remap[last_fc];
    char bc_c = __fb_con.color_remap[last_bc];

	EM_ASM_ARGS({
        __fb_rtlib.console.color_set($0, $1);
    }, fc_c, bc_c);

	return cur;
}

unsigned int fb_ConsoleGetColorAtt( void )
{
	return last_fc | (last_bc << 4);
}
