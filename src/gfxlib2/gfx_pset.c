/* pixel plotting */

#include "fb_gfx.h"

FBCALL void fb_GfxPset(void *target, float fx, float fy, unsigned int color, int flags, int ispreset)
{
	FB_GFXCTX *context;
	int x, y;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);

	if (flags & DEFAULT_COLOR_1) {
		if (ispreset)
			color = context->bg_color;
		else
			color = context->fg_color;
	} else {
		color = fb_hFixColor(context->target_bpp, color);
	}

	fb_hSetPixelTransfer(context, color);
	fb_hFixRelative(context, flags, &fx, &fy, NULL, NULL);
	fb_hTranslateCoord(context, fx, fy, &x, &y);

	if ((x < context->view_x) || (y < context->view_y) ||
	    (x >= context->view_x + context->view_w) || (y >= context->view_y + context->view_h)) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	DRIVER_LOCK();
	context->put_pixel(context, x, y, color);
	if (__fb_gfx->framebuffer == context->line[0])
		__fb_gfx->dirty[y] = TRUE;
	DRIVER_UNLOCK();

	FB_GRAPHICS_UNLOCK( );
}
