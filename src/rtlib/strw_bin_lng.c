/* binw$ routine for long long's */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrBinEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *s;
	int i;
	unsigned long long num2;

	if( digits <= 0 ) {
		/* Only use the minimum amount of digits needed; need to count
		   the important bits in the number. And if there are none set,
		   use 1 digit for 1 zero. */
		digits = 0;
		num2 = num;
		while( num2 ) {
			digits += 1;
			num2 >>= 1;
		}
		if( digits == 0 )
			digits = 1;
	}

	s = fb_wstr_AllocTemp( digits );
	if( s == NULL )
		return NULL;

	i = digits - 1;
	while( i >= 0 ) {
		s[i] = _LC('0') + (num & 1); /* '0' or '1' */
		num >>= 1;
		i -= 1;
	}

	s[digits] = _LC('\0');
	return s;
}

FBCALL FB_WCHAR *fb_WstrBin_l ( unsigned long long num )
{
	return fb_WstrBinEx_l( num, 0 );
}
