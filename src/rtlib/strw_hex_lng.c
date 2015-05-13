/* hexw$ routine for long long's */

#include "fb.h"

static FB_WCHAR hex_table[16] = {_LC('0'),_LC('1'),_LC('2'),_LC('3'),
								 _LC('4'),_LC('5'),_LC('6'),_LC('7'),
								 _LC('8'),_LC('9'),_LC('A'),_LC('B'),
								 _LC('C'),_LC('D'),_LC('E'),_LC('F')};

FBCALL FB_WCHAR *fb_WstrHexEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *s;
	int i;
	unsigned long long num2;

	if( digits <= 0 ) {
		/* Only use the minimum amount of digits needed; need to count
		   the important 4-bit (base 16) chunks in the number.
		   And if it's zero, use 1 digit for 1 zero. */
		digits = 0;
		num2 = num;
		while( num2 ) {
			digits += 1;
			num2 >>= 4;
		}
		if( digits == 0 )
			digits = 1;
	}

	s = fb_wstr_AllocTemp( digits );
	if( s == NULL )
		return NULL;

	i = digits - 1;
	while( i >= 0 ) {
		s[i] = hex_table[num & 0xF];
		num >>= 4;
		i -= 1;
	}

	s[digits] = _LC('\0');
	return s;
}

FBCALL FB_WCHAR *fb_WstrHex_l ( unsigned long long num )
{
	return fb_WstrHexEx_l( num, 0 );
}
