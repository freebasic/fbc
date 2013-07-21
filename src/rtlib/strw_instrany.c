/* instranyw function */

#include "fb.h"

FBCALL ssize_t fb_WstrInstrAny( ssize_t start, const FB_WCHAR *src, const FB_WCHAR *patt )
{
	ssize_t r = 0;

	if( (src != NULL) && (patt != NULL) )
	{
		ssize_t size_src = fb_wstr_Len( src );

		if( (start > 0) && (start <= size_src) )
		{
			r = fb_wstr_InstrAny( &src[start-1], patt ) + start;

			if( r > size_src )
				r = 0;
		}
	}

	return r;
}
