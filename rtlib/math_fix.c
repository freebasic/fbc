/* fix function for singles and doubles FIX( x ) = SGN( x ) * INT( ABS( x ) ) */

#include "fb.h"
#include <math.h>


/*:::::*/
FBCALL float fb_FIXSingle( float x )
{

	return __builtin_floorf( __builtin_fabsf( x ) ) * fb_SGNSingle( x );

}


/*:::::*/
FBCALL double fb_FIXDouble( double x )
{

	return __builtin_floorl( __builtin_fabsl( x ) ) * fb_SGNDouble( x );

}


