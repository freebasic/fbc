/* woct$ routines */

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

static FB_WCHAR *hOCT( unsigned int num, ssize_t len, int digits )
{
	FB_WCHAR *dst, *buf;
	int i, totdigs;

	totdigs = ((len * 8) / 3) + 1;

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
		if( (totdigs * 3 < (sizeof(int)*8)) )
		{
			num <<= (sizeof(int)*8) - (totdigs*3);
			i = 0;
        }
		/* too big.. */
		else
		{
			if( num > (0xFFFFFFFFUL >> 2) )
			{
				buf = hFillDigits( buf, digits, totdigs, 0 );
				*buf++ = _LC('0') + ((num & ~(0xFFFFFFFFUL >> 2)) >> (sizeof(int)*8-2));
			}

			num <<= 2;
			i = 1;
		}

		/* check for 0's at msb? */
		if( buf == dst )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFUL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			*buf++ = _LC('0') + ((num & 0xE0000000UL) >> (sizeof(int)*8-3));
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

FBCALL FB_WCHAR *fb_WstrOct_b ( unsigned char num )
{
	return hOCT( num, sizeof( char ), 0 );
}

FBCALL FB_WCHAR *fb_WstrOct_s ( unsigned short num )
{
	return hOCT( num, sizeof( short ), 0 );
}

FBCALL FB_WCHAR *fb_WstrOct_i ( unsigned int num )
{
	return hOCT( num, sizeof( int ), 0 );
}

FBCALL FB_WCHAR *fb_WstrOctEx_b ( unsigned char num, int digits )
{
	return hOCT( num, sizeof( char ), digits );
}

FBCALL FB_WCHAR *fb_WstrOctEx_s ( unsigned short num, int digits )
{
	return hOCT( num, sizeof( short ), digits );
}

FBCALL FB_WCHAR *fb_WstrOctEx_i ( unsigned int num, int digits )
{
	return hOCT( num, sizeof( int ), digits );
}
