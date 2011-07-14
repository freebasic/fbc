/* instrany function */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_StrInstrAny ( int start, FBSTRING *src, FBSTRING *patt )
{
	int r;

	if( (src == NULL) || (src->data == NULL) || (patt == NULL) || (patt->data == NULL) ) 
	{
		r = 0;
	}
	else
	{
		size_t size_src = FB_STRSIZE(src);
		size_t size_patt = FB_STRSIZE(patt);

		if( (size_src == 0) || (size_patt == 0) || (start < 1) || (start > size_src) )
		{
			r = 0;
		} 
		else 
		{
			size_t i, found, search_len = size_src - start + 1;
			const char *pachText = src->data + start - 1;
			r = search_len;
			
			for( i=0; i!=size_patt; ++i ) 
			{
				const char *pszEnd = FB_MEMCHR( pachText, patt->data[i], r );
				if( pszEnd!=NULL ) 
				{
					found = pszEnd - pachText;
					if( found < r )
						r = found;
				}
			}
			if( r==search_len ) 
			{
				r = 0;
			} 
			else 
			{
				r += start;
			}
		}
	}

	FB_STRLOCK();

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
	fb_hStrDelTemp_NoLock( patt );

	FB_STRUNLOCK();

	return r;
}
