/*
 * screeninfo.c -- Function to get informations about current gfx mode.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxScreenInfo(int *width, int *height, int *depth, int *bpp, int *pitch, int *refresh, FBSTRING *driver)
{
	char *name;
	
	if (!__fb_gfx) {
		name = "";
		fb_hScreenInfo(width, height, depth, refresh);
		*bpp = *pitch = 0;
	}
	else {
		name = __fb_gfx->driver->name;
		*width = __fb_gfx->w;
		*height = __fb_gfx->h;
		*depth = __fb_gfx->depth;
		*bpp = __fb_gfx->bpp;
		*pitch = __fb_gfx->pitch;
		*refresh = __fb_gfx->refresh_rate;
	}
	
	if (fb_hStrDelTemp(driver)) {
		fb_hStrRealloc(driver, strlen(name), FB_FALSE);
		strcpy(driver->data, name);
	}
}
