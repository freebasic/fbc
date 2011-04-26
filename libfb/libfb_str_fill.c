/*
 * str_fill.c -- string$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_StrFill1 ( int cnt, int fchar )
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


/*:::::*/
FBCALL FBSTRING *fb_StrFill2 ( int cnt, FBSTRING *src )
{
	FBSTRING 	*dst;
	int			fchar;

	if( (cnt > 0) && (src != NULL) && (src->data != NULL) && (FB_STRSIZE( src ) > 0) ) {
		fchar = (int)src->data[0];
		dst = fb_StrFill1( cnt, fchar );
	}
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}

