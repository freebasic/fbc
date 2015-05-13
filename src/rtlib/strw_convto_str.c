/* unicode to ascii string convertion function */

#include "fb.h"

FBCALL FBSTRING *fb_WstrToStr( const FB_WCHAR *src )
{
	FBSTRING *dst;
	ssize_t chars;

    if( src == NULL )
    	return &__fb_ctx.null_desc;

	chars = fb_wstr_Len( src );
    if( chars == 0 )
    	return &__fb_ctx.null_desc;

    dst = fb_hStrAllocTemp( NULL, chars );
	if( dst == NULL )
		return &__fb_ctx.null_desc;

	fb_wstr_ConvToA( dst->data, src, chars );

	return dst;
}
