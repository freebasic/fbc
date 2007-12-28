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
static int load_bmp(FB_GFXCTX *ctx, FILE *f, void *dest, void *pal)
{
	BMP_HEADER header;
	PUT_HEADER *put_header = NULL;
	unsigned char *buffer, *d = NULL;
	int result = fb_ErrorSetNum( FB_RTERROR_OK );
	int i, j, width, height, bpp, color, rgb[3], expand, size, padding, palette[256], palette_entries;
	void *target_pal = pal;
	FBGFX_IMAGE_CONVERT convert = NULL;

	if (!__fb_gfx)
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	/* This will need adjustment if/when we port to big-endian (like PPC) machines */
	if ((!fread(&header, 54, 1, f)) || (header.bfType != 19778) || (header.biSize != 40))
		return FB_RTERROR_FILEIO;

	if ((header.biBitCount == 15) || (header.biBitCount == 16))
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	palette_entries = (header.bfOffBits - 54) >> 2;
	for (i = 0; i < palette_entries; i++) {
		palette[i] = (fgetc(f) << 16) | (fgetc(f) << 8) | fgetc(f);
		if (pal)
			palette[i] = (palette[i] >> 2) & 0x3F3F3F;
		fgetc(f);
	}
	if (!pal)
		target_pal = (void *)__fb_gfx->device_palette;

	if (dest) {
		put_header = (PUT_HEADER *)dest;
		/* do not overwrite pre-allocated image buffer header */
		if (put_header->type != PUT_HEADER_NEW) {
			put_header->type = PUT_HEADER_NEW;
			put_header->bpp = ctx->target_bpp;
			put_header->width = header.biWidth;
			put_header->height = header.biHeight;
			put_header->pitch = ((put_header->width * put_header->bpp) + 0xF) & ~0xF;
		}
		width = MIN(put_header->width, header.biWidth);
		height = MIN(put_header->height, header.biHeight);
		bpp = put_header->bpp;
		d = (unsigned char *)dest + sizeof(PUT_HEADER);
	}
	else {
		width = MIN(__fb_gfx->w, header.biWidth);
		height = MIN(__fb_gfx->h, header.biHeight);
		bpp = __fb_gfx->bpp;
	}
	fb_hPrepareTarget(ctx, dest);
	fb_hSetPixelTransfer(ctx, MASK_A_32);

	expand = (header.biBitCount < 8) ? header.biBitCount : 0;
	if (header.biCompression == BI_BITFIELDS) {
		if ((!fread(rgb, 12, 1, f)) || (rgb[0] != 0x00FF0000))
			return FB_RTERROR_FILEIO;
		header.biBitCount = 24;
	}
	if (header.biBitCount <= 8) {
		switch (bpp) {
			case 1: convert = fb_image_convert_8to8;  break;
			case 2: convert = fb_image_convert_8to16; break;
			case 3:
			case 4: convert = fb_image_convert_8to32; break;
		}
	}
	else if (header.biBitCount == 24) {
		switch (bpp) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = fb_image_convert_24bgrto16; break;
			case 3:
			case 4: convert = fb_image_convert_24bgrto32; break;
		}
	}
	else {
		switch (bpp) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = fb_image_convert_32bgrto16; break;
			case 3:
			case 4: convert = fb_image_convert_32bgrto32; break;
		}
	}

	DRIVER_LOCK();
	fb_hMemCpy(target_pal, palette, palette_entries * sizeof(int));
	if (!pal)
		fb_hRestorePalette();
	size = ((header.biWidth * BYTES_PER_PIXEL(header.biBitCount)) + 3) & ~0x3;
	buffer = (unsigned char *)malloc(size + 1);
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
		if (i < height)
			convert(buffer, ctx->line[i], width);
	}

exit_error:
	SET_DIRTY(ctx, 0, __fb_gfx->h);
	DRIVER_UNLOCK();

	free(buffer);

	return result;
}


/*:::::*/
FBCALL int fb_GfxBload(FBSTRING *filename, void *dest, void *pal)
{
	FILE *f;
	FB_GFXCTX *context = fb_hGetContext();
	unsigned char id;
	unsigned int color, *palette = pal, size = 0;
	char buffer[MAX_PATH];
	int i, result = fb_ErrorSetNum( FB_RTERROR_OK );

	if ((!dest) && (!__fb_gfx))
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	snprintf(buffer, MAX_PATH-1, "%s", filename->data);
	buffer[MAX_PATH-1] = '\0';
	fb_hConvertPath(buffer, strlen(buffer));

	f = fopen(buffer, "rb");

	if (!f) {
		fb_hStrDelTemp(filename);
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

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
			result = load_bmp(context, f, dest, pal);
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
			size = MIN(size, __fb_gfx->pitch * __fb_gfx->h);
			if ((!fread(context->line[0], size, 1, f)) && (!feof(f)))
				result = FB_RTERROR_FILEIO;
			SET_DIRTY(context, 0, __fb_gfx->h);
			if (!feof(f)) {
				if (!pal)
					palette = __fb_gfx->device_palette;
				for (i = 0; i < (1 << __fb_gfx->depth); i++) {
					color = fgetc(f) | (fgetc(f) << 8) | (fgetc(f) << 16);
					if (!pal)
						color = (color << 2) & 0xFCFCFC;
					palette[i] = color;
				}
				if (!pal)
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
