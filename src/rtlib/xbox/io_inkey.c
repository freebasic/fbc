/* console INKEY() function */

#include "../fb.h"

/* Caller is expected to hold FB_LOCK() */
FBSTRING *fb_ConsoleInkey( void )
{
	return 0;
}

/* Doing synchronization manually here because getkey() is blocking */
int fb_ConsoleGetkey( void )
{
	return 0;
}

/* Caller is expected to hold FB_LOCK() */
int fb_ConsoleKeyHit( void )
{
	return 0;
}
