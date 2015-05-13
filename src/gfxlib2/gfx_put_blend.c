/* BLEND drawing method for PUT statement */

#include "fb_gfx.h"

extern void fb_hPutTrans1C(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutTrans(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);

#ifdef HOST_X86
#include "x86/fb_gfx_mmx.h"
extern void fb_hPutTrans1MMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutBlend2MMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutBlend4MMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
#endif

static void fb_hPutBlend2C(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src, *d;
	unsigned int sc, dc, drb, dg, srb, sg, dt, st;
	int x;
	
	alpha = (alpha + 7) >> 3;
	src_pitch = (src_pitch >> 1) - w;
	for (; h; h--) {
		d = (unsigned short *)dest;
		if (w & 1) {
			sc = *s++;
			if (sc != 0xF81F) {
				dc = *(unsigned short *)d;
				srb = sc & MASK_RB_16;
				sg = sc & MASK_G_16;
				drb = dc & MASK_RB_16;
				dg = dc & MASK_G_16;
				srb = ((srb - drb) * alpha) >> 5;
				sg = ((sg - dg) * alpha) >> 5;
				*(unsigned short *)d = ((drb + srb) & MASK_RB_16) | ((dg + sg) & MASK_G_16);
			}
			d++;
		}
		for (x = w >> 1; x; x--) {
			sc = *(unsigned int *)s;
			if (sc != 0xF81FF81F) {
				dc = *(unsigned int *)d;
				if ((sc & 0xFFFF) == 0xF81F) {
					sc &= 0xFFFF0000;
					sc |= (dc & 0xFFFF);
				}
				if ((sc & 0xFFFF0000) == 0xF81F0000) {
					sc &= 0xFFFF;
					sc |= (dc & 0xFFFF0000);
				}
				st = sc & (MASK_RB_16 | (MASK_G_16 << 16));
				sc &= (MASK_G_16 | (MASK_RB_16 << 16));
				dt = dc & (MASK_RB_16 | (MASK_G_16 << 16));
				dc &= (MASK_G_16 | (MASK_RB_16 << 16));
				dc = ((((sc >> 5) - (dc >> 5)) * alpha) + dc) & (MASK_G_16 | (MASK_RB_16 << 16));
				sc = ((((st - dt) * alpha) >> 5) + dt) & (MASK_RB_16 | (MASK_G_16 << 16));
				*(unsigned int *)d = dc | sc;
			}
			s += 2;
			d += 2;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

static void fb_hPutBlend4C(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d, sc, dc, drb, dga, srb, sga;
	int x;
	
	alpha++;
	src_pitch = (src_pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			sc = *s++;
			if ((sc & 0xFFFFFF) != 0xFF00FF) {
				dc = *d;
				srb = sc & MASK_RB_32;
				sga = sc & MASK_GA_32;
				drb = dc & MASK_RB_32;
				dga = dc & MASK_GA_32;
				srb = ((srb - drb) * alpha) >> 8;
				sga = ((sga - dga) >> 8) * alpha;
				*d = ((drb + srb) & MASK_RB_32) | ((dga + sga) & MASK_GA_32);
			}
			d++;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

/* Not thread-safe; putters should only be called from other gfx functions that
   take care of the synchronization */
void fb_hPutBlend(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutTrans1C, fb_hPutBlend2C, NULL, fb_hPutBlend4C,
#ifdef HOST_X86
		fb_hPutTrans1MMX, fb_hPutBlend2MMX, NULL, fb_hPutBlend4MMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context;
	
	if (alpha == 0) {
		return;
	}
	
	context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_BLEND]) {
#ifdef HOST_X86
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_BLEND] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_BLEND] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_BLEND][context->target_bpp - 1];
	alpha &= 0xFF;
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
