/*
 * str_ltrim.c -- ltrim$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LTRIM 
	( 
		FBSTRING *src 
	)
{
	FBSTRING *dst;
	int len;
	char *src_ptr = NULL;

	if( src == NULL )
		return &__fb_ctx.null_desc;

	FB_STRLOCK();

	if( src->data != NULL )
	{
		src_ptr = fb_hStrSkipChar( src->data, FB_STRSIZE( src ), 32 );
		len = FB_STRSIZE( src ) - (int)(src_ptr - src->data);
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

	FB_STRUNLOCK();

	return dst;
}

