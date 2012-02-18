/* date$ function */

#include "fb.h"
#include <time.h>

/*:::::*/
FBCALL FBSTRING *fb_Date ( void )
{
	FBSTRING        *dst;
	time_t          rawtime;
	struct tm       *ptm;

	/* guard by global lock because time/localtime might not be thread-safe */
	FB_LOCK();

	rawtime = time( NULL );

	/* Note: localtime() can return NULL due to weird value from time() */
	if( ((ptm = localtime( &rawtime )) != NULL) &&
	    ((dst = fb_hStrAllocTemp( NULL, 2+1+2+1+4 )) != NULL) /* done last so it's not leaked */ ) {
		sprintf( dst->data, "%02d-%02d-%04d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year );
	} else {
		dst = &__fb_ctx.null_desc;
	}

	FB_UNLOCK();

	return dst;
}
