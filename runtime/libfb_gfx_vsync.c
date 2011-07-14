/* vertical sync routine */

#include "fb_gfx.h"


FBCALL int fb_GfxWaitVSync(void)
{
	if (!__fb_gfx)
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	if (__fb_gfx->driver->wait_vsync)
		__fb_gfx->driver->wait_vsync();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
