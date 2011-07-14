/* thread local context storage */

#include "fb.h"

/*:::::*/
FBCALL void *fb_TlsGetCtx( int index, int len )
{
	void *ctx = (void *)FB_TLSGET( __fb_ctx.tls_ctxtb[index] );

	if( ctx == NULL )
	{
		ctx = (void *)calloc( 1, len );
		FB_TLSSET( __fb_ctx.tls_ctxtb[index], ctx );
	}

	return ctx;
}

/*:::::*/
FBCALL void fb_TlsDelCtx( int index )
{
    void *ctx = (void *)FB_TLSGET( __fb_ctx.tls_ctxtb[index] );

	/* free mem block if any */
	if( ctx != NULL )
	{
		free( ctx );
		FB_TLSSET( __fb_ctx.tls_ctxtb[index], NULL );
	}
}

/*:::::*/
FBCALL void fb_TlsFreeCtxTb( void )
{
    int i;

	/* free all thread local storage ctx's */
	for( i = 0; i < FB_TLSKEYS; i++ )
     	fb_TlsDelCtx( i );
}

