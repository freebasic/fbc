/* hex$ routines */

#include <stdlib.h>
#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


/*:::::*/
static FBSTRING *hHEX ( unsigned int num, int len, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs;

	if( digits > 0 )
	{
		totdigs = (digits < len << 1? digits: len << 1);
		if( digits > len << 1 )
			digits = len << 1;
	}
	else
		totdigs = len << 1;

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
		num <<= ((sizeof(int) << 3) - (totdigs << 2));

		for( i = 0; i < totdigs; i++, num <<= 4 )
			if( num > 0x0FFFFFFF )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 4 )
			*buf++ = hex_table[(num & 0xF0000000) >> 28];
	}

	/* add null-term */
	*buf = '\0';

	fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_b ( unsigned char num )
{
	return hHEX( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_s ( unsigned short num )
{
	return hHEX( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_i ( unsigned int num )
{
	return hHEX( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEXEx_i ( unsigned int num, int digits )
{
	return hHEX( num, sizeof( int ), digits );
}

