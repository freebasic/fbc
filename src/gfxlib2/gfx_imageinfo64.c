/* function to get information about FB image buffers. */

#include "fb_gfx.h"

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
	int result, width_, height_, bpp_, pitch_, size_;

	result = fb_GfxImageInfo( img, &width_, &height_, &bpp_, &pitch_,
	                          imgdata, &size_ );

	*width  = width_;
	*height = height_;
	*bpp    = bpp_;
	*pitch  = pitch_;
	*size   = size_;

	return result;
}
