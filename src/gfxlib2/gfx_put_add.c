/* ADD drawing method for PUT statement */

#include "fb_gfx.h"

extern void fb_hPutOrC(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);

#ifdef HOST_X86
#include "x86/fb_gfx_mmx.h"
extern void fb_hPutOrMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutAdd2MMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutAdd4MMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
#endif

static void fb_hPutAdd2C(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src, *d;
	unsigned int sc, dc, overflow;
	int x;
	
	alpha = (alpha + 7) >> 3;
	src_pitch = (src_pitch >> 1) - w;
	for (; h; h--) {
		d = (unsigned short *)dest;
		for (x = w; x; x--) {
			sc = *s;
			dc = *d;
			if (sc != MASK_COLOR_16) {
				sc = ((sc << 16) | sc) & 0x07C0F81F;
				sc = ((sc * alpha) >> 5) & 0x07C0F81F;
				dc = ((dc << 16) | dc) & 0x07C0F81F;
				sc += dc;
				overflow = sc & 0x08010020;
				overflow -= (overflow >> 5);
				sc |= overflow;
				sc &= 0x07C0F81F;
				sc |= (sc >> 16);
				*d = sc & 0xFFFF;
			}
			s++;
			d++;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

static void fb_hPutAdd4C(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src, *d;
	unsigned int sc, dc, temp1, temp2;
	int x;

	src_pitch = (src_pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			sc = *s;
			dc = *d;
			if ((sc & 0xFFFFFF) != MASK_COLOR_32) {
				temp1 = sc & 0xFF00FF;
				temp2 = (sc >> 8) & 0xFF00FF;
				temp1 = ((temp1 * alpha) >> 8) & 0xFF00FF;
				temp2 = (temp2 * alpha) & 0xFF00FF00;
				sc = temp1 | temp2;
				temp1 = sc & 0x80808080;
				temp2 = dc & 0x80808080;
				sc = (sc & 0x7F7F7F7F) + (dc & 0x7F7F7F7F);
				dc = temp1;
				temp1 = temp1 | temp2;
				temp2 = dc & temp2;
				dc = temp1 & sc;
				sc |= ((((temp2 | dc) >> 7) + 0x7F7F7F7F) ^ 0x7F7F7F7F) | temp1;
				*d = sc;
			}
			s++;
			d++;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

/* Not thread-safe; putters should only be called from other gfx functions that
   take care of the synchronization */
void fb_hPutAdd(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutOrC, fb_hPutAdd2C, NULL, fb_hPutAdd4C,
#ifdef HOST_X86
		fb_hPutOrMMX, fb_hPutAdd2MMX, NULL, fb_hPutAdd4MMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_ADD]) {
#ifdef HOST_X86
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_ADD] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_ADD] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_ADD][context->target_bpp - 1];
	alpha &= 0xFF;
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
