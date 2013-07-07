/* right$ function */

#include "fb.h"

FBCALL FBSTRING *fb_RIGHT( FBSTRING *src, ssize_t chars )
{
	FBSTRING 	*dst;
	ssize_t len, src_len;

	if( src == NULL )
		return &__fb_ctx.null_desc;

   	FB_STRLOCK();

	src_len = FB_STRSIZE( src );
	if( (src->data != NULL)	&& (chars > 0) && (src_len > 0) )
    {
		if( chars > src_len )
			len = src_len;
		else
			len = chars;

		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple rev copy */
			fb_hStrCopy( dst->data, src->data + src_len - len, len );
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
