/* bin$ routines */

#include "fb.h"

FBCALL FBSTRING *fb_BIN_b ( unsigned char num )
{
	return fb_BINEx_l( num, 0 );
}

FBCALL FBSTRING *fb_BIN_s ( unsigned short num )
{
	return fb_BINEx_l( num, 0 );
}

FBCALL FBSTRING *fb_BIN_i ( unsigned int num )
{
	return fb_BINEx_l( num, 0 );
}

FBCALL FBSTRING *fb_BINEx_b( unsigned char num, int digits )
{
	return fb_BINEx_l( num, digits );
}

FBCALL FBSTRING *fb_BINEx_s( unsigned short num, int digits )
{
	return fb_BINEx_l( num, digits );
}

FBCALL FBSTRING *fb_BINEx_i ( unsigned int num, int digits )
{
	return fb_BINEx_l( num, digits );
}
