/* console CLS statement */

#include "../fb.h"
#include "fb_private_console.h"
#include <pc.h>

void fb_ConsoleClear( int mode )
{
    int toprow, botrow;

    if( mode==1 ) {
        return;
	}

	if( (mode == 2) || (mode == (int)0xFFFF0000) ) {	/* same as gfxlib's DEFAULT_COLOR */
        fb_ConsoleGetView( &toprow, &botrow );
        --toprow;
        --botrow;
    } else {
        toprow = 0;
        botrow = ScreenRows() - 1;
	}

    fb_ConsoleScroll_BIOS( 0, toprow, ScreenCols()-1, botrow, 0 );
	fb_ConsoleLocate_BIOS( toprow, 0, -1 );
}
