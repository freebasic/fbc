/*
 * mem_copyclear.c -- LSET for non-strings
 *
 * chng: apr/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_MemCopyClear( unsigned char *dst, int dstlen, unsigned char *src, int srclen )
{
	int bytes;

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




