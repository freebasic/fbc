/* fix function for singles and doubles FIX( x ) = SGN( x ) * INT( ABS( x ) ) */

#include "fb.h"

/*:::::*/
FBCALL float fb_FIXSingle( float x )
{
	return __builtin_floorf( __builtin_fabsf( x ) ) * fb_SGNSingle( x );
}

/*:::::*/
FBCALL double fb_FIXDouble( double x )
{
	return __builtin_floor( __builtin_fabs( x ) ) * fb_SGNDouble( x );
}
