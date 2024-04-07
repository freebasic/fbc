/* temp string descriptor allocation for fixed-len strings */

#include "fb.h"

FBCALL FBSTRING *fb_StrAllocTempDescF( char *str, ssize_t str_size )
{
	FBSTRING *dsc;

	FB_STRLOCK();

 	/* alloc a temporary descriptor */
 	dsc = fb_hStrAllocTempDesc( );

	FB_STRUNLOCK();

    if( dsc == NULL )
        return &__fb_ctx.null_desc;

    dsc->data = str;

	/* can't use strlen() if the size is known */
	if( str_size > 0 )
	{
		/* less the null-term */
		dsc->len = str_size - 1;
	}
	else if( str_size & FB_STRISFIXED )
	{
		dsc->len = str_size & FB_STRSIZEMSK;
	}
	else
	{
		if( str != NULL )
			dsc->len = strlen( str );
		else
			dsc->len = 0;
	}

	dsc->size = dsc->len;

	return dsc;
}
