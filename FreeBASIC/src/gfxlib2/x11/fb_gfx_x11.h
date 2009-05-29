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
 * fb_gfx_x11.h -- common x11 internal definitions
 *
 * chng: feb/2005 written [lillo]
 *
 */

#ifdef WITH_X

#ifndef __FB_GFX_X11_H__
#define __FB_GFX_X11_H__

#include <pthread.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/xpm.h>
#include <X11/keysym.h>
#include <X11/cursorfont.h>
#include <X11/extensions/XShm.h>
#include <X11/extensions/Xrandr.h>
#include <X11/extensions/shape.h>

#define DOUBLE_CLICK_TIME		250

typedef struct X11DRIVER
{
	Display *display;
	Visual *visual;
	int screen;
	Window window;
	Window wmwindow;
	Window fswindow;
	GC gc;
	XRRScreenConfiguration *config;
	int w, h, depth, visual_depth, flags;
	int refresh_rate, display_offset;
	unsigned char keymap[256];
	int (*init)(void);
	void (*exit)(void);
	void (*update)(void);
	int mouse_clip;
} X11DRIVER;


extern X11DRIVER fb_x11;
extern GFXDRIVER fb_gfxDriverX11;
extern GFXDRIVER fb_gfxDriverOpenGL;

extern void *fb_program_icon;

extern void fb_hXlibInit(void);
extern int fb_hX11Init(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_hX11Exit(void);
extern void fb_hX11Lock(void);
extern void fb_hX11Unlock(void);
extern void fb_hX11SetPalette(int index, int r, int g, int b);
extern void fb_hX11WaitVSync(void);
extern int fb_hX11GetMouse(int *x, int *y, int *z, int *buttons, int *clip);
extern void fb_hX11SetMouse(int x, int y, int cursor, int clip);
extern void fb_hX11SetWindowTitle(char *title);
extern int fb_hX11SetWindowPos(int x, int y);
extern int *fb_hX11FetchModes(int depth, int *size);
extern int fb_hX11EnterFullscreen(int *h);
extern void fb_hX11LeaveFullscreen(void);
extern void fb_hX11InitWindow(int x, int y);
extern int fb_hX11ScreenInfo(int *width, int *height, int *depth, int *refresh);

#endif

#endif
