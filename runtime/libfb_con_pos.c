/*
 * con_pos.c -- implementation of pos(dummy), simply redirects to fb_GetX()
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_Pos( int dummy )
{
	return fb_GetX();
}

