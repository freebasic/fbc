/* implementation of pos(dummy), simply redirects to fb_GetX() */

#include "fb.h"

/*:::::*/
FBCALL int fb_Pos( int dummy )
{
	return fb_GetX();
}

