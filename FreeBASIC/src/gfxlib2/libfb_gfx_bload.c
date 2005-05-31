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
 * bload.c -- BLOAD support.
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 added BMP loading support [lillo]
 *
 */

#include "fb_gfx.h"

#define BI_RGB		0
#define BI_BITFIELDS	3

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
static void convert_8to8(unsigned char *src, unsigned char *dest, int w)
{
	for (; w; w--)
		*dest++ = *src++ & fb_mode->color_mask;
}


/*:::::*/
static void convert_8to16(unsigned char *src, unsigned char *dest, int w)
{
	int r, g, b;
	unsigned short *d = (unsigned short *)dest;
	
	for (; w; w--) {
		r = fb_mode->device_palette[*src] & 0xFF;
		g = (fb_mode->device_palette[*src] >> 8) & 0xFF;
		b = (fb_mode->device_palette[*src] >> 16) & 0xFF;
		*d++ = (b >> 3) | ((g << 3) & 0x07E0) | ((r << 8) & 0xF800);
		src++;
	}
}


/*:::::*/
static void convert_8to32(unsigned char *src, unsigned char *dest, int w)
{
	int r, g, b;
	unsigned int *d = (unsigned int *)dest;
	
	for (; w; w--) {
		r = fb_mode->device_palette[*src] & 0xFF;
		g = (fb_mode->device_palette[*src] >> 8) & 0xFF;
		b = (fb_mode->device_palette[*src] >> 16) & 0xFF;
		*d++ = b | (g << 8) | (r << 16);
		src++;
	}
}


/*:::::*/
static void convert_24to16(unsigned char *src, unsigned char *dest, int w)
{
	unsigned short *d = (unsigned short *)dest;
	for (; w; w--) {
		*d++ = ((unsigned short)src[0] >> 3) | (((unsigned short)src[1] << 3) & 0x07E0) | (((unsigned short)src[2] << 8) & 0xF800);
		src += 3;
	}
}


/*:::::*/
static void convert_24to32(unsigned char *src, unsigned char *dest, int w)
{
	unsigned int *d = (unsigned int *)dest;
	
	for (; w; w--) {
		*d++ = *(unsigned int *)src & 0xFFFFFF;
		src += 3;
	}
}


