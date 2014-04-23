/* Software cursor helper routines */

#include "fb_gfx.h"

#define CURSOR_W	13
#define CURSOR_H	22

#define BIT_ENCODE(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12) \
	((p0)|(p1<<2)|(p2<<4)|(p3<<6)|(p4<<8)|(p5<<10)|(p6<<12)|(p7<<14)|(p8<<16)|(p9<<18)|(p10<<20)|(p11<<22)|(p12<<24))

char fb_hSoftCursor_data_start;

static const unsigned int cursor_data[] = {
	BIT_ENCODE(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0),
	BIT_ENCODE(2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 0),
	BIT_ENCODE(2, 1, 1, 1, 2, 1, 1, 2, 3, 3, 3, 3, 3),
	BIT_ENCODE(2, 1, 1, 2, 2, 1, 1, 2, 3, 0, 0, 0, 0),
	BIT_ENCODE(2, 1, 2, 3, 3, 2, 1, 1, 2, 0, 0, 0, 0),
	BIT_ENCODE(2, 2, 3, 0, 0, 2, 1, 1, 2, 3, 0, 0, 0),
	BIT_ENCODE(2, 3, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 3, 0, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 3, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 3, 3, 0),
	BIT_ENCODE(0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0)
};

static unsigned char *cursor_area;
static unsigned int white, black;

char fb_hSoftCursor_data_end;

void fb_hSoftCursor_code_start(void) { }

static void copy_cursor_area(int x, int y, int from_area)
{
	unsigned char *s, *d;
	int w, h, s_pitch, d_pitch;

	w = (MIN(CURSOR_W, __fb_gfx->w - x) * __fb_gfx->bpp);
	h = MIN(CURSOR_H, __fb_gfx->h - y);

	if (from_area) {
		s = cursor_area;
		d = __fb_gfx->framebuffer + (y * __fb_gfx->pitch) + (x * __fb_gfx->bpp);
		s_pitch = w;
		d_pitch = __fb_gfx->pitch;
	} else {
		s = __fb_gfx->framebuffer + (y * __fb_gfx->pitch) + (x * __fb_gfx->bpp);
		d = cursor_area;
		s_pitch = __fb_gfx->pitch;
		d_pitch = w;
	}

	for (; h; h--) {
		fb_hMemCpy(d, s, w);
		s += s_pitch;
		d += d_pitch;
	}
}

int fb_hColorDistance(int index, int r, int g, int b)
{
	return (((__fb_gfx->device_palette[index] & 0xFF) - r) * ((__fb_gfx->device_palette[index] & 0xFF) - r)) +
	       ((((__fb_gfx->device_palette[index] >> 8) & 0xFF) - g) * (((__fb_gfx->device_palette[index] >> 8) & 0xFF) - g)) +
	       ((((__fb_gfx->device_palette[index] >> 16) & 0xFF) - b) * (((__fb_gfx->device_palette[index] >> 16) & 0xFF) - b));
}

void fb_hSoftCursorInit(void)
{
	cursor_area = malloc(CURSOR_W * CURSOR_H * __fb_gfx->bpp);

#ifdef HOST_DOS
	fb_dos_lock_data(cursor_area, CURSOR_W * CURSOR_H * __fb_gfx->bpp);
#endif

	if (__fb_gfx->bpp == 1) {
		white = 15;
		black = 0;
	}
	else {
		white = fb_hFixColor(__fb_gfx->bpp, 0xFFFFFF);
		black = fb_hFixColor(__fb_gfx->bpp, 0x000000);
	}
}

void fb_hSoftCursorExit(void)
{
#ifdef HOST_DOS
	fb_dos_unlock_data(cursor_area, CURSOR_W * CURSOR_H * __fb_gfx->bpp);
#endif
	free(cursor_area);
}

void fb_hSoftCursorPut(int x, int y)
{
	unsigned char *d, *dest;
	int w, h, px, py, pixel, count;
	unsigned int data;
	const unsigned int *cursor;

	copy_cursor_area(x, y, FALSE);

	w = MIN(CURSOR_W, __fb_gfx->w - x);
	h = MIN(CURSOR_H, __fb_gfx->h - y);
	dest = __fb_gfx->framebuffer + (y * __fb_gfx->pitch) + (x * __fb_gfx->bpp);
	cursor = cursor_data;
	for (py = 0; py < h; py++) {
		d = dest;
		data = *cursor++;
		for (px = 0; px < w;) {
			pixel = data & 0x3;
			for (count = 0; (px < w) && ((int)(data & 0x3) == pixel); px++, data >>= 2)
				count++;
			if (pixel == 0x3) {
				if (__fb_gfx->bpp == 4)
					fb_hPixelSetAlpha4(d, 0x40000000, count);
			}
			else {
				if (pixel)
					fb_hPixelSet(d, (pixel & 0x1) ? white : black, count);
			}
			d += (count * __fb_gfx->bpp);
		}
		__fb_gfx->dirty[y + py] = TRUE;
		dest += __fb_gfx->pitch;
	}
}

void fb_hSoftCursorUnput(int x, int y)
{
	copy_cursor_area(x, y, TRUE);
	fb_hMemSet(__fb_gfx->dirty + y, TRUE, MIN(CURSOR_H, __fb_gfx->h - y));
}

void fb_hSoftCursorPaletteChanged(void)
{
	int i, dist, min_wdist = 1000000, min_bdist = 1000000;

	if (__fb_gfx->bpp > 1)
		return;
	for (i = 0; i < 256; i++) {
		dist = fb_hColorDistance(i, 255, 255, 255);
		if (dist < min_wdist) {
			min_wdist = dist;
			white = i;
		}
		dist = fb_hColorDistance(i, 0, 0, 0);
		if (dist < min_bdist) {
			min_bdist = dist;
			black = i;
		}
	}
}

void fb_hSoftCursor_code_end(void) { }
