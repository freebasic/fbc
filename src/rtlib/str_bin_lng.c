/* bin$ routine for long long's */

#include "fb.h"

FBCALL FBSTRING *fb_BINEx_l ( unsigned long long num, int digits )
{
	FBSTRING *s;
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

	s = fb_hStrAllocTemp( NULL, digits );
	if( s == NULL )
		return &__fb_ctx.null_desc;

	i = digits - 1;
	while( i >= 0 ) {
		s->data[i] = '0' + (num & 1); /* '0' or '1' */
		num >>= 1;
		i -= 1;
	}

	s->data[digits] = '\0';
	return s;
}

FBCALL FBSTRING *fb_BIN_l ( unsigned long long num )
{
	return fb_BINEx_l( num, 0 );
}
