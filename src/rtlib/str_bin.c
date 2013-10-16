/* bin$ routines */

#include "fb.h"

static FBSTRING *hBIN( unsigned int num, ssize_t len, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs;
	unsigned int mask;

	if( digits > 0 )
	{
		totdigs = (digits < len << 3? digits: len << 3);
		if( digits > len << 3 )
			digits = len << 3;
	}
	else
		totdigs = len << 3;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, totdigs );
	if( dst == NULL )
		return &__fb_ctx.null_desc;

	/* convert */
	buf = dst->data;

	if( num == 0 )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = '0';
	}
	else
	{
		mask = 1UL << (totdigs-1);

		for( i = 0; i < totdigs; i++, num <<= 1 )
			if( num & mask )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 1 )
			if( num & mask )
				*buf++ = '1';
			else
				*buf++ = '0';
	}

	/* add null-term */
	*buf = '\0';

    fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

FBCALL FBSTRING *fb_BIN_b ( unsigned char num )
{
	return hBIN( num, sizeof( char ), 0 );
}

FBCALL FBSTRING *fb_BIN_s ( unsigned short num )
{
	return hBIN( num, sizeof( short ), 0 );
}

FBCALL FBSTRING *fb_BIN_i ( unsigned int num )
{
	return hBIN( num, sizeof( int ), 0 );
}

FBCALL FBSTRING *fb_BINEx_b( unsigned char num, int digits )
{
	return hBIN( num, sizeof( unsigned char ), digits );
}

FBCALL FBSTRING *fb_BINEx_s( unsigned short num, int digits )
{
	return hBIN( num, sizeof( unsigned short ), digits );
}

FBCALL FBSTRING *fb_BINEx_i ( unsigned int num, int digits )
{
	return hBIN( num, sizeof( int ), digits );
}
