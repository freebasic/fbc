/* PUT statement */

#include "fb_gfx.h"

#ifdef HOST_X86
#include "x86/fb_gfx_mmx.h"
extern void fb_hPutAlphaMaskMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
#endif

static void fb_hPutAlphaMask(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned char *s;
	unsigned int *d;
	unsigned int dc, sc;
	int x;

#ifdef HOST_X86
	if (__fb_gfx->flags & HAS_MMX) {
		fb_hPutAlphaMaskMMX(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
		return;
	}
#endif

	s = src;
	d = (unsigned int *)dest;
	src_pitch -= w;
	dest_pitch = (dest_pitch >> 2) - w;
	for (; h; h--) {
		for (x = w; x; x--) {
			dc = *d;
			sc = *s++;
			*d++ = (dc & ~MASK_A_32) | (sc << 24);
		}
		s += src_pitch;
		d += dest_pitch;
	}
}

FBCALL int fb_GfxPut(void *target, float fx, float fy, unsigned char *src, int x1, int y1, int x2, int y2, int coord_type, int put_mode, PUTTER *putter, int alpha, BLENDER *blender, void *param)
{
	FB_GFXCTX *context;
	int x, y, w, h, pitch, bpp;
	int lhs, rhs;
	PUT_HEADER *header;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (!src)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	context = fb_hGetContext( );
	fb_hPrepareTarget(context, target);
	fb_hSetPixelTransfer(context, MASK_A_32);

	// quirky but good
	switch (coord_type) {
		case COORD_TYPE_RA:
			lhs = COORD_TYPE_R;
			rhs = COORD_TYPE_A;
			break;
		case COORD_TYPE_RR:
			lhs = COORD_TYPE_R;
			rhs = COORD_TYPE_R;
			break;
		case COORD_TYPE_AA:
			lhs = COORD_TYPE_A;
			rhs = COORD_TYPE_A;
			break;
		case COORD_TYPE_AR:
			lhs = COORD_TYPE_A;
			rhs = COORD_TYPE_R;
			break;
		default:
			FB_GRAPHICS_UNLOCK( );
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	fb_hFixRelative(context, lhs, &fx, &fy, NULL, NULL);

	if( rhs == COORD_TYPE_R ) {
		x2 += x1;
		y2 += y1;
	}
	fb_hTranslateCoord(context, fx, fy, &x, &y);

	header = (PUT_HEADER *)src;
	if (header->type == PUT_HEADER_NEW) {
		bpp = header->bpp;
		w = header->width;
		h = header->height;
		pitch = header->pitch;
		src += sizeof(PUT_HEADER);
	} else {
		bpp = header->old.bpp;
		if (!bpp)
			bpp = context->target_bpp;
		w = header->old.width;
		h = header->old.height;
		pitch = w * bpp;
		src += 4;
	}

	if (bpp != context->target_bpp) {
		if ((put_mode == PUT_MODE_ALPHA) && (bpp == 1) && (context->target_bpp == 4)) {
			putter = fb_hPutAlphaMask;
		} else {
			FB_GRAPHICS_UNLOCK( );
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
	}

	if (x1 != (int)0xFFFF0000) {
		fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);

		x1 = MID(0, x1, w-1);
		x2 = MID(0, x2, w-1);
		y1 = MID(0, y1, h-1);
		y2 = MID(0, y2, h-1);

		w = x2 - x1 + 1;
		h = y2 - y1 + 1;
		src += (y1 * pitch) + (x1 * bpp);
	}

	if ((w == 0) || (h == 0) ||
	    (x + w <= context->view_x) || (x >= context->view_x + context->view_w) ||
	    (y + h <= context->view_y) || (y >= context->view_y + context->view_h)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}

	if (y < context->view_y) {
		src += ((context->view_y - y) * pitch);
		h -= (context->view_y - y);
		y = context->view_y;
	}
	if (y + h > context->view_y + context->view_h)
		h -= ((y + h) - (context->view_y + context->view_h));
	if (x < context->view_x) {
		src += ((context->view_x - x) * bpp);
		w -= (context->view_x - x);
		x = context->view_x;
	}
	if (x + w > context->view_x + context->view_w)
		w -= ((x + w) - (context->view_x + context->view_w));

	DRIVER_LOCK();
	putter(src, context->line[y] + (x * context->target_bpp), w, h, pitch, context->target_pitch, alpha, blender, param);
	SET_DIRTY(context, y, h);
	DRIVER_UNLOCK();

	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
