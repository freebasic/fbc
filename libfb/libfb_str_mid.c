/*
 * str_mid.c -- mid$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stddef.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_StrMid ( FBSTRING *src, int start, int len )
{
    FBSTRING 	*dst;
    int			src_len;

	FB_STRLOCK();

    if( (src != NULL) && (src->data != NULL) && (FB_STRSIZE( src ) > 0) )
	{
        src_len = FB_STRSIZE( src );

        if( (start > 0) && (start <= src_len) && (len != 0) )
        {
        	--start;

        	if( len < 0 )
        		len = src_len;

        	if( start + len > src_len )
        		len = src_len - start;

			/* alloc temp string */
            dst = fb_hStrAllocTemp_NoLock( NULL, len );
			if( dst != NULL )
            {
				FB_MEMCPY( dst->data, src->data + start, len );
				/* null term */
				dst->data[len] = '\0';
            }
        	else
        		dst = &__fb_ctx.null_desc;
        }
        else
        	dst = &__fb_ctx.null_desc;
	}
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();

	return dst;
}