/*:::::*/
static int load_bmp(FILE *f, void *dest)
{
	BMP_HEADER header;
	unsigned char *buffer, *d = NULL;
	int result = FB_RTERROR_OK;
	int i, j, color, rgb[3], expand, size, padding, palette[256];
	void (*convert)(unsigned char *, unsigned char *, int) = NULL;
	
	if (!fb_mode)
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	
	/* This will need adjustment if/when we port to big-endian (like PPC) machines */
	if ((!fread(&header, 54, 1, f)) || (header.bfType != 19778) || (header.biSize != 40))
		return FB_RTERROR_FILEIO;
	
	if ((header.biBitCount == 15) || (header.biBitCount == 16))
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	for (i = 0; i < (header.bfOffBits - 54) >> 2; i++) {
		palette[i] = (fgetc(f) << 16) | (fgetc(f) << 8) | fgetc(f);
		fgetc(f);
	}
	
	if (dest) {
		*(unsigned short *)dest = header.biWidth << 3;
		*(unsigned short *)(dest + 2) = header.biHeight;
		d = (unsigned char *)dest + 4;
	}
	
	expand = (header.biBitCount < 8) ? header.biBitCount : 0;
	if (header.biCompression == BI_BITFIELDS) {
		if ((!fread(rgb, 12, 1, f)) || (rgb[0] != 0x00FF0000))
			return FB_RTERROR_FILEIO;
		header.biBitCount = 24;
	}
	if (header.biBitCount <= 8) {
		switch (BYTES_PER_PIXEL(fb_mode->depth)) {
			case 1: convert = convert_8to8;  break;
			case 2: convert = convert_8to16; break;
			case 3:
			case 4: convert = convert_8to32; break;
		}
	}
	else {
		switch (BYTES_PER_PIXEL(fb_mode->depth)) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = convert_24to16; break;
			case 3:
			case 4: convert = convert_24to32; break;
		}
	}

	DRIVER_LOCK();
	fb_hMemCpy(fb_mode->device_palette, palette, 256 * sizeof(int));
	fb_hRestorePalette();
	size = ((header.biWidth * BYTES_PER_PIXEL(header.biBitCount)) + 3) & ~0x3;
	buffer = (unsigned char *)malloc(size);
	switch (expand) {
		case 1: padding = 4 - (((header.biWidth + 7) >> 3) & 0x3); break;
		case 4: padding = 4 - (((header.biWidth + 1) >> 1) & 0x3); break;
		default: padding = 4 - ((header.biWidth * BYTES_PER_PIXEL(header.biBitCount)) & 0x3); break;
	}
	padding &= 0x3;
	for (i = header.biHeight - 1; i >= 0; i--) {
		if (expand) {
			color = 0;
			for (j = 0; j < header.biWidth; j++) {
				if (j % (8 / expand) == 0) {
					if ((color = fgetc(f)) < 0) {
						result = FB_RTERROR_FILEIO;
						goto exit_error;
					}
				}
				buffer[j] = color >> (8 - expand);
				color = (color << expand) & 0xFF;
			}
			for (j = 0; j < padding; j++)
				fgetc(f);
		}
		else if (!fread(buffer, size, 1, f)) {
			result = FB_RTERROR_FILEIO;
			break;
		}
		if (dest)
			convert(buffer, d + (i * header.biWidth * fb_mode->bpp), header.biWidth);
		else if (i < fb_mode->h)
			convert(buffer, fb_mode->line[i], MIN(fb_mode->w, header.biWidth));
	}

exit_error:
	SET_DIRTY(0, fb_mode->h);
	DRIVER_UNLOCK();
	
	free(buffer);
	
	return result;
}


/*:::::*/
FBCALL int fb_GfxBload(FBSTRING *filename, void *dest)
{
	FILE *f;
	unsigned char id;
	unsigned int size = 0;
	int result = FB_RTERROR_OK;
	
	if ((!dest) && (!fb_mode))
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	
	f = fopen(filename->data, "rb");

	if (!f) {
		fb_hStrDelTemp(filename);
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}
	
	fb_hPrepareTarget(NULL);

	id = fgetc(f);
	switch (id) {

		case 0xFD:
			/* QB BSAVEd block */
			fgetc(f); fgetc(f); fgetc(f); fgetc(f);
			size = fgetc(f) | (fgetc(f) << 8);
			break;

		case 0xFE:
			/* FB BSAVEd block */
			size = fgetc(f) | (fgetc(f) << 8) | (fgetc(f) << 16) | (fgetc(f) << 24);
			break;
		
		case 'B':
			/* Can be a BMP */
			rewind(f);
			result = load_bmp(f, dest);
			fclose(f);
			fb_hStrDelTemp(filename);
			return result;
			
		default:
			result = FB_RTERROR_FILEIO;
			break;
	}

	if (result == FB_RTERROR_OK) {
		if (!dest) {
			DRIVER_LOCK();
			size = MIN(size, fb_mode->pitch * fb_mode->h);
			if ((!fread(fb_mode->line[0], size, 1, f)) && (!feof(f)))
				result = FB_RTERROR_FILEIO;
			SET_DIRTY(0, fb_mode->h);
			if (!feof(f)) {
				fread(fb_mode->device_palette, 1024, 1, f);
				fb_hRestorePalette();
			}
			DRIVER_UNLOCK();
		}
		else {
			if ((!fread(dest, size, 1, f)) && (!feof(f)))
				result = FB_RTERROR_FILEIO;
		}
	}
	fclose(f);
	
	fb_hStrDelTemp(filename);
	
	return fb_ErrorSetNum( result );
}
