/*
 * strw_midassign.c -- midw$ statement
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_WstrAssignMid ( FB_WCHAR *dst, int dst_len,
							   int start, int len, const FB_WCHAR *src )
{
    int src_len;

    if( (dst == NULL) || (src == NULL) )
    	return;

    src_len = fb_wstr_Len( src );
    if( src_len == 0 )
    	return;

    if( dst_len == 0 )
    {
    	/* it's a pointer, assume it's large enough */
    	dst_len = fb_wstr_Len( dst ) + src_len;
    }

    if( (start > 0) && (start <= dst_len) )
    {
		--start;

        if( (len < 1) || (len > src_len) )
			len = src_len;

        if( start + len > dst_len )
        	len = (dst_len - start) - 1;

		/* without the null-term */
		fb_wstr_Move( &dst[start], src, len );
    }
}
