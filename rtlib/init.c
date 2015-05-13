/* libfb initialization */

#include "fb.h"

FB_RTLIB_CTX __fb_ctx /* not initialized */;
static int __fb_is_inicnt = 0;

/* called from fbrt0 */
void fb_hRtInit( void )
{
	/* already initialized? */
	++__fb_is_inicnt;
	if( __fb_is_inicnt != 1 )
		return;

	/* initialize context */
	memset( &__fb_ctx, 0, sizeof( FB_RTLIB_CTX ) );
    
	/* os-dep initialization */
	fb_hInit( );

#ifdef ENABLE_MT
	fb_TlsInit( );
#endif
}

/* called from fbrt0 */
void fb_hRtExit( void )
{
	--__fb_is_inicnt;
	if( __fb_is_inicnt != 0 )
		return;

	/* atexit() can't be used because if OPEN is called in a global ctor inside 
	   a shared-lib and any other file function is called in the respective global
	   dtor, it would be already reseted - the atexit() chain is called before the 
	   global dtors one*/
	fb_FileReset( );

	/* os-dep termination */
	fb_hEnd( 0 );

#ifdef ENABLE_MT
	fb_TlsExit( );
#endif

	/* if an error has to be displayed, do it now */
	if( __fb_ctx.error_msg )
		fputs( __fb_ctx.error_msg, stderr );
}

/* called by FB program */
FBCALL void fb_Init( int argc, char **argv, int lang )
{
	__fb_ctx.argc = argc;
	__fb_ctx.argv = argv;
	__fb_ctx.lang = lang;
}

/* called by FB program */
FBCALL void fb_End( int errlevel )
{
	exit( errlevel );
}
