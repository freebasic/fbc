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
 * fb_gfx_win32.h -- common win32 internal definitions
 *
 * chng: feb/2005 written [lillo]
 *
 */

#ifndef __FB_GFX_WIN32_H__
#define __FB_GFX_WIN32_H__

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#define WINDOW_CLASS_PREFIX "fbgfxclass_"


typedef struct WIN32DRIVER
{
	int version;
	HINSTANCE hinstance;
	WNDCLASS wndclass;
	HWND wnd;
	PALETTEENTRY palette[256];
	BLITTER *blitter;
	int is_running, is_palette_changed, is_active;
	int w, h, depth, fullscreen, refresh_rate;
	char *window_title;
	char window_class[WINDOW_TITLE_SIZE+sizeof( WINDOW_CLASS_PREFIX )];
	int (*init)(void);
	void (*exit)(void);
	void (*paint)(void);
	void (*thread)(HANDLE running_event);
} WIN32DRIVER;


extern WIN32DRIVER fb_win32;
extern GFXDRIVER fb_gfxDriverDirectDraw;
extern GFXDRIVER fb_gfxDriverGDI;
extern GFXDRIVER fb_gfxDriverOpenGL;


extern LRESULT CALLBACK fb_hWin32WinProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
extern void fb_hHandleMessages(void);
extern int fb_hWin32Init(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_hWin32Exit(void);
extern void fb_hWin32Lock(void);
extern void fb_hWin32Unlock(void);
extern void fb_hWin32SetPalette(int index, int r, int g, int b);
extern void fb_hWin32WaitVSync(void);
extern int fb_hWin32GetMouse(int *x, int *y, int *z, int *buttons);
extern void fb_hWin32SetMouse(int x, int y, int cursor);
extern void fb_hWin32SetWindowTitle(char *title);


#endif
