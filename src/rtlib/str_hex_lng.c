/* hex$ routine for long long's */

#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

FBCALL FBSTRING *fb_HEXEx_l ( unsigned long long num, int digits )
{
	FBSTRING *s;
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

	s = fb_hStrAllocTemp( NULL, digits );
	if( s == NULL )
		return &__fb_ctx.null_desc;

	i = digits - 1;
	while( i >= 0 ) {
		s->data[i] = hex_table[num & 0xF];
		num >>= 4;
		i -= 1;
	}

	s->data[digits] = '\0';
	return s;
}

FBCALL FBSTRING *fb_HEX_l ( unsigned long long num )
{
	return fb_HEXEx_l( num, 0 );
}
