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
 * put_preset.c -- PRESET drawing method for PUT statement
 *
 * chng: mar/2007 written [lillo]
 *
 */

#include "fb_gfx.h"


#if defined(TARGET_X86)

#include "fb_gfx_mmx.h"

extern void fb_hPutPResetMMX(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);

#endif


/*:::::*/
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

/*:::::*/
void fb_hPutPReset(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param)
{
	static PUTTER *all_putters[] = {
		fb_hPutPResetC, fb_hPutPResetC, NULL, fb_hPutPResetC,
#if defined(TARGET_X86)
		fb_hPutPResetMMX, fb_hPutPResetMMX, NULL, fb_hPutPResetMMX,
#endif
	};
	PUTTER *putter;
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!context->putter[PUT_MODE_PRESET]) {
#if defined(TARGET_X86)
		if (__fb_gfx->flags & HAS_MMX)
			context->putter[PUT_MODE_PRESET] = &all_putters[4];
		else
#endif
			context->putter[PUT_MODE_PRESET] = &all_putters[0];
	}
	putter = context->putter[PUT_MODE_PRESET][context->target_bpp - 1];
	
	putter(src, dest, w, h, src_pitch, dest_pitch, alpha, blender, param);
}
