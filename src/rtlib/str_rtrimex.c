/* enhanced rtrim$ function */

#include "fb.h"

FBCALL FBSTRING *fb_RTrimEx( FBSTRING *src, FBSTRING *pattern )
{
	FBSTRING *dst;
	ssize_t len;

    if( src == NULL ) 
    {
        fb_hStrDelTemp( pattern );
        return &__fb_ctx.null_desc;
    }

   	FB_STRLOCK();

	if( src->data != NULL )
	{
		ssize_t len_pattern = ((pattern != NULL) && (pattern->data != NULL)? FB_STRSIZE( pattern ) : 0);
		len = FB_STRSIZE( src );		
		if( len >= len_pattern )
		{
            if( len_pattern==1 ) 
            {
                char *src_ptr = fb_hStrSkipCharRev( src->data,
                                        	  		len,
                                        	  		FB_CHAR_TO_INT(pattern->data[0]) );
                len = (ssize_t)(src_ptr - src->data) + 1;
            } 
            else if( len_pattern != 0 ) 
            {
                char *src_ptr = src->data;
                ssize_t test_index = len - len_pattern;
                while (len >= len_pattern ) 
                {
                    if( FB_MEMCMP( src_ptr + test_index,
                                   pattern->data,
                                   len_pattern )!=0 )
                        break;
                    test_index -= len_pattern;
                }
                len = test_index + len_pattern;
            }
		}
    } 
    else 
        len = 0;

    if( len > 0 )
    {
        /* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
        if( dst != NULL )
        {
            /* simple copy */
            fb_hStrCopy( dst->data, src->data, len );
        }
        else
            dst = &__fb_ctx.null_desc;
    }
    else
        dst = &__fb_ctx.null_desc;

    /* del if temp */
    fb_hStrDelTemp_NoLock( src );
    fb_hStrDelTemp_NoLock( pattern );

    FB_STRUNLOCK();

    return dst;
}
