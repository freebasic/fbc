/*
 * strw_convfrom_int.c -- valwint function
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrToInt( const FB_WCHAR *src, int len )
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

	/* wcstol() saturates values outside [-2^31, 2^31)
	so use wcstoul() instead */
	return (int)wcstoul( p, NULL, radix );
}

/*:::::*/
FBCALL int fb_WstrValInt ( const FB_WCHAR *str )
{
    int	val, len;

	if( str == NULL )
	    return 0;

	len = fb_wstr_Len( str );
	if( len == 0 )
		val = 0;
	else
		val = fb_WstrToInt( str, len );

	return val;
}
