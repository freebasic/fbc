/* list of linux gfx drivers */

#include "fb_gfx.h"

#ifndef DISABLE_X
#include "fb_gfx_x11.h"
#endif

#include "fb_gfx_linux.h"
#include <unistd.h>

const GFXDRIVER *__fb_gfx_drivers_list[] = {
#ifndef DISABLE_X
	&fb_gfxDriverX11,
#ifndef DISABLE_OPENGL
	&fb_gfxDriverOpenGL,
#endif
#endif
	&fb_gfxDriverFBDev,
	NULL
};

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
#ifndef DISABLE_X
	if (fb_hX11ScreenInfo(width, height, depth, refresh))
#endif
		if (fb_hFBDevInfo(width, height, depth, refresh))
			*width = *height = *depth = *refresh = 0;
}
