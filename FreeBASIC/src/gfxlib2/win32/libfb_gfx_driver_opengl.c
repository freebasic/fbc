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
 * opengl.c -- OpenGL gfx driver
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"
#include <GL/GL.h>


static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_flip(void);
static int opengl_window_init(void);
static void opengl_window_exit(void);

GFXDRIVER fb_gfxDriverOpenGL =
{
	"OpenGL",		/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	fb_hWin32Exit,		/* void (*exit)(void); */
	fb_hWin32Lock,		/* void (*lock)(void); */
	fb_hWin32Unlock,	/* void (*unlock)(void); */
	fb_hWin32SetPalette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_hWin32WaitVSync,	/* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_hWin32SetMouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	driver_flip		/* void (*flip)(void); */
};


typedef HGLRC (APIENTRY *WGLCREATECONTEXT)(HDC);
typedef BOOL (APIENTRY *WGLMAKECURRENT)(HDC, HGLRC);
typedef HGLRC (APIENTRY *WGLGETCURRENTCONTEXT)(VOID);
typedef BOOL (APIENTRY *WGLDELETECONTEXT)(HGLRC);

static WGLCREATECONTEXT fb_wglCreateContext;
static WGLMAKECURRENT fb_wglMakeCurrent;
static WGLGETCURRENTCONTEXT fb_wglGetCurrentContext;
static WGLDELETECONTEXT fb_wglDeleteContext;
static HMODULE library;
static HGLRC hglrc;
static HDC hdc;
static int gl_options;


/*:::::*/
static void opengl_paint(void)
{
}


/*:::::*/
static int opengl_init(void)
{
	DWORD style, ex_style;
	PIXELFORMATDESCRIPTOR pfd;
	int pf;
	
	library = (HMODULE)LoadLibrary("opengl32.dll");
	if (!library)
		return -1;

	fb_wglCreateContext = (WGLCREATECONTEXT)GetProcAddress(library, "wglCreateContext");
	fb_wglMakeCurrent = (WGLMAKECURRENT)GetProcAddress(library, "wglMakeCurrent");
	fb_wglGetCurrentContext = (WGLGETCURRENTCONTEXT)GetProcAddress(library, "wglGetCurrentContext");
	fb_wglDeleteContext = (WGLDELETECONTEXT)GetProcAddress(library, "wglDeleteContext");
	if ((!fb_wglCreateContext) || (!fb_wglMakeCurrent) || (!fb_wglGetCurrentContext) || (!fb_wglDeleteContext))
		return -1;
	
	fb_win32.wnd = CreateWindow(fb_win32.window_class, fb_win32.window_title,
				    0, 0, 0, 320, 200, NULL, NULL, fb_win32.hinstance, NULL);
	if (!fb_win32.wnd)
		return -1;
	
	fb_hMemSet(&pfd, 0, sizeof(PIXELFORMATDESCRIPTOR));
	pfd.nSize = sizeof(PIXELFORMATDESCRIPTOR);
	pfd.nVersion = 1;
	pfd.dwFlags = PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
	pfd.iPixelType = PFD_TYPE_RGBA;
	pfd.cColorBits = fb_win32.depth;
	pfd.cDepthBits = 32;
	if (gl_options & HAS_STENCIL_BUFFER)
		pfd.cStencilBits = 8;
	if (gl_options & HAS_ACCUMULATION_BUFFER)
		pfd.cAccumBits = 32;
	pfd.iLayerType = PFD_MAIN_PLANE;
	
	hdc = GetDC(fb_win32.wnd);
	pf = ChoosePixelFormat(hdc, &pfd);
	if ((!pf) || (!SetPixelFormat(hdc, pf, &pfd)))
		return -1;
	hglrc = fb_wglCreateContext(hdc);
	if (!hglrc)
		return -1;
	
	return opengl_window_init();
}


/*:::::*/
static void opengl_exit(void)
{
	if (library) {
		if (hglrc) {
			fb_wglMakeCurrent(NULL, NULL);
			fb_wglDeleteContext(hglrc);
		}
		if (hdc)
			ReleaseDC(fb_win32.wnd, hdc);
		if (fb_win32.fullscreen)
			ChangeDisplaySettings(NULL, 0);
		if (fb_win32.wnd)
			DestroyWindow(fb_win32.wnd);
		FreeLibrary(library);
	}
}


/*:::::*/
static int opengl_window_init(void)
{
	DEVMODE mode;
	DWORD style, ex_style;
	RECT rect;
	HWND root;
	int x, y;
	
	if (fb_win32.fullscreen) {
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
		ex_style = WS_EX_APPWINDOW;
		root = HWND_TOPMOST;
	}
	else {
		style = (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME) | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
		ex_style = WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;
		root = HWND_NOTOPMOST;
	}
	SetWindowLong(fb_win32.wnd, GWL_STYLE, style);
	SetWindowLong(fb_win32.wnd, GWL_EXSTYLE, ex_style);

	rect.left = rect.top = x = y = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;
	if (!fb_win32.fullscreen) {
		AdjustWindowRectEx(&rect, style, FALSE, ex_style);
		x = (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1;
		y = (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1;
	}
	SetWindowPos(fb_win32.wnd, root, x, y, rect.right - rect.left, rect.bottom - rect.top,
		     SWP_FRAMECHANGED | SWP_NOCOPYBITS | SWP_NOACTIVATE);
	ShowWindow(fb_win32.wnd, SW_SHOW);
	SetForegroundWindow(fb_win32.wnd);
	SetFocus(fb_win32.wnd);
	fb_mode->refresh_rate = GetDeviceCaps(hdc, VREFRESH);
	
	return 0;
}


/*:::::*/
static void opengl_window_exit(void)
{
	if (fb_win32.fullscreen)
		ChangeDisplaySettings(NULL, 0);
	ShowWindow(fb_win32.wnd, SW_HIDE);
}


/*:::::*/
static void opengl_thread(HANDLE running_event)
{
	MSG message;
	int i;
	unsigned char keystate[256];
	
	if (opengl_init())
		goto error;
	
	SetEvent(running_event);
	fb_win32.is_active = TRUE;
	
	while (fb_win32.is_running)
	{
		fb_hWin32Lock();
		
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
	opengl_exit();
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	int result;
	
	if (!(flags & DRIVER_OPENGL))
		return -1;
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));
	fb_win32.init = opengl_window_init;
	fb_win32.exit = opengl_window_exit;
	fb_win32.paint = opengl_paint;
	fb_win32.thread = opengl_thread;
	gl_options = flags & DRIVER_OPENGL_OPTIONS;
	
	result = fb_hWin32Init(title, w, h, depth, refresh_rate, flags);
	if (!result)
		fb_wglMakeCurrent(hdc, hglrc);
	
	return result;
}


/*:::::*/
static void driver_flip(void)
{
	SwapBuffers(hdc);
}
