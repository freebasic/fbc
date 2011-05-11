/*
 * put_pset.c -- PSET drawing method for PUT statement
 *
 * chng: mar/2007 written [lillo]
 *
 */

#include "fb_gfx.h"


#if defined(HOST_X86)

#include "fb_gfx_mmx.h"

extern void fb_hPutPSetMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);

#endif


/*:::::*/
void fb_hPutPSetC(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	for (; h; h--) {
		fb_hPixelCpy(dest, src, w);
		src += src_pitch;
		dest += dest_pitch;
	}
}


/*:::::*/
void fb_hPutPSet(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutPSetC, fb_hPutPSetC, NULL, fb_hPutPSetC,
#if defined(HOST_X86)
		fb_hPutPSetMMX, fb_hPutPSetMMX, NULL, fb_hPutPSetMMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_PSET]) {
#if defined(HOST_X86)
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_PSET] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_PSET] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_PSET][context->target_bpp - 1];
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
