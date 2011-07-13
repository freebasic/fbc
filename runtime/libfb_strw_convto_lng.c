/*
 * strw_convto_lng.c -- strw$ routines for longint, ulongint
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_LongintToWstr ( long long num )
{
	FB_WCHAR *dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( sizeof( long long ) * 3 );
	if( dst != NULL )
	{
		/* convert */
        FB_WSTR_FROM_INT64( dst, num );
	}

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_ULongintToWstr ( unsigned long long num )
{
	FB_WCHAR *dst;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( sizeof( long long ) * 3 );
	if( dst != NULL )
	{
        /* convert */
        FB_WSTR_FROM_UINT64( dst, num );
	}

	return dst;
}

