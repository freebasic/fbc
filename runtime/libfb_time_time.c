/* time$ function */

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_Time ( void )
{
	FBSTRING	*dst;
	time_t 		rawtime;
  	struct tm	*ptm;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, 2+1+2+1+2 );
	if( dst != NULL )
	{
        /* guard by global lock because time/localtime might not be thread-safe */
        FB_LOCK();
  		time( &rawtime );
  		ptm = localtime( &rawtime );
        sprintf( dst->data, "%02d:%02d:%02d", ptm->tm_hour, ptm->tm_min, ptm->tm_sec );
        FB_UNLOCK();
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

