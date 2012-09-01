/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"
#include <conio.h>

FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING *res;

	if( fb_ConsoleKeyHit( ) ) {
		res = fb_hMakeInkeyStr( fb_ConsoleGetkey( ) );
	} else {
		res = &__fb_ctx.null_desc;
	}

	return res;
}

int fb_ConsoleGetkey( void )
{
	unsigned int k;

	k = (unsigned int)getch( );
	if( k == 0x00 || k == 0xE0 )
		k = FB_MAKE_EXT_KEY( (unsigned int)getch( ) );

	/* Reset the status for "key buffer changed" when a key
	 * was removed from the input queue. */
	fb_hConsoleInputBufferChanged( );

	return k;
}

int fb_ConsoleKeyHit( void )
{
	return _conio_kbhit( );
}
