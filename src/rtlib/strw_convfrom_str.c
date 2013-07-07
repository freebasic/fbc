/* ascii to unicode string convertion function */

#include "fb.h"

FBCALL FB_WCHAR *fb_StrToWstr( const char *src )
{
	FB_WCHAR *dst;
	ssize_t chars;

    if( src == NULL )
    	return NULL;

	chars = strlen( src );
    if( chars == 0 )
    	return NULL;

    dst = fb_wstr_AllocTemp( chars );
	if( dst == NULL )
		return NULL;

	fb_wstr_ConvFromA( dst, chars, src );

	return dst;
}
