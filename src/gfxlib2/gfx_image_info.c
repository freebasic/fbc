/* function to get information about FB image buffers. */

#include "fb_gfx.h"

FBCALL int fb_GfxImageInfo
	(
		void *img,
		ssize_t *width,
		ssize_t *height,
		ssize_t *bpp,
		ssize_t *pitch,
		void **imgdata,
		ssize_t *size
	)
{
	PUT_HEADER *header;
	int bpp_, width_, height_, pitch_, headerSize_;

	header = (PUT_HEADER *)img;

	if (!header || header->type == 0)
	{
		*width = *height = *bpp = *pitch = *size = -1;
		*imgdata = NULL;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	else if (header->type == PUT_HEADER_NEW) {
		bpp_        = header->bpp;
		width_      = header->width;
		height_     = header->height;
		pitch_      = header->pitch;
		headerSize_ = sizeof(PUT_HEADER);
	}
	else {
		bpp_        = header->old.bpp;
		width_      = header->old.width;
		height_     = header->old.height;
		pitch_      = width_ * bpp_;
		headerSize_ = 4;
	}

	*width   = width_;
	*height  = height_;
	*bpp     = bpp_;
	*pitch   = pitch_;
	*imgdata = (unsigned char*)img + headerSize_;
	*size    = headerSize_ + (pitch_ * height_);

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int fb_GfxImageInfo32
	(
		void *img,
		int *width,
		int *height,
		int *bpp,
		int *pitch,
		void **imgdata,
		int *size
	)
{
	ssize_t w, h, b, p, s;
	int ret = fb_GfxImageInfo( img, &w, &h, &b, &p, imgdata, &s );
	*width = (int)w;
	*height = (int)h;
	*bpp = (int)b;
	*pitch = (int)p;
	*size = (int)s;
	return ret;
}

FBCALL int fb_GfxImageInfo64
	(
		void *img,
		long long *width,
		long long *height,
		long long *bpp,
		long long *pitch,
		void **imgdata,
		long long *size
	)
{
	ssize_t w, h, b, p, s;
	int ret = fb_GfxImageInfo( img, &w, &h, &b, &p, imgdata, &s );
	*width = (long long)w;
	*height = (long long)h;
	*bpp = (long long)b;
	*pitch = (long long)p;
	*size = (long long)s;
	return ret;
}
