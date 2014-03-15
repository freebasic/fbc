/* CV# and MK#$ routines */

#include "fb.h"

static void hCV( FBSTRING *str, ssize_t len, void *num )
{
	ssize_t i;

	if( str == NULL )
		return;

	if( (str->data != NULL) && (FB_STRSIZE( str ) >= len) )
	{
		for( i = 0; i < len; i++ )
			((char *)num)[i] = str->data[i];
	}

	/* del if temp */
	fb_hStrDelTemp( str );
}

FBCALL double fb_CVD( FBSTRING *str )
{
	double num = 0.0;
	hCV( str, sizeof( double ), &num );
	return num;
}

FBCALL float fb_CVS( FBSTRING *str )
{
	float num = 0.0;
	hCV( str, sizeof( float ), &num );
	return num;
}

FBCALL short fb_CVSHORT( FBSTRING *str )
{
	short num = 0;
	hCV( str, sizeof( short ), &num );
	return num;
}

/* 32bit legacy, fbc after 64bit port always calls fb_CVL() or fb_CVLONGINT() */
FBCALL int fb_CVI( FBSTRING *str )
{
	int num = 0;
	hCV( str, sizeof( int ), &num );
	return num;
}

FBCALL int fb_CVL( FBSTRING *str )
{
	int num = 0;
	hCV( str, sizeof( int ), &num );
	return num;
}

FBCALL long long fb_CVLONGINT( FBSTRING *str )
{
	long long num = 0;
	hCV( str, sizeof( long long ), &num );
	return num;
}

static FBSTRING *hMK( ssize_t len, void *num )
{
	ssize_t i;
	FBSTRING *dst;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, len );
	if( dst != NULL )
	{
		/* convert */
		for( i = 0; i < len; i++ )
			dst->data[i] = ((char *)num)[i];

		dst->data[len] = '\0';
	}
	else
		dst = &__fb_ctx.null_desc;

	return dst;
}

FBCALL FBSTRING *fb_MKD( double num )
{
	return hMK( sizeof( double ), &num );
}

FBCALL FBSTRING *fb_MKS( float num )
{
	return hMK( sizeof( float ), &num );
}

FBCALL FBSTRING *fb_MKSHORT( short num )
{
	return hMK( sizeof( short ), &num );
}

FBCALL FBSTRING *fb_MKI( ssize_t num )
{
	return hMK( sizeof( num ), &num );
}

FBCALL FBSTRING *fb_MKL( int num )
{
	return hMK( sizeof( num ), &num );
}

FBCALL FBSTRING *fb_MKLONGINT( long long num )
{
	return hMK( sizeof( long long ), &num );
}
