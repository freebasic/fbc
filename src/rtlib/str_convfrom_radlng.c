#include "fb.h"

FBCALL long long fb_hStrRadix2Longint( char *src, ssize_t len, int radix )
{
	long long v;
	int c;

	v = 0;

	switch( radix )
	{
		/* hex */
		case 16:
			while( --len >= 0 )
			{
				c = *src++;
				if( (c >= 97) && (c <= 102) )
					c -= 87;
				else if( (c >= 65) && (c <= 70) )
					c -= 55;
				else if( (c >= 48) && (c <= 57) )
					c -= 48;
				else
					break;
				
				v = (v * 16) + c;
			}
			break;

		/* oct */
		case 8:
			while( --len >= 0 ) {
				c = *src++;
				if( (c >= 48) && (c <= 55) )
					v = (v * 8) + (c - 48);
				else
					break;
			}
			break;

		/* bin */
		case 2:
			while( --len >= 0 ) {
				c = *src++;
				if( (c >= 48) && (c <= 49) )
					v = (v * 2) + (c - 48);
				else
					break;
			}
			break;

		default:
			break;
	}

	return v;
}
