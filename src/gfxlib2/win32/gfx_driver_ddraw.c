/* DirectDraw gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"

#ifndef HOST_CYGWIN

#include <objbase.h>
#include <ddraw.h>
#include <dinput.h>

/* Normally these globals are found in -ldxguid, but we don't link that into
   FB programs because MinGW's libdxguid.a contains lots of other such globals
   and all of them in one object resulting in lots of unnecessary bloat.
   So we declare these manually here. They must be renamed from the originals
   too to prevent collisions with the DirectX/MinGW[-w64] headers. */
#define DX_GUID(id,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) static const GUID id = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}
DX_GUID( __fb_IID_IDirectDraw2, 0xB3A6F3E0,0x2B43,0x11CF,0xA2,0xDE,0x00,0xAA,0x00,0xB9,0x33,0x56 );
DX_GUID( __fb_GUID_Key,         0x55728220,0xD33C,0x11CF,0xBF,0xC7,0x44,0x45,0x53,0x54,0x00,0x00 );
DX_GUID( __fb_GUID_SysKeyboard, 0x6F1D2B61,0xD5A0,0x11CF,0xBF,0xC7,0x44,0x45,0x53,0x54,0x00,0x00 );

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_wait_vsync(void);
static int *driver_fetch_modes(int depth, int *size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverDirectDraw =
{
	"DirectX",              /* char *name; */
	driver_init,            /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	fb_hWin32Exit,          /* void (*exit)(void); */
	fb_hWin32Lock,          /* void (*lock)(void); */
	fb_hWin32Unlock,        /* void (*unlock)(void); */
	fb_hWin32SetPalette,    /* void (*set_palette)(int index, int r, int g, int b); */
	driver_wait_vsync,      /* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,      /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hWin32SetMouse,      /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	fb_hWin32SetWindowPos,  /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,     /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                   /* void (*flip)(void); */
	NULL,                   /* void (*poll_events)(void); */
	NULL                    /* void (*update)(void); */
};

typedef struct MODESLIST {
	int depth;
	int size;
	int *data;
} MODESLIST;

typedef struct DEVENUMDATA {
	GUID guid;
	BOOL success;
} DEVENUMDATA;

static int directx_init(void);
static void directx_exit(void);

/* We don't want to directly link with DDRAW.DLL and DINPUT.DLL,
 * as this way generated exes will not depend on them to run.
 * This will ensure if DirectX is not installed in the system,
 * the programs will still run, fallbacking on the GDI driver.
 */
typedef HRESULT (WINAPI *DIRECTDRAWCREATE)(GUID FAR *lpGUID,LPDIRECTDRAW FAR *lplpDD,IUnknown FAR *pUnkOuter);
typedef HRESULT (WINAPI *DIRECTINPUTCREATE)(HINSTANCE hinst,DWORD dwVersion,LPDIRECTINPUT *lplpDI,LPUNKNOWN pUnkOuter);
typedef HRESULT (WINAPI *DIRECTDRAWENUMERATEEX)(LPDDENUMCALLBACKEX lpCallback,LPVOID lpContext,DWORD dwFlags);

/* Unfortunately c_dfDIKeyboard is a required global variable
 * defined in import library LIBDINPUT.A, and as we're not
 * linking with it, we need to define it here...
 * 
 * ARRAYSIZE won't be defined for really old gcc  
 */
#ifndef ARRAYSIZE
#define ARRAYSIZE(__a) (sizeof(__a)/sizeof(__a[0]))
#endif
 
static DIOBJECTDATAFORMAT __c_rgodfDIKeyboard[256];
static const DIDATAFORMAT __c_dfDIKeyboard = { sizeof(__c_dfDIKeyboard), sizeof(*__c_rgodfDIKeyboard),
                                               DIDF_RELAXIS, 256,
                                               ARRAYSIZE(__c_rgodfDIKeyboard), __c_rgodfDIKeyboard };
static HMODULE dd_library;
static HMODULE di_library;
static LPDIRECTDRAW2 lpDD = NULL;
static LPDIRECTDRAWSURFACE lpDDS;
static LPDIRECTDRAWSURFACE lpDDS_back;
static LPDIRECTDRAWPALETTE lpDDP;
static LPDIRECTINPUT lpDI;
static LPDIRECTINPUTDEVICE lpDID;
static RECT rect;
static int win_x, win_y, display_offset, wait_vsync = FALSE;
static HANDLE vsync_event = NULL;

static void restore_surfaces(void)
{
	HRESULT result;
	FB_FLASHWINFO fwinfo;

	result = IDirectDrawSurface_IsLost(lpDDS);
	while (result == DDERR_SURFACELOST) {
		if (lpDDS_back != lpDDS)
			IDirectDrawSurface_Restore(lpDDS_back);
		result = IDirectDrawSurface_Restore(lpDDS);
		if (result == DDERR_WRONGMODE) {
			/* it sucks, we have to recreate all DD objects */
			directx_exit();
			while (directx_init()) {
				directx_exit();
				Sleep(300);
			}

			if (fb_win32.FlashWindowEx) {
				/* stop our window to flash */
				fwinfo.cbSize = sizeof(fwinfo);
				fwinfo.hwnd = fb_win32.wnd;
				fwinfo.dwFlags = 0;
				fb_win32.FlashWindowEx(&fwinfo);
			}
		}
		result = IDirectDrawSurface_IsLost(lpDDS);
	}
}

static void directx_paint(void)
{
	RECT src, dest;
	POINT point;
	HRESULT result;

	if (fb_win32.flags & DRIVER_FULLSCREEN)
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
	do {
		restore_surfaces();
		result = IDirectDrawSurface_Blt(lpDDS, &dest, lpDDS_back, &src, DDBLT_WAIT, NULL);
	} while (result == DDERR_SURFACELOST);
}

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

static BOOL WINAPI ddenum_callback(GUID FAR *lpGUID, LPSTR lpDriverDescription, LPSTR lpDriverName, LPVOID lpContext, HMONITOR hm)
{
	if (hm == fb_win32.monitor && lpGUID) {
		((DEVENUMDATA *)lpContext)->guid = *lpGUID;
		((DEVENUMDATA *)lpContext)->success = TRUE;
		return 0;
	} else {
		return 1;
	}
}

static int directx_init(void)
{
	LPDIRECTDRAW lpDD1 = NULL;
	LPDIRECTDRAWCLIPPER lpDDC = NULL;
	GUID *ddGUID = NULL;
	DIRECTDRAWCREATE DirectDrawCreate;
	DIRECTDRAWENUMERATEEX DirectDrawEnumerateEx;
	DIRECTINPUTCREATE DirectInputCreate;
	DDSURFACEDESC desc;
	DDPIXELFORMAT format;
	HRESULT res;
	DWORD style;
	int i, depth, is_rgb = FALSE, height, flags;
	DEVENUMDATA dev_enum_data;

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

	DirectDrawCreate = (DIRECTDRAWCREATE)(void*)GetProcAddress(dd_library, "DirectDrawCreate");
	DirectDrawEnumerateEx = (DIRECTDRAWENUMERATEEX)(void*)GetProcAddress(dd_library, "DirectDrawEnumerateExA");
	DirectInputCreate = (DIRECTINPUTCREATE)(void*)GetProcAddress(di_library, "DirectInputCreateA");
	
	dev_enum_data.success = FALSE;
	
	if (!(fb_win32.flags & DRIVER_FULLSCREEN) || (fb_win32.monitor == NULL) || !DirectDrawEnumerateEx ||
	    (DirectDrawEnumerateEx(ddenum_callback, &dev_enum_data, DDENUM_ATTACHEDSECONDARYDEVICES) != DD_OK) ||
	    !dev_enum_data.success ) {
		ddGUID = NULL;
	} else {
		ddGUID = &dev_enum_data.guid;
	}
	
	if ((!DirectDrawCreate) || (DirectDrawCreate(ddGUID, &lpDD1, NULL) != DD_OK))
		return -1;
	res = IDirectDraw_QueryInterface(lpDD1, &__fb_IID_IDirectDraw2, (LPVOID)&lpDD);
	IDirectDraw_Release(lpDD1);
	if (res != DD_OK)
		return -1;
	if ((!DirectInputCreate) || (DirectInputCreate(fb_win32.hinstance, 0x0300, &lpDI, NULL) != DI_OK))
		return -1;

	rect.left = rect.top = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;

	if (fb_win32.flags & DRIVER_FULLSCREEN) {
		if (fb_hInitWindow(WS_POPUP, 0, 0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN)))
			return -1;
		if (IDirectDraw2_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_ALLOWREBOOT | DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE) != DD_OK)
			return -1;

		height = fb_win32.h;
		while( 1 )
		{
			flags = ((fb_win32.w == 320) && (height == 200) && (fb_win32.depth == 8)) ? DDSDM_STANDARDVGAMODE : 0;

			if (IDirectDraw2_SetDisplayMode(lpDD, fb_win32.w, height, fb_win32.depth, fb_win32.refresh_rate, flags) == DD_OK)
				break;

			depth = fb_win32.depth;
			switch (fb_win32.depth)
			{
				case 15: depth = 16; break;
				case 16: depth = 15; break;
				case 24: depth = 32; break;
				case 32: depth = 24; break;
			}

			if ((depth == fb_win32.depth) || (IDirectDraw2_SetDisplayMode(lpDD, fb_win32.w, height, depth, fb_win32.refresh_rate, flags) != DD_OK))
			{
				height = calc_comp_height( height );
				if( height == 0 )
					return -1;
			} else {
				break;
			}
		}
		display_offset = ((height - fb_win32.h) >> 1);
	} else {
		if (fb_win32.flags & DRIVER_NO_FRAME) {
			style = WS_POPUP;
		} else {
			style = (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME);
			if (fb_win32.flags & DRIVER_NO_SWITCH)
				style &= ~WS_MAXIMIZEBOX;
		}
		AdjustWindowRect(&rect, style, 0);
		rect.right -= rect.left;
		rect.bottom -= rect.top;
		if (fb_hInitWindow(style, 0, win_x, win_y, rect.right, rect.bottom))
			return -1;
		if (IDirectDraw2_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_NORMAL) != DD_OK)
			return -1;
		if (IDirectDraw2_CreateClipper(lpDD, 0, &lpDDC, NULL) != DD_OK)
			return -1;
		if (IDirectDrawClipper_SetHWnd(lpDDC, 0, fb_win32.wnd) != DD_OK)
			return -1;
		display_offset = 0;
	}

	fb_hMemSet(&desc, 0, sizeof(DDSURFACEDESC));
	desc.dwSize = sizeof(desc);
	desc.dwFlags = DDSD_CAPS;
	desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	if (IDirectDraw2_CreateSurface(lpDD, &desc, &lpDDS, NULL) != DD_OK)
		return -1;

	if (!(fb_win32.flags & DRIVER_FULLSCREEN)) {
		if (IDirectDrawSurface_SetClipper(lpDDS, lpDDC) != DD_OK)
			return -1;
		fb_hMemSet(&desc, 0, sizeof(DDSURFACEDESC));
		desc.dwSize = sizeof(desc);
		desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
		desc.dwWidth = fb_win32.w;
		desc.dwHeight = fb_win32.h;
		desc.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_VIDEOMEMORY;
		if (IDirectDraw2_CreateSurface(lpDD, &desc, &lpDDS_back, 0) != DD_OK)
			return -1;
	} else {
		lpDDS_back = lpDDS;
	}

	format.dwSize = sizeof(format);
	if (IDirectDrawSurface_GetPixelFormat(lpDDS, &format) != DD_OK)
		return -1;
	if (!(format.dwFlags & DDPF_RGB))
		return -1;

	if (format.dwRGBBitCount == 8) {
		if (IDirectDraw2_CreatePalette(lpDD, DDPCAPS_8BIT | DDPCAPS_INITIALIZE | DDPCAPS_ALLOW256,
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

	IDirectDraw2_GetMonitorFrequency(lpDD, (LPDWORD)&__fb_gfx->refresh_rate);

	vsync_event = CreateEvent(NULL, TRUE, FALSE, NULL);

	for (i = 0; i < 256; i++) {
		__c_rgodfDIKeyboard[i].pguid = &__fb_GUID_Key;
		__c_rgodfDIKeyboard[i].dwOfs = i;
		__c_rgodfDIKeyboard[i].dwType = 0x8000000C | (i << 8);
		__c_rgodfDIKeyboard[i].dwFlags = 0;
	}
	if (IDirectInput_CreateDevice(lpDI, &__fb_GUID_SysKeyboard, &lpDID, NULL) != DI_OK)
		return -1;
	if (IDirectInputDevice_SetDataFormat(lpDID, &__c_dfDIKeyboard) != DI_OK)
		return -1;
	if (IDirectInputDevice_Acquire(lpDID) != DI_OK)
		return -1;

	ShowWindow(fb_win32.wnd, SW_SHOWNORMAL);

	return 0;
}

static void directx_exit(void)
{
	DDBLTFX bltfx;
	RECT rect;

	if (!(fb_win32.flags & DRIVER_FULLSCREEN)) {
		GetWindowRect(fb_win32.wnd, &rect);
		win_x = rect.left;
		win_y = rect.top;
	}

	if (lpDI) {
		if (lpDID) {
			IDirectInputDevice_Unacquire(lpDID);
			IDirectInputDevice_Release(lpDID);
			lpDID = NULL;
		}
		IDirectInput_Release(lpDI);
		lpDI = NULL;
	}

	if (lpDD) {
		if ((fb_win32.flags & DRIVER_FULLSCREEN) && lpDDS) {
			bltfx.dwSize = sizeof(bltfx);
			bltfx.dwDDFX = 0;
			bltfx.dwFillColor = 0;
			IDirectDrawSurface_Blt(lpDDS, &rect, NULL, NULL, DDBLT_COLORFILL, &bltfx);
		}

		if (lpDDS) {
			IDirectDrawSurface_Release(lpDDS);
			lpDDS = NULL;
		}
		if ((!(fb_win32.flags & DRIVER_FULLSCREEN)) && (lpDDS_back)) {
			IDirectDrawSurface_Release(lpDDS_back);
			lpDDS_back = NULL;
		}

		if (fb_win32.flags & DRIVER_FULLSCREEN) {
			IDirectDraw2_RestoreDisplayMode(lpDD);
			IDirectDraw2_SetCooperativeLevel(lpDD, fb_win32.wnd, DDSCL_NORMAL);
		}
		IDirectDraw2_Release(lpDD);
		lpDD = NULL;
	}
	if (fb_win32.wnd) {
		DestroyWindow(fb_win32.wnd);
		fb_win32.wnd = NULL;
	}
	if (dd_library) {
		FreeLibrary(dd_library);
		dd_library = NULL;
	}
	if (di_library) {
		FreeLibrary(di_library);
		di_library = NULL;
	}
	if (vsync_event) {
		CloseHandle(vsync_event);
		vsync_event = NULL;
	}
}

#ifdef HOST_MINGW
static unsigned int WINAPI directx_thread( void *param )
#else
static DWORD WINAPI directx_thread( LPVOID param )
#endif
{
	HANDLE running_event = param;
	DDSURFACEDESC desc;
	HRESULT result;
	unsigned char keystate[256];
	int i;

	if (directx_init()) return 1;

	SetEvent(running_event);
	fb_win32.is_active = TRUE;

	while (fb_win32.is_running)
	{
		Sleep(10);
		
		fb_hWin32Lock();
		
		if (wait_vsync) {
			WaitForSingleObject(vsync_event, 20);
			wait_vsync = FALSE;
		}
		
		if ((fb_win32.is_active) || (!(fb_win32.flags & DRIVER_FULLSCREEN))) {
			if (fb_win32.is_palette_changed && lpDDP) {
				IDirectDrawPalette_SetEntries(lpDDP, 0, 0, 256, fb_win32.palette);
				fb_win32.is_palette_changed = FALSE;
			}
			desc.dwSize = sizeof(desc);
			do {
				restore_surfaces();
				result = IDirectDrawSurface_Lock(lpDDS_back, NULL, &desc, DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR, NULL);
			} while (result == DDERR_SURFACELOST);
			if (result == DD_OK) {
				fb_win32.blitter((unsigned char *)desc.lpSurface + display_offset * desc.lPitch, desc.lPitch);
				IDirectDrawSurface_Unlock(lpDDS_back, desc.lpSurface);
				fb_hMemSet(__fb_gfx->dirty, FALSE, fb_win32.h);
			}

			directx_paint();
		}

        if( fb_win32.is_active ) {
            result = IDirectInputDevice_GetDeviceState(lpDID, 256, keystate);
            if ((result == DIERR_NOTACQUIRED) || (result == DIERR_INPUTLOST))
                IDirectInputDevice_Acquire(lpDID);
            else {
                /* Simplicistic way to deal with extended scancodes */
                for (i = 0; i < 128; i++)
                    __fb_gfx->key[i] = ((keystate[i] | keystate[i + 128]) & 0x80) ? TRUE : FALSE;
            }
        }

		fb_hHandleMessages();

		fb_hWin32Unlock();
	}

	return 1;
}

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));

	if (flags & (DRIVER_OPENGL | DRIVER_SHAPED_WINDOW))
		return -1;
	fb_win32.init = directx_init;
	fb_win32.exit = directx_exit;
	fb_win32.paint = directx_paint;
	fb_win32.thread = directx_thread;

	win_x = (GetSystemMetrics(SM_CXSCREEN) - w) >> 1;
	win_y = (GetSystemMetrics(SM_CYSCREEN) - h) >> 1;

	return fb_hWin32Init(title, w, h, MAX(8, depth), refresh_rate, flags);
}

