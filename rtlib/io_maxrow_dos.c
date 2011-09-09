/* get max row (console, no gfx) for DOS */

#include "fb.h"
#include <conio.h>

/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
	struct text_info ti;

	gettextinfo( &ti );

	return ti.screenheight;
}

