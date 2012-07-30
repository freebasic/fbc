/* blitter functions for different color depths */

#include "fb_gfx.h"

#ifdef HOST_X86
/* MMX functions declarations */
extern void fb_hBlit8to15RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to15BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to16RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to16BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to24RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to24BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to32RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit8to32BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit16to15RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit16to15BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit16to16RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit16to24MMX(unsigned char *dest, int pitch);
extern void fb_hBlit16to32MMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to15RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to15BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to16RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to16BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to24RGBMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to24BGRMMX(unsigned char *dest, int pitch);
extern void fb_hBlit32to32RGBMMX(unsigned char *dest, int pitch);
#endif

void fb_hBlit_code_start(void) { }

/*:::::*/
static void fb_hBlitCopy(unsigned char *dest, int pitch)
{
	unsigned char *src = __fb_gfx->framebuffer;
	char *dirty = __fb_gfx->dirty;
	int y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty)
			fb_hMemCpy(dest, src, __fb_gfx->pitch);
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 6) & 0x7C00) |
				     (((c2 >> 3) & 0x001F) | ((c2 >> 6) & 0x03E0) | ((c2 >> 6) & 0x7C00) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = pal[*s];
				*(unsigned short *)d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 6) & 0x7C00);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 << 7) & 0x7C00) | ((c1 >> 6) & 0x03E0) | ((c1 >> 19) & 0x001F) |
				     ((((c2 << 7) & 0x7C00) | ((c2 >> 6) & 0x03E0) | ((c2 >> 19) & 0x001F)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = pal[*s];
				*(unsigned short *)d = ((c1 << 7) & 0x7C00) | ((c1 >> 6) & 0x03E0) | ((c1 >> 19) & 0x001F);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 5) & 0xF800) |
				     (((c2 >> 3) & 0x001F) | ((c2 >> 5) & 0x07E0) | ((c2 >> 5) & 0xF800) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = pal[*s];
				*(unsigned short *)d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 5) & 0xF800);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to16BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c1, c2, *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = pal[*s];
				c2 = pal[*(s + 1)];
				*d = ((c1 << 8) & 0xF800) | ((c1 >> 5) & 0x07E0) | ((c1 >> 19) & 0x001F) |
				     ((((c2 << 8) & 0xF800) | ((c2 >> 5) & 0x07E0) | ((c2 >> 19) & 0x001F)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = pal[*s];
				*(unsigned short *)d = ((c1 << 8) & 0xF800) | ((c1 >> 5) & 0x07E0) | ((c1 >> 19) & 0x001F);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to24RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned char *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = pal[*s];
				d[0] = (c >> 16) & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = c & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to24BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned char *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = pal[*s];
				d[0] = c & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = (c >> 16) & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to32RGB(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned int *d;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w; x; x--) {
				*d = pal[*s];
				s++;
				d++;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit8to32BGR(unsigned char *dest, int pitch)
{
	unsigned int *pal = __fb_gfx->device_palette;
	unsigned int *d;
	unsigned char *s, *src = __fb_gfx->framebuffer;
	unsigned int c;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;

	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = pal[*s];
				*d = ((c << 16) & 0xFF0000) | (c & 0xFF00) | (c >> 16);
				s++;
				d++;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 << 10) & 0x7C00) | ((c1 >> 1) & 0x03E0) | (c1 >> 11) |
				     ((((c2 << 10) & 0x7C00) | ((c2 >> 1) & 0x03E0) | (c2 >> 11)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = ((c1 << 10) & 0x7C00) | ((c1 >> 1) & 0x03E0) | (c1 >> 11);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 & 0x001F) | ((c1 >> 1) & 0x7FE0) |
				     (((c2 & 0x001F) | ((c2 >> 1) & 0x7FE0)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = (c1 & 0x001F) | ((c1 >> 1) & 0x7FE0);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *d;
	unsigned short *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned short *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 << 11) & 0xF800) | (c1 & 0x07E0) | (c1 >> 11) |
				     ((((c2 << 11) & 0xF800) | (c2 & 0x07E0) | (c2 >> 11)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = ((c1 << 11) & 0xF800) | (c1 & 0x07E0) | (c1 >> 11);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to24(unsigned char *dest, int pitch)
{
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int *s, *d, c1, c2, c3, temp;
	unsigned short *ss;
	unsigned char *dc;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 2; x; x--) {
				c1 = __fb_color_conv_16to32[*s & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 8) & 0xFF)];
				temp = __fb_color_conv_16to32[(*s >> 16) & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 24) & 0xFF)];
				*d++ = c1 | (temp << 24);
				c2 = temp >> 8;
				s++;
				temp = __fb_color_conv_16to32[*s & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 8) & 0xFF)];
				*d++ = c2 | (temp << 16);
				c3 = temp >> 16;
				*d++ = c3 | ((__fb_color_conv_16to32[(*s >> 16) & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 24) & 0xFF)]) << 8);
				s++;
			}
			dc = (unsigned char *)d;
			if (__fb_gfx->w & 0x2) {
				c1 = __fb_color_conv_16to32[*s & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 8) & 0xFF)];
				c2 = __fb_color_conv_16to32[(*s >> 16) & 0xFF] | __fb_color_conv_16to32[256 + ((*s >> 24) & 0xFF)];
				dc[0] = (c1 >> 16) & 0xFF;
				dc[1] = (c1 >> 8) & 0xFF;
				dc[2] = c1 & 0xFF;
				dc[3] = (c2 >> 16) & 0xFF;
				dc[4] = (c2 >> 8) & 0xFF;
				dc[5] = c2 & 0xFF;
				dc += 6;
				s++;
			}
			if (__fb_gfx->w & 0x1) {
				ss = (unsigned short *)s;
				c1 = __fb_color_conv_16to32[*ss & 0xFF] | __fb_color_conv_16to32[256 + ((*ss >> 8) & 0xFF)];
				dc[0] = (c1 >> 16) & 0xFF;
				dc[1] = (c1 >> 8) & 0xFF;
				dc[2] = c1 & 0xFF;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit16to32(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c = *s++;
				*d++ = __fb_color_conv_16to32[c & 0xFF] | __fb_color_conv_16to32[256 + ((c >> 8) & 0xFF)];
				*d++ = __fb_color_conv_16to32[(c >> 16) & 0xFF] | __fb_color_conv_16to32[256 + ((c >> 24) & 0xFF)];
			}
			if (__fb_gfx->w & 0x1) {
				c = *(unsigned short *)s;
				*d = __fb_color_conv_16to32[c & 0xFF] | __fb_color_conv_16to32[256 + ((c >> 8) & 0xFF)];
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to15RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 >> 19) | ((c1 >> 6) & 0x03E0) | ((c1 << 7) & 0x7C00) |
				     (((c2 >> 19) | ((c2 >> 6) & 0x03E0) | ((c2 << 7) & 0x7C00)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = (c1 >> 19) | ((c1 >> 6) & 0x03E0) | ((c1 << 7) & 0x7C00);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to15BGR(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 9) & 0x7C00) |
				     ((((c2 >> 3) & 0x001F) | ((c2 >> 6) & 0x03E0) | ((c2 >> 9) & 0x7C00)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = ((c1 >> 3) & 0x001F) | ((c1 >> 6) & 0x03E0) | ((c1 >> 9) & 0x7C00);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to16RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = (c1 >> 19) | ((c1 >> 5) & 0x07E0) | ((c1 << 8) & 0xF800) |
				     (((c2 >> 19) | ((c2 >> 5) & 0x07E0) | ((c2 << 8) & 0xF800)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = (c1 >> 19) | ((c1 >> 5) & 0x07E0) | ((c1 << 8) & 0xF800);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to16BGR(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c1, c2;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w >> 1; x; x--) {
				c1 = *s;
				c2 = *(s + 1);
				*d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 8) & 0xF800) |
				     ((((c2 >> 3) & 0x001F) | ((c2 >> 5) & 0x07E0) | ((c2 >> 8) & 0xF800)) << 16);
				s += 2;
				d++;
			}
			if (__fb_gfx->w & 0x1) {
				c1 = *s;
				*(unsigned short *)d = ((c1 >> 3) & 0x001F) | ((c1 >> 5) & 0x07E0) | ((c1 >> 8) & 0xF800);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to24RGB(unsigned char *dest, int pitch)
{
	unsigned int *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned char *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = *s;
				d[0] = (c >> 16) & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = c & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to24BGR(unsigned char *dest, int pitch)
{
	unsigned int *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c;
	unsigned char *d;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned char *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = *s;
				d[0] = c & 0xFF;
				d[1] = (c >> 8) & 0xFF;
				d[2] = (c >> 16) & 0xFF;
				s++;
				d += 3;
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
static void fb_hBlit32to32RGB(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c;
	char *dirty = __fb_gfx->dirty;
	int x, y, z = 0;
	
	for (y = __fb_gfx->h * __fb_gfx->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = (*s++) & 0xFFFFFF;
				*d++ = (c >> 16) | (c & 0xFF00) | (c << 16);
			}
		}
		z++;
		if (z >= __fb_gfx->scanline_size) {
			z = 0;
			dirty++;
			src += __fb_gfx->pitch;
		}
		dest += pitch;
	}
}


/*:::::*/
BLITTER *fb_hGetBlitter(int device_depth, int is_rgb)
{
	BLITTER *all_blitters[] = {
		/* RGB (C) */
		fb_hBlit8to15RGB, fb_hBlit8to16RGB, fb_hBlit8to24RGB, fb_hBlit8to32RGB,
		fb_hBlit16to15RGB, fb_hBlit16to16RGB, fb_hBlit16to24, fb_hBlit16to32,
		fb_hBlit32to15RGB, fb_hBlit32to16RGB, fb_hBlit32to24RGB, fb_hBlit32to32RGB,
		/* BGR (C) */
		fb_hBlit8to15BGR, fb_hBlit8to16BGR, fb_hBlit8to24BGR, fb_hBlit8to32BGR,
		fb_hBlit16to15BGR, fb_hBlitCopy, fb_hBlit16to24, fb_hBlit16to32,
		fb_hBlit32to15BGR, fb_hBlit32to16BGR, fb_hBlit32to24BGR, fb_hBlitCopy,
#ifdef HOST_X86
		/* RGB (MMX) */
		fb_hBlit8to15RGBMMX, fb_hBlit8to16RGBMMX, fb_hBlit8to24RGBMMX, fb_hBlit8to32RGBMMX,
		fb_hBlit16to15RGBMMX, fb_hBlit16to16RGBMMX, fb_hBlit16to24MMX, fb_hBlit16to32MMX,
		fb_hBlit32to15RGBMMX, fb_hBlit32to16RGBMMX, fb_hBlit32to24RGBMMX, fb_hBlit32to32RGBMMX,
		/* BGR (MMX) */
		fb_hBlit8to15BGRMMX, fb_hBlit8to16BGRMMX, fb_hBlit8to24BGRMMX, fb_hBlit8to32BGRMMX,
		fb_hBlit16to15BGRMMX, fb_hBlitCopy, fb_hBlit16to24MMX, fb_hBlit16to32MMX,
		fb_hBlit32to15BGRMMX, fb_hBlit32to16BGRMMX, fb_hBlit32to24BGRMMX, fb_hBlitCopy,
#endif
	}, **blitter = &all_blitters[0];
	int i;
	
	for (i = 0; i < 256; i++) {
		if (is_rgb) {
			__fb_color_conv_16to32[i] = ((i & 0x1F) << 19) | ((i & 0xE0) << 5);
			__fb_color_conv_16to32[256+i] = ((i & 0x07) << 13) | (i & 0xF8);
		}
		else {
			__fb_color_conv_16to32[i] = ((i & 0x1F) << 3) | ((i & 0xE0) << 5);
			__fb_color_conv_16to32[256+i] = ((i & 0x07) << 13) | ((i & 0xF8) << 16);
		}
	}
	
#ifdef HOST_X86
	if ((__fb_gfx->flags & HAS_MMX) && (__fb_gfx->scanline_size == 1) && !(__fb_gfx->w & 0x3))
		blitter = &blitter[24];
#endif

	if (!is_rgb)
		blitter = &blitter[12];
	
	switch (__fb_gfx->depth) {
		case 1:
		case 2:
		case 4:
		case 8:
			switch (device_depth) {
				case 8:		return fb_hBlitCopy;
				case 15:	return blitter[0];
				case 16:	return blitter[1];
				case 24:	return blitter[2];
				case 32:	return blitter[3];
			}
			break;
		
		case 15:
		case 16:
			switch (device_depth) {
				case 15:	return blitter[4];
				case 16:	return blitter[5];
				case 24:	return blitter[6];
				case 32:	return blitter[7];
			}
			break;
		
		case 24:
		case 32:
			switch (device_depth) {
				case 15:	return blitter[8];
				case 16:	return blitter[9];
				case 24:	return blitter[10];
				case 32:	return blitter[11];
			}
			break;
	}
	return NULL;
}

void fb_hBlit_code_end(void) { }
