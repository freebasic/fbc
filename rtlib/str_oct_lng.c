/* oct$ routine for long long's */

#include "fb.h"

/*:::::*/
static char *hFillDigits( char *buf, int digits, int totdigs, int cnt )
{
	if( digits > 0 )
	{
		digits -= totdigs - cnt;
		while( digits > 0 )
		{
			*buf++ = '0';
			--digits;
		}
	}

	return buf;
}

/*:::::*/
FBCALL FBSTRING *fb_OCTEx_l ( unsigned long long num, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs;

	totdigs = ((sizeof(long long)*8) / 3) + 1;

	if( digits > 0 )
	{
		if( digits < totdigs )
			totdigs = digits;
		else if( digits > totdigs )
			digits = totdigs;
	}

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
		/* enough to fit? */
		if( (totdigs * 3 < (sizeof(long long)*8)) )
		{
			num <<= (sizeof(long long)*8) - (totdigs*3);
			i = 0;
        }
		/* too big.. */
		else
		{
			if( num > (0xFFFFFFFFFFFFFFFFULL >> 1) )
			{
				buf = hFillDigits( buf, digits, totdigs, 0 );
				*buf++ = '0' + ((num & ~(0xFFFFFFFFFFFFFFFFULL >> 1))
								>> (sizeof(long long)*8-1));
			}

			num <<= 1;
			i = 1;
		}

		/* check for 0's at msb? */
		if( buf == dst->data )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFFFFFFFFFULL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			*buf++ = '0' + ((num & 0xE000000000000000ULL) >> (sizeof(long long)*8-3));
	}

	/* add null-term */
	*buf = '\0';

    fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_OCT_l ( unsigned long long num )
{
	return fb_OCTEx_l( num, 0 );
}

