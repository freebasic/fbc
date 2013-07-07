/* leftw$ function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrLeft( const FB_WCHAR *src, ssize_t chars )
{
	FB_WCHAR *dst;
	ssize_t len;

	if( src == NULL )
		return NULL;

	len = fb_wstr_Len( src );
	if( (chars <= 0) || (len == 0) )
		return NULL;

	if( chars < len )
		len = chars;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len );
	if( dst != NULL )
		fb_wstr_Copy( dst, src, len );

	return dst;
}
