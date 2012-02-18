/* val function */

#include "fb.h"

/*:::::*/
FBCALL double fb_hStr2Double( char *src, int len )
{
	char *p, *q, c;
	int radix;
	int i;
	int skip;
	double ret;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (int)(p - src);
	if( len < 1 )
		return 0.0;

	else if( (len >= 2) && (p[0] == '&') )
	{
		skip = 2;
		radix = 0;
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
			return (double)fb_hStrRadix2Longint( &p[skip], len - skip, radix );
	}

	/* Workaround: strtod() does not allow 'd' as an exponent specifier on 
	 * non-win32 platforms, so create a temporary buffer and replace any 
     * 'd's with 'e'
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

/*:::::*/
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
