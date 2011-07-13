/*
 * io_inkey.c -- inkey$ function for Windows console mode apps
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING 	 *res;
    int  key = fb_hConsoleGetKey( TRUE );

    if( key==-1 )
    {
        res = &__fb_ctx.null_desc;
    }
    else if( key > 255 )
    {
        res = fb_hStrAllocTemp( NULL, 2 );
        if( res!=NULL )
        {
            res->data[0] = FB_EXT_CHAR;
            res->data[1] = (key >> 8) & 0xFF;
            res->data[2] = 0;
        }
    }
    else
    {
        res = fb_hStrAllocTemp( NULL, 1 );
        if( res!=NULL )
        {
            res->data[0] = key & 0xFF;
            res->data[1] = 0;
        }
    }

    if( res==NULL )
        res = &__fb_ctx.null_desc;

	return res;
}

/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = fb_hConsoleGetKey( TRUE );
    while( k==-1 ) {
        fb_Sleep( -1 );
        k = fb_hConsoleGetKey( TRUE );
    }
    return k;
}

/*:::::*/
int fb_ConsoleKeyHit( void )
{
    return fb_hConsolePeekKey( TRUE ) != -1;
}

