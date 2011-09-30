/* get max row (console, no gfx) for Linux */

#include "fb.h"


/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
	if (!__fb_con.inited)
		return 24;
	
	return __fb_con.h;
}
