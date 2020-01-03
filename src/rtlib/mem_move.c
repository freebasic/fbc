/* memmove for fb */

#include "fb.h"

FBCALL int fb_MemMove
	(
		unsigned char *dst,
		unsigned char *src,
		size_t len
	)
{
	if( (dst == NULL) || (src == NULL) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* move */
	memmove( dst, src, len );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
