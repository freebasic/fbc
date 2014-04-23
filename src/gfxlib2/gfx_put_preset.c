/* PRESET drawing method for PUT statement */

#include "fb_gfx.h"

#ifdef HOST_X86
#include "x86/fb_gfx_mmx.h"
extern void fb_hPutPResetMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
#endif

static void fb_hPutPResetC(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	int x;
	FB_GFXCTX *context = fb_hGetContext();
	
	w <<= (context->target_bpp >> 1);
	src_pitch -= w;
	dest_pitch -= w;
	for (; h; h--) {
		if (w & 1)
			*dest++ = 0xFF ^ *src++;
		if (w & 2) {
			*(unsigned short *)dest = 0xFFFF ^ *(unsigned short *)src;
			dest += 2;
			src += 2;
		}
		for (x = w >> 2; x; x--) {
			*(unsigned int *)dest = 0xFFFFFFFF ^ *(unsigned int *)src;
			dest += 4;
			src += 4;
		}
		src += src_pitch;
		dest += dest_pitch;
	}
}

/* Not thread-safe; putters should only be called from other gfx functions that
   take care of the synchronization */
void fb_hPutPReset(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutPResetC, fb_hPutPResetC, NULL, fb_hPutPResetC,
#ifdef HOST_X86
		fb_hPutPResetMMX, fb_hPutPResetMMX, NULL, fb_hPutPResetMMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_PRESET]) {
#ifdef HOST_X86
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_PRESET] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_PRESET] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_PRESET][context->target_bpp - 1];
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
