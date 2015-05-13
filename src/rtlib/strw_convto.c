/* strw$ routines for int, uint */

#include "fb.h"

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
