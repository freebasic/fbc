/* unicode string assigning function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrAssign( FB_WCHAR *dst, ssize_t dst_chars, FB_WCHAR *src )
{
	ssize_t src_chars;

	if( dst == NULL )
		return dst;

	if( src == 0 )
		src_chars = 0;
	else
		src_chars = fb_wstr_Len( src );

	/* src NULL? */
	if( src_chars == 0 )
	{
		*dst = 0;
	}
	else
	{
		if( dst_chars > 0 )
		{
			--dst_chars;						/* less the null-term */
			/* not enough? clamp */
			if( dst_chars < src_chars )
				src_chars = dst_chars;
		}

		fb_wstr_Copy( dst, src, src_chars );
	}

	return dst;
}
