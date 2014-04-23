/* screen clearing routine */

#include "fb_gfx.h"

void fb_GfxClear(int mode)
{
	FB_GFXCTX *context;
    int i, dirty, dirty_len;
    int reset_gfx_pos;
    int reset_console_start = 0, reset_console_end = 0;
    int new_x = -1, new_y = -1;

	FB_GRAPHICS_LOCK( );

	context = fb_hGetContext();
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, context->bg_color);

    DRIVER_LOCK();

    if( mode == (int)0xFFFF0000 ) {
        if( context->flags & CTX_VIEWPORT_SET )
            mode = 1;
        else {
            int con_y_start = fb_ConsoleGetTopRow();
            int con_y_end = fb_ConsoleGetBotRow();
            if( con_y_start==0 && (con_y_end==__fb_gfx->text_h-1) )
                /* No VIEW PRINT range set */
                mode = 0;
            else
                mode = 2;
        }
    }

	switch (mode) {
		case 0:
			/* Clear entire screen */
            {
                int cursor_y = fb_ConsoleGetTopRow();

                context->pixel_set(context->line[0], context->bg_color, __fb_gfx->w * __fb_gfx->h);
                dirty = 0;
                dirty_len = __fb_gfx->h;

                new_x = 0;
                new_y = cursor_y;

                reset_console_end = __fb_gfx->text_h;

                reset_gfx_pos = TRUE;
            }
			break;

		case 2:
            /* Clear text viewport */
            {
                int con_y_start = fb_ConsoleGetTopRow();
                int con_y_end = fb_ConsoleGetBotRow();
                int y_start = con_y_start * __fb_gfx->font->h;
                int y_end = (con_y_end + 1) * __fb_gfx->font->h;
                int view_height = y_end - y_start;

                context->pixel_set(context->line[y_start], context->bg_color, __fb_gfx->w * view_height);
                dirty = y_start;
                dirty_len = view_height;

                new_x = 0;
                new_y = con_y_start;

                reset_console_start = con_y_start;
                reset_console_end = con_y_end + 1;

                reset_gfx_pos = FALSE;
            }
            break;

		case 1:
		default:
            /* Clear graphics viewport if set */
            {
                unsigned char *dest = context->line[context->view_y] + (context->view_x * __fb_gfx->bpp);
                for (i = 0; i < context->view_h; i++) {
                    context->pixel_set(dest, context->bg_color, context->view_w);
                    dest += __fb_gfx->pitch;
                }
                dirty = context->view_y;
                dirty_len = context->view_h;

                reset_gfx_pos = TRUE;
            }
			break;
	}
	SET_DIRTY(context, dirty, dirty_len);

    if( reset_gfx_pos ) {
        context->last_x = context->view_x + (context->view_w >> 1);
        context->last_y = context->view_y + (context->view_h >> 1);
    }

    fb_hClearCharCells( 0, reset_console_start,
                        __fb_gfx->text_w, reset_console_end,
                        context->work_page,
                        32,
                        context->fg_color, context->bg_color );

    if( new_x!=-1 || new_y!=-1 ) {
        fb_GfxLocate( new_y + 1, new_x + 1, -1 );
    }

    DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );
}
