/* binw$ routine for long long's */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrBinEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *dst, *buf;
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
		num <<= ((sizeof( long long ) << 3) - totdigs);

		for( i = 0; i < totdigs; i++, num <<= 1 )
			if( num & 0x8000000000000000ULL )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = _LC('0');
		}

		for( ; i < totdigs; i++, num <<= 1 )
			if( num & 0x8000000000000000ULL )
				*buf++ = _LC('1');
			else
				*buf++ = _LC('0');
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

FBCALL FB_WCHAR *fb_WstrBin_l ( unsigned long long num )
{
	return fb_WstrBinEx_l( num, 0 );
}
