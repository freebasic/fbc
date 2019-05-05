/* rtrimw$ function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrRTrim ( const FB_WCHAR *src )
{
	FB_WCHAR *dst;
	const FB_WCHAR *p;
	ssize_t chars;

	if( src == NULL )
		return NULL;

	chars = fb_wstr_Len( src );
	if( chars <= 0 )
		return NULL;

	p = fb_wstr_SkipCharRev( src, chars, _LC(' ') );
	chars = fb_wstr_CalcDiff( src, p );
	if( chars <= 0 )
		return NULL;

	/* alloc temp string */
	dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
	{
		/* simple copy */
		fb_wstr_Copy( dst, src, chars );
	}

	return dst;
}
