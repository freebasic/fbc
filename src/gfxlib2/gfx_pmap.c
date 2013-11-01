/* pmap statement and point function with one argument */

#include "fb_gfx.h"


/*:::::*/
FBCALL float fb_GfxPMap(float coord, int func)
{
	FB_GFXCTX *context = fb_hGetContext();

	if (!__fb_gfx)
		return 0.0;
	
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);
	
	switch (func) {
		
		case 0:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord - context->win_x) * context->view_w) / context->win_w;
			return coord;
		
		case 1:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				coord = ((coord - context->win_y) * context->view_h) / context->win_h;
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
			}
			return coord;
		
		case 2:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord * context->win_w) / context->view_w) + context->win_x;
			return coord;
		
		case 3:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
				coord = ((coord * context->win_h) / context->view_h) + context->win_y;
			}
			return coord;
	}
	return 0;
}


/*:::::*/
FBCALL float fb_GfxCursor(int func)
{
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!__fb_gfx)
		return 0.0;
	
	switch (func) {
		
		case 0: return fb_GfxPMap(context->last_x, 0);
		case 1: return fb_GfxPMap(context->last_y, 1);
		case 2: return context->last_x;
		case 3: return context->last_y;
	}
	return 0;
}
