/* joystick handling, win32 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"
#include <mmsystem.h>

#define CALCPOS(pos, min, max)	(((((float)(pos) - (float)(min)) * 2.0) / ((float)(max) - (float)(min) + 1.0)) - 1.0)

typedef struct _JOYDATA {
	int detected, available;
	JOYCAPS caps;
} JOYDATA;

static JOYDATA joy[16];
static int inited = FALSE;

#define POV_LAP 2250

FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8)
{
	JOYINFOEX info;
	JOYDATA *j;

	FB_GRAPHICS_LOCK( );

	*buttons = -1;
	*a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = -1000.0;

	if (!inited) {
		fb_hMemSet(joy, 0, sizeof(JOYDATA) * 16);
		inited = TRUE;
	}

	if ((id < 0) || (id > 15)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	j = &joy[id];

	if (!j->detected) {
		j->detected = TRUE;
		if (joyGetDevCaps(id + JOYSTICKID1, &j->caps, sizeof(j->caps)) != JOYERR_NOERROR) {
			FB_GRAPHICS_UNLOCK( );
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
		j->available = TRUE;
	}

	if (!j->available) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	info.dwSize = sizeof(info);
	info.dwFlags = JOY_RETURNALL;
	if (joyGetPosEx(id + JOYSTICKID1, &info) != JOYERR_NOERROR) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	*a1 = CALCPOS(info.dwXpos, j->caps.wXmin, j->caps.wXmax);
	*a2 = CALCPOS(info.dwYpos, j->caps.wYmin, j->caps.wYmax);
	if (j->caps.wCaps & JOYCAPS_HASZ)
		*a3 = CALCPOS(info.dwZpos, j->caps.wZmin, j->caps.wZmax);
	if (j->caps.wCaps & JOYCAPS_HASR)
		*a4 = CALCPOS(info.dwRpos, j->caps.wRmin, j->caps.wRmax);
	if (j->caps.wCaps & JOYCAPS_HASU)
		*a5 = CALCPOS(info.dwUpos, j->caps.wUmin, j->caps.wUmax);
	if (j->caps.wCaps & JOYCAPS_HASV)
		*a6 = CALCPOS(info.dwVpos, j->caps.wVmin, j->caps.wVmax);
	if (j->caps.wCaps & JOYCAPS_HASPOV)
	{
		*a7 = *a8 = 0;

		if(( info.dwPOV > 4500 - POV_LAP ) && ( info.dwPOV < 13500 + POV_LAP ))
			*a7 = 1;
		else if(( info.dwPOV > 22500 - POV_LAP ) && ( info.dwPOV < 31500 + POV_LAP ))
			*a7 = -1;

		if(( info.dwPOV > 13500 - POV_LAP ) && ( info.dwPOV < 22500 + POV_LAP ))
			*a8 = 1;
		else if( info.dwPOV < 4500 + POV_LAP )
			*a8 = -1;
		else if(( info.dwPOV > 31500 - POV_LAP ) && ( info.dwPOV < 36000 ))
			*a8 = -1;
	}

	*buttons = info.dwButtons;

	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
