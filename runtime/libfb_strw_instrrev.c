/*
 * strw_instrrev.c -- instrrevw function
 *
 * chng: dec/2007 written [jeffm]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrInstrRev ( const FB_WCHAR *src, const FB_WCHAR *patt, int start )
{
	if( (src != NULL) && (patt != NULL) )
	{
		size_t size_src = fb_wstr_Len(src);
		size_t size_patt = fb_wstr_Len(patt);
		size_t i, j;

		if( (size_src != 0) && (size_patt != 0) && (size_patt <= size_src) && (start != 0))
		{
			/* handle signed/unsigned comparisons of start and size_* vars */
			if( start < 0 )
				start = size_src - size_patt + 1;
			else if( start > size_src )
				start = 0;
			else if(start > size_src - size_patt)
				start = size_src - size_patt + 1;
			
			/*
				There is no wcsrstr() function, 
				so instead do a brute force scan.
			*/

			for( i=0; i<start; ++i ) 
			{
				for( j=0; j!=size_patt; ++j ) 
				{
					if( src[start-i+j-1] != patt[j] )
						break;
				}
				if( j==size_patt )
					return start - i;
			}
		}
	}
		
	return 0;
}
