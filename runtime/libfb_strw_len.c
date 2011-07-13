/*
 * strw_len.c -- wstring length function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_WstrLen( FB_WCHAR *str )
{
	if( str == NULL )
		return 0;

	return fb_wstr_Len( str );
}


