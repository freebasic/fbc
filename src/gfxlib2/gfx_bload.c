/* BLOAD support. */

#include "fb_gfx.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

#ifndef BI_RGB
#define BI_RGB          0
#define BI_RLE8         1
#define BI_RLE4         2
#define BI_BITFIELDS    3
#endif

static inline int fread_16_le(uint16_t *buf, FILE *f)
{
	int rc;
	rc = fread(buf, sizeof(*buf), 1, f);
	/* TODO: byteswap on BE */
	return rc;
}

static inline int fread_32_le(uint32_t *buf, FILE *f)
{
	int rc;
	rc = fread(buf, sizeof(*buf), 1, f);
	/* TODO: byteswap on BE */
	return rc;
}

typedef void (*FBGFX_BLOAD_IMAGE_CONVERT)(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits);

static void convert_8to8(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	fb_image_convert_8to8(src, dest, w);
}

static void convert_8to16(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	fb_image_convert_8to16(src, dest, w);
}

static void convert_8to32(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	fb_image_convert_8to32(src, dest, w);
}

#define CONVERT_DEPTH(c, from, to) \
	((from) <= (to) ? \
		((c) << (to - from)) | (c >> (from - (to - from))) \
		: (c) >> (from - to))

static void convert_bf_16to16(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b;
	uint16_t *s = (uint16_t *)src;
	uint16_t *d = (uint16_t *)dest;
	for (; w; w--) {
		r = (*s >> shifts[0]) & masks[0];
		g = (*s >> shifts[1]) & masks[1];
		b = (*s >> shifts[2]) & masks[2];
		r = CONVERT_DEPTH(r, bits[0], 5);
		g = CONVERT_DEPTH(g, bits[1], 6);
		b = CONVERT_DEPTH(b, bits[2], 5);
		*d = (r << 11) | (g << 5) | b;
		s++;
		d++;
	}
}

static void convert_bf_16to32(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b;
	uint16_t *s = (uint16_t *)src;
	uint32_t *d = (uint32_t *)dest;
	for (; w; w--) {
		r = (*s >> shifts[0]) & masks[0];
		g = (*s >> shifts[1]) & masks[1];
		b = (*s >> shifts[2]) & masks[2];
		r = CONVERT_DEPTH(r, bits[0], 8);
		g = CONVERT_DEPTH(g, bits[1], 8);
		b = CONVERT_DEPTH(b, bits[2], 8);
		*d = (255 << 24) | (r << 16) | (g << 8) | b;
		s++;
		d++;
	}
}

static void convert_bf_24to16(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b;

	uint32_t c;
	uint16_t *d = (uint16_t *)dest;
	for (; w; w--) {
		c = src[0] | (src[1] << 8) | (src[2] << 16);
		r = (c >> shifts[0]) & masks[0];
		g = (c >> shifts[1]) & masks[1];
		b = (c >> shifts[2]) & masks[2];
		r = CONVERT_DEPTH(r, bits[0], 5);
		g = CONVERT_DEPTH(g, bits[1], 6);
		b = CONVERT_DEPTH(b, bits[2], 5);
		*d++ = (r << 11) | (g << 5) | b;
		src += 3;
	}
}

static void convert_bf_24to32(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b;

	uint32_t c;
	uint32_t *d = (uint32_t *)dest;
	for (; w; w--) {
		c = src[0] | (src[1] << 8) | (src[2] << 16);
		r = (c >> shifts[0]) & masks[0];
		g = (c >> shifts[1]) & masks[1];
		b = (c >> shifts[2]) & masks[2];
		r = CONVERT_DEPTH(r, bits[0], 8);
		g = CONVERT_DEPTH(g, bits[1], 8);
		b = CONVERT_DEPTH(b, bits[2], 8);
		*d++ = (255 << 24) | (r << 16) | (g << 8) | b;
		src += 3;
	}
}

static void convert_bf_32to16(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b;
	uint32_t *s = (uint32_t *)src;
	uint16_t *d = (uint16_t *)dest;
	for (; w; w--) {
		r = (*s >> shifts[0]) & masks[0];
		g = (*s >> shifts[1]) & masks[1];
		b = (*s >> shifts[2]) & masks[2];
		r = CONVERT_DEPTH(r, bits[0], 5);
		g = CONVERT_DEPTH(g, bits[1], 6);
		b = CONVERT_DEPTH(b, bits[2], 5);
		*d++ = (r << 11) | (g << 5) | b;
		s++;
	}
}

