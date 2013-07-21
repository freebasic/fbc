/* valwuint function */

#include "fb.h"

FBCALL unsigned int fb_WstrToUInt( const FB_WCHAR *src, ssize_t len )
{
    const FB_WCHAR *p, *r;
	int radix;

	/* skip white spc */
	p = fb_wstr_SkipChar( src, len, 32 );

	len -= fb_wstr_CalcDiff( src, p );
	if( len < 1 )
		return 0;

	radix = 10;
	r = p;
	if( (len >= 2) && (*r++ == L'&') )
	{
		switch( *r++ )
		{
			case L'h':
			case L'H':
				radix = 16;
				break;
			case L'o':
			case L'O':
				radix = 8;
				break;
			case L'b':
			case L'B':
				radix = 2;
				break;

			default: /* assume octal */
				radix = 8;
				r--;
				break;
		}

		if( radix != 10 )
			p = r;
	}

	return wcstoul( p, NULL, radix );
}

FBCALL unsigned int fb_WstrValUInt ( const FB_WCHAR *str )
{
    unsigned int val;
	ssize_t len;

	if( str == NULL )
	    return 0;

	len = fb_wstr_Len( str );
	if( len == 0 )
		val = 0;
	else
		val = fb_WstrToUInt( str, len );

	return val;
}
