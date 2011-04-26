/*
 * linux.c -- list of linux gfx drivers
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

#ifdef WITH_X
#include "fb_gfx_x11.h"
#endif

#include "fb_gfx_linux.h"
#include <unistd.h>

const GFXDRIVER *__fb_gfx_drivers_list[] = {
#ifdef WITH_X
	&fb_gfxDriverX11,
#ifdef HAVE_GL_GL_H
	&fb_gfxDriverOpenGL,
#endif
#endif
	&fb_gfxDriverFBDev,
	NULL
};

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
#ifdef WITH_X
	if (fb_hX11ScreenInfo(width, height, depth, refresh))
#endif
		if (fb_hFBDevInfo(width, height, depth, refresh))
			*width = *height = *depth = *refresh = 0;
}
