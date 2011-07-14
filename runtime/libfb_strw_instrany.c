/* instranyw function */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrInstrAny ( int start, const FB_WCHAR *src, const FB_WCHAR *patt )
{
	int r = 0;

	if( (src != NULL) && (patt != NULL) )
	{
		size_t size_src = fb_wstr_Len( src );

		if( (start > 0) && (start <= size_src) )
		{
			r = fb_wstr_InstrAny( &src[start-1], patt ) + start;
	
			if( r > size_src )
				r = 0;
		}
	}

	return r;
}
