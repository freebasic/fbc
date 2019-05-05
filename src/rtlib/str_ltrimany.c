/* ltrim$ ANY function */

#include "fb.h"

FBCALL FBSTRING *fb_LTrimAny 
	( 
		FBSTRING *src,
		FBSTRING *pattern 
	)
{
	const char *pachText = NULL;
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
		ssize_t len_pattern = ((pattern != NULL) && (pattern->data != NULL)? FB_STRSIZE( pattern ) : 0);
		pachText = src->data;
		len = FB_STRSIZE( src );
		if( len_pattern != 0 )
		{
			while ( len != 0 )
			{
				if( FB_MEMCHR( pattern->data, *pachText, len_pattern ) == NULL )
					break;

				--len;
				++pachText;
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
			fb_hStrCopy( dst->data, pachText, len );
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
