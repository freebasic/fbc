/* spacew$ function */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrSpace ( int chars )
{
	FB_WCHAR *dst;

	if( chars <= 0 )
		return NULL;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
	{
		/* fill it */
		fb_wstr_Fill( dst, 32, chars );
	}

	return dst;
}

