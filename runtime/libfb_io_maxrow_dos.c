/*
 * io_maxrow.c -- get max row (console, no gfx) for DOS
 *
 * chng: nov/2004 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>

/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
	struct text_info ti;

	gettextinfo( &ti );

	return ti.screenheight;
}

