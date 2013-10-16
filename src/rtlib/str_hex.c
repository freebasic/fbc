/* hex$ routines */

#include "fb.h"

FBCALL FBSTRING *fb_HEX_b ( unsigned char num )
{
	return fb_HEXEx_l( num, 0 );
}

FBCALL FBSTRING *fb_HEX_s ( unsigned short num )
{
	return fb_HEXEx_l( num, 0 );
}

FBCALL FBSTRING *fb_HEX_i ( unsigned int num )
{
	return fb_HEXEx_l( num, 0 );
}

FBCALL FBSTRING *fb_HEXEx_b( unsigned char num, int digits )
{
	return fb_HEXEx_l( num, digits );
}

FBCALL FBSTRING *fb_HEXEx_s( unsigned short num, int digits )
{
	return fb_HEXEx_l( num, digits );
}

FBCALL FBSTRING *fb_HEXEx_i ( unsigned int num, int digits )
{
	return fb_HEXEx_l( num, digits );
}
