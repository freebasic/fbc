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
 * ddraw.c -- DirectDraw gfx driver
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"

#define INITGUID
#include <objbase.h>
#include <ddraw.h>
#include <dinput.h>


static int driver_init(char *title, int w, int h, int depth, int flags);


GFXDRIVER fb_gfxDriverDirectDraw =
{
	"DirectX",		/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	fb_hWin32Exit,		/* void (*exit)(void); */
	fb_hWin32Lock,		/* void (*lock)(void); */
	fb_hWin32Unlock,	/* void (*unlock)(void); */
	fb_hWin32SetPalette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_hWin32WaitVSync,	/* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_hWin32SetWindowTitle	/* void (*set_window_title)(char *title); */
};


/* We don't want to directly link with DDRAW.DLL and DINPUT.DLL,
 * as this way generated exes will not depend on them to run.
 * This will ensure if DirectX is not installed in the system,
 * the programs will still run, maybe fallbacking on a GDI
 * driver.
 */
typedef HRESULT (WINAPI *DIRECTDRAWCREATE)(GUID FAR *lpGUID,LPDIRECTDRAW FAR *lplpDD,IUnknown FAR *pUnkOuter);
typedef HRESULT (WINAPI *DIRECTINPUTCREATE)(HINSTANCE hinst,DWORD dwVersion,LPDIRECTINPUT *lplpDI,LPUNKNOWN pUnkOuter);

/* Unfortunately c_dfDIKeyboard is a required global variable
 * defined in import library LIBDINPUT.A, and as we're not
 * linking with it, we need to define it here...
 */
static DIOBJECTDATAFORMAT c_rgodfDIKeyboard[256];
static const DIDATAFORMAT c_dfDIKeyboard = { 24, 16, 0x2, 256, 256, c_rgodfDIKeyboard };
static HMODULE dd_library;
static HMODULE di_library;
static LPDIRECTDRAW lpDD;
static LPDIRECTDRAWSURFACE lpDDS;
static LPDIRECTDRAWSURFACE lpDDS_back;
static LPDIRECTDRAWPALETTE lpDDP;
static LPDIRECTINPUT lpDI;
static LPDIRECTINPUTDEVICE lpDID;
static RECT rect;
static int display_offset;


/*:::::*/
static void directx_paint(void)
{
	RECT src, dest;
	POINT point;

	if (fb_win32.fullscreen)
		return;

	src.left = src.top = 0;
	src.right = fb_win32.w;
	src.bottom = fb_win32.h;
	point.x = point.y = 0;
	ClientToScreen(fb_win32.wnd, &point);
	GetClientRect(fb_win32.wnd, &dest);
	dest.left += point.x;
	dest.top += point.y;
	dest.right += point.x;
	dest.bottom += point.y;
	IDirectDrawSurface_Blt(lpDDS, &dest, lpDDS_back, &src, DDBLT_WAIT, NULL);
}

/*:::::*/
static int calc_comp_height( int h )
{
	if( h < 240 )
		return 240;
	else if( h < 480 )
		return 480;
	else if( h < 600 )
		return 480;
	else if( h < 768 )
		return 768;
	else if( h < 1024 )
		return 1024;
	else
		return 0;
}

