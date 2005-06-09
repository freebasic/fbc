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
 * gdi.c -- GDI gfx driver
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"


static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);


GFXDRIVER fb_gfxDriverGDI =
{
	"GDI",			/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	fb_hWin32Exit,		/* void (*exit)(void); */
	fb_hWin32Lock,		/* void (*lock)(void); */
	fb_hWin32Unlock,	/* void (*unlock)(void); */
	fb_hWin32SetPalette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_hWin32WaitVSync,	/* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_hWin32SetMouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	NULL,			/* int *(*fetch_modes)(void); */
	NULL			/* void (*flip)(void); */
};


static BITMAPINFO *bitmap_info;
static HDC hdc;
static RECT rect;
static unsigned char *buffer;


/*:::::*/
static void gdi_paint(void)
{
	unsigned char *source = (fb_win32.blitter ? buffer : fb_mode->framebuffer);
	
	StretchDIBits(hdc, 0, 0, fb_win32.w, fb_win32.h, 0, 0, fb_win32.w, fb_win32.h,
	      source, bitmap_info, DIB_RGB_COLORS, SRCCOPY);
}


/*:::::*/
static int gdi_init(void)
{
	bitmap_info = NULL;
	buffer = NULL;
	
	if (fb_win32.fullscreen)
		return -1;
	
	rect.left = rect.top = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;
	AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME & ~WS_MAXIMIZEBOX, 0);
	rect.right -= rect.left;
	rect.bottom -= rect.top;
	fb_win32.wnd = CreateWindow(fb_win32.window_class, fb_win32.window_title,
			   (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME & ~WS_MAXIMIZEBOX) | WS_VISIBLE,
			   (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1,
			   (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1,
			   rect.right, rect.bottom, NULL, NULL, fb_win32.hinstance, NULL);
	if (!fb_win32.wnd)
		return -1;
	
	bitmap_info = (BITMAPINFO *)calloc(1, sizeof(BITMAPINFO) + (sizeof(RGBQUAD) * 256));
	if (!bitmap_info)
		return -1;
	bitmap_info->bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bitmap_info->bmiHeader.biBitCount = fb_win32.depth;
	bitmap_info->bmiHeader.biPlanes = 1;
	bitmap_info->bmiHeader.biWidth = fb_win32.w;
	bitmap_info->bmiHeader.biHeight = -fb_win32.h;
	bitmap_info->bmiHeader.biClrUsed = 256;
	bitmap_info->bmiHeader.biCompression = BI_RGB;
	
	if (fb_win32.depth == 16) {
		fb_win32.blitter = fb_hGetBlitter(15, FALSE);
		if (!fb_win32.blitter)
			return -1;
		buffer = malloc(((fb_win32.w + 1) & ~1) * fb_win32.h * 2);
		if (!buffer)
			return -1;
	}
	
	SetForegroundWindow(fb_win32.wnd);
	hdc = GetDC(fb_win32.wnd);
	fb_mode->refresh_rate = GetDeviceCaps(hdc, VREFRESH);
	
	return 0;
}


/*:::::*/
static void gdi_exit(void)
{
	if (buffer)
		free(buffer);
	if (bitmap_info)
		free(bitmap_info);
	if (hdc)
		ReleaseDC(fb_win32.wnd, hdc);
	if (fb_win32.wnd)
		DestroyWindow(fb_win32.wnd);
}


/*:::::*/
static void gdi_thread(HANDLE running_event)
{
	MSG message;
	int i, y1, y2, h;
	unsigned char *source, keystate[256];
	
	if (gdi_init())
		goto error;
	
	SetEvent(running_event);
	fb_win32.is_active = TRUE;
	
	while (fb_win32.is_running)
	{
		fb_hWin32Lock();
		
		if (fb_win32.is_palette_changed) {
			/* Can't use fb_hMemCpy as structure layout is different :( */
			for (i = 0; i < 256; i++) {
				bitmap_info->bmiColors[i].rgbRed = fb_win32.palette[i].peRed;
				bitmap_info->bmiColors[i].rgbGreen = fb_win32.palette[i].peGreen;
				bitmap_info->bmiColors[i].rgbBlue = fb_win32.palette[i].peBlue;
			}
			fb_win32.is_palette_changed = FALSE;
		}
		if (fb_win32.blitter) {
			fb_win32.blitter(buffer, (fb_mode->pitch + 3) & ~3);
			source = buffer;
		}
		else
			source = fb_mode->framebuffer;
		/* Only do a single StretchDIBits call per frame */
		for (y1 = 0; y1 < fb_win32.h; y1++) {
			if (fb_mode->dirty[y1]) {
				for (y2 = fb_win32.h - 1; !fb_mode->dirty[y2]; y2--)
					;
				h = y2 - y1 + 1;
				y1 = fb_win32.h - y1 - h;
				StretchDIBits(hdc, 0, y1, fb_win32.w, h, 0, y1, fb_win32.w, h,
					      source, bitmap_info, DIB_RGB_COLORS, SRCCOPY);
				break;
			}
		}
		fb_hMemSet(fb_mode->dirty, FALSE, fb_win32.h);
		
		GetKeyboardState(keystate);
		for (i = 0; fb_keytable[i][0]; i++) {
			if (fb_keytable[i][2])
				fb_mode->key[fb_keytable[i][0]] = ((keystate[fb_keytable[i][1]] & 0x80) |
								   (keystate[fb_keytable[i][2]] & 0x80)) ? TRUE : FALSE;
			else
				fb_mode->key[fb_keytable[i][0]] = (keystate[fb_keytable[i][1]] & 0x80) ? TRUE : FALSE;
		}
		
		while (PeekMessage(&message, fb_win32.wnd, 0, 0, PM_REMOVE)) {
			TranslateMessage(&message);
			DispatchMessage(&message);
		}
		
		fb_hWin32Unlock();
		
		Sleep(1000 / 60);
		SetEvent(fb_win32.vsync_event);
	}
	
error:
	gdi_exit();
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));
	
	if (flags & DRIVER_OPENGL)
		return -1;
	fb_win32.init = gdi_init;
	fb_win32.exit = gdi_exit;
	fb_win32.paint = gdi_paint;
	fb_win32.thread = gdi_thread;
	
	return fb_hWin32Init(title, w, h, depth, refresh_rate, flags);
}
