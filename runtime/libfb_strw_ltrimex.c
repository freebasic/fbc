/* enhanced ltrimw$ function */

#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrLTrimEx ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
	FB_WCHAR 	*dst;
	size_t       len;
	const FB_WCHAR *p = NULL;

    if( src == NULL ) {
        return NULL;
    }

    {
        size_t len_pattern = fb_wstr_Len( pattern );
        len = fb_wstr_Len( src );
        if( len >= len_pattern ) {
            if( len_pattern==1 ) {
                p = fb_wstr_SkipChar( src,
                                      len,
                                      *pattern );
                len = len - (int)(p - src);

            } else if( len_pattern != 0 ) {
                p = src;
                while (len >= len_pattern ) {
                    if( fb_wstr_Compare( p, pattern, len_pattern )!=0 )
                        break;
                    p += len_pattern;
                    len -= len_pattern;
                }
            }
        }
	}

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_wstr_AllocTemp( len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_wstr_Copy( dst, p, len );
		}
		else
			dst = NULL;
    }
	else
		dst = NULL;

	return dst;
}

