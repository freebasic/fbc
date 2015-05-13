/* CUSTOM drawing method for PUT statement */

#include "fb_gfx.h"

static void fb_hPutCustom1(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned char *s = (unsigned char *)src;
	unsigned char *d;
	int x;
	
	src_pitch -= w;
	for (; h; h--) {
		d = (unsigned char *)dest;
		for (x = w; x; x--) {
			*d = (unsigned char)blender((unsigned int)*s, (unsigned int)*d, param);
			s++;
			d++;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

static void fb_hPutCustom2(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src;
	unsigned short *d;
	int x;
	unsigned int cs, cd;
	
	src_pitch = (src_pitch >> 1) - w;
	for (; h; h--) {
		d = (unsigned short *)dest;
		for (x = w; x; x--) {
			cs = *s++;
			cs = (((cs & 0x001F) << 3) | ((cs >> 2) & 0x7) |
			      ((cs & 0x07E0) << 5) | ((cs >> 1) & 0x300) |
			      ((cs & 0xF800) << 8) | ((cs << 3) & 0x70000));
			cd = *d;
			cd = (((cd & 0x001F) << 3) | ((cd >> 2) & 0x7) |
			      ((cd & 0x07E0) << 5) | ((cd >> 1) & 0x300) |
			      ((cd & 0xF800) << 8) | ((cd << 3) & 0x70000));
			cd = blender(cs, cd, param);
			*d++ = (unsigned short)((cd >> 3) & 0x001F) | ((cd >> 5) & 0x07E0) | ((cd >> 8) & 0xF800);
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

static void fb_hPutCustom4(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d;
	int x;
	
	src_pitch = (src_pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			*d = blender(*s, *d, param);
			s++;
			d++;
		}
		s += src_pitch;
		dest += dest_pitch;
	}
}

/* Not thread-safe; putters should only be called from other gfx functions that
   take care of the synchronization */
void fb_hPutCustom(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutCustom1, fb_hPutCustom2, NULL, fb_hPutCustom4,
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_CUSTOM]) {
		context->putter[PUT_MODE_CUSTOM] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_CUSTOM][context->target_bpp - 1];
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
