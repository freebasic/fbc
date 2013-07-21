/* octw$ routine for long long's */

#include "fb.h"

static FB_WCHAR *hFillDigits( FB_WCHAR *buf, int digits, int totdigs, int cnt )
{
	if( digits > 0 )
	{
		digits -= totdigs - cnt;
		while( digits > 0 )
		{
			*buf++ = _LC('0');
			--digits;
		}
	}

	return buf;
}

FBCALL FB_WCHAR *fb_WstrOctEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *dst, *buf;
	int i, totdigs;

	totdigs = ((sizeof(long long)*8) / 3) + 1;

	if( digits > 0 )
	{
		if( digits < totdigs )
			totdigs = digits;
		else if( digits > totdigs )
			digits = totdigs;
	}

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( totdigs );
	if( dst == NULL )
		return NULL;

	/* convert */
	buf = dst;

	if( num == 0 )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = _LC('0');
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
				*buf++ = _LC('0') + ((num & ~(0xFFFFFFFFFFFFFFFFULL >> 1))
									 >> (sizeof(long long)*8-1));
			}

			num <<= 1;
			i = 1;
		}

		/* check for 0's at msb? */
		if( buf == dst )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFFFFFFFFFULL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			*buf++ = _LC('0') + ((num & 0xE000000000000000ULL) >> (sizeof(long long)*8-3));
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

FBCALL FB_WCHAR *fb_WstrOct_l ( unsigned long long num )
{
	return fb_WstrOctEx_l( num, 0 );
}
