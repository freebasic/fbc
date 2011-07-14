/* instrrevanyw function */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrInstrRevAny ( const FB_WCHAR *src, const FB_WCHAR *patt, int start )
{
	if( (src != NULL) && (patt != NULL) ) 
	{
		size_t size_src = fb_wstr_Len(src);
		size_t size_patt = fb_wstr_Len(patt);
		size_t i;

		if( (size_src != 0) && (size_patt != 0) && (start != 0))
		{
			if( start < 0 )
				start = size_src;
			else if( start > size_src )
				start = 0;

			while( start-- )
			{
				for( i = 0; i != size_patt; ++i )
					if( src[start] == patt[i] )
						return start + 1;
			}
		}
	}

	return 0;
}
