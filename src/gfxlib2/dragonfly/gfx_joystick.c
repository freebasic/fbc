/* joystick handling, freebsd */

#include "../fb_gfx.h"

FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8)
{
	*buttons = -1;
	*a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = -1000.0;

	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
