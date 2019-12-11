/* memmove for fb */

#include "fb.h"

FBCALL int fb_MemMove
	(
		char *dst,
		char *src,
		ssize_t len
	)
{
	if( (dst == NULL) || (src == NULL) || (len <= 0) )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* move */
	memmove( dst, src, len );

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
