/* GET statement */

#include "fb_gfx.h"

static int gfx_get(void *target, float fx1, float fy1, float fx2, float fy2, unsigned char *dest, int coord_type, FBARRAY *array, int usenewheader )
{
	FB_GFXCTX *context;
	PUT_HEADER *header;
	int x1, y1, x2, y2, w, h, pitch;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);
	fb_hSetPixelTransfer(context, MASK_A_32);

	fb_hFixRelative(context, coord_type, &fx1, &fy1, &fx2, &fy2);

	fb_hTranslateCoord(context, fx1, fy1, &x1, &y1);
	fb_hTranslateCoord(context, fx2, fy2, &x2, &y2);

	fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);

	if ((x1 < context->view_x) || (y1 < context->view_y) ||
	    (x2 >= context->view_x + context->view_w) || (y2 >= context->view_y + context->view_h)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	w = x2 - x1 + 1;
	h = y2 - y1 + 1;

	header = (PUT_HEADER *)dest;
	if (!usenewheader) {
		/* use old-style header for compatibility */
		header->old.bpp = context->target_bpp;
		header->old.width = w;
		header->old.height = h;
		pitch = w * context->target_bpp;
		dest += 4;
	} else {
		/* use new-style header */
		header->type = PUT_HEADER_NEW;
		header->width = w;
		header->height = h;
		header->bpp = context->target_bpp;
		pitch = header->pitch = ((w * context->target_bpp) + 0xF) & ~0xF;
		dest += sizeof(PUT_HEADER);
	}

	if( array != NULL ) {
		if ((array->size > 0) && (((intptr_t)(dest + (pitch * h))) > ((intptr_t)(array->data + array->size)))) {
			FB_GRAPHICS_UNLOCK( );
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
	}

	DRIVER_LOCK();

	for (; y1 <= y2; y1++) {
		fb_hPixelCpy(dest, context->line[y1] + (x1 * context->target_bpp), w);
		dest += pitch;
	}

	DRIVER_UNLOCK();

	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int fb_GfxGet(void *target, float fx1, float fy1, float fx2, float fy2, unsigned char *dest, int coord_type, FBARRAY *array)
{
	return gfx_get( target, fx1, fy1, fx2, fy2, dest, coord_type, array, TRUE );
}

FBCALL int fb_GfxGetQB(void *target, float fx1, float fy1, float fx2, float fy2, unsigned char *dest, int coord_type, FBARRAY *array)
{
	return gfx_get( target, fx1, fy1, fx2, fy2, dest, coord_type, array, FALSE );
}
