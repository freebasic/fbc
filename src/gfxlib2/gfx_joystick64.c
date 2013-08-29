#include "fb_gfx.h"

FBCALL int fb_GfxGetJoystick64
	(
		int id,
		long long *buttons,
		float *a1,
		float *a2,
		float *a3,
		float *a4,
		float *a5,
		float *a6,
		float *a7,
		float *a8
	)
{
	int res, ibuttons;

	res = fb_GfxGetJoystick( id, &ibuttons, a1, a2, a3, a4, a5, a6, a7, a8 );

	*buttons = ibuttons;
	return res;
}
