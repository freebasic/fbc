/* trimw$ ANY function */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrTrimAny ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
	const FB_WCHAR *pachText = NULL;
	FB_WCHAR	*dst;
	ssize_t len;

	if( src == NULL ) {
		return NULL;
	}

	len = 0;
	{
		ssize_t len_pattern = fb_wstr_Len( pattern );
		pachText = src;
		len = fb_wstr_Len( src );
		if( len_pattern != 0 )
		{
			while ( len != 0 )
			{
				if( wcschr( pattern, *pachText )==NULL ) {
					break;
				}
				--len;
				++pachText;
			}
			while ( len != 0 )
			{
				--len;
				if( wcschr( pattern, pachText[len] )==NULL ) {
					++len;
					break;
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
			fb_wstr_Copy( dst, pachText, len );
		}
		else
			dst = NULL;
	}
	else
		dst = NULL;

	return dst;
}
