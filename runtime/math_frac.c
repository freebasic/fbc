/* frac function for singles and doubles FRAC( x ) = x - INT( x ) */

#include "fb.h"
#include <math.h>


/*:::::*/
FBCALL float fb_FRACf( float x )
{

	return x - __builtin_floorf( x );

}


/*:::::*/
FBCALL double fb_FRACd( double x )
{

	return x - __builtin_floorl( x );

}


