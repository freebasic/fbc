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

#define WIN32_LEAN_AND_MEAN
#include <ddraw.h>

#include "fb_gfx.h"


#define KEY_BUFFER_LEN		16

#define WINDOW_CLASS_PREFIX "fbgfxclass_"

static int ddraw_init(char *title, int w, int h, int depth, int flags);
static void ddraw_exit(void);
static void ddraw_lock(void);
static void ddraw_unlock(void);
static void ddraw_set_palette(int index, int r, int g, int b);
static void ddraw_wait_vsync(void);
static int ddraw_get_key(int wait);
static void ddraw_set_window_title(char *title);



GFXDRIVER fb_gfxDriverDirectDraw =
{
	ddraw_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	ddraw_exit,		/* void (*exit)(void); */
	ddraw_lock,		/* void (*lock)(void); */
	ddraw_unlock,		/* void (*unlock)(void); */
	ddraw_set_palette,	/* void (*set_palette)(int index, int r, int g, int b); */
	ddraw_wait_vsync,	/* void (*wait_vsync)(void); */
	ddraw_get_key,		/* int (*get_key)(int wait); */
	ddraw_set_window_title	/* void (*set_window_title)(char *title); */
};


typedef HRESULT (WINAPI *DIRECTDRAWCREATE)(GUID FAR *lpGUID,LPDIRECTDRAW FAR *lplpDD,IUnknown FAR *pUnkOuter);

static LRESULT CALLBACK win_proc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);


static HMODULE library = 0;
static LPDIRECTDRAW lpDD = NULL;
static LPDIRECTDRAWSURFACE lpDDS = NULL;
static LPDIRECTDRAWSURFACE lpDDS_back = NULL;
static LPDIRECTDRAWPALETTE lpDDP = NULL;
static PALETTEENTRY palette[256];
static BLITTER *blitter;
static short key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;
static HWND wnd;
static RECT rect;
static HANDLE handle = NULL;
static CRITICAL_SECTION update_lock;
static int is_running, is_palette_changed, is_active;
static int mode_w, mode_h, mode_depth, mode_fullscreen;
static char *window_title;
static char window_class[WINDOW_TITLE_SIZE+sizeof( WINDOW_CLASS_PREFIX )] = { 0 };
static int display_offset;
static BOOL screensaver_active;


/*:::::*/
static void update_screen()
{
	RECT src, dest;
	POINT point;

	if (mode_fullscreen)
		return;

	src.left = src.top = 0;
	src.right = mode_w;
	src.bottom = mode_h;
	point.x = point.y = 0;
	ClientToScreen(wnd, &point);
	GetClientRect(wnd, &dest);
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
static int private_init()
{
	WNDCLASS wndclass;
	LPDIRECTDRAWCLIPPER lpDDC = NULL;
	DIRECTDRAWCREATE DirectDrawCreate;
	DDSURFACEDESC desc;
	DDPIXELFORMAT format;
	int depth, is_rgb = FALSE, height;

	lpDD = NULL;
	lpDDS = NULL;
	lpDDS_back = NULL;
	lpDDP = NULL;

	library = (HMODULE)LoadLibrary("ddraw.dll");
	if (!library)
		return -1;

	DirectDrawCreate = (DIRECTDRAWCREATE)GetProcAddress(library, "DirectDrawCreate");
	if (DirectDrawCreate(NULL, &lpDD, NULL) != DD_OK)
		return -1;

	fb_hMemSet(&wndclass, 0, sizeof(wndclass));
	wndclass.lpfnWndProc = win_proc;
	wndclass.lpszClassName = window_class;

	rect.left = rect.top = 0;
	rect.right = mode_w;
	rect.bottom = mode_h;

	if (mode_fullscreen) {
		RegisterClass(&wndclass);
		wnd = CreateWindow(window_class, window_title, WS_POPUP | WS_VISIBLE, 0, 0,
				   GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN), NULL, NULL, 0, NULL);
		if (IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_ALLOWREBOOT | DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE) != DD_OK)
			return -1;

		height = mode_h;
		while( 1 )
		{
			if (IDirectDraw_SetDisplayMode(lpDD, mode_w, height, mode_depth) == DD_OK)
				break;

			depth = mode_depth;
			switch (mode_depth)
			{
				case 15: depth = 16; break;
				case 16: depth = 15; break;
				case 24: depth = 32; break;
				case 32: depth = 24; break;
			}

			if ((depth == mode_depth) || (IDirectDraw_SetDisplayMode(lpDD, mode_w, height, depth) != DD_OK))
			{
				height = calc_comp_height( height );
				if( height == 0 )
					return -1;
			}
			else
				break;
		}
		display_offset = ((height - mode_h) >> 1);
	}
	else {
		wndclass.style = CS_VREDRAW | CS_HREDRAW;
		wndclass.hCursor = LoadCursor(0, IDC_ARROW);
		RegisterClass(&wndclass);
		AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, 0);
		rect.right -= rect.left;
		rect.bottom -= rect.top;
		wnd = CreateWindow(window_class, window_title, (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME) | WS_VISIBLE,
				   (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1,
				   (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1,
				   rect.right, rect.bottom, 0, 0, 0, 0);
		if ( wnd == 0 )
			return -1;
		if (IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_NORMAL) != DD_OK)
			return -1;
		if (IDirectDraw_CreateClipper(lpDD, 0, &lpDDC, NULL) != DD_OK)
			return -1;
		if (IDirectDrawClipper_SetHWnd(lpDDC, 0, wnd) != DD_OK)
			return -1;
		display_offset = 0;
	}
	desc.dwSize = sizeof(desc);
	desc.dwFlags = DDSD_CAPS;
	desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	if (IDirectDraw_CreateSurface(lpDD, &desc, &lpDDS, NULL) != DD_OK)
		return -1;

	if (!mode_fullscreen) {
		if (IDirectDrawSurface_SetClipper(lpDDS, lpDDC) != DD_OK)
			return -1;
		desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
		desc.dwWidth = mode_w;
		desc.dwHeight = mode_h;
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
					      palette, &lpDDP, NULL) != DD_OK)
			return -1;
		IDirectDrawSurface_SetPalette(lpDDS, lpDDP);
		is_palette_changed = FALSE;
	}

	depth = format.dwRGBBitCount;
	if ((format.dwRGBBitCount == 16) && (format.dwGBitMask == 0x03E0))
		depth = 15;
	if ((format.dwRGBBitCount >= 24) && (format.dwRBitMask == 0xFF))
		is_rgb = TRUE;
	else if ((format.dwRGBBitCount >= 16) && (format.dwRBitMask == 0x1F))
		is_rgb = TRUE;
	blitter = fb_hGetBlitter(depth, is_rgb);
	if (!blitter)
		return -1;

	SetForegroundWindow(wnd);

	return 0;
}


