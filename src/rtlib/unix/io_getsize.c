#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	if( !__fb_con.inited ) {
		if( cols ) *cols = 80;
		if( rows ) *rows = 24;
		return;
	}

	BG_LOCK( );
	fb_hRecheckConsoleSize( TRUE );
	BG_UNLOCK( );

	if( cols ) *cols = __fb_con.w;
	if( rows ) *rows = __fb_con.h;
}
