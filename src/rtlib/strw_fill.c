/* stringw$ function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrFill1( ssize_t chars, int c )
{
	FB_WCHAR *dst;

	if( chars <= 0 )
		return NULL;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
	{
		/* fill it */
		fb_wstr_Fill( dst, c, chars );
	}

	return dst;
}

FBCALL FB_WCHAR *fb_WstrFill2( ssize_t chars, const FB_WCHAR *src )
{
	FB_WCHAR *dst;

	if( (chars > 0) && (src != NULL) && (fb_wstr_Len( src ) > 0) )
	{
		dst = fb_WstrFill1( chars, src[0] );
	}
	else
		dst = NULL;

	return dst;
}
