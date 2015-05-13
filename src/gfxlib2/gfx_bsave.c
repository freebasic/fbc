/* BSAVE support. */

#include "fb_gfx.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

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
static int save_bmp(FB_GFXCTX *ctx, FILE *f, void *src, void *pal)
{
	BMP_HEADER header;
	PUT_HEADER *put_header;
	int w, h, i, shift = 2, bfSize, biSizeImage, bfOffBits, biClrUsed, filler, bpp, pitch, color;
	unsigned char *s, *buffer, *p;
	unsigned int *palette = (unsigned int *)pal;

	if (src) {
		put_header = (PUT_HEADER *)src;
		if (put_header->type == PUT_HEADER_NEW) {
			w = put_header->width;
			h = put_header->height;
			s = (unsigned char *)src + sizeof(PUT_HEADER);
			bpp = put_header->bpp;
			pitch = put_header->pitch;
		}
		else {
			w = put_header->old.width;
			h = put_header->old.height;
			s = (unsigned char *)src + 4;
			bpp = (put_header->old.bpp ? put_header->old.bpp : __fb_gfx->bpp);
			pitch = w * bpp;
		}
	}
	else {
		w = __fb_gfx->w;
		h = __fb_gfx->h;
		s = ctx->line[0];
		bpp = __fb_gfx->bpp;
		pitch = __fb_gfx->pitch;
	}

	if (bpp == 1) {
		biSizeImage = ( (w + 3) & ~3 ) * h;
		bfOffBits = 54 + 1024;
		bfSize = bfOffBits + biSizeImage;
		biClrUsed = 256;
	}
	else {
		biSizeImage = ( ((w * 3) + 3) & ~3 ) * h;
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
	header.biBitCount = (bpp == 1) ? 8 : 24;
	header.biSizeImage = biSizeImage;
	header.biXPelsPerMeter = 0xB12;
	header.biYPelsPerMeter = 0xB12;
	header.biClrUsed = biClrUsed;
	header.biClrImportant = biClrUsed;
	if (!fwrite(&header, 54, 1, f))
		return FB_RTERROR_FILEIO;
	if (bpp == 1) {
		if (!pal) {
			palette = __fb_gfx->device_palette;
			shift = 0;
		}
		for (i = 0; i < 256; i++) {
			fputc(((palette[i] >> 16) & 0xFF) << shift, f);
			fputc(((palette[i] >> 8) & 0xFF) << shift, f);
			fputc((palette[i] & 0xFF) << shift, f);
			fputc(0, f);
		}
	}

	switch (bpp) {
		case 1:
			filler = ( (w + 3) & ~3 );
			break;
		case 2:
		case 4:
			filler = ( ((w * 3) + 3) & ~3 );
			break;
	}
	buffer = (unsigned char *)calloc(1, filler + 15);

	s += (h - 1) * pitch;
	for (; h; h--) {
		p = buffer;
		switch (bpp) {
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

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_GfxBsave(FBSTRING *filename, void *src, unsigned int size, void *pal)
{
	FILE *f;
	FB_GFXCTX *context = fb_hGetContext();
	int i, result = fb_ErrorSetNum( FB_RTERROR_OK );
	unsigned int color, *palette = (unsigned int *)pal;
	char buffer[MAX_PATH], *p;

	snprintf(buffer, MAX_PATH-1, "%s", filename->data);
	buffer[MAX_PATH-1] = '\0';
	fb_hConvertPath(buffer);

	f = fopen(buffer, "wb");
	if (!f) {
		fb_hStrDelTemp(filename);
		return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
	}

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

	p = strrchr(filename->data, '.');
	if ((p) && (!strcasecmp(p + 1, "bmp")))
		result = save_bmp(context, f, src, pal);
	else {
		if ((size == 0) && src) {
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
			size = MIN(size, __fb_gfx->pitch * __fb_gfx->h);
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

	return fb_ErrorSetNum( result );
}
