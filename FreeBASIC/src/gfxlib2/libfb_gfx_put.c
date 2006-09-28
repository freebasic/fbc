/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * put.c -- PUT statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"
#include "fb_gfx_mmx.h"


#if defined(TARGET_X86)
/* MMX functions declarations */
extern void fb_hPutAdd2MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutAdd4MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutAlpha4MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutBlend2MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutBlend4MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutTrans1MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutTrans2MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutTrans4MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutPSetMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutPResetMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutAndMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutOrMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
extern void fb_hPutXorMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param);
#endif

/* Local vars */
static void (*fb_hPutAdd)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutAlpha)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutBlend)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutTrans)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutPSet)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutPReset)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutAnd)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutOr)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutXor)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static void (*fb_hPutCustom)(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param) = NULL;
static int put_initialized_depth = 0;


/*:::::*/
static void fb_hPutAlpha4C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d, sc, dc, a, drb, dg, srb, sg;
	int x;
	
	pitch = (pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			sc = *s++;
			dc = *d;
			a = (sc >> 24);
			srb = sc & MASK_RB_32;
			sg = sc & MASK_G_32;
			drb = dc & MASK_RB_32;
			dg = dc & MASK_G_32;
			srb = ((srb - drb) * a) >> 8;
			sg = ((sg - dg) * a) >> 8;
			*d++ = ((drb + srb) & MASK_RB_32) | ((dg + sg) & MASK_G_32);
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutAdd2C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src, *d;
	unsigned int sc, dc, overflow;
	int x;
	
	alpha = (alpha + 7) >> 3;
	pitch = (pitch >> 1) - w;
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
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutAdd4C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src, *d;
	unsigned int sc, dc, temp1, temp2;
	int x;

	pitch -= (w << 2);
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
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutBlend2C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src, *d;
	unsigned int sc, dc, drb, dg, srb, sg, dt, st;
	int x;
	
	alpha = (alpha + 7) >> 3;
	pitch = (pitch >> 1) - w;
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
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutBlend4C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d, sc, dc, drb, dg, srb, sg;
	int x;
	
	alpha++;
	pitch = (pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			sc = *s++;
			if ((sc & 0xFFFFFF) != 0xFF00FF) {
				dc = *d;
				srb = sc & MASK_RB_32;
				sg = sc & MASK_G_32;
				drb = dc & MASK_RB_32;
				dg = dc & MASK_G_32;
				srb = ((srb - drb) * alpha) >> 8;
				sg = ((sg - dg) * alpha) >> 8;
				*d = ((drb + srb) & MASK_RB_32) | ((dg + sg) & MASK_G_32);
			}
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutTrans1C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned char *s = (unsigned char *)src;
	unsigned char *d;
	int x;
	
	pitch -= w;
	for (; h; h--) {
		d = (unsigned char *)dest;
		for (x = w; x; x--) {
			if (*s)
				*d = (unsigned int)*s;
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutTrans2C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src;
	unsigned short *d;
	int x;
	
	pitch = (pitch >> 1) - w;
	for (; h; h--) {
		d = (unsigned short *)dest;
		for (x = w; x; x--) {
			if (*s != MASK_COLOR_16)
				*d = (unsigned short)*s;
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutTrans4C(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d, c;
	int x;
	
	pitch = (pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			c = *s & 0x00FFFFFF;
			if (c != MASK_COLOR_32)
				*d = c;
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutPSetC(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	for (; h; h--) {
		fb_hPixelCpy(dest, src, w);
		src += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutPResetC(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->target_pitch - w;
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
		src += pitch;
		dest += dpitch;
	}
}


/*:::::*/
static void fb_hPutAndC(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->target_pitch - w;
	for (; h; h--) {
		if (w & 1)
			*dest++ &= *src++;
		if (w & 2) {
			*(unsigned short *)dest &= *(unsigned short *)src;
			dest += 2;
			src += 2;
		}
		for (x = w >> 2; x; x--) {
			*(unsigned int *)dest &= *(unsigned int *)src;
			dest += 4;
			src += 4;
		}
		src += pitch;
		dest += dpitch;
	}
}


/*:::::*/
static void fb_hPutOrC(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->target_pitch - w;
	for (; h; h--) {
		if (w & 1)
			*dest++ |= *src++;
		if (w & 2) {
			*(unsigned short *)dest |= *(unsigned short *)src;
			dest += 2;
			src += 2;
		}
		for (x = w >> 2; x; x--) {
			*(unsigned int *)dest |= *(unsigned int *)src;
			dest += 4;
			src += 4;
		}
		src += pitch;
		dest += dpitch;
	}
}


/*:::::*/
static void fb_hPutXorC(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->target_pitch - w;
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
		src += pitch;
		dest += dpitch;
	}
}


/*:::::*/
static void fb_hPutCustom1(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned char *s = (unsigned char *)src;
	unsigned char *d;
	int x;
	
	pitch -= w;
	for (; h; h--) {
		d = (unsigned char *)dest;
		for (x = w; x; x--) {
			*d = (unsigned char)blender((unsigned int)*s, (unsigned int)*d, param);
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutCustom2(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned short *s = (unsigned short *)src;
	unsigned short *d;
	int x;
	unsigned int cs, cd;
	
	pitch = (pitch >> 1) - w;
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
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void fb_hPutCustom4(unsigned char *src, unsigned char *dest, int w, int h, int pitch, int alpha, BLENDER *blender, void *param)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d;
	int x;
	
	pitch = (pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			*d = blender(*s, *d, param);
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->target_pitch;
	}
}


/*:::::*/
static void init_put(void)
{

#if defined(TARGET_X86)
	if (fb_mode->flags & HAS_MMX) {
		fb_hPutPSet = fb_hPutPSetMMX;
		fb_hPutPReset = fb_hPutPResetMMX;
		fb_hPutAnd = fb_hPutAndMMX;
		fb_hPutOr = fb_hPutOrMMX;
		fb_hPutXor = fb_hPutXorMMX;
		switch (fb_mode->depth) {
			case 1:
			case 2:
			case 4:
			case 8:
				fb_hPutTrans = fb_hPutTrans1MMX;
				fb_hPutAlpha = fb_hPutPSetMMX;		/* No alpha channel: default to all solid PUT */
				fb_hPutBlend = fb_hPutTrans1MMX;	/* Cannot blend in paletted mode */
				fb_hPutAdd = fb_hPutOrMMX;		/* No color channels, cannot add: default to OR */
				fb_hPutCustom = fb_hPutCustom1;
				break;
			
			case 15:
			case 16:
				fb_hPutTrans = fb_hPutTrans2MMX;
				fb_hPutAlpha = fb_hPutPSetMMX;		/* No alpha channel: default to all solid PUT */
				fb_hPutBlend = fb_hPutBlend2MMX;
				fb_hPutAdd = fb_hPutAdd2MMX;
				fb_hPutCustom = fb_hPutCustom2;
				break;
			
			case 24:
			case 32:
				fb_hPutTrans = fb_hPutTrans4MMX;
				fb_hPutAlpha = fb_hPutAlpha4MMX;
				fb_hPutBlend = fb_hPutBlend4MMX;
				fb_hPutAdd = fb_hPutAdd4MMX;
				fb_hPutCustom = fb_hPutCustom4;
				break;
		}
	}
	else {
#endif
		fb_hPutPSet = fb_hPutPSetC;
		fb_hPutPReset = fb_hPutPResetC;
		fb_hPutAnd = fb_hPutAndC;
		fb_hPutOr = fb_hPutOrC;
		fb_hPutXor = fb_hPutXorC;
		switch (fb_mode->depth) {
			case 1:
			case 2:
			case 4:
			case 8:
				fb_hPutTrans = fb_hPutTrans1C;
				fb_hPutAlpha = fb_hPutPSetC;		/* No alpha channel: default to all solid PUT */
				fb_hPutBlend = fb_hPutTrans1C;		/* Cannot blend in paletted mode */
				fb_hPutAdd = fb_hPutOrC;		/* No color channels, cannot add: default to OR */
				fb_hPutCustom = fb_hPutCustom1;
				break;
			
			case 15:
			case 16:
				fb_hPutTrans = fb_hPutTrans2C;
				fb_hPutAlpha = fb_hPutPSetC;		/* No alpha channel: default to all solid PUT */
				fb_hPutBlend = fb_hPutBlend2C;
				fb_hPutAdd = fb_hPutAdd2C;
				fb_hPutCustom = fb_hPutCustom2;
				break;
			
			case 24:
			case 32:
				fb_hPutTrans = fb_hPutTrans4C;
				fb_hPutAlpha = fb_hPutAlpha4C;
				fb_hPutBlend = fb_hPutBlend4C;
				fb_hPutAdd = fb_hPutAdd4C;
				fb_hPutCustom = fb_hPutCustom4;
				break;
		}
#if defined(TARGET_X86)
	}
#endif
	put_initialized_depth = fb_mode->depth;
}


/*:::::*/
PUTTER *fb_hGetPutter(int mode, int *alpha)
{
	PUTTER *put;
	
	if (put_initialized_depth != fb_mode->depth)
		init_put();
	
	switch (mode) {
		case PUT_MODE_TRANS:	put = fb_hPutTrans;	break;
		case PUT_MODE_PRESET:	put = fb_hPutPReset;	break;
		case PUT_MODE_AND:	put = fb_hPutAnd;	break;
		case PUT_MODE_OR:	put = fb_hPutOr;	break;
		case PUT_MODE_XOR:	put = fb_hPutXor;	break;
		case PUT_MODE_ALPHA:	if (*alpha < 0)
						put = fb_hPutAlpha;
					else if (*alpha == 0)
						return NULL;
					else {
						*alpha &= 0xFF;
						if (*alpha == 0xFF)
							put = fb_hPutTrans;
						else
							put = fb_hPutBlend;
					}
					break;
		case PUT_MODE_ADD:	put = fb_hPutAdd;
					*alpha &= 0xFF;
					break;
		case PUT_MODE_CUSTOM:	put = fb_hPutCustom;	break;
		case PUT_MODE_PSET:
		default:		put = fb_hPutPSet;	break;
	}
	
	return put;
}


/*:::::*/
FBCALL int fb_GfxPut(void *target, float fx, float fy, unsigned char *src, int x1, int y1, int x2, int y2, int coord_type, int mode, int alpha, BLENDER *blender, void *param)
{
	int x, y, w, h, pitch, bpp;
	PUTTER *put;
	
	if (!fb_mode)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	fb_hPrepareTarget(target);
	
	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(fx, fy, &x, &y);
	
	bpp = (int)*(unsigned short *)src;
	w = pitch = bpp >> 3;
	pitch *= fb_mode->bpp;
	h = (int)*(unsigned short *)(src + 2);
	src += 4;

	bpp &= 0x7;
	if ((bpp) && (bpp != fb_mode->bpp))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	if (x1 != 0xFFFF0000) {
		fb_hFixCoordsOrder(&x1, &y1, &x2, &y2);
		
		x1 = MID(0, x1, w-1);
		x2 = MID(0, x2, w-1);
		y1 = MID(0, y1, h-1);
		y2 = MID(0, y2, h-1);
		
		w = x2 - x1 + 1;
		h = y2 - y1 + 1;
		src += (pitch * y1) + (x1 * fb_mode->bpp);
	}
	
	if ((w == 0) || (h == 0) ||
	    (x + w <= fb_mode->view_x) || (x >= fb_mode->view_x + fb_mode->view_w) ||
	    (y + h <= fb_mode->view_y) || (y >= fb_mode->view_y + fb_mode->view_h))
		return FB_RTERROR_OK;
	
	if (y < fb_mode->view_y) {
		src += (pitch * (fb_mode->view_y - y));
		h -= (fb_mode->view_y - y);
		y = fb_mode->view_y;
	}
	if (y + h > fb_mode->view_y + fb_mode->view_h)
		h -= ((y + h) - (fb_mode->view_y + fb_mode->view_h));
	if (x < fb_mode->view_x) {
		src += ((fb_mode->view_x - x) * fb_mode->bpp);
		w -= (fb_mode->view_x - x);
		x = fb_mode->view_x;
	}
	if (x + w > fb_mode->view_x + fb_mode->view_w)
		w -= ((x + w) - (fb_mode->view_x + fb_mode->view_w));
	
	put = fb_hGetPutter(mode, &alpha);
	
	if (put) {
		DRIVER_LOCK();
		put(src, fb_mode->line[y] + (x * fb_mode->bpp), w, h, pitch, alpha, blender, param);
		SET_DIRTY(y, h);
		DRIVER_UNLOCK();
	}
	
	return FB_RTERROR_OK;
}
