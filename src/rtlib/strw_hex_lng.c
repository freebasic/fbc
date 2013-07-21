/* hexw$ routine for long long's */

#include "fb.h"

static FB_WCHAR hex_table[16] = {_LC('0'),_LC('1'),_LC('2'),_LC('3'),
								 _LC('4'),_LC('5'),_LC('6'),_LC('7'),
								 _LC('8'),_LC('9'),_LC('A'),_LC('B'),
								 _LC('C'),_LC('D'),_LC('E'),_LC('F')};


FBCALL FB_WCHAR *fb_WstrHexEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *dst, *buf;
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
    dst = fb_wstr_AllocTemp( totdigs );
	if( dst == NULL )
		return NULL;

	/* convert */
	buf = dst;

	if( num == 0ULL )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = _LC('0');
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
				*buf++ = _LC('0');
		}

		for( ; i < totdigs; i++, num <<= 4 )
			*buf++ = hex_table[(num & 0xF000000000000000ULL) >> 60];
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

FBCALL FB_WCHAR *fb_WstrHex_l ( unsigned long long num )
{
	return fb_WstrHexEx_l( num, 0 );
}
