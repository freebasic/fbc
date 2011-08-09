/* view print update (console, no gfx) for DOS */

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
