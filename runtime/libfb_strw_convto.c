/*
 * strw_convto.c -- strw$ routines for int, uint
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_IntToWstr ( int num )
{
	FB_WCHAR *dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( sizeof( int ) * 3 );
	if( dst != NULL )
	{
		/* convert */
        FB_WSTR_FROM_INT( dst, num );
	}

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_UIntToWstr ( unsigned int num )
{
	FB_WCHAR *dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( sizeof( int ) * 3 );
	if( dst != NULL )
	{
		/* convert */
        FB_WSTR_FROM_UINT( dst, num );
	}

	return dst;
}

