/* valint function */

#include "fb.h"

FBCALL int fb_hStr2Int( char *src, ssize_t len )
{
    char 	*p;
	int radix, skip;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (ssize_t)(p - src);
	if( len < 1 )
		return 0;

	else if( (len >= 2) && (p[0] == '&') )
	{
		radix = 0;
		skip = 2;
		switch( p[1] )
		{
			case 'h':
			case 'H':
				radix = 16;
				break;
			case 'o':
			case 'O':
				radix = 8;
				break;
			case 'b':
			case 'B':
				radix = 2;
				break;

			default: /* assume octal */
				radix = 8;
				skip = 1;
				break;
		}

		if( radix != 0 )
			return fb_hStrRadix2Int( &p[skip], len - skip, radix );
	}

	/* atoi() saturates values outside [-2^31, 2^31)
	so use strtoul() instead */
	return strtoul( p, NULL, 10 );
}

FBCALL int fb_VALINT ( FBSTRING *str )
{
    int	val;

	if( str == NULL )
	    return 0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0;
	else
		val = fb_hStr2Int( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
