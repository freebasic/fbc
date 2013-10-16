/* hexw$ routines */

#include "fb.h"

FBCALL FB_WCHAR *fb_WstrHex_b ( unsigned char num )
{
	return fb_WstrHexEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrHex_s ( unsigned short num )
{
	return fb_WstrHexEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrHex_i ( unsigned int num )
{
	return fb_WstrHexEx_l( num, 0 );
}

FBCALL FB_WCHAR *fb_WstrHexEx_b( unsigned char num, int digits )
{
	return fb_WstrHexEx_l( num, digits );
}

FBCALL FB_WCHAR *fb_WstrHexEx_s( unsigned short num, int digits )
{
	return fb_WstrHexEx_l( num, digits );
}

FBCALL FB_WCHAR *fb_WstrHexEx_i ( unsigned int num, int digits )
{
	return fb_WstrHexEx_l( num, digits );
}
