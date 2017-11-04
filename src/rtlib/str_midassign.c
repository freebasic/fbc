/* mid$ statement */

#include "fb.h"

FBCALL void fb_StrAssignMid( FBSTRING *dst, ssize_t start, ssize_t len, FBSTRING *src )
{
	ssize_t src_len, dst_len;

	FB_STRLOCK();

    if( (dst == NULL) || (dst->data == NULL) || (FB_STRSIZE( dst ) == 0) )
    {
    	fb_hStrDelTemp_NoLock( src );
    	fb_hStrDelTemp_NoLock( dst );
    	FB_STRUNLOCK();
    	return;
    }

    if(	(src == NULL) || (src->data == NULL) || (FB_STRSIZE( src ) == 0) ) {
        fb_hStrDelTemp_NoLock( src );
    	fb_hStrDelTemp_NoLock( dst );
    	FB_STRUNLOCK();
    	return ;
    }

	src_len = FB_STRSIZE( src );
	dst_len = FB_STRSIZE( dst );

	if( (start > 0) && (start <= dst_len) && (len != 0) )
    {
        --start;

        if( (len < 0) || (len > src_len) )
            len = src_len;

        if( start + len > dst_len )
            len = (dst_len - start);

        memcpy( dst->data + start, src->data, len );
    }

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
    fb_hStrDelTemp_NoLock( dst );

   	FB_STRUNLOCK();
}
