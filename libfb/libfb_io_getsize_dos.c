/*
 * io_getsize.c -- get size (console, no gfx) function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <pc.h>


/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
#if 0
    int toprow, botrow;
#endif

	if( cols != NULL ) {
		*cols = ScreenCols();
	}

    if( rows != NULL ) {
#if 0
		fb_ConsoleGetView( &toprow, &botrow );
        *rows = botrow - toprow + 1;
#else
        *rows = ScreenRows();
#endif
	}
}
