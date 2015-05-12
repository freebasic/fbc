/* time$ function */

#include "fb.h"
#include <time.h>

/*:::::*/
FBCALL FBSTRING *fb_Time ( void )
{
	FBSTRING        *dst;
	time_t          rawtime;
	struct tm       *ptm;

	/* guard by global lock because time/localtime might not be thread-safe */
	FB_LOCK();

	rawtime = time( NULL );

	/* Note: localtime() may return NULL, as documented on MSDN and Linux man pages,
	   and it has been observed to do that on at least one FB user's Windows system,
	   because of a negative time_t value from time(). */
	if( ((ptm = localtime( &rawtime )) != NULL) &&
	    ((dst = fb_hStrAllocTemp( NULL, 2+1+2+1+2 )) != NULL) /* done last so it's not leaked */ ) {
		sprintf( dst->data, "%02d:%02d:%02d", ptm->tm_hour, ptm->tm_min, ptm->tm_sec );
	} else {
		dst = &__fb_ctx.null_desc;
	}

	FB_UNLOCK();

	return dst;
}
