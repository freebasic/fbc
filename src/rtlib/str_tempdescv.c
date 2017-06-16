/* legacy: temp string descriptor allocation for var-len strings */

#include "fb.h"

FBCALL FBSTRING *fb_StrAllocTempDescV( FBSTRING *str )
{
	FBSTRING *dsc;

	FB_STRLOCK();

 	/* alloc a temporary descriptor */
 	dsc = fb_hStrAllocTmpDesc( );

    FB_STRUNLOCK();

    if( dsc == NULL )
        return &__fb_ctx.null_desc;

    dsc->data = str->data;
    dsc->len  = FB_STRSIZE( str );
    dsc->size = str->size;

    return dsc;
}
