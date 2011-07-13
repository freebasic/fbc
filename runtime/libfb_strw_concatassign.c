/*
 * strw_concatassign.c -- string concat and assign (s = s + expr) function
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrConcatAssign ( FB_WCHAR *dst, int dst_chars, const FB_WCHAR *src )
{
	int src_len, dst_len;

	/* NULL? */
	if( (dst == NULL) || (src == NULL) )
		return dst;

	src_len = fb_wstr_Len( src );
	if( src_len == 0 )
		return dst;

	dst_len = fb_wstr_Len( dst );

	/* don't check ptr's */
	if( dst_chars > 0 )
	{
		--dst_chars;							/* less the null-term */

		if( src_len > dst_chars - dst_len )
			src_len = dst_chars - dst_len;
	}

	/* copy the null-term too */
	fb_wstr_Move( &dst[dst_len], src, src_len + 1 );

	return dst;
}
