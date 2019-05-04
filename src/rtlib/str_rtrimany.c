/* rtrim$ ANY function */

#include "fb.h"

FBCALL FBSTRING *fb_RTrimAny( FBSTRING *src, FBSTRING *pattern )
{
	FBSTRING *dst;
	ssize_t len;

	if( src == NULL )
	{
		fb_hStrDelTemp( pattern );
		return &__fb_ctx.null_desc;
	}

	FB_STRLOCK();

	len = 0;
	if( src->data != NULL )
	{
		const char *pachText = src->data;
		ssize_t len_pattern = ((pattern != NULL) && (pattern->data != NULL)? FB_STRSIZE( pattern ) : 0);
		len = FB_STRSIZE( src );
		if( len_pattern != 0 )
		{
			while ( len != 0 )
			{
				--len;
				if( FB_MEMCHR( pattern->data, pachText[len], len_pattern ) == NULL )
				{
					++len;
					break;
				}
			}
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
	fb_hStrDelTemp_NoLock( pattern );

	FB_STRUNLOCK();

	return dst;
}
