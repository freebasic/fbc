/* VIEW statement */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxView(int x1, int y1, int x2, int y2, unsigned int fill_color, unsigned int border_color, int flags)
{
	FB_GFXCTX *context = fb_hGetContext();
	unsigned int old_bg_color;

	if (!__fb_gfx)
		return;

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, border_color);

	fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);

    if ((x1 | y1 | x2 | y2) != 0xFFFF8000) {

        context->flags |= CTX_VIEWPORT_SET;

        if (flags & VIEW_SCREEN)
            context->flags |= CTX_VIEW_SCREEN;
        else
            context->flags &= ~CTX_VIEW_SCREEN;

        if (!(flags & DEFAULT_COLOR_2)) {
            border_color = fb_hFixColor(context->target_bpp, border_color);
            /* Temporarily set full screen area clipping to draw view border */
            context->view_x = 0;
            context->view_y = 0;
            context->view_w = __fb_gfx->w;
            context->view_h = __fb_gfx->h;
            fb_hGfxBox(x1 - 1, y1 - 1, x2 + 1, y2 + 1, border_color & __fb_gfx->color_mask, FALSE, 0xFFFF);
        }
        
        context->view_x = MID(0, x1, __fb_gfx->w);
        context->view_y = MID(0, y1, __fb_gfx->h);
        context->view_w = MIN(x2 - x1 + 1, __fb_gfx->w - x1);
        context->view_h = MIN(y2 - y1 + 1, __fb_gfx->h - y1);
        
        if (!(flags & DEFAULT_COLOR_1)) {
            old_bg_color = context->bg_color;
            context->bg_color = fb_hFixColor(context->target_bpp, fill_color);
            fb_GfxClear(1);
            context->bg_color = old_bg_color;
        }

    } else {

        context->flags &= ~CTX_VIEWPORT_SET;

        context->view_x = context->view_y = 0;
        context->view_w = __fb_gfx->w;
        context->view_h = __fb_gfx->h;
    }
}
