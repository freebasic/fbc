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
 * fb_gfx_linux.h -- common linux internal definitions
 *
 * chng: feb/2005 written [lillo]
 *
 */

#ifndef __FB_GFX_LINUX_H__
#define __FB_GFX_LINUX_H__

#include <pthread.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/xpm.h>
#include <X11/keysym.h>
#include <X11/cursorfont.h>
#include <X11/extensions/XShm.h>
#include <X11/extensions/xf86vmode.h>

typedef struct LINUXDRIVER
{
	Display *display;
	Visual *visual;
	int screen;
	Window window;
	GC gc;
	int w, h, depth, visual_depth, fullscreen, display_offset;
	unsigned char keymap[256];
	int (*init)(void);
	void (*exit)(void);
	void (*update)(void);
} LINUXDRIVER;


extern LINUXDRIVER fb_linux;
extern GFXDRIVER fb_gfxDriverX11;
extern GFXDRIVER fb_gfxDriverOpenGL;

extern void *fb_program_icon[];

extern int fb_hX11Init(char *title, int w, int h, int depth, int flags);
extern void fb_hX11Exit(void);
extern void fb_hX11Lock(void);
extern void fb_hX11Unlock(void);
extern void fb_hX11SetPalette(int index, int r, int g, int b);
extern void fb_hX11WaitVSync(void);
extern int fb_hX11GetMouse(int *x, int *y, int *z, int *buttons);
extern void fb_hX11SetMouse(int x, int y, int cursor);
extern void fb_hX11SetWindowTitle(char *title);
extern int fb_hX11EnterFullscreen(void);
extern void fb_hX11LeaveFullscreen(XF86VidModeModeInfo *old_mode);


#endif
