/* ports I/O hooks, default to system implementations */

#include "fb.h"

/*:::::*/
FBCALL int fb_In( unsigned short port )
{
	int res = -1;
	
	FB_LOCK();
	
	if( __fb_ctx.hooks.inproc)
		res = __fb_ctx.hooks.inproc( port );
	if( res < 0 )
		res = fb_hIn( port );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_Out( unsigned short port, unsigned char value )
{
	int res = -1;
	
	FB_LOCK();
	
	if( __fb_ctx.hooks.outproc)
		res = __fb_ctx.hooks.outproc( port, value );
	if( res < 0 )
		res = fb_hOut( port, value );
	
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_Wait( unsigned short port, int and, int xor )
{
	int res;
	
	do {
		res = fb_In( port );
		if( res < 0 )
			return res;
		res ^= xor;
	} while( ( res & and ) == 0 );
	
	return FB_RTERROR_OK;
}
