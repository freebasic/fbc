#include "../fb_gfx.h"
#include "fb_gfx_x11.h"

#ifdef HOST_LINUX
#include "../linux/fb_gfx_linux.h"
#endif

#if defined HOST_FREEBSD || defined HOST_OPENBSD || defined HOST_LINUX || defined HOST_DARWIN || defined HOST_SOLARIS || defined HOST_DRAGONFLY || defined HOST_NETBSD

const GFXDRIVER *__fb_gfx_drivers_list[] = {

#ifndef DISABLE_X11
	&fb_gfxDriverX11,
#ifndef DISABLE_OPENGL
	&fb_gfxDriverOpenGL,
#endif
#endif

#if defined HOST_LINUX && !defined DISABLE_FBDEV
	&fb_gfxDriverFBDev,
#endif

	NULL
};

void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
#ifndef DISABLE_X11
	if (fb_hX11ScreenInfo(width, height, depth, refresh))
#endif
#if defined HOST_LINUX && !defined DISABLE_FBDEV
		if (fb_hFBDevInfo(width, height, depth, refresh))
#endif
			*width = *height = *depth = *refresh = 0;
}

#endif
