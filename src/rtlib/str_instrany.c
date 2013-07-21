/* instrany function */

#include "fb.h"

FBCALL ssize_t fb_StrInstrAny( ssize_t start, FBSTRING *src, FBSTRING *patt )
{
	ssize_t r;

	if( (src == NULL) || (src->data == NULL) || (patt == NULL) || (patt->data == NULL) ) 
	{
		r = 0;
	}
	else
	{
		ssize_t size_src = FB_STRSIZE(src);
		ssize_t size_patt = FB_STRSIZE(patt);

		if( (size_src == 0) || (size_patt == 0) || (start < 1) || (start > size_src) )
		{
			r = 0;
		} 
		else 
		{
			ssize_t i, found, search_len = size_src - start + 1;
			const char *pachText = src->data + start - 1;
			r = search_len;
			
			for( i=0; i!=size_patt; ++i ) 
			{
				const char *pszEnd = (const char *) FB_MEMCHR( pachText, patt->data[i], r );
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
