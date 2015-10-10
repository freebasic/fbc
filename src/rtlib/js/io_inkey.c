/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"

/* Caller is expected to hold FB_LOCK() */
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING *res = &__fb_ctx.null_desc;

	if( fb_ConsoleKeyHit( ) != 0 )
	{
        res = fb_hMakeInkeyStr( fb_ConsoleGetkey( ) );
	}

	return res;
}

int fb_ConsoleGetkey( void )
{
    /* !!!FIXME!!! getkey() should block */
	if( __fb_con.key_head == __fb_con.key_tail)
        return 0;

	int key = __fb_con.key_buffer[__fb_con.key_head];
	__fb_con.key_head = (__fb_con.key_head + 1) % KEY_BUFFER_LEN;

	return key;
}

/* Caller is expected to hold FB_LOCK() */
int fb_ConsoleKeyHit( void )
{
	return __fb_con.key_head != __fb_con.key_tail;
}
