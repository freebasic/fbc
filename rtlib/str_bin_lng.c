/* bin$ routine for long long's */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_BINEx_l ( unsigned long long num, int digits )
{
	FBSTRING *dst;
	char *buf;
	int i, totdigs;

	if( digits > 0 )
	{
		totdigs = (digits < sizeof( long long ) << 3? digits: sizeof( long long ) << 3);
		if( digits > sizeof( long long ) << 3 )
			digits = sizeof( long long ) << 3;
	}
	else
		totdigs = sizeof( long long ) << 3;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, totdigs );
	if( dst == NULL )
		return &__fb_ctx.null_desc;

	/* convert */
	buf = dst->data;

	if( num == 0ULL )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = '0';
	}
	else
	{
		num <<= ((sizeof( long long ) << 3) - totdigs);

		for( i = 0; i < totdigs; i++, num <<= 1 )
			if( num & 0x8000000000000000ULL )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 1 )
			if( num & 0x8000000000000000ULL )
				*buf++ = '1';
			else
				*buf++ = '0';
	}

	/* add null-term */
	*buf = '\0';

	fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_l ( unsigned long long num )
{
	return fb_BINEx_l( num, 0 );
}

