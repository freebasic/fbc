/* CV# and MK#$ routines */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
static void hCV( FBSTRING *str, int len, void *num )
{
	int	i;

	if( (str->data != NULL) && (FB_STRSIZE( str ) >= len) )
	{
		for( i = 0; i < len; i++ )
			((char *)num)[i] = str->data[i];
	}

	/* del if temp */
	fb_hStrDelTemp( str );
}

/*:::::*/
FBCALL double fb_CVD ( FBSTRING *str )
{
    double num;

	if( str == NULL )
		return 0.0;

	num = 0.0;
	hCV( str, sizeof( double ), &num );

	return num;
}

/*:::::*/
FBCALL float fb_CVS ( FBSTRING *str )
{
    float num;

	if( str == NULL )
		return 0.0;

	num = 0.0;
	hCV( str, sizeof( float ), &num );

	return num;
}

/*:::::*/
FBCALL int fb_CVI ( FBSTRING *str )
{
    int	num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( int ), &num );

	return num;
}

/*:::::*/
FBCALL short fb_CVSHORT ( FBSTRING *str )
{
    short num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( short ), &num );

	return num;
}

/*:::::*/
FBCALL long long fb_CVLONGINT ( FBSTRING *str )
{
    long long num;

	if( str == NULL )
		return 0;

	num = 0;
	hCV( str, sizeof( long long ), &num );

	return num;
}

/*:::::*/
static FBSTRING *hMK( int len, void *num )
{
	int	i;
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

/*:::::*/
FBCALL FBSTRING *fb_MKD ( double num )
{
	return hMK( sizeof( double ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKS ( float num )
{
	return hMK( sizeof( float ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKI ( int num )
{
	return hMK( sizeof( int ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKSHORT ( short num )
{
	return hMK( sizeof( short ), &num );
}

/*:::::*/
FBCALL FBSTRING *fb_MKLONGINT ( long long num )
{
	return hMK( sizeof( long long ), &num );
}



