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


/* MMX functions declarations */
extern void fb_hPutTrans1MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutTrans2MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutTrans4MMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutPSetMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutPResetMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutAndMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutOrMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);
extern void fb_hPutXorMMX(unsigned char *src, unsigned char *dest, int w, int h, int pitch);


/* Local vars */
static void (*fb_hPutTrans)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static void (*fb_hPutPSet)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static void (*fb_hPutPReset)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static void (*fb_hPutAnd)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static void (*fb_hPutOr)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static void (*fb_hPutXor)(unsigned char *src, unsigned char *dest, int w, int h, int pitch) = NULL;
static int put_initialized_depth = 0;


/*:::::*/
static void fb_hPutTrans1C(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
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
		dest += fb_mode->pitch;
	}
}


/*:::::*/
static void fb_hPutTrans2C(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
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
		dest += fb_mode->pitch;
	}
}


/*:::::*/
static void fb_hPutTrans4C(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	unsigned int *s = (unsigned int *)src;
	unsigned int *d;
	int x;
	
	pitch = (pitch >> 2) - w;
	for (; h; h--) {
		d = (unsigned int *)dest;
		for (x = w; x; x--) {
			if (*s != MASK_COLOR_32)
				*d = *s;
			s++;
			d++;
		}
		s += pitch;
		dest += fb_mode->pitch;
	}
}


/*:::::*/
static void fb_hPutPSetC(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	for (; h; h--) {
		fb_hPixelCpy(dest, src, w);
		src += pitch;
		dest += fb_mode->pitch;
	}
}


/*:::::*/
static void fb_hPutPResetC(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->pitch - w;
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
static void fb_hPutAndC(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->pitch - w;
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
static void fb_hPutOrC(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->pitch - w;
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
static void fb_hPutXorC(unsigned char *src, unsigned char *dest, int w, int h, int pitch)
{
	int x, dpitch;
	
	w <<= (fb_mode->bpp >> 1);
	pitch -= w;
	dpitch = fb_mode->pitch - w;
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
static void init_put(void)
{
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
				break;
			
			case 15:
			case 16:
				fb_hPutTrans = fb_hPutTrans2MMX;
				break;
			
			case 24:
			case 32:
				fb_hPutTrans = fb_hPutTrans4MMX;
				break;
		}
	}
	else {
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
				break;
			
			case 15:
			case 16:
				fb_hPutTrans = fb_hPutTrans2C;
				break;
			
			case 24:
			case 32:
				fb_hPutTrans = fb_hPutTrans4C;
				break;
		}
	}
	put_initialized_depth = fb_mode->depth;
}


/*:::::*/
FBCALL void fb_GfxPut(float fx, float fy, unsigned char *src, int coord_type, int mode)
{
	int x, y, w, h, pitch;
	void (*put)(unsigned char *, unsigned char *, int, int, int);
	
	if (!fb_mode)
		return;
	
	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(fx, fy, &x, &y);
	
	w = pitch = (int)*(unsigned short *)src >> 3;
	h = (int)*(unsigned short *)(src + 2);
	src += 4;
	
	if ((x + w <= fb_mode->view_x) || (x >= fb_mode->view_x + fb_mode->view_w) ||
	    (y + h <= fb_mode->view_y) || (y >= fb_mode->view_y + fb_mode->view_h))
		return;
	
	if (fb_mode->depth > 8) {
		pitch <<= 1;
		if (fb_mode->depth > 16)
			pitch <<= 1;
	}
	
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
	
	if (put_initialized_depth != fb_mode->depth)
		init_put();
	
	switch (mode) {
		case PUT_MODE_TRANS:	put = fb_hPutTrans;	break;
		case PUT_MODE_PRESET:	put = fb_hPutPReset;	break;
		case PUT_MODE_AND:	put = fb_hPutAnd;	break;
		case PUT_MODE_OR:	put = fb_hPutOr;	break;
		case PUT_MODE_XOR:	put = fb_hPutXor;	break;
		case PUT_MODE_PSET:
		default:		put = fb_hPutPSet;	break;
	}
	
	fb_mode->driver->lock();
	put(src, fb_mode->line[y] + (x * fb_mode->bpp), w, h, pitch);
	fb_hMemSet(fb_mode->dirty + y, TRUE, h);
	fb_mode->driver->unlock();
}
