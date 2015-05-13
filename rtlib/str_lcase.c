/* lcase$ function */

#include "fb.h"
#include <ctype.h>

/*:::::*/
FBCALL FBSTRING *fb_LCASE ( FBSTRING *src )
{
	FBSTRING 	*dst;
	int 		i, c, len = 0;
	char		*s, *d;

	if( src == NULL )
		return &__fb_ctx.null_desc;

	FB_STRLOCK();

	if( src->data != NULL )
	{
		len = FB_STRSIZE( src );
		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
	}
	else
		dst = NULL;

	if( dst != NULL )
	{
		/* to lower */
		s = src->data;
		d = dst->data;
		for( i = 0; i < len; i++ )
		{
			c = FB_CHAR_TO_INT(*s++);

#if 0
			if( (c >= 65) && (c <= 90) )
                c += 97 - 65;
#else
            if( isupper( c ) )
                c = tolower( c );
#endif

			*d++ = (char)c;
		}

		/* null char */
		*d = '\0';
	}
	else
		dst = &__fb_ctx.null_desc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();

	return dst;
}
