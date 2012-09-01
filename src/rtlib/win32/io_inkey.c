/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"

FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING *res;
	int key;

	key = fb_hConsoleGetKey( TRUE );

	if( key == -1 ) {
		res = &__fb_ctx.null_desc;
	} else {
		res = fb_hMakeInkeyStr( key );
	}

	return res;
}

int fb_ConsoleGetkey( void )
{
	int k = fb_hConsoleGetKey( TRUE );
    while( k==-1 ) {
        fb_Sleep( -1 );
        k = fb_hConsoleGetKey( TRUE );
    }
    return k;
}

int fb_ConsoleKeyHit( void )
{
    return fb_hConsolePeekKey( TRUE ) != -1;
}
