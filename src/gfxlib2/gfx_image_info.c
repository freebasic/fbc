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
