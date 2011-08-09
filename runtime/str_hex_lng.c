/* hex$ routine for long long's */

#include <stdlib.h>
#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

/*:::::*/
FBCALL FBSTRING *fb_HEXEx_l ( unsigned long long num, int digits )
{
	FBSTRING *dst;
	char *buf;
	int i, totdigs;

	if( digits > 0 )
	{
		totdigs = (digits < sizeof( long long ) << 1? digits: sizeof( long long ) << 1);
		if( digits > sizeof( long long ) << 1 )
			digits = sizeof( long long ) << 1;
	}
	else
		totdigs = sizeof( long long ) << 1;

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
		num <<= ((sizeof( long long ) << 3) - (totdigs << 2));

		for( i = 0; i < totdigs; i++, num <<= 4 )
			if( num > 0x0FFFFFFFFFFFFFFFULL )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 4 )
			*buf++ = hex_table[(num & 0xF000000000000000ULL) >> 60];
	}

	/* add null-term */
	*buf = '\0';

	fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_l ( unsigned long long num )
{
	return fb_HEXEx_l( num, 0 );
}

