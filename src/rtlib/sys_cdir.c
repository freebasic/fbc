/* curdir$ */

#include "fb.h"
#ifdef HOST_WIN32
#include <windows.h> /* for MAX_PATH */
#endif

FBCALL FBSTRING *fb_CurDir( void )
{
	FBSTRING 	*dst;
	char		tmp[MAX_PATH];
	ssize_t len;

	FB_LOCK();

	len = fb_hGetCurrentDir( tmp, MAX_PATH );

	/* alloc temp string */
	if( len > 0 ) {
        dst = fb_hStrAllocTemp( NULL, len );
		if( dst != NULL ) {
			memcpy( dst->data, tmp, len + 1 );
		} else {
			dst = &__fb_ctx.null_desc;
		}
	} else {
		dst = &__fb_ctx.null_desc;
	}

	FB_UNLOCK();

	return dst;
}