static void driver_wait_vsync(void)
{
	ResetEvent(vsync_event);
	fb_hWin32Lock();
	wait_vsync = TRUE;
	fb_hWin32Unlock();
	IDirectDraw2_WaitForVerticalBlank(lpDD, DDWAITVB_BLOCKBEGIN, 0);
	/* Signal vsync to updater thread */
	SetEvent(vsync_event);
}

static HRESULT CALLBACK fetch_modes_callback(LPDDSURFACEDESC desc, LPVOID data)
{
	MODESLIST *modes = (MODESLIST *)data;
	int depth = desc->ddpfPixelFormat.dwRGBBitCount;

	if ((depth == 16) && (desc->ddpfPixelFormat.dwGBitMask == 0x03E0))
		depth = 15;
	if (depth == modes->depth) {
		modes->size++;
		modes->data = (int *)realloc(modes->data, modes->size * sizeof(int));
		modes->data[modes->size - 1] = (desc->dwWidth << 16) | desc->dwHeight;
	}

	return DDENUMRET_OK;
}

static int *driver_fetch_modes(int depth, int *size)
{
	MODESLIST modes = { depth, 0, NULL };
	LPDIRECTDRAW dd1;
	LPDIRECTDRAW2 dd2;
	DIRECTDRAWCREATE DirectDrawCreate;
	HMODULE library = NULL;
	HRESULT res;

	if (!lpDD) {
		library = (HMODULE)LoadLibrary("ddraw.dll");
		if (!library)
			return NULL;
		DirectDrawCreate = (DIRECTDRAWCREATE)(void*)GetProcAddress(library, "DirectDrawCreate");
		if ((!DirectDrawCreate) || (DirectDrawCreate(NULL, &dd1, NULL) != DD_OK)) {
			FreeLibrary(library);
			return NULL;
		}
		res = IDirectDraw_QueryInterface(dd1, &__fb_IID_IDirectDraw2, (LPVOID)&dd2);
		IDirectDraw_Release(dd1);
		if (res != DD_OK) {
			FreeLibrary(library);
			return NULL;
		}
	} else {
		dd2 = lpDD;
	}
	if (IDirectDraw2_EnumDisplayModes(dd2, DDEDM_STANDARDVGAMODES, NULL, (LPVOID)&modes, fetch_modes_callback) != DD_OK)
		modes.data = NULL;

	if (!lpDD) {
		IDirectDraw_Release(dd2);
		FreeLibrary(library);
	}

	*size = modes.size;
	return modes.data;
}

#endif /* HOST_CYGWIN */
