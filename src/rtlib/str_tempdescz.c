/* temp string descriptor allocation for zstring's */

#include "fb.h"

FBCALL FBSTRING *fb_StrAllocTempDescZEx( const char *str, ssize_t len )
{
	FBSTRING *dsc;

	FB_STRLOCK();

 	/* alloc a temporary descriptor */
 	dsc = fb_hStrAllocTmpDesc( );

    FB_STRUNLOCK();

    if( dsc == NULL )
        return &__fb_ctx.null_desc;

    dsc->data = (char *)str;
	dsc->len = len;
	dsc->size = len;

	return dsc;
}

FBCALL FBSTRING *fb_StrAllocTempDescZ( const char *str )
{
	ssize_t len;

	/* find the true size */
	if( str != NULL )
		len = strlen( str );
	else
		len = 0;

	return fb_StrAllocTempDescZEx( str, len );
}
