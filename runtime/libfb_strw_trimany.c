/*
 * strw_trim.c -- trimw$ ANY function
 *
 * chng: nov/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrTrimAny ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
    const FB_WCHAR *pachText = NULL;
	FB_WCHAR 	*dst;
	size_t 		len;

    if( src == NULL ) {
        return NULL;
    }

	len = 0;
    {
        size_t len_pattern = fb_wstr_Len( pattern );
        pachText = src;
        len = fb_wstr_Len( src );
		while ( len != 0 )
        {
            size_t i;
            for( i=0; i!=len_pattern; ++i ) {
                if( wcschr( pattern, *pachText )!=NULL ) {
                    break;
                }
            }
            if( i==len_pattern ) {
                break;
            }
            --len;
            ++pachText;
		}
		while ( len != 0 )
        {
            size_t i;
            --len;
            for( i=0; i!=len_pattern; ++i ) {
                if( wcschr( pattern, pachText[len] )!=NULL ) {
                    break;
                }
            }
            if( i==len_pattern ) {
                ++len;
                break;
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
			fb_wstr_Copy( dst, pachText, len );
		}
		else
			dst = NULL;
    }
	else
		dst = NULL;

	return dst;
}
