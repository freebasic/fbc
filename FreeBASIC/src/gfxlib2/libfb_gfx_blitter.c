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
 * blitter.c -- blitter functions for different color depths
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
static void fb_hBlitCopy(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *src = fb_mode->framebuffer;
	char *dirty = fb_mode->dirty;
	int y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty)
			fb_hPixelCpy(dest, src, fb_mode->w);
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 6) & 0x7C00) |
				     (((c2 >> 3) & 0x001F) | ((c2 >> 6) & 0x03E0) | ((c2 >> 6) & 0x7C00) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 << 7) & 0x7C00) | ((c1 >> 6) & 0x03E0) | ((c1 >> 19) & 0x001F) |
				     ((((c2 << 7) & 0x7C00) | ((c2 >> 6) & 0x03E0) | ((c2 >> 19) & 0x001F)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 5) & 0xF800) |
				     (((c2 >> 3) & 0x001F) | ((c2 >> 5) & 0x07E0) | ((c2 >> 5) & 0xF800) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to16BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 << 8) & 0xF800) | ((c1 >> 5) & 0x07E0) | ((c1 >> 19) & 0x001F) |
				     ((((c2 << 8) & 0xF800) | ((c2 >> 5) & 0x07E0) | ((c2 >> 19) & 0x001F)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to24RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = pal[*s];
				d[0] = (c >> 16) & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = c & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to24BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = pal[*s];
				d[0] = c & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = (c >> 16) & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to32RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned int *d;
	unsigned char *s, *src = fb_mode->framebuffer;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w; x; x--) {
				*d = pal[*s];
				s++;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to32BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = fb_mode->device_palette;
	unsigned int *d;
	unsigned char *s, *src = fb_mode->framebuffer;
	unsigned int c;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;

	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w; x; x--) {
				c = pal[*s];
				*d = ((c << 16) & 0xFF0000) | (c & 0xFF00) | (c >> 16);
				s++;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 << 10) & 0x7C00) | ((c1 >> 1) & 0x03E0) | (c1 >> 11) |
				     ((((c2 << 10) & 0x7C00) | ((c2 >> 1) & 0x03E0) | (c2 >> 11)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 & 0x001F) | ((c1 >> 1) & 0x7FE0) |
				     (((c2 & 0x001F) | ((c2 >> 1) & 0x7FE0)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 << 11) & 0xF800) | (c1 & 0x07E0) | (c1 >> 11) |
				     ((((c2 << 11) & 0xF800) | (c2 & 0x07E0) | (c2 >> 11)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to24RGB(unsigned char *dest, int pitch)
{
	unsigned char *src = fb_mode->framebuffer;
	unsigned short *s;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s;
				d[0] = (c >> 8) & 0xF8;
				d[1] = (c >> 3) & 0xFC;
				d[2] = (c << 3) & 0xF8;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to24BGR(unsigned char *dest, int pitch)
{
	unsigned char *src = fb_mode->framebuffer;
	unsigned short *s;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s;
				d[0] = (c << 3) & 0xF8;
				d[1] = (c >> 3) & 0xFC;
				d[2] = (c >> 8) & 0xF8;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to32RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c = *s++;
				*d++ = ((c & 0xF800) >> 8) | ((c & 0x07E0) << 5) | ((c & 0x001F) << 19);
				*d++ = ((c & 0xF8000000) >> 24) | ((c & 0x07E00000) >> 11) | ((c & 0x001F0000) << 3);
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to32BGR(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c = *s++;
				*d++ = ((c & 0x001F) << 3) | ((c & 0x07E0) << 5) | ((c & 0xF800) << 8);
				*d++ = ((c & 0x001F0000) >> 13) | ((c & 0x07E00000) >> 11) | ((c & 0xF8000000) >> 8);
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 >> 19) | ((c1 >> 6) & 0x03E0) | ((c1 << 7) & 0x7C00) |
				     (((c2 >> 19) | ((c2 >> 6) & 0x03E0) | ((c2 << 7) & 0x7C00)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 9) & 0x7C00) |
				     ((((c2 >> 3) & 0x001F) | ((c2 >> 6) & 0x03E0) | ((c2 >> 9) & 0x7C00)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 >> 19) | ((c1 >> 5) & 0x07E0) | ((c1 << 8) & 0xF800) |
				     (((c2 >> 19) | ((c2 >> 5) & 0x07E0) | ((c2 << 8) & 0xF800)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to16BGR(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c1, c2;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 8) & 0xF800) |
				     ((((c2 >> 3) & 0x001F) | ((c2 >> 5) & 0x07E0) | ((c2 >> 8) & 0xF800)) << 16);
				s += 2;
				d++;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to24RGB(unsigned char *dest, int pitch)
{
	unsigned int *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s;
				d[0] = c >> 16;
				d[1] = (c >> 8) & 0xFF;
				d[2] = c & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to24BGR(unsigned char *dest, int pitch)
{
	unsigned int *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned char *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s;
				d[0] = c & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = c >> 16;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to32RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	char *dirty = fb_mode->dirty;
	int x, y, z = 0;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s++;
				*d++ = (c >> 16) | (c & 0xFF00) | (c << 16);
			}
		}
		z++;
		if (z >= fb_mode->scanline_size) {
			z = 0;
			dirty++;
			src += fb_mode->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
BLITTER *fb_hGetBlitter(int device_depth, int is_rgb)
{
	switch (fb_mode->depth) {
		case 1:
		case 2:
		case 4:
		case 8:
			switch (device_depth) {
				case 8:		return fb_hBlitCopy;
				case 15:	if (is_rgb) return fb_hBlit8to15RGB; else return fb_hBlit8to15BGR;
				case 16:	if (is_rgb) return fb_hBlit8to16RGB; else return fb_hBlit8to16BGR;
				case 24:	if (is_rgb) return fb_hBlit8to24RGB; else return fb_hBlit8to24BGR;
				case 32:	if (is_rgb) return fb_hBlit8to32RGB; else return fb_hBlit8to32BGR;
			}
			break;
		
		case 15:
		case 16:
			switch (device_depth) {
				case 15:	if (is_rgb) return fb_hBlit16to15RGB; else return fb_hBlit16to15BGR;
				case 16:	if (is_rgb) return fb_hBlit16to16RGB; else return fb_hBlitCopy;
				case 24:	if (is_rgb) return fb_hBlit16to24RGB; else return fb_hBlit16to24BGR;
				case 32:	if (is_rgb) return fb_hBlit16to32RGB; else return fb_hBlit16to32BGR;
			}
			break;
		
		case 24:
		case 32:
			switch (device_depth) {
				case 15:	if (is_rgb) return fb_hBlit32to15RGB; else return fb_hBlit32to15BGR;
				case 16:	if (is_rgb) return fb_hBlit32to16RGB; else return fb_hBlit32to16BGR;
				case 24:	if (is_rgb) return fb_hBlit32to24RGB; else return fb_hBlit32to24BGR;
				case 32:	if (is_rgb) return fb_hBlit32to32RGB; else return fb_hBlitCopy;
			}
			break;
	
	}
	return NULL;
}
