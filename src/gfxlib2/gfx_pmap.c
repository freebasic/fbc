/* pmap statement and point function with one argument */

#include "fb_gfx.h"

FBCALL float fb_GfxPMap(float coord, int func)
{
	FB_GFXCTX *context;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return 0.0;
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

	switch (func) {
		case 0:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord - context->win_x) * context->view_w) / context->win_w;
			break;

		case 1:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				coord = ((coord - context->win_y) * context->view_h) / context->win_h;
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
			}
			break;

		case 2:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord * context->win_w) / context->view_w) + context->win_x;
			break;

		case 3:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
				coord = ((coord * context->win_h) / context->view_h) + context->win_y;
			}
			break;

		default:
			coord = 0;
			break;
	}

	FB_GRAPHICS_UNLOCK( );
	return coord;
}

FBCALL float fb_GfxCursor(int func)
{
	FB_GFXCTX *context;
	float result;

	FB_GRAPHICS_LOCK( );

	context = fb_hGetContext( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return 0.0;
	}

	switch (func) {
	case 0:  result = fb_GfxPMap(context->last_x, 0); break;
	case 1:  result = fb_GfxPMap(context->last_y, 1); break;
	case 2:  result = context->last_x; break;
	case 3:  result = context->last_y; break;
	default: result = 0; break;
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}
