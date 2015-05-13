/* midw$ function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrMid( const FB_WCHAR *src, ssize_t start, ssize_t len )
{
    FB_WCHAR *dst;
	ssize_t src_len;

    if( src == NULL )
    	return NULL;

    src_len = fb_wstr_Len( src );
    if( src_len == 0 )
    	return NULL;

    if( (start <= 0) || (start > src_len) || (len == 0) )
    	return NULL;

    --start;

    if( len < 0 )
    	len = src_len;

    if( start + len > src_len )
    	len = src_len - start;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len );
	if( dst != NULL )
		fb_wstr_Copy( dst, &src[start], len );

	return dst;
}
