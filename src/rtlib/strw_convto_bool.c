/* strw$ routines for boolean */

#include "fb.h"

static FB_WCHAR false_string[] = _LC( "false" );
static FB_WCHAR true_string[] = _LC( "true" );

/*:::::*/
FBCALL FB_WCHAR *fb_hBoolToWstr( char num )
{
	return num ? true_string : false_string;
}

/*:::::*/
FBCALL FB_WCHAR *fb_BoolToWstr ( char num )
{
	FB_WCHAR *dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( 5 );

	if( dst != NULL )
	{
		FB_WCHAR *src = fb_hBoolToWstr(num);
		fb_wstr_Copy( dst, src, fb_wstr_Len(src) );
	}

	return dst;
}