/*:::::*/
static int directx_init(void)
{
	WNDCLASS wndclass;
	LPDIRECTDRAWCLIPPER lpDDC = NULL;
	DIRECTDRAWCREATE DirectDrawCreate;
	DIRECTINPUTCREATE DirectInputCreate;
	DDSURFACEDESC desc;
	DDPIXELFORMAT format;
	int i, depth, is_rgb = FALSE, height;

	lpDD = NULL;
	lpDDS = NULL;
	lpDDS_back = NULL;
	lpDDP = NULL;
	lpDI = NULL;
	lpDID = NULL;

	dd_library = (HMODULE)LoadLibrary("ddraw.dll");
	if (!dd_library)
		return -1;
	di_library = (HMODULE)LoadLibrary("dinput.dll");
	if (!di_library)
		return -1;

	DirectDrawCreate = (DIRECTDRAWCREATE)GetProcAddress(dd_library, "DirectDrawCreate");
	DirectInputCreate = (DIRECTINPUTCREATE)GetProcAddress(di_library, "DirectInputCreateA");
	
	if ((!DirectDrawCreate) || (DirectDrawCreate(NULL, &lpDD, NULL) != DD_OK))
		return -1;
	if ((!DirectInputCreate) || (DirectInputCreate(fb_win32.hinstance, 0x0300, &lpDI, NULL) != DI_OK))
		return -1;

	fb_hMemSet(&wndclass, 0, sizeof(wndclass));
	wndclass.lpfnWndProc = fb_hWin32WinProc;
	wndclass.lpszClassName = fb_win32.window_class;
	wndclass.hInstance = fb_win32.hinstance;

	rect.left = rect.top = 0;
	rect.right = fb_win32.w - 1;
	rect.bottom = fb_win32.h - 1;

	if (fb_win32.fullscreen) {
		RegisterClass(&wndclass);
		fb_win32.wnd = CreateWindow(fb_win32.window_class, fb_win32.window_title, WS_POPUP | WS_VISIBLE, 0, 0,
				   GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN), NULL, NULL, 0, NULL);
		if (!fb_win32.wnd)
			return -1;
		if (IDirectDraw_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_ALLOWREBOOT | DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE) != DD_OK)
			return -1;

		height = fb_win32.h;
		while( 1 )
		{
			if (IDirectDraw_SetDisplayMode(lpDD, fb_win32.w, height, fb_win32.depth) == DD_OK)
				break;

			depth = fb_win32.depth;
			switch (fb_win32.depth)
			{
				case 15: depth = 16; break;
				case 16: depth = 15; break;
				case 24: depth = 32; break;
				case 32: depth = 24; break;
			}

			if ((depth == fb_win32.depth) || (IDirectDraw_SetDisplayMode(lpDD, fb_win32.w, height, depth) != DD_OK))
			{
				height = calc_comp_height( height );
				if( height == 0 )
					return -1;
			}
			else
				break;
		}
		display_offset = ((height - fb_win32.h) >> 1);
	}
	else {
		wndclass.style = CS_VREDRAW | CS_HREDRAW;
		wndclass.hCursor = LoadCursor(0, IDC_ARROW);
		RegisterClass(&wndclass);
		AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, 0);
		rect.right -= (rect.left + 1);
		rect.bottom -= (rect.top + 1);
		fb_win32.wnd = CreateWindow(fb_win32.window_class, fb_win32.window_title,
				   (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME) | WS_VISIBLE,
				   (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1,
				   (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1,
				   rect.right, rect.bottom, 0, 0, 0, 0);
		if (!fb_win32.wnd)
			return -1;
		if (IDirectDraw_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_NORMAL) != DD_OK)
			return -1;
		if (IDirectDraw_CreateClipper(lpDD, 0, &lpDDC, NULL) != DD_OK)
			return -1;
		if (IDirectDrawClipper_SetHWnd(lpDDC, 0, fb_win32.wnd) != DD_OK)
			return -1;
		display_offset = 0;
	}
	desc.dwSize = sizeof(desc);
	desc.dwFlags = DDSD_CAPS;
	desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	if (IDirectDraw_CreateSurface(lpDD, &desc, &lpDDS, NULL) != DD_OK)
		return -1;

	if (!fb_win32.fullscreen) {
		if (IDirectDrawSurface_SetClipper(lpDDS, lpDDC) != DD_OK)
			return -1;
		desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
		desc.dwWidth = fb_win32.w;
		desc.dwHeight = fb_win32.h;
		desc.ddsCaps.dwCaps = DDSCAPS_VIDEOMEMORY;
		if (IDirectDraw_CreateSurface(lpDD, &desc, &lpDDS_back, 0) != DD_OK)
			return -1;
	}
	else
		lpDDS_back = lpDDS;

	format.dwSize = sizeof(format);
	if (IDirectDrawSurface_GetPixelFormat(lpDDS, &format) != DD_OK)
		return -1;
	if (!(format.dwFlags & DDPF_RGB))
		return -1;

	if (format.dwRGBBitCount == 8) {
		if (IDirectDraw_CreatePalette(lpDD, DDPCAPS_8BIT | DDPCAPS_INITIALIZE | DDPCAPS_ALLOW256,
					      fb_win32.palette, &lpDDP, NULL) != DD_OK)
			return -1;
		IDirectDrawSurface_SetPalette(lpDDS, lpDDP);
		fb_win32.is_palette_changed = FALSE;
	}

	depth = format.dwRGBBitCount;
	if ((format.dwRGBBitCount == 16) && (format.dwGBitMask == 0x03E0))
		depth = 15;
	if ((format.dwRGBBitCount >= 24) && (format.dwRBitMask == 0xFF))
		is_rgb = TRUE;
	else if ((format.dwRGBBitCount >= 16) && (format.dwRBitMask == 0x1F))
		is_rgb = TRUE;
	fb_win32.blitter = fb_hGetBlitter(depth, is_rgb);
	if (!fb_win32.blitter)
		return -1;

	SetForegroundWindow(fb_win32.wnd);
	
	for (i = 0; i < 256; i++) {
		c_rgodfDIKeyboard[i].pguid = &GUID_Key;
		c_rgodfDIKeyboard[i].dwOfs = i;
		c_rgodfDIKeyboard[i].dwType = 0x8000000C | (i << 8);
		c_rgodfDIKeyboard[i].dwFlags = 0;
	}
	if (IDirectInput_CreateDevice(lpDI, &GUID_SysKeyboard, &lpDID, NULL) != DI_OK)
		return -1;
	if (IDirectInputDevice_SetDataFormat(lpDID, &c_dfDIKeyboard) != DI_OK)
		return -1;
	if (IDirectInputDevice_Acquire(lpDID) != DI_OK)
		return -1;
	
	return 0;
}


