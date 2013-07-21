/* lsetw and rsetw functions */

#include "fb.h"

FBCALL void fb_WstrLset ( FB_WCHAR *dst, FB_WCHAR *src )
{
	ssize_t slen, dlen, len;

	if( (dst != NULL) && (src != NULL) )
	{
		slen = fb_wstr_Len( src );
		dlen = fb_wstr_Len( dst );

		if( dlen > 0 )
		{
			len = (dlen <= slen? dlen: slen );

			fb_wstr_Copy( dst, src, len );

			len = dlen - slen;
			if( len > 0 )
				fb_wstr_Fill( &dst[slen], 32, len );
		}
	}
}

FBCALL void fb_WstrRset ( FB_WCHAR *dst, FB_WCHAR *src )
{
	ssize_t slen, dlen, len, padlen;

	if( (dst != NULL) && (src != NULL) )
	{
		slen = fb_wstr_Len( src );
		dlen = fb_wstr_Len( dst );

		if( dlen > 0 )
		{
			padlen = dlen - slen;
			if( padlen > 0 )
				fb_wstr_Fill( dst, 32, padlen );
			else
				padlen = 0;

			len = (dlen <= slen? dlen: slen );

			fb_wstr_Copy( &dst[padlen], src, len );
		}
	}
}
