/* val function */

#include "fb.h"

FBCALL double fb_hStr2Double( char *src, ssize_t len )
{
	char *p, *q, c;
	int radix, i, skip;
	double ret;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (ssize_t)(p - src);
	if( len < 1 )
		return 0.0;

	else if( len >= 2 ) {
		if( p[0] == '&' ) {
			skip = 2;
			switch( p[1] ) {
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

			return fb_hStrRadix2Longint( p + skip, len - skip, radix );

		} else if( p[0] == '0' ) {
			if( p[1] == 'x' || p[1] == 'X' ) {
				/* Filter out strings with 0x/0X prefix -- strtod() treats them as hex.
				   But we only want to support the &h prefix for that. */
				return 0.0; /* 0x would be parsed to the value zero */
			}
		}
	}

	/* Workaround: strtod() does not allow 'd' as an exponent specifier on 
	 * non-win32 platforms, so create a temporary buffer and replace any 
	 * 'd's with 'e'.
	 * This would be bad for hex strings, but those should be handled above already.
	 */
	q = malloc( len + 1 );
	for( i = 0; i < len; i++ )
	{
		c = p[i];
		if( c == 'd' || c == 'D' ) 
			++c;
		q[i] = c;
	}
	q[len] = '\0';

	ret = strtod( q, NULL );
	free( q );

	return ret;
}

FBCALL double fb_VAL ( FBSTRING *str )
{
    double	val;

	if( str == NULL )
	    return 0.0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0.0;
	else
		val = fb_hStr2Double( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
