/* frac( x ) = x - fix( x )  - returns the fractional part of a float */

#include "fb.h"

FBCALL float fb_FRACf( float x )
{
	return x - fb_FIXSingle( x );
}

FBCALL double fb_FRACd( double x )
{
	return x - fb_FIXDouble( x );
}
