/* inkey$ function for DOS console mode apps */

#include "fb.h"

/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING	*res;
	unsigned int	k;
	int		chars;

	if( _conio_kbhit( ) )
	{
		chars = 1;
		k = (unsigned int)getch( );
		if( k == 0x00 || k == 0xE0 )
		{
			k = (unsigned int)getch( );
			chars = 2;
		}

        res = fb_hStrAllocTemp( NULL, chars );
        DBG_ASSERT( res!=NULL );
        if( chars > 1 )
            res->data[0] = FB_EXT_CHAR; /* note: can't use '\0' here as in qb */

        res->data[chars-1] = (unsigned char)k;
        res->data[chars-0] = '\0';

        /* Reset the status for "key buffer changed" when a key
         * was removed from the input queue. */
        fb_hConsoleInputBufferChanged();
    }
	else
		res = &__fb_ctx.null_desc;

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = 0;

	k = getch( );
	if( k == 0x00 || k == 0xE0 )
		k = getch( );

    /* Reset the status for "key buffer changed" when a key
     * was removed from the input queue. */
    fb_hConsoleInputBufferChanged();

	return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{

	return _conio_kbhit( );

}

