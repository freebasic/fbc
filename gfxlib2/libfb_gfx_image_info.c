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
 * imageinfo.c -- function to get information about FB image buffers.
 *
 * chng: apr/2008 written [counting_pine]
 *
 */

#include "fb_gfx.h"


FBCALL int fb_GfxImageInfo( void *img,
							int *width,	int *height,
							int *bpp,	int *pitch,	void **imgdata, 
							int *size)
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
	*imgdata = img + headerSize_;
	*size    = headerSize_ + (pitch_ * height_);

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
