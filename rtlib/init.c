/* libfb initialization */

#include <stdlib.h>
#include "fb.h"

/* globals */
int __fb_is_inicnt = 0;

FB_RTLIB_CTX __fb_ctx /* not initialized */;

/* Called from fbrt0 */
void fb_hRtInit ( void )
{
#ifdef ENABLE_MT
	int i;
#endif

	/* already initialized? */
	++__fb_is_inicnt;
	if( __fb_is_inicnt != 1 )
		return;

	/* initialize context */
	memset( &__fb_ctx, 0, sizeof( FB_RTLIB_CTX ) );
    
	/* os-dep initialization */
	fb_hInit( );

#ifdef ENABLE_MT
	/* allocate thread local storage keys */
	for( i = 0; i < FB_TLSKEYS; i++ )
		FB_TLSALLOC( __fb_ctx.tls_ctxtb[i] );
#endif

}

/* Called from FB program's main() */
FBCALL void fb_Init ( int argc, char **argv, int lang )
{
	__fb_ctx.argc = argc;
	__fb_ctx.argv = argv;
	__fb_ctx.lang = lang;
}
