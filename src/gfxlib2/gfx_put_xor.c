/* XOR drawing method for PUT statement */

#include "fb_gfx.h"

#ifdef HOST_X86
#include "x86/fb_gfx_mmx.h"
extern void fb_hPutXorMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
#endif

static void fb_hPutXorC(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	int x;
	FB_GFXCTX *context = fb_hGetContext();
	
	w <<= (context->target_bpp >> 1);
	src_pitch -= w;
	dest_pitch -= w;
	for (; h; h--) {
		if (w & 1)
			*dest++ ^= *src++;
		if (w & 2) {
			*(unsigned short *)dest ^= *(unsigned short *)src;
			dest += 2;
			src += 2;
		}
		for (x = w >> 2; x; x--) {
			*(unsigned int *)dest ^= *(unsigned int *)src;
			dest += 4;
			src += 4;
		}
		src += src_pitch;
		dest += dest_pitch;
	}
}

/* Not thread-safe; putters should only be called from other gfx functions that
   take care of the synchronization */
void fb_hPutXor(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutXorC, fb_hPutXorC, NULL, fb_hPutXorC,
#ifdef HOST_X86
		fb_hPutXorMMX, fb_hPutXorMMX, NULL, fb_hPutXorMMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_XOR]) {
#ifdef HOST_X86
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_XOR] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_XOR] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_XOR][context->target_bpp - 1];
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
