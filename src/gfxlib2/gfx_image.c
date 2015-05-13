/* image create/destroy functions */

#include "fb_gfx.h"

static void *gfx_imagecreate(int width, int height, unsigned int color, int depth, int flags, int usenewheader)
{
	FB_GFXCTX *context;
	PUT_HEADER *image;
	int size, pitch, header_size = 4;
	int bpp;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (width <= 0) || (height <= 0)) {
		FB_GRAPHICS_UNLOCK( );
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		return NULL;
	}

	context = fb_hGetContext();

	if (depth > 0) {
		bpp = BYTES_PER_PIXEL(depth);
		if ((bpp != 1) && (bpp != 2) && (bpp != 4)) {
			FB_GRAPHICS_UNLOCK( );
			fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
			return NULL;
		}
	} else {
		bpp = __fb_gfx->bpp;
	}

	if (flags & DEFAULT_COLOR_1) {
		switch (bpp) {
			case 1: color = 0; break;
			case 2: color = MASK_COLOR_16; break;
			case 4: color = MASK_COLOR_32 | MASK_A_32; break;
		}
	} else {
		if (bpp == 2)
			color = ((color & 0xF8) >> 3) | ((color & 0xFC00) >> 5) | ((color & 0xF80000) >> 8);
	}

	pitch = width * bpp;
	if (usenewheader) {
		header_size = sizeof(PUT_HEADER);
		pitch = (pitch + 0xF) & ~0xF;
	}
	size = pitch * height;

	/* 0xF for the para alignment, p_size is sizeof(void *) rounded up to % 16 for the storage for the original pointer */
	int p_size = (sizeof(void *) + 0xF) & 0xF;
	void *tmp = malloc(size + header_size + p_size + 0xF);
	if (tmp == NULL) {
		FB_GRAPHICS_UNLOCK( );
		fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
		return NULL;
	}

	image = (PUT_HEADER *)(((intptr_t)tmp + p_size + 0xF) & ~0xF);
	((void **)image)[-1] = tmp;

	if (!usenewheader) {
		/* use old-style header for compatibility */
		image->old.bpp = bpp;
		image->old.width = width;
		image->old.height = height;
	} else {
		image->type = PUT_HEADER_NEW;
		image->bpp = bpp;
		image->width = width;
		image->height = height;
		image->pitch = pitch;
		fb_hMemSet(image->_reserved, 0, sizeof(image->_reserved));
	}

	fb_hPrepareTarget(context, (void *)image);
	fb_hSetPixelTransfer(context, MASK_A_32);
	context->pixel_set((unsigned char *)image + header_size, color, (pitch * height) / bpp);

	FB_GRAPHICS_UNLOCK( );
	fb_ErrorSetNum( FB_RTERROR_OK );
	return image;
}

FBCALL void *fb_GfxImageCreate(int width, int height, unsigned int color, int depth, int flags)
{
	return gfx_imagecreate( width, height, color, depth, flags, TRUE );
}

FBCALL void *fb_GfxImageCreateQB(int width, int height, unsigned int color, int depth, int flags)
{
	return gfx_imagecreate( width, height, color, depth, flags, FALSE );
}

FBCALL void fb_GfxImageDestroy(void *image)
{
	if( image == NULL ) return;
	free(((void **)image)[-1]);
}
