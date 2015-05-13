#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetMaxRow( void )
{
	if( !__fb_con.inited )
		return 24;

	BG_LOCK( );
	fb_hRecheckConsoleSize( );
	BG_UNLOCK( );
	return __fb_con.h;
}
