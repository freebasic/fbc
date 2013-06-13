#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_HEX ( int num )
{
	return fb_HEX_i ( num );
}


/*:::::*/
FBCALL FBSTRING *fb_OCT ( int num )
{
	return fb_OCT_i ( num );
}


/*:::::*/
FBCALL FBSTRING *fb_BIN ( int num )
{
	return fb_BIN_i ( num );
}


