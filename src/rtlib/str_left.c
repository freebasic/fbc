/* left$ function */

#include "fb.h"

FBCALL FBSTRING *fb_LEFT( FBSTRING *src, ssize_t chars )
{
	FBSTRING 	*dst;
	ssize_t len, src_len;

	if( src == NULL )
		return &__fb_ctx.null_desc;

	FB_STRLOCK();

	src_len = FB_STRSIZE( src );
	if( (src->data != NULL)	&& (chars > 0) && (src_len > 0) ) {
		if( chars > src_len )
			len = src_len;
		else
			len = chars;

		/* alloc temp string */
		dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_hStrCopy( dst->data, src->data, len );
		}
		else
			dst = &__fb_ctx.null_desc;
	} else {
		dst = &__fb_ctx.null_desc;
	}

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();

	return dst;
}


/* 
	Special case of a = left( a, n )
	The string 'a' is not reallocated, only the string length field is adjusted
	and a NUL terminator written. fbc does not optimize for this so to use 
	it must be a direct call by the user.  Carefule, due the function declaration
	does not check for fb_LEFTSELF( "lteral", n ) so if src is a temporary,
	It just gets deleted.
*/
FBCALL void fb_LEFTSELF( FBSTRING *src, ssize_t chars )
{
	ssize_t     src_len;

	if( src == NULL )
		return;

	FB_STRLOCK();

	src_len = FB_STRSIZE( src );
	if( (src->data != NULL)	&& (chars > 0) && (src_len > 0) )
	{
		if( chars > src_len )
		{
			fb_hStrSetLength( src, src_len );
			/* add a NUL character */
			src->data[src_len] = '\0';
		}
		else
		{
			fb_hStrSetLength( src, chars );
			/* add a NUL character */
			src->data[chars] = '\0';
		}
	}

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();
}
