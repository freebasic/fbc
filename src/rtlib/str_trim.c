/* trim$ function */

#include "fb.h"

FBCALL FBSTRING *fb_TRIM( FBSTRING *src )
{
	FBSTRING *dst;
	ssize_t len;
	char *src_ptr;

	if( src == NULL )
		return &__fb_ctx.null_desc;

	FB_STRLOCK();

	len = 0;
	if( src->data != NULL )
	{
		len = FB_STRSIZE( src );
		if( len > 0 )
		{
			src_ptr = fb_hStrSkipCharRev( src->data, len, 32 );
			len = (ssize_t)(src_ptr - src->data) + 1;
		}
	}

	if( len > 0 )
	{
		src_ptr = fb_hStrSkipChar( src->data, FB_STRSIZE( src ), 32 );
		len -= (ssize_t)(src_ptr - src->data);
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
    }
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();

	return dst;
}
