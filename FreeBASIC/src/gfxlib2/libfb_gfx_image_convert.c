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
 * image_convert.c -- bpp conversion
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

/*:::::*/
void fb_image_convert_8to8(unsigned char *src, unsigned char *dest, int w)
{
	for (; w; w--)
		*dest++ = *src++ & fb_mode->color_mask;
}


/*:::::*/
void fb_image_convert_8to16(unsigned char *src, unsigned char *dest, int w)
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
void fb_image_convert_8to32(unsigned char *src, unsigned char *dest, int w)
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
void fb_image_convert_24to16(unsigned char *src, unsigned char *dest, int w)
{
	unsigned short *d = (unsigned short *)dest;
	for (; w; w--) {
		*d++ = ((unsigned short)src[0] >> 3) | (((unsigned short)src[1] << 3) & 0x07E0) | (((unsigned short)src[2] << 8) & 0xF800);
		src += 3;
	}
}


/*:::::*/
void fb_image_convert_24to32(unsigned char *src, unsigned char *dest, int w)
{
	unsigned int *d = (unsigned int *)dest;

	for (; w; w--) {
		*d++ = *(unsigned int *)src & 0xFFFFFF;
		src += 3;
	}
}


/*:::::*/
void fb_image_convert_32to16(unsigned char *src, unsigned char *dest, int w)
{
	unsigned short *d = (unsigned short *)dest;
	unsigned int *s = (unsigned int *)src;

	for (; w; w--) {
		*d++ = (unsigned short)(((*s & 0xFF) >> 3) | ((*s >> 5) & 0x07E0) | ((*s >> 8) & 0xF800));
		s++;
	}
}

/*:::::*/
void fb_image_convert_32to32(unsigned char *src, unsigned char *dest, int w)
{
	fb_hMemCpy(dest, src, w << 2);
}

/*:::::*/
FBCALL void fb_GfxImageConvertRow( unsigned char *src, int src_bpp, unsigned char *dest, int dst_bpp, int width )
{
	FBGFX_IMAGE_CONVERT convert = NULL;
	
	if (src_bpp <= 8) 
	{
		switch (BYTES_PER_PIXEL( dst_bpp )) 
		{
			case 1: convert = fb_image_convert_8to8;  break;
			case 2: convert = fb_image_convert_8to16; break;
			case 3:
			case 4: convert = fb_image_convert_8to32; break;
		}
	}
	else if (src_bpp == 24) 
	{
		switch (BYTES_PER_PIXEL( dst_bpp )) 
		{
			case 1: return;
			case 2: convert = fb_image_convert_24to16; break;
			case 3:
			case 4: convert = fb_image_convert_24to32; break;
		}
	}
	else 
	{
		switch (BYTES_PER_PIXEL( dst_bpp )) 
		{
			case 1: return;
			case 2: convert = fb_image_convert_32to16; break;
			case 3:
			case 4: convert = fb_image_convert_32to32; break;
		}
	}

	convert( src, dest, width );
}
