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
 * bsave.c -- BSAVE support.
 *
 * chng: jan/2005 written [lillo]
 *       may/2005 added BMP saving support [lillo]
 *
 */

#include "fb_gfx.h"

typedef struct BMP_HEADER
{
	unsigned short bfType			__attribute__((packed));
	unsigned int   bfSize			__attribute__((packed));
	unsigned short bfReserved1		__attribute__((packed));
	unsigned short bfReserved2		__attribute__((packed));
	unsigned int   bfOffBits		__attribute__((packed));
	unsigned int   biSize			__attribute__((packed));
	unsigned int   biWidth			__attribute__((packed));
	unsigned int   biHeight			__attribute__((packed));
	unsigned short biPlanes			__attribute__((packed));
	unsigned short biBitCount		__attribute__((packed));
	unsigned int   biCompression		__attribute__((packed));
	unsigned int   biSizeImage		__attribute__((packed));
	unsigned int   biXPelsPerMeter		__attribute__((packed));
	unsigned int   biYPelsPerMeter		__attribute__((packed));
	unsigned int   biClrUsed		__attribute__((packed));
	unsigned int   biClrImportant		__attribute__((packed));
} BMP_HEADER;


/*:::::*/
static int save_bmp(FILE *f, void *src)
{
	BMP_HEADER header;
	int w, h, i, bfSize, biSizeImage, bfOffBits, biClrUsed, filler, pitch, color;
	unsigned char *s, *buffer, *p;
	
	if (src) {
		w = ((unsigned short *)src)[0] >> 3;
		h = ((unsigned short *)src)[1];
		s = (unsigned char *)src + 4;
		pitch = w * fb_mode->bpp;
	}
	else {
		w = fb_mode->w;
		h = fb_mode->h;
		s = fb_mode->line[0];
		pitch = fb_mode->pitch;
	}
	filler = 3 - (((w * (fb_mode->bpp)) - 1) & 0x3);
	if (fb_mode->bpp == 1) {
		biSizeImage = (w + filler) * h;
		bfOffBits = 54 + 1024;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 256;
	}
	else {
		biSizeImage = ((w * 3) + filler) * h;
		bfOffBits = 54;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 0;
	}
	
	fb_hMemSet(&header, 0, sizeof(header));
	header.bfType = 19778;
	header.bfSize = bfSize;
	header.bfOffBits = bfOffBits;
	header.biSize = 40;
	header.biWidth = w;
	header.biHeight = h;
	header.biPlanes = 1;
	header.biBitCount = (fb_mode->bpp == 1) ? 8 : 24;
	header.biSizeImage = biSizeImage;
	header.biXPelsPerMeter = 0xB12;
	header.biYPelsPerMeter = 0xB12;
	header.biClrUsed = biClrUsed;
	header.biClrImportant = biClrUsed;
	if (!fwrite(&header, 54, 1, f))
		return FB_RTERROR_FILEIO;
	if (fb_mode->bpp == 1) {
		for (i = 0; i < 256; i++) {
			fputc((fb_mode->device_palette[i] >> 16) & 0xFF, f);
			fputc((fb_mode->device_palette[i] >> 8) & 0xFF, f);
			fputc(fb_mode->device_palette[i] & 0xFF, f);
			fputc(0, f);
		}
	}
	
	filler = biSizeImage / h;
	switch (fb_mode->bpp) {
		case 1:
			break;
		case 2:
			filler += ((w * 3 + 1) % 4) - 1;
			break;
		case 4:
			filler += 3 - ((w * 3 - 1) % 4);
			break;
	}
	buffer = (unsigned char *)calloc(1, filler + 3);
	
	s += (h - 1) * pitch;
	for (; h; h--) {
		p = buffer;
		switch (fb_mode->bpp) {
			case 1:
				fb_hMemCpy(p, s, pitch);
				break;
			case 2:
				for (i = 0; i < w; i++) {
					color = ((unsigned short *)s)[i];
					*p++ = ((color & 0x001F) << 3) | ((color & 0x001F) >> 2);
					*p++ = ((color & 0x07E0) >> 3) | ((color & 0x07E0) >> 8);
					*p++ = ((color & 0xF800) >> 8) | ((color & 0xF800) >> 13);
				}
				break;
			case 4:
				for (i = 0; i < w; i++) {
					*(unsigned int *)p = ((unsigned int *)s)[i];
					p += 3;
				}
				break;
		}
		if (!fwrite(buffer, filler, 1, f))
			return FB_RTERROR_FILEIO;
		s -= pitch;
	}
	
	free(buffer);
	
	return FB_RTERROR_OK;
}


/*:::::*/
FBCALL int fb_GfxBsave(FBSTRING *filename, void *src, unsigned int size)
{
	FILE *f;
	int result = FB_RTERROR_OK;
	char *p;

	f = fopen(filename->data, "wb");
	if (!f) {
		fb_hStrDelTemp(filename);
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}
	
	fb_hPrepareTarget(NULL);

	p = strrchr(filename->data, '.');
	if ((p) && (!strcasecmp(p + 1, "bmp")))
		result = save_bmp(f, src);
	else {
		if ((size < 0) || ((size == 0) && (src))) {
			fclose(f);
			fb_hStrDelTemp(filename);
			return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		}

		fputc(0xFE, f);
		fputc(size & 0xFF, f);
		fputc((size >> 8) & 0xFF, f);
		fputc((size >> 16) & 0xFF, f);
		fputc(size >> 24, f);

		if (!src) {
			DRIVER_LOCK();
			size = MIN(size, fb_mode->pitch * fb_mode->h);
			if (!fwrite(fb_mode->line[0], size, 1, f))
				result = FB_RTERROR_FILEIO;
			DRIVER_UNLOCK();
			if (fb_mode->depth <= 8) {
				size = (1 << fb_mode->depth) * sizeof(int);
				if (!fwrite(fb_mode->device_palette, size, 1, f))
					result = FB_RTERROR_FILEIO;
			}
		}
		else if (!fwrite(src, size, 1, f))
			result = FB_RTERROR_FILEIO;
	}
	
	fclose(f);
	
	fb_hStrDelTemp(filename);
	
	return fb_ErrorSetNum( result );
}
