/* Function to get informations about current gfx mode. */

#include "fb_gfx.h"

FBCALL void fb_GfxScreenInfo
	(
		ssize_t *width,
		ssize_t *height,
		ssize_t *depth,
		ssize_t *bpp,
		ssize_t *pitch,
		ssize_t *refresh,
		FBSTRING *driver
	)
{
	char *name;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		name = "";
		fb_hScreenInfo(width, height, depth, refresh);
		*bpp = *pitch = 0;
	} else {
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

	FB_GRAPHICS_UNLOCK( );
}

FBCALL void fb_GfxScreenInfo32
	(
		int *width,
		int *height,
		int *depth,
		int *bpp,
		int *pitch,
		int *refresh,
		FBSTRING *driver
	)
{
	ssize_t w, h, d, b, p, r;
	fb_GfxScreenInfo( &w, &h, &d, &b, &p, &r, driver );
	*width = (int)w;
	*height = (int)h;
	*depth = (int)d;
	*bpp = (int)b;
	*pitch = (int)p;
	*refresh = (int)r;
}

FBCALL void fb_GfxScreenInfo64
	(
		long long *width,
		long long *height,
		long long *depth,
		long long *bpp,
		long long *pitch,
		long long *refresh,
		FBSTRING *driver
	)
{
	ssize_t w, h, d, b, p, r;
	fb_GfxScreenInfo( &w, &h, &d, &b, &p, &r, driver );
	*width = (long long)w;
	*height = (long long)h;
	*depth = (long long)d;
	*bpp = (long long)b;
	*pitch = (long long)p;
	*refresh = (long long)r;
}
