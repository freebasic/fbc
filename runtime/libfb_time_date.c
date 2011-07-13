/*
 * time_data.c -- date$ function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_Date ( void )
{
	FBSTRING	*dst;
	time_t 		rawtime = { 0 };
  	struct tm	*ptm = { 0 };

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, 2+1+2+1+4 );
	if( dst != NULL )
	{
        /* guard by global lock because time/localtime might not be thread-safe */
        FB_LOCK();
  		time( &rawtime );
  		ptm = localtime( &rawtime );
        sprintf( dst->data, "%02d-%02d-%04d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year );
        FB_UNLOCK();
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

