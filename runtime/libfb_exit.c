/* end and system routines */

#include <stdlib.h>
#include "fb.h"

extern int __fb_is_inicnt;


/*:::::*/
FBCALL void fb_End ( int errlevel )
{
	/* note: fb_RtExit() will be called from static/libfb_ctor.c */

	exit( errlevel );
}


/*:::::*/
void fb_hRtExit ( void )
{
#ifdef MULTITHREADED
    int i;
#endif

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

#ifdef MULTITHREADED
	/* free thread local storage plus the keys */
	for( i = 0; i < FB_TLSKEYS; i++ )
	{
     	fb_TlsDelCtx( i );

		/* del key/index */
		FB_TLSFREE( __fb_ctx.tls_ctxtb[i] );
	}
#endif

	/* if an error has to be displayed, do it now */
	if( __fb_ctx.error_msg )
		fprintf( stderr, __fb_ctx.error_msg );
		
}


