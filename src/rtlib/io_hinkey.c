#include "fb.h"

/* Builds the string to be returned by the console/gfx inkey() functions */
FBSTRING *fb_hMakeInkeyStr( int key )
{
	FBSTRING *res;

	if( key > 0xFF ) {
		/* 2-byte extended keycode */
		res = fb_CHR( 2, (key & 0xFF), (key >> 8) );
	} else {
		res = fb_CHR( 1, key );
	}

	return res;
}
