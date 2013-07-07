/* LSET for non-strings */

#include "fb.h"

FBCALL void fb_MemCopyClear
	(
		unsigned char *dst,
		ssize_t dstlen,
		unsigned char *src,
		ssize_t srclen
	)
{
	ssize_t bytes;

	if( (dst == NULL) || (src == NULL) || (dstlen <= 0) || (srclen <= 0) )
		return;

	bytes = (dstlen <= srclen? dstlen: srclen);
	
	/* move */
	memcpy( dst, src, bytes );

	/* clear remainder */
	dstlen -= bytes;
	if( dstlen > 0 )
		memset( &dst[bytes], 0, dstlen );
}