static void convert_bf_32to32(const unsigned char *src, unsigned char *dest, int w, const uint32_t *masks, const int *shifts, const int *bits)
{
	uint32_t r, g, b, a;
	uint32_t *s = (uint32_t *)src;
	uint32_t *d = (uint32_t *)dest;
	for (; w; w--) {
		r = (*s >> shifts[0]) & masks[0];
		g = (*s >> shifts[1]) & masks[1];
		b = (*s >> shifts[2]) & masks[2];
		a = (*s >> shifts[3]) & masks[3];
		r = CONVERT_DEPTH(r, bits[0], 8);
		g = CONVERT_DEPTH(g, bits[1], 8);
		b = CONVERT_DEPTH(b, bits[2], 8);
		if (masks[3]) a = CONVERT_DEPTH(a, bits[3], 8);
		*d++ = (a << 24) | (r << 16) | (g << 8) | b;
		s++;
	}
}

static int load_bmp(FB_GFXCTX *ctx, FILE *f, void *dest, void *pal, int usenewheader)
{
	uint16_t bfType;
	uint32_t bfSize;
	uint16_t bfReserved1;
	uint16_t bfReserved2;
	uint32_t bfOffBits;
	uint32_t biSize;
	int32_t biWidth;
	uint16_t bcWidth;
	int32_t biHeight;
	uint16_t bcHeight;
	uint16_t biPlanes;
	uint16_t biBitCount;
	uint32_t biCompression = BI_RGB;
	uint32_t biSizeImage = 0;
	int flipped = FALSE;

	PUT_HEADER *put_header = NULL;
	unsigned char *buffer;
	int result = fb_ErrorSetNum( FB_RTERROR_OK );
	int i, j, width, height, bpp, color, expand, size, padding, palette[256], palette_entries;
	int shifts[4] = {0, 0, 0, 0};
	uint32_t masks[4];
	int bits[4] = {0, 0, 0, 0};
	void *target_pal = pal;
	uint32_t rgba[4];
	FBGFX_BLOAD_IMAGE_CONVERT convert = NULL;
	rgba[3] = 0;

	if (!__fb_gfx)
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if ((!fread_16_le(&bfType, f)) ||
	    (!fread_32_le(&bfSize, f)) ||
	    (!fread_16_le(&bfReserved1, f)) ||
	    (!fread_16_le(&bfReserved2, f)) ||
	    (!fread_32_le(&bfOffBits, f)) ||
	    (!fread_32_le(&biSize, f)))
		return FB_RTERROR_FILEIO;

	switch (biSize)
	{
		case 12:  /* OS/2 V1 (BITMAPCOREHEADER) */
		case 40:  /* BITMAPINFOHEADER */
		case 56:  /* BITMAPV3HEADER (undocumented) */
		case 108: /* BITMAPV4HEADER */
		case 124: /* BITMAPV5HEADER */
			break;
		default:
			return FB_RTERROR_FILEIO;
	}

	if (biSize == 12) {
		/* OS/2 V1 (BITMAPCOREHEADER) */
		if ((!fread_16_le(&bcWidth, f)) ||
		    (!fread_16_le(&bcHeight, f)) ||
		    (!fread_16_le(&biPlanes, f)) ||
		    (!fread_16_le(&biBitCount, f)))
			return FB_RTERROR_FILEIO;
		biWidth = bcWidth;
		biHeight = bcHeight;
	} else if (biSize >= 16) {
		/* Windows V3 (BITMAPINFOHEADER) or OS/2 V2 (BITMAPINFOHEADER2) */
	    if ((!fread_32_le((uint32_t *)&biWidth, f)) ||
		    (!fread_32_le((uint32_t *)&biHeight, f)) ||
		    (!fread_16_le(&biPlanes, f)) ||
		    (!fread_16_le(&biBitCount, f)))
			return FB_RTERROR_FILEIO;

		if (biSize >= 20) {
			if (!fread_32_le(&biCompression, f)) {
				return FB_RTERROR_FILEIO;
			}
			if (biSize >= 24) {
				if (!fread_32_le(&biSizeImage, f)) {
					return FB_RTERROR_FILEIO;
				}

				if (biSize >= 56) {
					/* Windows V3 (BITMAPV3HEADER) or later */
					if ((fseek(f, 4*4, SEEK_CUR)) ||
					    (!fread_32_le(&rgba[0], f)) ||
					    (!fread_32_le(&rgba[1], f)) ||
					    (!fread_32_le(&rgba[2], f)) ||
					    (!fread_32_le(&rgba[3], f))) {
						return FB_RTERROR_FILEIO;
					}
				}
			}
		}
	} else {
		/* unsupported header type */
		return FB_RTERROR_FILEIO;
	}

	if ((bfType != 19778) || (biPlanes > 1) || (biWidth <= 0) || (biHeight == 0) || (biCompression > BI_BITFIELDS))
		return FB_RTERROR_FILEIO;

	if (biHeight < 0) {
		if ((biCompression != BI_RGB) && (biCompression != BI_BITFIELDS))
			return FB_RTERROR_FILEIO;
		flipped = TRUE;
		biHeight = -biHeight;
	}

	if (bfOffBits == 0) {
		bfOffBits = biSize + 14;
		if (biBitCount <= 8) {
			bfOffBits += (1 << biBitCount);
		}
	}

	fseek(f, biSize + 14, SEEK_SET);

	if (biBitCount <= 8) {
		/* OS/2 palette entries are 3 bytes; others are 4 bytes */
		int pal_entry_size = (biSize == 12 ? 3 : 4);
		palette_entries = 1 << biBitCount;
		for (i = 0; i < palette_entries; i++) {
			palette[i] = (fgetc(f) << 16) | (fgetc(f) << 8) | fgetc(f);
			if (pal)
				palette[i] = (palette[i] >> 2) & 0x3F3F3F;
			if (pal_entry_size == 4) {
				fgetc(f);
			}
		}
	}
	else
		palette_entries = 0;
	if (!pal)
		target_pal = (void *)__fb_gfx->device_palette;

	if (dest) {
		put_header = (PUT_HEADER *)dest;
		/* do not overwrite pre-allocated image buffer header */
		if (put_header->type == PUT_HEADER_NEW) {
			width = MIN((int)put_header->width, biWidth);
			height = MIN((int)put_header->height, biHeight);
			bpp = put_header->bpp;
		} else {
			bpp = put_header->old.bpp;
			if (bpp == 1 || bpp == 2 || bpp == 4) {
				width = MIN((int)put_header->old.width, biWidth);
				height = MIN((int)put_header->old.height, biHeight);
			}
			else {
				if (usenewheader) {
					put_header->type = PUT_HEADER_NEW;
					put_header->bpp = ctx->target_bpp;
					put_header->width = biWidth;
					put_header->height = biHeight;
					put_header->pitch = ((put_header->width * put_header->bpp) + 0xF) & ~0xF;

					width = MIN((int)put_header->width, biWidth);
					height = MIN((int)put_header->height, biHeight);
					bpp = put_header->bpp;
				}
				else {
					put_header->old.bpp = ctx->target_bpp;
					put_header->old.width = biWidth;
					put_header->old.height = biHeight;
					put_header->pitch = ((put_header->width * put_header->bpp) + 0xF) & ~0xF;

					width = MIN((int)put_header->old.width, biWidth);
					height = MIN((int)put_header->old.height, biHeight);
					bpp = put_header->old.bpp;
				}
			}
		}
	}
	else {
		width = MIN(__fb_gfx->w, biWidth);
		height = MIN(__fb_gfx->h, biHeight);
		bpp = __fb_gfx->bpp;
	}
	fb_hPrepareTarget(ctx, dest);
	fb_hSetPixelTransfer(ctx, MASK_A_32);

	expand = (biBitCount < 8) ? biBitCount : 0;
	if (biCompression == BI_BITFIELDS) {
		if (biSize < 56) {
			if (!fread(rgba, 12, 1, f))
				return FB_RTERROR_FILEIO;
		}
	} else if (biBitCount <= 16) {
		rgba[0] = 0x7C00;
		rgba[1] = 0x3E0;
		rgba[2] = 0x1F;
	} else {
		rgba[0] = 0xFF0000;
		rgba[1] = 0xFF00;
		rgba[2] = 0xFF;
		rgba[3] = 0xFF000000;
	}
	if (biBitCount <= 8) {
		switch (bpp) {
			case 1: convert = convert_8to8;  break;
			case 2: convert = convert_8to16; break;
			case 3:
			case 4: convert = convert_8to32; break;
		}
	}
	else if (biBitCount <= 16) {
		switch (bpp) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = convert_bf_16to16; break;
			case 3:
			case 4: convert = convert_bf_16to32; break;
		}
	}
	else if (biBitCount <= 24) {
		switch (bpp) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = convert_bf_24to16; break;
			case 3:
			case 4: convert = convert_bf_24to32; break;
		}
	}
	else if (biBitCount <= 32) {
		switch (bpp) {
			case 1: return FB_RTERROR_ILLEGALFUNCTIONCALL;
			case 2: convert = convert_bf_32to16; break;
			case 3:
			case 4: convert = convert_bf_32to32; break;
		}
	}
	else
		return FB_RTERROR_FILEIO;

	/* calculate shifts and masks from bitfields to convert
	 * source pixels into fbgfx format */
	for (i = 0; i < 4; i++) {
		masks[i] = rgba[i];
		if (masks[i]) {
			while ((~masks[i]) & 1) {
				shifts[i]++;
				masks[i] >>= 1;
			}
			while (masks[i]) {
				bits[i]++;
				masks[i] >>= 1;
			}
			masks[i] = rgba[i] >> shifts[i];
		}
	}

	DRIVER_LOCK();
	fb_hMemCpy(target_pal, palette, palette_entries * sizeof(int));
	if (!pal)
		fb_hRestorePalette();
	size = ((biWidth * BYTES_PER_PIXEL(biBitCount)) + 3) & ~0x3;
	buffer = (unsigned char *)malloc(size + 1);
	switch (expand) {
		case 1: padding = 4 - (((biWidth + 7) >> 3) & 0x3); break;
		case 4: padding = 4 - (((biWidth + 1) >> 1) & 0x3); break;
		default: padding = 4 - ((biWidth * BYTES_PER_PIXEL(biBitCount)) & 0x3); break;
	}
	padding &= 0x3;
	fseek(f, bfOffBits, SEEK_SET);
	for (i = flipped ? 0 : (biHeight - 1);
	     flipped ? (i < biHeight) : (i >= 0);
	     flipped ? i++ : i--) {

		if (expand) {
			color = 0;
			for (j = 0; j < biWidth; j++) {
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
			convert(buffer, ctx->line[i], width, masks, shifts, bits);
	}

exit_error:
	SET_DIRTY(ctx, 0, __fb_gfx->h);
	DRIVER_UNLOCK();

	free(buffer);

	return result;
}

static int gfx_bload(FBSTRING *filename, void *dest, void *pal, int usenewheader)
{
	FILE *f;
	FB_GFXCTX *context;
	unsigned char id;
	unsigned int color, *palette = pal, size = 0;
	char buffer[MAX_PATH];
	int i, result = fb_ErrorSetNum( FB_RTERROR_OK );

	FB_GRAPHICS_LOCK( );

	context = fb_hGetContext();

	if ((!dest) && (!__fb_gfx)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	snprintf(buffer, MAX_PATH-1, "%s", filename->data);
	buffer[MAX_PATH-1] = '\0';
	fb_hConvertPath(buffer);

	f = fopen(buffer, "rb");

	if (!f) {
		fb_hStrDelTemp(filename);
		FB_GRAPHICS_UNLOCK( );
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
			result = load_bmp(context, f, dest, pal, usenewheader);
			fclose(f);
			fb_hStrDelTemp(filename);
			FB_GRAPHICS_UNLOCK( );
			return result;

		default:
			result = FB_RTERROR_FILEIO;
			break;
	}

	if (result == FB_RTERROR_OK) {
		if (!dest) {
			DRIVER_LOCK();
			size = MIN(size, (unsigned int)(__fb_gfx->pitch * __fb_gfx->h));
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
	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( result );
}

FBCALL int fb_GfxBload(FBSTRING *filename, void *dest, void *pal)
{
	return gfx_bload( filename, dest, pal, TRUE );
}

FBCALL int fb_GfxBloadQB(FBSTRING *filename, void *dest, void *pal)
{
	return gfx_bload( filename, dest, pal, FALSE );
}
