/* str$ routines for boolean
 *
 */

#include "fb.h"

static char false_string[] = "false";
static char true_string[] = "true";

/*:::::*/
FBCALL char *fb_hBoolToStr( char num )
{
	return num ? true_string : false_string;
}

/*:::::*/
FBCALL FBSTRING *fb_BoolToStr ( char num )
{
	FBSTRING 	*dst;

	dst = fb_hStrAllocTemp( NULL, 8 );
	if( dst != NULL )
	{
		char *src = fb_hBoolToStr( num );
		fb_hStrCopy( dst->data, src, strlen(src) );
		fb_hStrSetLength( dst, strlen(src) );
	}
	else
	{
		dst = &__fb_ctx.null_desc;
	}

	return dst;
}
