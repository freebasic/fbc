/* enhanced ltrim$ function */

#include "fb.h"

FBCALL FBSTRING *fb_LTrimEx 
	( 
		FBSTRING *src, 
		FBSTRING *pattern 
	)
{
	FBSTRING *dst;
	ssize_t len;
	char *src_ptr = NULL;

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
        src_ptr = src->data;
        if( len >= len_pattern ) 
        {
            if( len_pattern == 1 ) 
            {
                src_ptr = fb_hStrSkipChar( src_ptr,
                                     	   len,
                                     	   FB_CHAR_TO_INT(pattern->data[0]) );
                len = len - (ssize_t)(src_ptr - src->data);

            } 
            else
            {                
                if( len_pattern != 0 ) 
                {
	                while (len >= len_pattern ) 
	                {
	                    if( FB_MEMCMP( src_ptr, pattern->data, len_pattern )!=0 )
	                        break;
	    
	                    src_ptr += len_pattern;
	                    len -= len_pattern;
	                }
				}
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
			fb_hStrCopy( dst->data, src_ptr, len );
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

