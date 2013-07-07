/* valuint function */

#include "fb.h"

FBCALL unsigned int fb_hStr2UInt( char *src, ssize_t len )
{
    char 	*p;
	int radix, skip;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (ssize_t)(p - src);
	if( len < 1 )
		return 0;

	radix = 10;
	if( (len >= 2) && (p[0] == '&') )
	{
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

		if( radix != 10 )
			p += skip;
	}

	return strtoul( p, NULL, radix );
}

FBCALL unsigned int fb_VALUINT ( FBSTRING *str )
{
    unsigned int	val;

	if( str == NULL )
	    return 0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0;
	else
		val = fb_hStr2UInt( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
