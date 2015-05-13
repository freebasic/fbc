/* rtrim$ function */

#include "fb.h"

FBCALL FBSTRING *fb_RTRIM( FBSTRING *src )
{
	FBSTRING *dst;
	ssize_t len;

	if( src == NULL )
		return &__fb_ctx.null_desc;

   	FB_STRLOCK();

	len = 0;
	if( src->data != NULL )
	{
		len = FB_STRSIZE( src );
		if( len > 0 )
		{
			char *src_ptr = fb_hStrSkipCharRev( src->data, len, 32 );
			len = (ssize_t)(src_ptr - src->data) + 1;
		}
	}

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

   	FB_STRUNLOCK();

	return dst;
}

