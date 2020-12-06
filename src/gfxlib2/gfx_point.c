/* pixel retrieving */

#include "fb_gfx.h"

FBCALL unsigned int fb_GfxPoint(void *target, float fx, float fy)
{
	FB_GFXCTX *context;
	int x, y;
	unsigned int color;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return -1;
	}

	if( fy == -8388607.0 ) {
		FB_GRAPHICS_UNLOCK( );
		return fb_GfxCursor(fx);
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);
	fb_hSetPixelTransfer(context, MASK_A_32);

	fb_hTranslateCoord(context, fx, fy, &x, &y);

	if ((x < context->view_x) || (y < context->view_y) ||
	    (x >= context->view_x + context->view_w) || (y >= context->view_y + context->view_h)) {
		FB_GRAPHICS_UNLOCK( );
		return -1;
	}

	DRIVER_LOCK();
	color = context->get_pixel(context, x, y);
	DRIVER_UNLOCK();

	if (__fb_gfx->depth == 16)
		/* approximate: for each component we also report high bits in lower bits of new value */
		color = (((color & 0x001F) << 3) | ((color >> 2) & 0x7) |
			 ((color & 0x07E0) << 5) | ((color >> 1) & 0x300) |
			 ((color & 0xF800) << 8) | ((color << 3) & 0x70000));

	FB_GRAPHICS_UNLOCK( );

	/* Returning a RGBA value or palette index in a signed 32bit/64bit
	   Integer, without sign-extension on 64bit.
	   (palette indices can't be negative anyways, and sign-extending an
	   RGBA value would cause it to compare unequal to a normal,
	   non-sign-extended one) */
	return color;
}
