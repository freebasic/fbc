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
 * x11.c -- X11 gfx driver
 *
 * chng: jan/2005 written [lillo]
 *
 */

#ifdef WITH_X

#include "fb_gfx.h"
#include "fb_gfx_x11.h"

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);

GFXDRIVER fb_gfxDriverX11 =
{
	"X11",			/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	fb_hX11Exit,		/* void (*exit)(void); */
	fb_hX11Lock,		/* void (*lock)(void); */
	fb_hX11Unlock,		/* void (*unlock)(void); */
	fb_hX11SetPalette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_hX11WaitVSync,	/* void (*wait_vsync)(void); */
	fb_hX11GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hX11SetMouse,	/* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hX11SetWindowTitle,	/* void (*set_window_title)(char *title); */
	fb_hX11SetWindowPos,	/* int (*set_window_pos)(int x, int y); */
	fb_hX11FetchModes,	/* int *(*fetch_modes)(void); */
	NULL,			/* void (*flip)(void); */
	NULL			/* void (*poll_events)(void); */
};


static XImage *image, *shape_image;
static Pixmap shape_pixmap;
static GC shape_gc;
static XShmSegmentInfo shm_info;
static BLITTER *blitter;
static int is_shm;
static void (*update_mask)(unsigned char *src, unsigned char *mask, int w, int h);


/*:::::*/
static void update_mask_8(unsigned char *pixel, unsigned char *mask, int w, int h)
{
	int x, b;
	unsigned char *p = pixel;
	
	for(; h; h--) {
		b = 0;
		for (x = 0; x < w; x++) {
			if (*p++ != 0)
				b |= 1 << (x & 0x7);
			if ((x & 0x7) == 0x7) {
				*mask++ = b;
				b = 0;
			}
		}
		if (w & 0x7)
			*mask++ = b;
	}
}


/*:::::*/
static void update_mask_16(unsigned char *pixel, unsigned char *mask, int w, int h)
{
	int x, b;
	unsigned short *p = (unsigned short *)pixel;
	
	for(; h; h--) {
		b = 0;
		for (x = 0; x < w; x++) {
			if (*p++ != MASK_COLOR_16)
				b |= 1 << (x & 0x7);
			if ((x & 0x7) == 0x7) {
				*mask++ = b;
				b = 0;
			}
		}
		if (w & 0x7)
			*mask++ = b;
	}
}


/*:::::*/
static void update_mask_32(unsigned char *pixel, unsigned char *mask, int w, int h)
{
	int x, b;
	unsigned int *p = (unsigned int *)pixel;
	
	for(; h; h--) {
		b = 0;
		for (x = 0; x < w; x++) {
			if (((*p++) & ~MASK_A_32) != MASK_COLOR_32)
				b |= 1 << (x & 0x7);
			if ((x & 0x7) == 0x7) {
				*mask++ = b;
				b = 0;
			}
		}
		if (w & 0x7)
			*mask++ = b;
	}
}


