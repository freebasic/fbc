/* lset and rset functions */

#include "fb.h"

FBCALL void fb_StrLset ( FBSTRING *dst, FBSTRING *src )
{
	ssize_t slen, dlen, len;

	if( (dst != NULL) && (dst->data != NULL) && (src != NULL) )
	{
		slen = FB_STRSIZE( src );
		dlen = FB_STRSIZE( dst );

		if( dlen > 0 )
		{
			len = (dlen <= slen? dlen: slen );

			fb_hStrCopy( dst->data, src->data, len );

			len = dlen - slen;
			if( len > 0 )
			{
				memset( &dst->data[slen], 32, len );

				/* null char */
				dst->data[slen+len] = '\0';
			}
		}
	}

	/* del if temp */
	fb_hStrDelTemp( src );

	/* del if temp */
	fb_hStrDelTemp( dst );
}

FBCALL void fb_StrRset ( FBSTRING *dst, FBSTRING *src )
{
	ssize_t slen, dlen, len, padlen;

	if( (dst != NULL) && (dst->data != NULL) && (src != NULL) )
	{
		slen = FB_STRSIZE( src );
		dlen = FB_STRSIZE( dst );

		if( dlen > 0 )
		{
			padlen = dlen - slen;
			if( padlen > 0 )
				memset( dst->data, 32, padlen );
			else
				padlen = 0;

			len = (dlen <= slen? dlen: slen );

			fb_hStrCopy( &dst->data[padlen], src->data, len );
		}
	}

	/* del if temp */
	fb_hStrDelTemp( src );

	/* del if temp */
	fb_hStrDelTemp( dst );
}
