#include "fb.h"

FBCALL int fb_GetMouse64( long long *x, long long *y, long long *z, long long *buttons, long long *clip )
{
	int res, ix, iy, iz, ibuttons, iclip;

	res = fb_GetMouse( &ix, &iy, &iz, &ibuttons, &iclip );

	*x = ix;
	*y = iy;
	*z = iz;
	*buttons = ibuttons;
	*clip = iclip;
	return res;
}
