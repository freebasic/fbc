/* strw$ routines for float and double */

#include "fb.h"

FBCALL FB_WCHAR *fb_FloatToWstr ( float num )
{
	FB_WCHAR *dst, *d;
	ssize_t len;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( 7+8 );
	if( dst != NULL )
    {
		/* convert */
        FB_WSTR_FROM_FLOAT( dst, num );

		/* skip the dot at end if any */
		len = fb_wstr_Len( dst );
		if( len > 0 )
		{
			d = &dst[len-1];
			if( *d == _LC('.') )
				*d = _LC('\0');
        }
    }

	return dst;
}

FBCALL FB_WCHAR *fb_DoubleToWstr ( double num )
{
	FB_WCHAR *dst, *d;
	ssize_t len;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( 16+8 );
	if( dst != NULL )
	{
        /* convert */
        FB_WSTR_FROM_DOUBLE( dst, num );

		/* skip the dot at end if any */
		len = fb_wstr_Len( dst );
		if( len > 0 )
		{
			d = &dst[len-1];
			if( *d == _LC('.') )
				*d = _LC('\0');
        }
	}

	return dst;
}
