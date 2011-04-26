/*
 * openbsd.c -- list of OpenBSD gfx drivers
 *
 * chng: jan/2007 written [DrV]
 *
 */

#include "fb_gfx.h"
#include "fb_gfx_x11.h"

const GFXDRIVER *__fb_gfx_drivers_list[] = {
	&fb_gfxDriverX11,
#ifdef HAVE_GL_GL_H
	&fb_gfxDriverOpenGL,
#endif
	NULL
};

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
	if (fb_hX11ScreenInfo(width, height, depth, refresh))
		*width = *height = *depth = *refresh = 0;
}
