/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"

/* Caller is expected to hold FB_LOCK() */
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

/* Doing synchronization manually here because getkey() is blocking */
int fb_ConsoleGetkey( void )
{
	int k;

	do {
		FB_LOCK( );
		k = fb_hConsoleGetKey( TRUE );
		FB_UNLOCK( );

		if( k != -1 ) {
			break;
		}

		fb_Sleep( -1 );
	} while( 1 );

	return k;
}

/* Caller is expected to hold FB_LOCK() */
int fb_ConsoleKeyHit( void )
{
    return fb_hConsolePeekKey( TRUE ) != -1;
}
