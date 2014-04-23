/* WINDOW statement */

#include "fb_gfx.h"

FBCALL void fb_GfxWindow(float x1, float y1, float x2, float y2, int screen)
{
	FB_GFXCTX *context;
	float temp;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext( );
	if (x1 || y1 || x2 || y2) {
		if (x2 < x1) {
			temp = x1;
			x1 = x2;
			x2 = temp;
		}
		if (y2 < y1) {
			temp = y1;
			y1 = y2;
			y2 = temp;
		}

		context->win_x = x1;
		context->win_w = x2 - x1;
		context->win_y = y1;
		context->win_h = y2 - y1;
		context->flags |= CTX_WINDOW_ACTIVE;
		if (screen)
			context->flags |= CTX_WINDOW_SCREEN;
	} else {
		context->flags &= ~(CTX_WINDOW_ACTIVE | CTX_WINDOW_SCREEN);
	}

	FB_GRAPHICS_UNLOCK( );
}
