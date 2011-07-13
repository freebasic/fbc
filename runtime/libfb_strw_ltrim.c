/*
 * strw_ltrim.c -- ltrimw$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrLTrim ( const FB_WCHAR *src )
{
	FB_WCHAR *dst;
	const FB_WCHAR *p;
	int len;

	if( src == NULL )
		return NULL;

	len = fb_wstr_Len( src );
	p = fb_wstr_SkipChar( src, len, _LC(' ') );

	len -= fb_wstr_CalcDiff( src, p );
	if( len <= 0 )
		return NULL;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len );
	if( dst != NULL )
		fb_wstr_Copy( dst, p, len );

	return dst;
}