/*:::::*/
static void private_exit()
{
	DDBLTFX bltfx;

	if (lpDD) {
		if (mode_fullscreen && lpDDS) {
			bltfx.dwSize = sizeof(bltfx);
			bltfx.dwDDFX = 0;
			bltfx.dwFillColor = 0;
			IDirectDrawSurface_Blt(lpDDS, &rect, NULL, NULL, DDBLT_COLORFILL, &bltfx);
		}
		if (lpDDS)
			IDirectDrawSurface_Release(lpDDS);
		if ((!mode_fullscreen) && (lpDDS_back))
			IDirectDrawSurface_Release(lpDDS_back);
		if (mode_fullscreen)
			IDirectDraw_RestoreDisplayMode(lpDD);
		if (mode_fullscreen)
			IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_NORMAL);
		IDirectDraw_Release(lpDD);
	}
	if (wnd)
		DestroyWindow(wnd);
	if (library)
		FreeLibrary(library);
}


/*:::::*/
static LRESULT CALLBACK win_proc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int result = 0;
	char key_state[256];
	WORD key = 0;

	switch (message)
	{
		case WM_SETCURSOR:
			if (mode_fullscreen)
				SetCursor(0);
			else
				result = DefWindowProc(hWnd, message, wParam, lParam);
			break;

		case WM_ACTIVATEAPP:
			if (mode_fullscreen)
				is_active = (int)wParam;
			result = DefWindowProc(hWnd, message, wParam, lParam);
			break;

		case WM_SIZE:
			if (wParam != SIZE_MAXIMIZED)
				return DefWindowProc(hWnd, message, wParam, lParam);

		case WM_SYSKEYDOWN:
			if ((message == WM_SIZE) || ((wParam == VK_RETURN) && (lParam & 0x20000000))) {
				private_exit();
				mode_fullscreen ^= DRIVER_FULLSCREEN;
				if (private_init()) {
					private_exit();
					mode_fullscreen ^= DRIVER_FULLSCREEN;
					private_init();
				}
				fb_hMemSet(fb_mode->dirty, TRUE, mode_h);
				is_active = TRUE;
			}
			if (message != WM_SIZE)
				result = DefWindowProc(hWnd, message, wParam, lParam);
			break;

		case WM_KEYDOWN:
			switch (wParam) {

				case VK_UP:		key = KEY_UP;		break;
				case VK_DOWN:		key = KEY_DOWN;		break;
				case VK_LEFT:		key = KEY_LEFT;		break;
				case VK_RIGHT:		key = KEY_RIGHT;	break;
				case VK_INSERT:		key = KEY_INS;		break;
				case VK_DELETE:		key = KEY_DEL;		break;
				case VK_HOME:		key = KEY_HOME;		break;
				case VK_END:		key = KEY_END;		break;
				case VK_PRIOR:		key = KEY_PAGE_UP;	break;
				case VK_NEXT:		key = KEY_PAGE_DOWN;	break;
				case VK_F1:
				case VK_F2:
				case VK_F3:
				case VK_F4:
				case VK_F5:
				case VK_F6:
				case VK_F7:
				case VK_F8:
				case VK_F9:
				case VK_F10:		key = KEY_F(wParam - VK_F1 + 1); break;

				default:
					GetKeyboardState(key_state);
					if (ToAscii(wParam, (lParam >> 16) & 0xff, key_state, &key, 0) != 1)
						key = 0;
					break;
			}
			if (key) {
				key_buffer[key_tail] = key;
				if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) != key_head)
					key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
			}
			result = DefWindowProc(hWnd, message, wParam, lParam);
			break;

		case WM_CLOSE:
			key_buffer[key_tail] = KEY_QUIT;
			if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) != key_head)
				key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
			break;

		case WM_PAINT:
			update_screen();

		default:
			result = DefWindowProc(hWnd, message, wParam, lParam);
			break;
	}

	return result;
}


