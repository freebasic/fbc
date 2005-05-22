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
 * core.c -- core internal routines
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 added gfx target handling [lillo]
 *
 */

#include "fb_gfx.h"

static int old_view_x, old_view_y, old_view_w, old_view_h;


/*:::::*/
void fb_hPrepareTarget(void *target)
{
	int i, h;
	
	if (target) {
		if (target != fb_mode->last_target) {
			if (fb_mode->last_target == NULL) {
				old_view_x = fb_mode->view_x;
				old_view_y = fb_mode->view_y;
				old_view_w = fb_mode->view_w;
				old_view_h = fb_mode->view_h;
			}
			fb_mode->view_x = 0;
			fb_mode->view_y = 0;
			fb_mode->view_w = *((short *)target) >> 3;
			fb_mode->view_h = h = *((short *)(target + 2));
			fb_mode->target_pitch = fb_mode->view_w * fb_mode->bpp;
			if (h > fb_mode->max_h) {
				fb_mode->line = (unsigned char **)realloc(fb_mode->line, h * sizeof(unsigned char *));
				fb_mode->max_h = h;
			}
			for (i = 0; i < h; i++)
				fb_mode->line[i] = (unsigned char *)target + 4 + (i * fb_mode->target_pitch);
			fb_mode->flags |= BUFFER_SET;
		}
	}
	else if (fb_mode->flags & BUFFER_SET) {
		fb_mode->view_x = old_view_x;
		fb_mode->view_y = old_view_y;
		fb_mode->view_w = old_view_w;
		fb_mode->view_h = old_view_h;
		fb_mode->target_pitch = fb_mode->pitch;
		for (i = 0; i < fb_mode->h; i++)
			fb_mode->line[i] = fb_mode->page[fb_mode->work_page] + (i * fb_mode->pitch);
		fb_mode->flags &= ~BUFFER_SET;
	}
	fb_mode->last_target = target;
}


/*:::::*/
void fb_hTranslateCoord(float fx, float fy, int *x, int *y)
{
	if (fb_mode->flags & WINDOW_ACTIVE) {
		fx = ((fx - fb_mode->win_x) * fb_mode->view_w) / (fb_mode->win_w - 1);
		fy = ((fy - fb_mode->win_y) * fb_mode->view_h) / (fb_mode->win_h - 1);
	}
	
	*x = (int)(fx > 0 ? fx + 0.5 : fx - 0.5);
	*y = (int)(fy > 0 ? fy + 0.5 : fy - 0.5);
	
	if ((fb_mode->flags & (WINDOW_ACTIVE | WINDOW_SCREEN)) == WINDOW_ACTIVE)
		*y = fb_mode->view_h - 1 - *y;
		
	if ((fb_mode->flags & VIEW_SCREEN) == 0) {
		*x += fb_mode->view_x;
		*y += fb_mode->view_y;
	}
}


/*:::::*/
void fb_hFixRelative(int coord_type, float *x1, float *y1, float *x2, float *y2)
{
	switch (coord_type) {
		
		case COORD_TYPE_R:
		case COORD_TYPE_RA:
			*x1 += fb_mode->last_x;
			*y1 += fb_mode->last_y;
			break;
		
		case COORD_TYPE_RR:
			*x1 += fb_mode->last_x;
			*y1 += fb_mode->last_y;
			/* fallthrough */
		
		case COORD_TYPE_AR:
			*x2 += *x1;
			*y2 += *y1;
			break;
	}
	
	if (x2) {
		fb_mode->last_x = *x2;
		fb_mode->last_y = *y2;
	}
	else {
		fb_mode->last_x = *x1;
		fb_mode->last_y = *y1;
	}
}


/*:::::*/
void fb_hFixCoordsOrder(int *x1, int *y1, int *x2, int *y2)
{
	if (*x2 < *x1)
		SWAP(*x1, *x2);
	
	if (*y2 < *y1)
		SWAP(*y1, *y2);
}


/*:::::*/
static void fb_hPutPixel1(int x, int y, unsigned int color)
{
	fb_mode->line[y][x] = color;
}


/*:::::*/
static void fb_hPutPixel2(int x, int y, unsigned int color)
{
	((unsigned short *)fb_mode->line[y])[x] = color;
}


/*:::::*/
static void fb_hPutPixel4(int x, int y, unsigned int color)
{
	((unsigned int *)fb_mode->line[y])[x] = color;
}


/*:::::*/
static unsigned int fb_hGetPixel1(int x, int y)
{
	return fb_mode->line[y][x];
}


/*:::::*/
static unsigned int fb_hGetPixel2(int x, int y)
{
	return ((unsigned short *)fb_mode->line[y])[x];
}


/*:::::*/
static unsigned int fb_hGetPixel4(int x, int y)
{
	return ((unsigned int *)fb_mode->line[y])[x];
}


/*:::::*/
static void *fb_hPixelSet2(void *dest, int color, size_t size)
{
	unsigned short *d = (unsigned short *)dest;
	
	for (; size; size--)
		*d++ = color;
	
	return dest;
}


/*:::::*/
static void *fb_hPixelSet4(void *dest, int color, size_t size)
{
	unsigned int *d = (unsigned int *)dest;
	
	for (; size; size--)
		*d++ = color;
	
	return dest;
}


/*:::::*/
static void *fb_hPixelCpy2(void *dest, const void *src, size_t size)
{
	return fb_hMemCpy(dest, src, size << 1);
}


/*:::::*/
static void *fb_hPixelCpy4(void *dest, const void *src, size_t size)
{
	return fb_hMemCpy(dest, src, size << 2);
}


/*:::::*/
void fb_hSetupFuncs(void)
{
	if (fb_hHasMMX()) {
		fb_mode->flags |= HAS_MMX;
		fb_hMemCpy = fb_hMemCpyMMX;
		fb_hMemSet = fb_hMemSetMMX;
	}
	else {
		fb_hMemCpy = memcpy;
		fb_hMemSet = memset;
	}
	switch (fb_mode->depth) {
		case 1:
		case 2:
		case 4:
		case 8:
			fb_hPutPixel = fb_hPutPixel1;
			fb_hGetPixel = fb_hGetPixel1;
			fb_hPixelSet = fb_hMemSet;
			fb_hPixelCpy = fb_hMemCpy;
			break;
		
		case 15:
		case 16:
			fb_hPutPixel = fb_hPutPixel2;
			fb_hGetPixel = fb_hGetPixel2;
			fb_hPixelSet = fb_hPixelSet2;
			fb_hPixelCpy = fb_hPixelCpy2;
			break;
		
		default:
			fb_hPutPixel = fb_hPutPixel4;
			fb_hGetPixel = fb_hGetPixel4;
			fb_hPixelSet = fb_hPixelSet4;
			fb_hPixelCpy = fb_hPixelCpy4;
			break;
	}
}
