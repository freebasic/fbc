/*  valbool (string) function (boolean)  */

#include "fb.h"

/** convert string to boolean value
 *  
 * return value must be 0|1
 *
 */
FBCALL char fb_hStr2Bool( char *src, ssize_t len )
{
	double val;

	if( strcasecmp( src, fb_hBoolToStr( FALSE ) )==0 )
		return 0;

	if( strcasecmp( src, fb_hBoolToStr( TRUE ) )==0 )
		return 1;

	val = fb_hStr2Double( src, len );

	if( (val != (double)(0.0) ) && (val != (double)(-0.0)) )
		return 1;

	return 0;
}

/*:::::*/
FBCALL char fb_VALBOOL ( FBSTRING *str )
{
    int	val;

	if( str == NULL )
	    return 0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0;
	else
		val = fb_hStr2Bool( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
