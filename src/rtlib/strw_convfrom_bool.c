/* valbool (wstring) function (boolean) */

#include "fb.h"

static int w_cmp( const FB_WCHAR *a, ssize_t len, const FB_WCHAR *z )
{
	ssize_t chars, i;

	chars = fb_wstr_Len( z );

	if( chars != len )
		return 1;
	
	for( i=0; i < chars; ++i )
	{
		if( fb_wstr_ToUpper( *a ) != fb_wstr_ToUpper( *z ) )
			return 1;

		++a;
		++z;
	}

	return 0;
}


/** convert wstring to boolean value
 *  
 * return value must be 0|1
 *
 */
FBCALL char fb_WstrToBool( const FB_WCHAR *src, ssize_t len )
{
	double val;

	if( w_cmp( src, len, fb_hBoolToWstr( FALSE ) )==0 )
		return 0;

	if( w_cmp( src, len, fb_hBoolToWstr( TRUE ) )==0 )
		return 1;

	val = fb_WstrToDouble( src, len );

	if( (val != (double)(0.0) ) && (val != (double)(-0.0)) )
		return 1;

	return 0;
}

/*:::::*/
FBCALL char fb_WstrValBool( const FB_WCHAR *str )
{
	ssize_t len;
	int val;

	if( str == NULL )
	    return 0;

	len = fb_wstr_Len( str );
	if( len == 0 )
		val = 0;
	else
		val = fb_WstrToBool( str, len );

	return val;
}