/*:::::*/
static void window_thread(HANDLE running_event)
{
	DDSURFACEDESC desc;
	MSG message;

	if (private_init())
		goto error;

	SetEvent(running_event);
	is_active = TRUE;

	while (is_running)
	{
		ddraw_lock();

		if (is_active) {
			IDirectDrawSurface_Restore(lpDDS);
			if (!mode_fullscreen)
				IDirectDrawSurface_Restore(lpDDS_back);

			if (is_palette_changed && lpDDP) {
				IDirectDrawPalette_SetEntries(lpDDP, 0, 0, 256, palette);
				is_palette_changed = FALSE;
			}
			desc.dwSize = sizeof(desc);
			if (IDirectDrawSurface_Lock(lpDDS_back, NULL, &desc, DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR, NULL) == DD_OK) {
				blitter((unsigned char *)desc.lpSurface + display_offset * desc.lPitch, desc.lPitch);
				IDirectDrawSurface_Unlock(lpDDS_back, desc.lpSurface);
				fb_hMemSet(fb_mode->dirty, FALSE, mode_h);
			}

			update_screen();
		}

		while (PeekMessage(&message, wnd, 0, 0, PM_REMOVE)) {
			TranslateMessage(&message);
			DispatchMessage(&message);
		}

		ddraw_unlock();

		Sleep(10);
		ddraw_wait_vsync();
	}

error:
	private_exit();
}


/*:::::*/
static int ddraw_init(char *title, int w, int h, int depth, int flags)
{
	DIRECTDRAWCREATE DirectDrawCreate;
	HANDLE events[2];
	long result;

	window_title = title;
	strcpy( window_class, WINDOW_CLASS_PREFIX );
	strcat( window_class, window_title );
	mode_w = w;
	mode_h = h;
	mode_depth = depth;
	mode_fullscreen = flags & DRIVER_FULLSCREEN;

	is_running = TRUE;

	InitializeCriticalSection(&update_lock);
	events[0] = CreateEvent(NULL, FALSE, FALSE, NULL);
	events[1] = (HANDLE)_beginthread(window_thread, 0, events[0]);
	result = WaitForMultipleObjects(2, events, FALSE, INFINITE);
	CloseHandle(events[0]);
	handle = events[1];
	if (result != WAIT_OBJECT_0) {
		DeleteCriticalSection(&update_lock);
		return -1;
	}

	SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL);

	SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, &screensaver_active, 0);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, FALSE, NULL, 0);

	return 0;
}


/*:::::*/
static void ddraw_exit(void)
{
	is_running = FALSE;
	WaitForSingleObject(handle, INFINITE);
	DeleteCriticalSection(&update_lock);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, screensaver_active, NULL, 0);
}


/*:::::*/
static void ddraw_lock(void)
{
	EnterCriticalSection(&update_lock);
}


/*:::::*/
static void ddraw_unlock(void)
{
	LeaveCriticalSection(&update_lock);
}


/*:::::*/
static void ddraw_set_palette(int index, int r, int g, int b)
{
	/* assumes lock to be held */

	palette[index].peRed = r;
	palette[index].peGreen = g;
	palette[index].peBlue = b;
	palette[index].peFlags = PC_NOCOLLAPSE;
	is_palette_changed = TRUE;
}


/*:::::*/
static void ddraw_wait_vsync(void)
{
	IDirectDraw_WaitForVerticalBlank(lpDD, DDWAITVB_BLOCKBEGIN, 0);
}


/*:::::*/
static int ddraw_get_key(int wait)
{
	int key = 0;

	if (wait) {
		do {
			key = ddraw_get_key(FALSE);
			Sleep(50);
		} while(!key);
		return key;
	}

	ddraw_lock();

	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

	ddraw_unlock();

	return key;
}


/*:::::*/
static void ddraw_set_window_title(char *title)
{
	SetWindowText(wnd, title);
}
