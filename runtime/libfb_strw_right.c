/* rightw$ function */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrRight ( const FB_WCHAR *src, int chars )
{
	FB_WCHAR *dst;
	int len, src_len;

	if( src == NULL )
		return NULL;

	src_len = fb_wstr_Len( src );
	if( (chars <= 0) || (src_len == 0) )
		return NULL;

	if( chars > src_len )
		len = src_len;
	else
		len = chars;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len );
	if( dst != NULL )
	{
		/* simple rev copy */
		fb_wstr_Copy( dst, &src[src_len - len], len );
	}

	return dst;
}
