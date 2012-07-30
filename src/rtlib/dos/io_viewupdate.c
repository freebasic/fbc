/* view print update (console, no gfx) */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleViewUpdate( void )
{
	int top = fb_ConsoleGetTopRow( );
	if( top >= 0 )
		++top;
	else
		top = 1;
	fb_ConsoleLocate( top, 1, -1 );
}
