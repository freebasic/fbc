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

#include "fb_gfx.h"
#include "fb_gfx_linux.h"


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
	fb_hX11GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_hX11SetMouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	fb_hX11SetWindowTitle,	/* void (*set_window_title)(char *title); */
	fb_hX11FetchModes,	/* int *(*fetch_modes)(void); */
	NULL			/* void (*flip)(void); */
};


static XImage *image;
static XShmSegmentInfo shm_info;
static BLITTER *blitter;
static int is_shm;


/*:::::*/
static int calc_comp_height( int h )
{
	if( h < 240 )
		return 240;
	else if( h < 480 )
		return 480;
	else if( h < 600 )
		return 600;
	else if( h < 768 )
		return 768;
	else if( h < 1024 )
		return 1024;
	else
		return 0;
}


/*:::::*/
static int x11_init(void)
{
	XSetWindowAttributes attribs;
	int x = 0, y = 0, h, is_rgb = FALSE;
	char *display_name;
	
	image = NULL;
	is_shm = FALSE;
	
	if ((fb_linux.visual_depth >= 24) && (fb_linux.visual->red_mask == 0xFF))
		is_rgb = TRUE;
	else if ((fb_linux.visual_depth >= 15) && (fb_linux.visual->red_mask == 0x1F))
		is_rgb = TRUE;
	blitter = fb_hGetBlitter(fb_linux.visual_depth, is_rgb);
	if (!blitter)
		return -1;
	
	if (!(fb_linux.flags & DRIVER_FULLSCREEN)) {
		x = (XDisplayWidth(fb_linux.display, fb_linux.screen) - fb_linux.w) >> 1;
		y = (XDisplayHeight(fb_linux.display, fb_linux.screen) - fb_linux.h) >> 1;
	}
	XMoveResizeWindow(fb_linux.display, fb_linux.window, x, y, fb_linux.w, fb_linux.h);
	attribs.override_redirect = ((fb_linux.flags & DRIVER_FULLSCREEN) ? True : False);
	XChangeWindowAttributes(fb_linux.display, fb_linux.window, CWOverrideRedirect, &attribs);
	XMapRaised(fb_linux.display, fb_linux.window);
	
	fb_linux.display_offset = 0;
	display_name = XDisplayName(NULL);
	if (((!display_name[0]) || (display_name[0] == ':') || (!strncmp(display_name, "unix:", 5))) &&
	    (XShmQueryExtension(fb_linux.display))) {
		if (fb_linux.flags & DRIVER_FULLSCREEN) {
			if (fb_hX11EnterFullscreen(fb_linux.h)) {
				fb_hX11LeaveFullscreen();
				if (!(h = calc_comp_height(fb_linux.h)))
					return -1;
				XResizeWindow(fb_linux.display, fb_linux.window, fb_linux.w, h);
				fb_linux.display_offset = (h - fb_linux.h) >> 1;
				if (fb_hX11EnterFullscreen(h)) {
					fb_hX11LeaveFullscreen();
					return -1;
				}
			}
		}
		is_shm = TRUE;
		image = XShmCreateImage(fb_linux.display, fb_linux.visual, XDefaultDepth(fb_linux.display, fb_linux.screen),
					ZPixmap, 0, &shm_info, fb_linux.w, fb_linux.h);
		if (image) {
			shm_info.shmid = shmget(IPC_PRIVATE, image->bytes_per_line * image->height, IPC_CREAT | 0777);
			shm_info.shmaddr = image->data = shmat(shm_info.shmid, 0, 0);
			shm_info.readOnly = False;
			if (!XShmAttach(fb_linux.display, &shm_info)) {
				shmdt(shm_info.shmaddr);
				shmctl(shm_info.shmid, IPC_RMID, 0);
				XDestroyImage(image);
				image = NULL;
			}
		}
	}
	else if (fb_linux.flags & DRIVER_FULLSCREEN)
		return -1;
	if (!image) {
		is_shm = FALSE;
		image = XCreateImage(fb_linux.display, fb_linux.visual, XDefaultDepth(fb_linux.display, fb_linux.screen),
				     ZPixmap, 0, NULL, fb_linux.w, fb_linux.h, 32, 0);
		image->data = malloc(image->bytes_per_line * image->height);
		if (!image->data) {
			XDestroyImage(image);
			image = NULL;
		}
	}
	if (!image)
		return -1;
	
	XSync(fb_linux.display, False);
	
	return 0;
}


/*:::::*/
static void x11_exit(void)
{
	if (fb_linux.flags & DRIVER_FULLSCREEN)
		fb_hX11LeaveFullscreen();
	XUnmapWindow(fb_linux.display, fb_linux.window);
	XSync(fb_linux.display, False);
	if (image) {
		if (is_shm) {
			XShmDetach(fb_linux.display, &shm_info);
			shmdt(shm_info.shmaddr);
			shmctl(shm_info.shmid, IPC_RMID, 0);
		}
		else
			free(image->data);
		XDestroyImage(image);
	}
}


/*:::::*/
static void x11_update(void)
{
	int i, y, h;
	
	blitter((unsigned char *)image->data, image->bytes_per_line);
	for (i = 0; i < fb_linux.h; i++) {
		if (fb_mode->dirty[i]) {
			for (y = i, h = 0; (fb_mode->dirty[i]) && (i < fb_linux.h); h++, i++)
				;
			if (is_shm)
				XShmPutImage(fb_linux.display, fb_linux.window, fb_linux.gc, image, 0, y, 0, y + fb_linux.display_offset, fb_linux.w, h, False);
			else
				XPutImage(fb_linux.display, fb_linux.window, fb_linux.gc, image, 0, y, 0, y + fb_linux.display_offset, fb_linux.w, h);
		}
	}
	fb_hMemSet(fb_mode->dirty, FALSE, fb_linux.h);
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
    int depth = MAX(8, depth_arg);
	if (flags & DRIVER_OPENGL)
		return -1;
	fb_hMemSet(&fb_linux, 0, sizeof(fb_linux));
	fb_linux.init = x11_init;
	fb_linux.exit = x11_exit;
	fb_linux.update = x11_update;
	
	return fb_hX11Init(title, w, h, depth, refresh_rate, flags);
}
