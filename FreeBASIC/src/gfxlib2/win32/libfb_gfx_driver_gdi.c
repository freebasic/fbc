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

#define SCREENLIST(w, h) ((h) | (w) << 16)


static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static int *driver_fetch_modes(int depth, int *size);


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
	fb_hWin32SetWindowPos,	/* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,	/* int *(*fetch_modes)(int depth, int *size); */
	NULL			/* void (*flip)(void); */
};


static BITMAPINFO *bitmap_info;
static unsigned char *buffer;

typedef BOOL (WINAPI *SETLAYEREDWINDOWATTRIBUTES)(HWND hWnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
static SETLAYEREDWINDOWATTRIBUTES SetLayeredWindowAttributes;


/*:::::*/
static void alpha_remover_blitter(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = fb_mode->framebuffer;
	unsigned int c;
	char *dirty = fb_mode->dirty;
	int x, y;
	
	for (y = fb_mode->h * fb_mode->scanline_size; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = fb_mode->w; x; x--) {
				c = *s++;
				*d++ = c & ~MASK_A_32;
			}
		}
		src += fb_mode->pitch;
		dest += pitch;
	}
}


/*:::::*/
static void gdi_paint(void)
{
	memset(fb_mode->dirty, TRUE, fb_mode->h);
}


/*:::::*/
static int gdi_init(void)
{
	DEVMODE mode;
	DWORD style, ex_style = 0;
	HDC hdc;
	RECT rect;
	HMODULE module;
	int x, y;

	bitmap_info = NULL;
	buffer = NULL;
	
	if (fb_win32.flags & DRIVER_FULLSCREEN) {
		fb_hMemSet(&mode, 0, sizeof(mode));
		mode.dmSize = sizeof(mode);
		mode.dmPelsWidth = fb_win32.w;
		mode.dmPelsHeight = fb_win32.h;
		mode.dmBitsPerPel = fb_win32.depth;
		mode.dmDisplayFrequency = fb_win32.refresh_rate;
		mode.dmFields = DM_BITSPERPEL | DM_PELSWIDTH | DM_PELSHEIGHT;
		if (ChangeDisplaySettings(&mode, CDS_FULLSCREEN) != DISP_CHANGE_SUCCESSFUL)
			return -1;
		style = WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	}
	else {
		style = WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME;
		if (fb_win32.flags & DRIVER_NO_SWITCH)
			style &= ~WS_MAXIMIZEBOX;
		if (fb_win32.flags & DRIVER_NO_FRAME)
			style = WS_POPUP;
		if (fb_win32.flags & DRIVER_SHAPED_WINDOW) {
			if (fb_win32.version < 0x500)
				return -1;
			ex_style = WS_EX_LAYERED;
		}
	}
	
	rect.left = rect.top = x = y = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;
	if (!(fb_win32.flags & DRIVER_FULLSCREEN)) {
		AdjustWindowRect(&rect, style, 0);
		rect.right -= rect.left;
		rect.bottom -= rect.top;
		x = (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1;
		y = (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1;
	}
	fb_win32.wnd = CreateWindowEx(ex_style, fb_win32.window_class, fb_win32.window_title, style | WS_VISIBLE,
			   x, y, rect.right, rect.bottom, NULL, NULL, fb_win32.hinstance, NULL);
	if (!fb_win32.wnd)
		return -1;
	if (fb_win32.flags & DRIVER_SHAPED_WINDOW) {
		if (!(module = GetModuleHandle("user32.dll")))
			return -1;
		SetLayeredWindowAttributes = (SETLAYEREDWINDOWATTRIBUTES)GetProcAddress(module, "SetLayeredWindowAttributes");
		if (!SetLayeredWindowAttributes)
			return -1;
		SetLayeredWindowAttributes(fb_win32.wnd, (fb_win32.depth > 8) ? RGB(255, 0, 255) : 0, 0, LWA_COLORKEY);
	}
	
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

	if (fb_win32.depth >= 16) {
		if (fb_win32.depth == 16) {
			fb_win32.blitter = fb_hGetBlitter(15, FALSE);
			if (!fb_win32.blitter)
				return -1;
		}
		if (fb_win32.flags & DRIVER_SHAPED_WINDOW)
			fb_win32.blitter = alpha_remover_blitter;
		buffer = malloc(((fb_win32.w + 3) & ~3) * fb_win32.h * fb_mode->bpp);
		if (!buffer)
			return -1;
	}

	SetForegroundWindow(fb_win32.wnd);
	hdc = GetDC(fb_win32.wnd);
	fb_mode->refresh_rate = GetDeviceCaps(hdc, VREFRESH);
	ReleaseDC(fb_win32.wnd, hdc);

	return 0;
}


/*:::::*/
static void gdi_exit(void)
{
	if (buffer)
		free(buffer);
	if (bitmap_info)
		free(bitmap_info);
	if (fb_win32.wnd) {
		if (fb_win32.flags & DRIVER_FULLSCREEN)
			ChangeDisplaySettings(NULL, 0);
		DestroyWindow(fb_win32.wnd);
	}
}


/*:::::*/
static void gdi_thread(HANDLE running_event)
{
	int i, y1, y2, h;
	unsigned char *source, keystate[256];
	HDC hdc;
	RECT rect;

	if (gdi_init())
		goto error;

	SetEvent(running_event);
	fb_win32.is_active = TRUE;
	
	rect.left = 0;
	rect.right = fb_win32.w;

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
		/* Only do a single SetDIBitsToDevice call per frame */
		hdc = GetDC(fb_win32.wnd);
		for (y1 = 0; y1 < fb_win32.h; y1++) {
			if (fb_mode->dirty[y1]) {
				for (y2 = fb_win32.h - 1; !fb_mode->dirty[y2]; y2--)
					;
				h = y2 - y1 + 1;
				if (fb_win32.blitter) {
					fb_win32.blitter(buffer, (fb_mode->pitch + 3) & ~3);
					source = buffer + (y1 * ((fb_mode->pitch + 3) & ~0x3));
				}
				else
				{
					source = fb_mode->framebuffer + (y1 * fb_mode->pitch);
				}

				SetDIBitsToDevice(hdc, 0, y1, fb_win32.w, h, 0, 0, 0, h, source, bitmap_info, DIB_RGB_COLORS);
				
				if (fb_win32.version < 0x500) {
					rect.top = y1;
					rect.bottom = h;
					InvalidateRect(fb_win32.wnd, &rect, FALSE);
				}
				
				break;
			}
		}
		ReleaseDC(fb_win32.wnd, hdc);

		fb_hMemSet(fb_mode->dirty, FALSE, fb_win32.h);

        if( fb_win32.is_active ) {
            GetKeyboardState(keystate);
            for (i = 0; __fb_keytable[i][0]; i++) {
                if (__fb_keytable[i][2])
                    fb_mode->key[__fb_keytable[i][0]] = ((keystate[__fb_keytable[i][1]] & 0x80) |
                                                       (keystate[__fb_keytable[i][2]] & 0x80)) ? TRUE : FALSE;
                else
                    fb_mode->key[__fb_keytable[i][0]] = (keystate[__fb_keytable[i][1]] & 0x80) ? TRUE : FALSE;
            }
        }

		fb_hHandleMessages();

		fb_hWin32Unlock();

		Sleep(10);
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

	return fb_hWin32Init(title, w, h, MAX(8, depth), refresh_rate, flags);
}

/*:::::*/
static int *driver_fetch_modes(int depth, int *size)
{
	int *data = NULL, *newdata;
	int mode = 0;
	int count = 0;
	DEVMODE dm;
	
	while (EnumDisplaySettings(NULL, mode, &dm)) {
		if ((dm.dmBitsPerPel == depth) ||
		    (dm.dmBitsPerPel == 15 && depth == 16) ||
		    (dm.dmBitsPerPel == 16 && depth == 15) ||
		    (dm.dmBitsPerPel == 24 && depth == 32) ||
		    (dm.dmBitsPerPel == 32 && depth == 24)) {
			++count;
			newdata = realloc(data, count * sizeof(int));
			if (!newdata) {
				*size = count - 1;
				return data;
			}
			data = newdata;
			data[count - 1] = SCREENLIST(dm.dmPelsWidth, dm.dmPelsHeight);
		}
		++mode;
	}
	
	*size = count;
	return data;
}
