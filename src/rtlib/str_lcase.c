/* lcase$ function */

#include "fb.h"
#include <ctype.h>

FBCALL FBSTRING *fb_StrLcase2( FBSTRING *src, int mode )
{
	FBSTRING 	*dst;
	int		i, c;
	ssize_t		len = 0;
	char		*s, *d;

	if( src == NULL )
		return &__fb_ctx.null_desc;

	FB_STRLOCK();

	if( src->data ) {
		len = FB_STRSIZE( src );
		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
	} else {
		dst = NULL;
	}

	if( dst ) {
		s = src->data;
		d = dst->data;

		if( mode == 1 ) {
			for( i = 0; i < len; i++ ) {
				c = *s++;
				if( (c >= 65) && (c <= 90) )
					c += 97 - 65;
				*d++ = c;
			}
		} else {
			for( i = 0; i < len; i++ ) {
				c = *s++;
				if( isupper( c ) )
					c = tolower( c );
				*d++ = c;
			}
		}

		/* null char */
		*d = '\0';
	} else {
		dst = &__fb_ctx.null_desc;
	}

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

	FB_STRUNLOCK();

	return dst;
}
