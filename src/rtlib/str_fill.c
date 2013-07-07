/* string$ function */

#include "fb.h"

FBCALL FBSTRING *fb_StrFill1( ssize_t cnt, int fchar )
{
	FBSTRING 	*dst;

	if( cnt > 0 )
	{
		/* alloc temp string */
        dst = fb_hStrAllocTemp( NULL, cnt );
		if( dst != NULL )
		{
			/* fill it */
			memset( dst->data, fchar, cnt );
			/* null char */
			dst->data[cnt] = '\0';
		}
		else
			dst = &__fb_ctx.null_desc;
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

FBCALL FBSTRING *fb_StrFill2( ssize_t cnt, FBSTRING *src )
{
	FBSTRING 	*dst;
	int fchar;

	if( (cnt > 0) && (src != NULL) && (src->data != NULL) && (FB_STRSIZE( src ) > 0) ) {
		fchar = src->data[0];
		dst = fb_StrFill1( cnt, fchar );
	}
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}