/*:::::*/
static int x11_init(void)
{
	XGCValues values;
	int x = 0, y = 0, h, is_rgb = FALSE;
	char *display_name;
	
	image = NULL;
	shape_image = NULL;
	is_shm = FALSE;
	
	if ((fb_x11.visual_depth >= 24) && (fb_x11.visual->red_mask == 0xFF))
		is_rgb = TRUE;
	else if ((fb_x11.visual_depth >= 15) && (fb_x11.visual->red_mask == 0x1F))
		is_rgb = TRUE;
	blitter = fb_hGetBlitter(fb_x11.visual_depth, is_rgb);
	if (!blitter)
		return -1;
	
	if (!(fb_x11.flags & DRIVER_FULLSCREEN)) {
		x = (XDisplayWidth(fb_x11.display, fb_x11.screen) - fb_x11.w) >> 1;
		y = (XDisplayHeight(fb_x11.display, fb_x11.screen) - fb_x11.h) >> 1;
	}
	fb_hX11InitWindow(x, y);
	
	if (fb_x11.flags & DRIVER_SHAPED_WINDOW) {
		shape_image = XCreateImage(fb_x11.display, fb_x11.visual, 1, XYBitmap, 0, NULL, fb_x11.w, fb_x11.h, 8, 0);
		shape_image->data = calloc(1, shape_image->bytes_per_line * shape_image->height);
		shape_pixmap = XCreateBitmapFromData(fb_x11.display, fb_x11.window,
											 shape_image->data, fb_x11.w, fb_x11.h);
		values.foreground = 1;
		values.background = 0;											 
		shape_gc = XCreateGC(fb_x11.display, shape_pixmap, GCForeground | GCBackground, &values);
		if (__fb_gfx->bpp == 1)
			update_mask = update_mask_8;
		else if (__fb_gfx->bpp == 2)
			update_mask = update_mask_16;
		else
			update_mask = update_mask_32;
	}
	
	fb_x11.display_offset = 0;
	display_name = XDisplayName(NULL);
	if (((!display_name[0]) || (display_name[0] == ':') || (!strncmp(display_name, "unix:", 5))) &&
	    (XShmQueryExtension(fb_x11.display))) {
		if (fb_x11.flags & DRIVER_FULLSCREEN) {
			if (fb_hX11EnterFullscreen(&h)) {
				fb_hX11LeaveFullscreen();
				return -1;
			}
			XMoveResizeWindow(fb_x11.display, fb_x11.window, 0, 0, fb_x11.w, h);
			fb_x11.display_offset = (h - fb_x11.h) >> 1;
		}
		is_shm = TRUE;
		image = XShmCreateImage(fb_x11.display, fb_x11.visual, XDefaultDepth(fb_x11.display, fb_x11.screen),
					ZPixmap, 0, &shm_info, fb_x11.w, fb_x11.h);
		if (image) {
			shm_info.shmid = shmget(IPC_PRIVATE, image->bytes_per_line * image->height, IPC_CREAT | 0777);
			shm_info.shmaddr = image->data = shmat(shm_info.shmid, 0, 0);
			shm_info.readOnly = False;
			if (!XShmAttach(fb_x11.display, &shm_info)) {
				shmdt(shm_info.shmaddr);
				shmctl(shm_info.shmid, IPC_RMID, 0);
				XDestroyImage(image);
				image = NULL;
			}
		}
	}
	else if (fb_x11.flags & DRIVER_FULLSCREEN)
		return -1;
	if (!image) {
		is_shm = FALSE;
		image = XCreateImage(fb_x11.display, fb_x11.visual, XDefaultDepth(fb_x11.display, fb_x11.screen),
				     ZPixmap, 0, NULL, fb_x11.w, fb_x11.h, 32, 0);
		image->data = malloc(image->bytes_per_line * image->height);
		if (!image->data) {
			XDestroyImage(image);
			image = NULL;
		}
	}
	if (!image)
		return -1;
	
	return 0;
}


/*:::::*/
static void x11_exit(void)
{
	if (fb_x11.flags & DRIVER_FULLSCREEN)
		fb_hX11LeaveFullscreen();
	XUnmapWindow(fb_x11.display, fb_x11.window);
	XSync(fb_x11.display, False);
	if (image) {
		if (is_shm) {
			XShmDetach(fb_x11.display, &shm_info);
			shmdt(shm_info.shmaddr);
			shmctl(shm_info.shmid, IPC_RMID, 0);
		}
		XDestroyImage(image);
	}
	if (shape_image) {
		XDestroyImage(shape_image);
		XFreePixmap(fb_x11.display, shape_pixmap);
	}
}


/*:::::*/
static void x11_update(void)
{
	int i, y, h;
	
	blitter((unsigned char *)image->data, image->bytes_per_line);
	for (i = 0; i < fb_x11.h; i++) {
		if (__fb_gfx->dirty[i]) {
			for (y = i, h = 0; (__fb_gfx->dirty[i]) && (i < fb_x11.h); h++, i++)
				;
			if (shape_image) {
				update_mask((unsigned char *)__fb_gfx->framebuffer + (y * __fb_gfx->pitch),
							(unsigned char *)shape_image->data + (y * shape_image->bytes_per_line), fb_x11.w, h);
				XPutImage(fb_x11.display, shape_pixmap, shape_gc, shape_image, 0, y, 0, y, fb_x11.w, h);
				XShapeCombineMask(fb_x11.display, fb_x11.window, ShapeBounding, 0, 0, shape_pixmap, ShapeSet);
			}
			if (is_shm)
				XShmPutImage(fb_x11.display, fb_x11.window, fb_x11.gc, image, 0, y, 0, y + fb_x11.display_offset, fb_x11.w, h, False);
			else
				XPutImage(fb_x11.display, fb_x11.window, fb_x11.gc, image, 0, y, 0, y + fb_x11.display_offset, fb_x11.w, h);
		}
	}
	fb_hMemSet(__fb_gfx->dirty, FALSE, fb_x11.h);
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
    int depth = MAX(8, depth_arg);
	if (flags & DRIVER_OPENGL)
		return -1;
	fb_hMemSet(&fb_x11, 0, sizeof(fb_x11));
	fb_x11.init = x11_init;
	fb_x11.exit = x11_exit;
	fb_x11.update = x11_update;
	
	return fb_hX11Init(title, w, h, depth, refresh_rate, flags);
}

#endif