/*:::::*/
static void directx_exit(void)
{
	DDBLTFX bltfx;
	
	if (lpDI) {
		if (lpDID) {
			IDirectInputDevice_Unacquire(lpDID);
			IDirectInputDevice_Release(lpDID);
		}
		IDirectInput_Release(lpDI);
	}
	
	if (lpDD) {
		if (fb_win32.fullscreen && lpDDS) {
			bltfx.dwSize = sizeof(bltfx);
			bltfx.dwDDFX = 0;
			bltfx.dwFillColor = 0;
			IDirectDrawSurface_Blt(lpDDS, &rect, NULL, NULL, DDBLT_COLORFILL, &bltfx);
		}
		if (lpDDS)
			IDirectDrawSurface_Release(lpDDS);
		if ((!fb_win32.fullscreen) && (lpDDS_back))
			IDirectDrawSurface_Release(lpDDS_back);
		if (fb_win32.fullscreen)
			IDirectDraw_RestoreDisplayMode(lpDD);
		if (fb_win32.fullscreen)
			IDirectDraw_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_NORMAL);
		IDirectDraw_Release(lpDD);
	}
	if (fb_win32.wnd)
		DestroyWindow(fb_win32.wnd);
	if (dd_library)
		FreeLibrary(dd_library);
	if (di_library)
		FreeLibrary(di_library);
}


/*:::::*/
static void directx_thread(HANDLE running_event)
{
	DDSURFACEDESC desc;
	MSG message;
	HRESULT result;
	unsigned char keystate[256];
	int i;

	if (directx_init())
		goto error;

	SetEvent(running_event);
	fb_win32.is_active = TRUE;

	while (fb_win32.is_running)
	{
		fb_hWin32Lock();

		if ((fb_win32.is_active) || (!fb_win32.fullscreen)) {
			IDirectDrawSurface_Restore(lpDDS);
			if (!fb_win32.fullscreen)
				IDirectDrawSurface_Restore(lpDDS_back);

			if (fb_win32.is_palette_changed && lpDDP) {
				IDirectDrawPalette_SetEntries(lpDDP, 0, 0, 256, fb_win32.palette);
				fb_win32.is_palette_changed = FALSE;
			}
			desc.dwSize = sizeof(desc);
			if (IDirectDrawSurface_Lock(lpDDS_back, NULL, &desc, DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR, NULL) == DD_OK) {
				fb_win32.blitter((unsigned char *)desc.lpSurface + display_offset * desc.lPitch, desc.lPitch);
				IDirectDrawSurface_Unlock(lpDDS_back, desc.lpSurface);
				fb_hMemSet(fb_mode->dirty, FALSE, fb_win32.h);
			}

			directx_paint();
		}

		result = IDirectInputDevice_GetDeviceState(lpDID, 256, keystate);
		if ((result == DIERR_NOTACQUIRED) || (result == DIERR_INPUTLOST))
			IDirectInputDevice_Acquire(lpDID);
		else {
			/* Simplicistic way to deal with extended scancodes */
			for (i = 0; i < 128; i++)
				fb_mode->key[i] = ((keystate[i] | keystate[i + 128]) & 0x80) ? TRUE : FALSE;
		}
		
		while (PeekMessage(&message, fb_win32.wnd, 0, 0, PM_REMOVE)) {
			TranslateMessage(&message);
			DispatchMessage(&message);
		}

		fb_hWin32Unlock();

		Sleep(10);
		IDirectDraw_WaitForVerticalBlank(lpDD, DDWAITVB_BLOCKBEGIN, 0);
		SetEvent(fb_win32.vsync_event);
	}

error:
	directx_exit();
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int flags)
{
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));
	fb_win32.init = directx_init;
	fb_win32.exit = directx_exit;
	fb_win32.paint = directx_paint;
	fb_win32.thread = directx_thread;
	fb_hWin32Init(title, w, h, depth, flags);
}
