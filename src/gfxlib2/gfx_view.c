/* VIEW statement */

#include "fb_gfx.h"

FBCALL void fb_GfxView(int x1, int y1, int x2, int y2, unsigned int fill_color, unsigned int border_color, int flags)
{
	FB_GFXCTX *context;
	unsigned int old_bg_color;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	context = fb_hGetContext();

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, border_color);
	fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);

    if ((x1 | y1 | x2 | y2) != (int)0xFFFF8000) {
        /* Do nothing if viewport is completely off-screen, otherwise the
           clipping done below would move the rectangle instead of just clipping
           it. It may be better to trigger an "Illegal function call" here, but
           there's no error return here currently. */
        if (x1 >= __fb_gfx->w || y1 >= __fb_gfx->h || x2 < 0 || y2 < 0) {
            FB_GRAPHICS_UNLOCK( );
            return;
        }

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

        /* Clip viewport to screen (without "moving" the viewport). The drawing
           commands rely on this to avoid buffer overruns.

           A "view" with off-screen parts doesn't make sense since it's supposed
           to restrict drawing to some area of the screen, but we have to deal
           with such "bad input" coordinates nevertheless, if they were given by
           the program. Clipping seems like a good solution. */

        x1 = MID(0, x1, __fb_gfx->w - 1);
        y1 = MID(0, y1, __fb_gfx->h - 1);
        x2 = MID(0, x2, __fb_gfx->w - 1);
        y2 = MID(0, y2, __fb_gfx->h - 1);

        context->view_x = x1;
        context->view_y = y1;
        context->view_w = x2 - x1 + 1;
        context->view_h = y2 - y1 + 1;

        DBG_ASSERT(context->view_x >= 0 && context->view_x < __fb_gfx->w);
        DBG_ASSERT(context->view_y >= 0 && context->view_y < __fb_gfx->h);
        DBG_ASSERT(context->view_w > 0 && context->view_w <= __fb_gfx->w);
        DBG_ASSERT(context->view_h > 0 && context->view_h <= __fb_gfx->h);

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

	FB_GRAPHICS_UNLOCK( );
}
