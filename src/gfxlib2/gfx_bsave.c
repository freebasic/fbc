/* BSAVE support. */

#include "fb_gfx.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

typedef struct BMP_HEADER
{
	unsigned short bfType;
	unsigned int   bfSize;
	unsigned short bfReserved1;
	unsigned short bfReserved2;
	unsigned int   bfOffBits;
	unsigned int   biSize;
	unsigned int   biWidth;
	unsigned int   biHeight;
	unsigned short biPlanes;
	unsigned short biBitCount;
	unsigned int   biCompression;
	unsigned int   biSizeImage;
	unsigned int   biXPelsPerMeter;
	unsigned int   biYPelsPerMeter;
	unsigned int   biClrUsed;
	unsigned int   biClrImportant;
} FBPACKED BMP_HEADER;

static int save_bmp(FB_GFXCTX *ctx, FILE *f, void *src, void *pal, int outbpp)
{
	BMP_HEADER header;
	PUT_HEADER *put_header;
	int w, h, i, bfSize, biSizeImage, bfOffBits, biClrUsed, inbpp, inpitch, outpitch, color;
	unsigned char *s, *buffer, *p;
	unsigned int *palette = (unsigned int *)pal, *paltmp = 0;

	if (src) {
		put_header = (PUT_HEADER *)src;
		if (put_header->type == PUT_HEADER_NEW) {
			w = put_header->width;
			h = put_header->height;
			s = (unsigned char *)src + sizeof(PUT_HEADER);
			inbpp = put_header->bpp;
			inpitch = put_header->pitch;
		}
		else {
			w = put_header->old.width;
			h = put_header->old.height;
			s = (unsigned char *)src + 4;
			inbpp = (put_header->old.bpp ? put_header->old.bpp : __fb_gfx->bpp);
			inpitch = w * inbpp;
		}
	}
	else {
		w = __fb_gfx->w;
		h = __fb_gfx->h;
		s = ctx->line[0];
		inbpp = __fb_gfx->bpp;
		inpitch = __fb_gfx->pitch;
	}

	if (w <= 0 || h <= 0 || s == 0 || inpitch < w * inbpp) {
		/* Something wrong with the image header */
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	}

	switch (inbpp) {
	case 1: /* 8-bit or 24-bit output (default to 8) */
		if (outbpp > 8) {
			outbpp = 24;
		}
		else {
			outbpp = 8;
		}
		break;
	case 2: /* 24-bit output only */
		outbpp = 24;
		break;
	case 4: /* 24-bit or 32-bit output only (default to 32) */
		if (outbpp != 24) {
			outbpp = 32;
		}
		break;
	default:
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	}

	/* Change bits/pixel to bytes/pixel */
	outbpp >>= 3;

	switch (outbpp) {
	case 1:
		outpitch = ( (w + 3) & ~3 );
		biSizeImage = outpitch * h;
		bfOffBits = 54 + 256*4;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 256;
		break;
	case 3:
		outpitch = ( ((w * 3) + 3) & ~3 );
		biSizeImage = outpitch * h;
		bfOffBits = 54;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 0;
		break;
	case 4:
	default:
		DBG_ASSERT(outbpp == 4);
		outpitch = w * 4;
		biSizeImage = outpitch * h;
		bfOffBits = 54;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 0;
		break;
	}

	fb_hMemSet(&header, 0, sizeof(header));
	header.bfType = 0x4D42; /* 'B' 'M' */
	header.bfSize = bfSize;
	header.bfOffBits = bfOffBits;
	header.biSize = 40;
	header.biWidth = w;
	header.biHeight = h;
	header.biPlanes = 1;
	header.biBitCount = outbpp * 8;
	header.biSizeImage = biSizeImage;
	header.biXPelsPerMeter = 0xB12;
	header.biYPelsPerMeter = 0xB12;
	header.biClrUsed = biClrUsed;
	header.biClrImportant = biClrUsed;
	if (!fwrite(&header, 54, 1, f))
		return FB_RTERROR_FILEIO;

	if (inbpp == 1) {
		if (!pal) {
			palette = __fb_gfx->device_palette;
		}
		else {
			paltmp = (unsigned int *)calloc(sizeof(unsigned int), 256);
			if (paltmp == 0) {
				return FB_RTERROR_OUTOFMEM;
			}
			for (i = 0; i < 256; i++) {
				paltmp[i] = (palette[i] & 0x3f0000) >> (16 - 2)
				          | (palette[i] & 0x003f00) << 2
				          | (palette[i] & 0x00003f) << (16 + 2);
			}
			palette = paltmp;
		}

		if (outbpp == 1) {
			for (i = 0; i < 256; i++) {
				fputc(((palette[i] >> 16) & 0xFF), f);
				fputc(((palette[i] >> 8) & 0xFF), f);
				fputc((palette[i] & 0xFF), f);
				fputc(0, f);
			}
		}
	}

	buffer = (unsigned char *)calloc(1, outpitch + 15);
	if (buffer == 0) {
		if (paltmp) free(paltmp);
		return FB_RTERROR_OUTOFMEM;
	}

	s += (h - 1) * inpitch;
	for (; h; h--) {
		p = buffer;
		switch (inbpp) {
			case 1:
				if (outbpp == 1) {
					fb_hMemCpy(p, s, inpitch);
				}
				else {
					DBG_ASSERT(outbpp == 3);
					for (i = 0; i < w; i++) {
						color = palette[((unsigned char *)s)[i]];
						*p++ = (color & 0xFF0000) >> 16;
						*p++ = (color & 0xFF00) >> 8;
						*p++ = (color & 0xFF);
					}
				}
				break;
			case 2:
				DBG_ASSERT(outbpp == 3);
				for (i = 0; i < w; i++) {
					color = ((unsigned short *)s)[i];
					*p++ = ((color & 0x001F) << 3) | ((color & 0x001F) >> 2);
					*p++ = ((color & 0x07E0) >> 3) | ((color & 0x07E0) >> 9);
					*p++ = ((color & 0xF800) >> 8) | ((color & 0xF800) >> 13);
				}
				break;
			case 4:
			default:
				DBG_ASSERT(inbpp == 4);
				DBG_ASSERT(outbpp == 3 || outbpp == 4);
				for (i = 0; i < w; i++) {
					*(unsigned int *)p = ((unsigned int *)s)[i];
					p += outbpp;
				}
				break;
		}
		if (!fwrite(buffer, outpitch, 1, f)) {
			free(buffer);
			if (paltmp) free(paltmp);
			return FB_RTERROR_FILEIO;
		}
		s -= inpitch;
	}

	free(buffer);
	if (paltmp) free(paltmp);

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int fb_GfxBsaveEx(FBSTRING *filename, void *src, unsigned int size, void *pal, int bitsperpixel)
{
	FILE *f;
	FB_GFXCTX *context;
	int i, result = fb_ErrorSetNum( FB_RTERROR_OK );
	unsigned int color, *palette = (unsigned int *)pal;
	char buffer[MAX_PATH], *p;

	FB_GRAPHICS_LOCK( );

	context = fb_hGetContext();
	snprintf(buffer, MAX_PATH-1, "%s", filename->data);
	buffer[MAX_PATH-1] = '\0';
	fb_hConvertPath(buffer);

	f = fopen(buffer, "wb");
	if (!f) {
		fb_hStrDelTemp(filename);
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

	p = strrchr(filename->data, '.');
	if (p && (!strcasecmp(p + 1, "bmp"))) {
		result = save_bmp(context, f, src, pal, bitsperpixel);
	} else {
		if ((size == 0) && src) {
			fclose(f);
			fb_hStrDelTemp(filename);
			FB_GRAPHICS_UNLOCK( );
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}

		fputc(0xFE, f);
		fputc(size & 0xFF, f);
		fputc((size >> 8) & 0xFF, f);
		fputc((size >> 16) & 0xFF, f);
		fputc(size >> 24, f);

		if (!src) {
			DRIVER_LOCK();
			size = MIN(size, (unsigned int)(__fb_gfx->pitch * __fb_gfx->h));
			if (!fwrite(context->line[0], size, 1, f))
				result = FB_RTERROR_FILEIO;
			DRIVER_UNLOCK();
			if (__fb_gfx->depth <= 8) {
				for (i = 0; i < (1 << __fb_gfx->depth); i++) {
					if (pal)
						color = palette[i];
					else
						color = (__fb_gfx->device_palette[i] >> 2) & 0x3F3F3F;
					fputc(color & 0xFF, f);
					fputc((color >> 8) & 0xFF, f);
					fputc((color >> 16) & 0xFF, f);
				}
			}
		}
		else if (!fwrite(src, size, 1, f))
			result = FB_RTERROR_FILEIO;
	}

	fclose(f);

	fb_hStrDelTemp(filename);
	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( result );
}

FBCALL int fb_GfxBsave(FBSTRING *filename, void *src, unsigned int size, void *pal)
{
	return fb_GfxBsaveEx(filename, src, size, pal, 0);
}
