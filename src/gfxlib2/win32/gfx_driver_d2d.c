#define CINTERFACE
#define COBJMACROS
#define D2D_USE_C_DEFINITIONS
/* This file requires a Windows SDK capable of targeting Windows 7 */
#define _WIN32_WINNT 0x0601

#ifndef DISABLE_D3D10
#ifndef HOST_CYGWIN

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"
#include <d3d10_1.h>
#include <d2d1.h>
#include <dxgi.h>
#include <stdlib.h>

/* Defining DEBUG or D2D_DEBUG will turn on debugging for Direct2D & Direct3D
// (if it's used). To see any output from them you'll need to install 
// the debug layer and have a debugger attached to the process 
// (DebugView won't cut it)
// If you're finding you're getting fails on D3D10CreateDevice
// or D2D1CreateFactory with this defined, it's likely you don't 
// have the debug layers installed - See here https://pastebin.com/8ptZxmim
//
// These defines will also turn on debug printing of any unexpected D2D/D3D failures
// (DebugView is fine for these) and throw an exception (C000003E, -1073741762)
// if the global state becomes corrupted
*/
#if defined(DEBUG) || defined(D2D_DEBUG)
/* ntstatus.h doesn't define the NTSTATUS type :-( */
typedef long NTSTATUS;
#include <ntstatus.h>
#define DO_DEBUG
#define D2D1_FACTORY_INFO_TYPE D2D1_DEBUG_LEVEL_INFORMATION
#define D3D10_CREATE_DEVICE_DEBUG_FLAG D3D10_CREATE_DEVICE_DEBUG

static void PrintDebugText(const char* pFmt, ...)
{
	char text[300] = {0};
	va_list args;
	va_start(args, pFmt);
	vsnprintf(text, ARRAYSIZE(text) - 1, pFmt, args);
	OutputDebugStringA(text);
	/* DebugView will put each message on its own line, WinDbg needs help */
	OutputDebugStringA("\n");
	va_end(args);
}

static BOOL PrintFailedHResult(HRESULT hr, const char* pFailure, int line)
{
	BOOL didFail = FAILED(hr);
	if(didFail)
	{
		PrintDebugText("%s failed with hresult %#lx on line %d", pFailure, hr, line);
	}
	return didFail;
}

#define NOTIFY_FAILED_HR(Func) \
	PrintFailedHResult(Func, #Func, __LINE__)

#define DBG_TEXT(string, ...) \
	PrintDebugText(string, __FUNCTION__, __VA_ARGS__)

#else /* DEBUG || D2D_DEBUG */
#define D2D1_FACTORY_INFO_TYPE D2D1_DEBUG_LEVEL_NONE
#define D3D10_CREATE_DEVICE_DEBUG_FLAG 0
#define NOTIFY_FAILED_HR(x) FAILED(x)
#define DBG_TEXT(string, ...) (void)0
#endif

static int D2DDriverInit(char *title, int w, int h, int depth, int refresh_rate, int flags);
static int* D2DFetchModes(int depth, int* size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverD2D = {
	"Direct2D",              /* char *name; */
	&D2DDriverInit,          /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	&fb_hWin32Exit,          /* void (*exit)(void); */
	&fb_hWin32Lock,          /* void (*lock)(void); */
	&fb_hWin32Unlock,        /* void (*unlock)(void); */
	&fb_hWin32SetPalette,    /* void (*set_palette)(int index, int r, int g, int b); */
	&fb_hWin32WaitVSync,     /* void (*wait_vsync)(void); */
	&fb_hWin32GetMouse,      /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	&fb_hWin32SetMouse,      /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	&fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	&fb_hWin32SetWindowPos,  /* int (*set_window_pos)(int x, int y); */
	&D2DFetchModes,          /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                    /* void (*flip)(void); */
	NULL,                    /* void (*poll_events)(void); */
	NULL                     /* void (*update)(void); */
};

#define DX_GUID(id,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) static const GUID id = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

/* IIDs of various interfaces so we don't need to link uuid.lib
// which is bad because of bloat
*/
DX_GUID(__fb_IID_IDXGIFactory, 0x7b7166ec, 0x21c7, 0x44ae, 0xb2, 0x1a, 0xc9, 0xae, 0x32, 0x1a, 0xe3, 0x69);
DX_GUID(__fb_IID_ID2D1Factory, 0x06152247, 0x6f50, 0x465a, 0x92, 0x45, 0x11, 0x8b, 0xfd, 0x3b, 0x60, 0x07);
DX_GUID(__fb_IID_IDXGISurface, 0xcafcb56c, 0x6ac3, 0x4889, 0xbf, 0x47, 0x9e, 0x23, 0xbb, 0xd2, 0x60, 0xec);
DX_GUID(__fb_IID_ID2D1GdiInteropRenderTarget, 0xe0db51c3, 0x6f77, 0x4bae, 0xb3, 0xd5, 0xe4, 0x75, 0x09, 0xb3, 0x58, 0x38);
DX_GUID(__fb_IID_ID2D1RenderTarget, 0x2cd90694, 0x12e2, 0x11dc, 0x9f, 0xed, 0x00, 0x11, 0x43, 0xa0, 0x55, 0xf9);

/* Direct2D HwndRenderTargets only support 32-bpp formats 
// https://docs.microsoft.com/en-gb/windows/win32/direct2d/supported-pixel-formats-and-alpha-modes#supported-formats-for-id2d1hwndrendertarget
*/
static const DXGI_FORMAT THIRTY_TWO_BPP_FORMATS[] = {DXGI_FORMAT_B8G8R8A8_UNORM, DXGI_FORMAT_R8G8B8A8_UNORM, DXGI_FORMAT_UNKNOWN};
/* Pick numbers unlikely to be used by somebody else */
static const USHORT D2D_PROP_ID = 0x56A2;

/* Prototypes for external functions */
typedef HRESULT (WINAPI*pfnCreateDXGIFactory)(REFIID riid, void** ppFactory);
typedef HRESULT (WINAPI*pfnCreateD2D1Factory)(
	D2D1_FACTORY_TYPE factoryType, 
	REFIID riid, 
	CONST D2D1_FACTORY_OPTIONS *pFactoryOptions, 
	void** ppIFactory
);
typedef BOOL (WINAPI*pfnUpdateLayeredWindow)(
	HWND hwnd, 
	HDC hdcDst, 
	POINT* pDest, 
	SIZE* pSize, 
	HDC hdcSrc, 
	POINT* pSrc, 
	COLORREF crKey, 
	BLENDFUNCTION* pBlendFn, 
	DWORD dwFlags
);
typedef HRESULT (WINAPI*pfnD3D10CreateDevice1)(
	IDXGIAdapter* pAdapter, 
	D3D10_DRIVER_TYPE type, 
	HMODULE hMod, 
	UINT flags, 
	D3D10_FEATURE_LEVEL1 level, 
	UINT sdkver, 
	ID3D10Device1** ppDevice
);

/* and for internal functions */
struct D2DGlobalState;
typedef void (*pfnD2DShutdown)(struct D2DGlobalState* pState);
typedef void (*pfnD2DPaint)(struct D2DGlobalState* pState, const D2D1_RECT_U* pDirtyRect);
typedef int (*pfnD2DSetup)(struct D2DGlobalState* ppState, HWND hwnd);

typedef struct D2DGlobalState
{
#ifdef DO_DEBUG
	ULONG_PTR cookie;
#endif
	WNDPROC wndProcCookie;    /* The original window proc of fb_win32.wnd */
	DXGI_FORMAT renderFormat; /* The format we're rendering to */
	HMODULE hD2D;             /* d2d1.dll handle */
	ID2D1Factory* pD2DFactory;/* The D2D creation object */
	ID2D1RenderTarget* pRenderTarget; /* Target that we render to */
	ID2D1Bitmap* pBackBufferBitmap; /* The bitmap, filled with data from fb_gfx->framebuffer, that we render */

	pfnD2DShutdown Shutdown;  /* Function pointer for mode specific cleanup */
	pfnD2DSetup Setup;        /* Function pointer for doing setup specific to whichever mode */
	pfnD2DPaint Paint;        /* Function pointer for mode specific rendering */

	unsigned char* pTempBuffer;/* Optional intermediate buffer used during RGB->BGR conversion */
	BLITTER* pBlitter;         /* Option FB Blitter function to do any required color conversion */
	BYTE vkToFBKeyTranslation[256]; /* Translation table for VK_ value to the appropriate index in __fb_keytable */

	/* Creating shaped windows still requires
	// interop with GDI, which complicates things a lot.
	// In order to get hardware accelerated rendering, we need to
	// involve all of Direct3D, DXGI, Direct2D & GDI
	// This is what the GdiInterop functions achieve.
	// 
	// (And now you know why The Brotherhood of NOD 
	// wanted to get rid of GDI once and for all :-)
	// https://msdn.microsoft.com/en-us/magazine/ee819134.aspx
	//
	// If the user doesn't want shaped windows, then we can just use 
	// D2D directly to render to the window
	// This is faster and simpler and what the D2DDirect functions do
	*/
	union RenderParams
	{
		/* These are used by the GDIInterop functions */
		struct LayeredWindowRenderParams
		{
			HMODULE hD3D;              /* D3D10_1.dll handle */
			ID3D10Device1* pD3DDevice; /* The D3D Device */
			IDXGISurface* pBackBuffer; /* The DXGI interface of the Direct3D Texture2D */
			ID2D1GdiInteropRenderTarget* pGDITarget; /* The D2D interface that'll give us a GDI HDC */
			pfnUpdateLayeredWindow updateLayeredWindow; /* The function from User32 that'll update any transparent areas */
		} Layered;
		/* These are used by the D2DDirect functions */
		struct NonLayeredRenderParams
		{
			ID2D1HwndRenderTarget* pHwndTarget; /* The guy that lets us render to a window */
		} NonLayered;
	} RenderParams;
} D2DGlobalState;

/* We could statically allocate the state as a global, but that would
// increase the size of apps even further, so we dynamicaly allocate it
// and attach it to our render window, thus they don't pay for it if we're
// not in use
*/
static D2DGlobalState* GetGlobalState(HWND hwnd)
{
	D2DGlobalState* pState = GetProp(hwnd, MAKEINTRESOURCE(D2D_PROP_ID));

#ifdef DO_DEBUG
	if(pState) {
		if(IsBadReadPtr(pState, sizeof(*pState)) || (pState->cookie != ~PtrToUlong(&GetGlobalState))) {
			ULONG_PTR arg = (ULONG_PTR)"Direct2D GFXDriver State Corruption";
			RaiseException(STATUS_DATA_ERROR, 0, 1, &arg);
		}
	}
#endif
	return pState;
}

static D2DGlobalState* CreateGlobalState(HWND hwnd, HMODULE hD2D, ID2D1Factory* pFactory, WNDPROC wndprocCookie)
{
	D2DGlobalState* pState = calloc(1, sizeof(*pState));

	if(pState) {
		BYTE i = 0;
#ifdef DO_DEBUG
		pState->cookie = ~PtrToUlong(&GetGlobalState);
#endif
		pState->hD2D = hD2D;
		pState->wndProcCookie = wndprocCookie;
		pState->pD2DFactory = pFactory;
		while(__fb_keytable[i][0]) {
			pState->vkToFBKeyTranslation[__fb_keytable[i][1]] = i;
			if(__fb_keytable[i][2]) {
				pState->vkToFBKeyTranslation[__fb_keytable[i][2]] = i;
			}
			++i;
		}
		if(!SetProp(hwnd, MAKEINTRESOURCE(D2D_PROP_ID), (HANDLE)pState)) {
			free(pState);
			pState = NULL;
		}
	}
	DBG_TEXT("%s - returning state at %p", pState);
	return pState;
}

static LRESULT CALLBACK D2DWndProcSubclass(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	D2DGlobalState* pGlobalState = GetGlobalState(hwnd);

	if(!pGlobalState) return DefWindowProc(hwnd, msg, wParam, lParam);
	switch(msg) {
		/* The other Win32 graphic drivers do the input handling in
		// the main thread loop using GetKeyState, which happens even 
		// if nothing has changed.
		// Since that's just a reflection of the state of the keys as per
		// the message loop, we subclass and react here and update as the changes
		// arrive rather than poll. We have to subclass as a) the WndProc is in
		// gfx_win32.c and b) contains a lot of important stuff
		*/
		case WM_KEYDOWN:
		case WM_SYSKEYDOWN:
		case WM_KEYUP:
		case WM_SYSKEYUP: {
			const BYTE* pTranslationTable = pGlobalState->vkToFBKeyTranslation;
			BOOL isDown = (msg == WM_KEYDOWN) || (msg == WM_SYSKEYDOWN);
			BYTE value = isDown ? TRUE : FALSE;

			DBG_ASSERT(wParam < 256);
			fb_gfxDriverD2D.lock();
			if(wParam != VK_SHIFT) {
				BYTE fbKeyIndex = pTranslationTable[wParam];
				const BYTE* pKeyTableKey = __fb_keytable[fbKeyIndex];
				BYTE fbScan = pKeyTableKey[0];
				BYTE alternateKey = (pKeyTableKey[1] == wParam) ? pKeyTableKey[2] : pKeyTableKey[1];
				if(alternateKey) {
					__fb_gfx->key[fbScan] = (value << 7) | ((GetKeyState(alternateKey) & 0x8000) ? TRUE : FALSE);
				}
				else {
					__fb_gfx->key[fbScan] = value;
				}
				DBG_TEXT(
					"%s - Got key%s for vKey %#x, fbScan=%#x, winScan=%#x, gfxKeyState=%#x",
					isDown ? "down" : "up",
					wParam,
					fbScan,
					LOBYTE(lParam >> 16),
					 __fb_gfx->key[fbScan]
				);
			}
			else {
				/* Shift needs to update both the LSHIFT and RSHIFT scancodes */
				__fb_gfx->key[SC_RSHIFT] = __fb_gfx->key[SC_LSHIFT] = value;
			}
			fb_gfxDriverD2D.unlock();
		}
		break;
	}
	return CallWindowProc(pGlobalState->wndProcCookie, hwnd, msg, wParam, lParam);
}

static HWND CreateTheWindow(WNDPROC* pOriginalProc)
{
	HWND hwnd = NULL;
	RECT winSize = {0};
	RECT monitorSize = {0};
	DWORD windowStyle = 0;
	DWORD exStyle = 0;
	DEVMODE mode = {};
	int fbFlags = fb_win32.flags;
	HMONITOR hCurMonitor = fb_win32.monitor;
	MONITORINFOEX mInf;
	BOOL isFullScreen = (fbFlags & DRIVER_FULLSCREEN);

	mode.dmSize = sizeof(mode);
	mInf.cbSize = sizeof(mInf);
	fb_win32.GetMonitorInfo(hCurMonitor, (MONITORINFO*)&mInf);
	monitorSize = mInf.rcMonitor;
	if(!(isFullScreen || (fbFlags & DRIVER_NO_FRAME))) {
		windowStyle |= (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME);
	}
	else {
		windowStyle |= WS_POPUP;
	}
	if(fbFlags & DRIVER_NO_SWITCH) {
		windowStyle &= ~WS_MAXIMIZEBOX;
	}
	winSize.right = fb_win32.w;
	winSize.bottom = fb_win32.h;
	winSize.left = winSize.top = 0;
	if(isFullScreen) {		
		mode.dmPelsWidth = fb_win32.w;
		mode.dmPelsHeight = fb_win32.h;
		mode.dmBitsPerPel = fb_win32.depth;
		mode.dmDisplayFrequency = fb_win32.refresh_rate;
		mode.dmFields = DM_PELSWIDTH | DM_PELSHEIGHT | DM_BITSPERPEL | DM_DISPLAYFREQUENCY;
		if(fb_win32.ChangeDisplaySettingsEx(mInf.szDevice, &mode, NULL, CDS_FULLSCREEN, NULL) != DISP_CHANGE_SUCCESSFUL) {
			mode.dmDisplayFrequency = 0;
			mode.dmFields ^= DM_DISPLAYFREQUENCY;
			if(fb_win32.ChangeDisplaySettingsEx(mInf.szDevice, &mode, NULL, CDS_FULLSCREEN, NULL) != DISP_CHANGE_SUCCESSFUL) {
				return NULL;
			}
		}
		DBG_TEXT("%s - Successfully full screen on display %s", mInf.szDevice);
	}
	else {
		exStyle = (fbFlags & DRIVER_SHAPED_WINDOW) ? WS_EX_LAYERED : 0;
		AdjustWindowRect(&winSize, windowStyle, FALSE);
		OffsetRect(&winSize, (monitorSize.right - winSize.right - winSize.left) / 2,  (monitorSize.bottom - winSize.bottom - winSize.top) / 2);
	}
	if(fb_hInitWindow(windowStyle, exStyle, winSize.left, winSize.top, winSize.right - winSize.left, winSize.bottom - winSize.top)) {
		return NULL;
	}
	if(EnumDisplaySettings(mInf.szDevice, ENUM_CURRENT_SETTINGS, &mode)) {
		DBG_TEXT("%s - current refresh rate is %d", mode.dmDisplayFrequency);
		__fb_gfx->refresh_rate = mode.dmDisplayFrequency;
	}
	hwnd = fb_win32.wnd;
	*pOriginalProc = (WNDPROC)SetWindowLongPtr(hwnd, GWLP_WNDPROC, (LONG_PTR)&D2DWndProcSubclass);
	DBG_TEXT("%s - Created window at %p, size=%dx%d, original wndproc at %p", hwnd, winSize.right - winSize.left, winSize.bottom - winSize.top, *pOriginalProc);
	return hwnd;
}

static void GdiInteropPaint(D2DGlobalState* pGlobalState, const D2D1_RECT_U* pDirtyRect)
{
	struct LayeredWindowRenderParams* pLp = &pGlobalState->RenderParams.Layered;
	HDC hdc = NULL;
	/* The empty rect tels D2D that we didn't
	// write to the DC, passing NULL instead of this
	// indicates a full redraw, which we definitely don't want
	*/
	RECT empty = {};
	SIZE winSize = {fb_win32.w, fb_win32.h};
	POINT origin = {};

	ID2D1GdiInteropRenderTarget_GetDC(pLp->pGDITarget, D2D1_DC_INITIALIZE_MODE_COPY, &hdc);
	pLp->updateLayeredWindow(fb_win32.wnd, NULL, NULL, &winSize, hdc, &origin, MASK_COLOR_32, NULL, ULW_COLORKEY);
	ID2D1GdiInteropRenderTarget_ReleaseDC(pLp->pGDITarget, &empty);
}

static void GdiInteropShutdown(D2DGlobalState* pGlobalState)
{
	struct LayeredWindowRenderParams* pLp = &pGlobalState->RenderParams.Layered;

	ID2D1GdiInteropRenderTarget_Release(pLp->pGDITarget);
	IDXGISurface_Release(pLp->pBackBuffer);
	ID3D10Device1_Release(pLp->pD3DDevice);
	FreeLibrary(pLp->hD3D);
}

static int GdiInteropSetup(D2DGlobalState* pGlobalState, HWND hwnd)
{
	int ret = -1;
	ID3D10Device1* pD3DDevice = NULL;
	ID3D10Texture2D* pD3DTexture = NULL;
	IDXGISurface* pDXGISurface = NULL;
	ID2D1RenderTarget* pRenderTarget = NULL;
	ID2D1GdiInteropRenderTarget* pGdiTarget = NULL;
	ID2D1Bitmap* pBitmap = NULL;
	HMODULE hD3D = LoadLibrary("d3d10_1.dll");

	if(hD3D != NULL) {
		D2D1_RENDER_TARGET_PROPERTIES renderProps = {};
		D2D1_BITMAP_PROPERTIES bitmapProps = {};
		D2D1_SIZE_U bitmapSize = {};
		UINT stride;
		D3D10_TEXTURE2D_DESC texDesc = {};
		HMODULE hUser32 = GetModuleHandle("user32.dll");
		struct LayeredWindowRenderParams* pLayeredParams = &pGlobalState->RenderParams.Layered;

		pfnD3D10CreateDevice1 CreateD3D10Device = (pfnD3D10CreateDevice1)(void*)GetProcAddress(hD3D, "D3D10CreateDevice1");
		if(CreateD3D10Device == NULL) {
			goto errorReturn;
		}
		if(NOTIFY_FAILED_HR(CreateD3D10Device(
			NULL, 
			D3D10_DRIVER_TYPE_HARDWARE, 
			NULL, 
			D3D10_CREATE_DEVICE_SINGLETHREADED | D3D10_CREATE_DEVICE_BGRA_SUPPORT | D3D10_CREATE_DEVICE_DEBUG_FLAG,
			D3D10_FEATURE_LEVEL_10_0,
			D3D10_1_SDK_VERSION,
			&pD3DDevice
		))) {
			goto errorReturn;
		}
		texDesc.ArraySize = texDesc.MipLevels = texDesc.SampleDesc.Count = 1;
		texDesc.BindFlags = D3D10_BIND_RENDER_TARGET;
		texDesc.MiscFlags = D3D10_RESOURCE_MISC_GDI_COMPATIBLE;
		texDesc.Format = DXGI_FORMAT_B8G8R8A8_UNORM;
		bitmapSize.width = texDesc.Width = fb_win32.w;
		bitmapSize.height = texDesc.Height = fb_win32.h;
		stride = bitmapSize.width * 4;
		if(NOTIFY_FAILED_HR(ID3D10Device1_CreateTexture2D(pD3DDevice, &texDesc, NULL, &pD3DTexture))) {
			goto errorReturn;
		}
		if(NOTIFY_FAILED_HR(ID3D10Texture2D_QueryInterface(pD3DTexture, &__fb_IID_IDXGISurface, (void**)&pDXGISurface))) {
			goto errorReturn;
		}
		/* We don't need this interface, just the DXGI one */
		ID3D10Texture2D_Release(pD3DTexture);
		pD3DTexture = NULL;
		renderProps.pixelFormat.alphaMode = D2D1_ALPHA_MODE_IGNORE;
		renderProps.usage = D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE;
		renderProps.dpiX = renderProps.dpiY = 96.f;
		if(NOTIFY_FAILED_HR(ID2D1Factory_CreateDxgiSurfaceRenderTarget(pGlobalState->pD2DFactory, pDXGISurface, &renderProps, &pRenderTarget))) {
			goto errorReturn;
		}
		bitmapProps.pixelFormat.format = texDesc.Format;
		bitmapProps.pixelFormat.alphaMode = renderProps.pixelFormat.alphaMode;
		bitmapProps.dpiX = bitmapProps.dpiY = 96.f;
		if(NOTIFY_FAILED_HR(ID2D1RenderTarget_CreateBitmap(pRenderTarget, bitmapSize, NULL, stride, &bitmapProps, &pBitmap))) {
			goto errorReturn;
		}
		if(NOTIFY_FAILED_HR(ID2D1RenderTarget_QueryInterface(pRenderTarget, &__fb_IID_ID2D1GdiInteropRenderTarget, (void**)&pGdiTarget))) {
			goto errorReturn;
		}
		/* if depth conversion is necessary, we need a blitter and a temp buffer */
		if(__fb_gfx->depth < 24) {
			pGlobalState->pBlitter = fb_hGetBlitter(32, FALSE);
			if(!(pGlobalState->pTempBuffer = calloc(1, bitmapSize.height * stride))) {
				goto errorReturn;
			}
		}
		if(!(pLayeredParams->updateLayeredWindow = (pfnUpdateLayeredWindow)(void*)GetProcAddress(hUser32, "UpdateLayeredWindow")))
		{
			goto errorReturn;
		}
		pLayeredParams->hD3D = hD3D;
		pLayeredParams->pD3DDevice = pD3DDevice;
		pLayeredParams->pBackBuffer = pDXGISurface;
		pLayeredParams->pGDITarget = pGdiTarget;
		pGlobalState->pRenderTarget = pRenderTarget;
		pGlobalState->pBackBufferBitmap = pBitmap;
		pGlobalState->Paint = &GdiInteropPaint;
		pGlobalState->Setup = &GdiInteropSetup;
		pGlobalState->Shutdown = &GdiInteropShutdown;
		ret = 0;
	}
	return ret;
errorReturn:
	if(pGdiTarget) ID2D1GdiInteropRenderTarget_Release(pGdiTarget);
	if(pBitmap) ID2D1Bitmap_Release(pBitmap);
	if(pRenderTarget) ID2D1RenderTarget_Release(pRenderTarget);
	if(pDXGISurface) IDXGISurface_Release(pDXGISurface);
	if(pD3DTexture) ID3D10Texture2D_Release(pD3DTexture);
	if(pD3DDevice) ID3D10Device1_Release(pD3DDevice);
	if(hD3D) FreeLibrary(hD3D);
	return ret;
}

static void D2DDirectShutdown(D2DGlobalState* pGlobalState)
{
	struct NonLayeredRenderParams* pNlp = &pGlobalState->RenderParams.NonLayered;

	ID2D1HwndRenderTarget_Release(pNlp->pHwndTarget);
}

static int D2DDirectSetup(D2DGlobalState* pGlobalState, HWND hwnd)
{
	int ret = -1;
	struct NonLayeredRenderParams* pNlp = &pGlobalState->RenderParams.NonLayered;
	ID2D1HwndRenderTarget* pHwndRenderTarget = NULL;
	ID2D1RenderTarget* pRenderTarget = NULL;
	ID2D1Bitmap* pBackBufferBitmap = NULL;
	const DXGI_FORMAT* pFormats = THIRTY_TWO_BPP_FORMATS;
	D2D1_RENDER_TARGET_PROPERTIES renderProps = {0};   
	D2D1_HWND_RENDER_TARGET_PROPERTIES hwndRenderProps = {0};
	D2D1_BITMAP_PROPERTIES bitmapProps = {};
	UINT stride = 0;
	
	hwndRenderProps.hwnd = hwnd;
	hwndRenderProps.presentOptions = D2D1_PRESENT_OPTIONS_IMMEDIATELY;
	hwndRenderProps.pixelSize.height = fb_win32.h;
	hwndRenderProps.pixelSize.width = fb_win32.w;
	stride = hwndRenderProps.pixelSize.width * 4;
	renderProps.type = D2D1_RENDER_TARGET_TYPE_DEFAULT;
	renderProps.usage = D2D1_RENDER_TARGET_USAGE_NONE;
	renderProps.pixelFormat.alphaMode = D2D1_ALPHA_MODE_IGNORE;
	renderProps.dpiX = renderProps.dpiY = 96.f;
	while(*pFormats != DXGI_FORMAT_UNKNOWN) {
		renderProps.pixelFormat.format = *(pFormats++);
		if(!NOTIFY_FAILED_HR(ID2D1Factory_CreateHwndRenderTarget(
			pGlobalState->pD2DFactory, 
			&renderProps, 
			&hwndRenderProps, 
			&pHwndRenderTarget
		))) {
			break;
		}
	}
	if(!pHwndRenderTarget) {
		goto errorReturn;
	}
	bitmapProps.pixelFormat = renderProps.pixelFormat;
	bitmapProps.dpiX = bitmapProps.dpiY = 96.f;
	if(NOTIFY_FAILED_HR(ID2D1HwndRenderTarget_CreateBitmap(
		pHwndRenderTarget, 
		hwndRenderProps.pixelSize, 
		NULL, 
		stride, 
		&bitmapProps, 
		&pBackBufferBitmap
	)))
	{
		goto errorReturn;
	}
	/* if no colour or depth conversion is necessary, then we can directly
	// use the framebuffer, no blitter is required.
	//
	// Otherwise we need a blitter and a temp buffer, since you can't map or lock D2D bitmaps
	*/
	if((renderProps.pixelFormat.format < DXGI_FORMAT_B8G8R8A8_UNORM) || (__fb_gfx->depth < 24)) {
		pGlobalState->pBlitter = fb_hGetBlitter(32, renderProps.pixelFormat.format < DXGI_FORMAT_B8G8R8A8_UNORM);
		if(!(pGlobalState->pTempBuffer = calloc(1, hwndRenderProps.pixelSize.height * stride))) {
			goto errorReturn;
		}
	}
	if(NOTIFY_FAILED_HR(ID2D1HwndRenderTarget_QueryInterface(pHwndRenderTarget, &__fb_IID_ID2D1RenderTarget, (void**)&pRenderTarget))) {
		goto errorReturn;
	}
	pNlp->pHwndTarget = pHwndRenderTarget;
	pGlobalState->pRenderTarget = pRenderTarget;
	pGlobalState->pBackBufferBitmap = pBackBufferBitmap;
	pGlobalState->Shutdown = &D2DDirectShutdown;
	pGlobalState->Setup = &D2DDirectSetup;
	/* CommonPaint does everything the D2DDirect method needs */
	pGlobalState->Paint = NULL;
	ret = 0;
	
	return ret;
errorReturn:
	if(pBackBufferBitmap) ID2D1Bitmap_Release(pBackBufferBitmap);
	if(pHwndRenderTarget) ID2D1HwndRenderTarget_Release(pHwndRenderTarget);
	return ret;
}

static void D2DCommonPaintInternal(D2DGlobalState* pGlobalState)
{
	HRESULT hr = S_OK;
	ID2D1RenderTarget* pRT = pGlobalState->pRenderTarget;
	ID2D1Bitmap* pBackBuffer = pGlobalState->pBackBufferBitmap;
	const int winWidth = fb_win32.w, winHeight = fb_win32.h;
	D2D1_RECT_U dirtyRect;
	D2D1_RECT_F drawRect;
	char* pDirtyStart, *pDirtyEnd;
	const char* pFirstDirtyRow = NULL, *pLastDirtyRow = NULL;
	unsigned char* pBitmapDataSrc = NULL;
	const UINT stride = winWidth * 4;
	const ULONG ptrSize = sizeof(ULONG_PTR);
	ULONG_PTR dirtyRows;
	ULONG bitPos;
	int scanlineSize;

	fb_gfxDriverD2D.lock();

	scanlineSize = __fb_gfx->scanline_size;
	pDirtyStart = __fb_gfx->dirty;
	pDirtyEnd = pDirtyStart + __fb_gfx->h;
	pFirstDirtyRow = FB_MEMCHR(pDirtyStart, TRUE, __fb_gfx->h);
	/* nothing's dirty, don't do anything */
	if(!pFirstDirtyRow) {
		fb_gfxDriverD2D.unlock();
		return;
	}
	/* why is there strchr and strrchr, but not memchr and memrchr?
	// anyway, since we're only searching for TRUE and not any character
	// we optimize and look at ptr-size bytes per time, instead of just looping 
	// over single ones.
	*/
	while(PtrToUlong(pDirtyEnd) & (ptrSize - 1)) {
		if(*(--pDirtyEnd)) {
			pLastDirtyRow = pDirtyEnd;
			goto fillInDirtyRect;
		}
	}
	while((dirtyRows = *(ULONG_PTR*)(pDirtyEnd -= ptrSize)) == 0);
#ifdef _WIN64
	BitScanReverse64(&bitPos, dirtyRows);
#else
	BitScanReverse(&bitPos, dirtyRows);
#endif
	pLastDirtyRow = pDirtyEnd + ((bitPos >> 3) & (ptrSize - 1));
fillInDirtyRect:
	dirtyRect.left = 0;
	dirtyRect.right = winWidth;
	dirtyRect.top = (pFirstDirtyRow - pDirtyStart) * scanlineSize;
	dirtyRect.bottom = ((pLastDirtyRow - pDirtyStart) + 1) * scanlineSize;
	drawRect.left = dirtyRect.left;
	drawRect.right = dirtyRect.right;
	drawRect.top = dirtyRect.top;
	drawRect.bottom = dirtyRect.bottom;

	DBG_TEXT("%s - dirty rect L-%lu, T-%lu, R-%lu, B-%lu", dirtyRect.left, dirtyRect.top, dirtyRect.right, dirtyRect.bottom);

	/* if we need to convert from BGRA to RGBA, then do that
	// otherwise we can just direcly use the framebuffer 
	*/
	if(pGlobalState->pBlitter) {
		pGlobalState->pBlitter(pBitmapDataSrc = pGlobalState->pTempBuffer, stride);
	}
	else {
		pBitmapDataSrc = __fb_gfx->framebuffer;
	}
	pBitmapDataSrc += (stride * dirtyRect.top);

	ID2D1Bitmap_CopyFromMemory(pBackBuffer, &dirtyRect, pBitmapDataSrc, stride);

	ID2D1RenderTarget_BeginDraw(pRT);
	ID2D1RenderTarget_DrawBitmap(pRT, pBackBuffer, &drawRect, 1.0f, D2D1_BITMAP_INTERPOLATION_MODE_LINEAR, &drawRect);
	if(pGlobalState->Paint)
	{
		pGlobalState->Paint(pGlobalState, &dirtyRect);
	}
	hr = ID2D1RenderTarget_EndDraw(pRT, NULL, NULL);
	/* If we have to reset the drawing surfaces, we mark it all dirty
	// otherwise we mark it all clean */
	fb_hMemSet(pDirtyStart, SUCCEEDED(hr) ? FALSE : TRUE, winHeight);

	fb_gfxDriverD2D.unlock();

	/* This value is cast to HRESULT in the headers in the Microsoft SDK 
	// not so much in MinGW's
	*/
	if(hr == (HRESULT)D2DERR_RECREATE_TARGET) {
		DBG_TEXT("%s - told to recreate targets", 0);
		pGlobalState->Shutdown(pGlobalState);
		pGlobalState->Setup(pGlobalState, fb_win32.wnd);
	}
}

static int D2DCommonInit()
{
	int ret = -1;
	D2DGlobalState* pGlobalState = NULL;
	HMODULE hD2D = LoadLibrary("d2d1.dll");
	ID2D1Factory* pFactory = NULL;
	HWND hwnd = NULL;

	DBG_TEXT("%s called", 0);
	if(hD2D != NULL) {
		D2D1_FACTORY_OPTIONS opts = {D2D1_FACTORY_INFO_TYPE};
		WNDPROC wndProcCookie = NULL;
		pfnCreateD2D1Factory D2DCreateFactory = (pfnCreateD2D1Factory)(void*)GetProcAddress(hD2D, "D2D1CreateFactory");

		if((D2DCreateFactory == NULL) || 
		   (NOTIFY_FAILED_HR(D2DCreateFactory(
			D2D1_FACTORY_TYPE_SINGLE_THREADED,
			&__fb_IID_ID2D1Factory,
			&opts,
			(void**)&pFactory))
		)) {
			goto errorReturn;
		}
		hwnd = CreateTheWindow(&wndProcCookie);
		if(hwnd == NULL) {
			goto errorReturn;
		}
		if(!(pGlobalState = CreateGlobalState(hwnd, hD2D, pFactory, wndProcCookie))) {
			goto errorReturn;
		}
		if(fb_win32.flags & DRIVER_SHAPED_WINDOW) {
			ret = GdiInteropSetup(pGlobalState, hwnd);
		}
		else {
			ret = D2DDirectSetup(pGlobalState, hwnd);
		}
		if(ret == 0) {
			ShowWindow(hwnd, SW_SHOWNORMAL);
		}
	}
	if(ret != 0) {
errorReturn:
		if(hwnd) DestroyWindow(hwnd);
		if(pGlobalState) free(pGlobalState);
		if(pFactory) ID2D1Factory_Release(pFactory);
		if(hD2D) FreeLibrary(hD2D);
	}
	return ret;
}

static void D2DCommonPaint()
{
	D2DGlobalState* pGlobalState = GetGlobalState(fb_win32.wnd);

	if(pGlobalState) {
		D2DCommonPaintInternal(pGlobalState);
	}
}

static void D2DCommonShutdown()
{
	HWND hwnd = fb_win32.wnd;
	D2DGlobalState* pGlobalState = GetGlobalState(hwnd);

	DBG_TEXT("%s called with hwnd=%p, pState=%p", hwnd, pGlobalState);
	if(hwnd) {
		DestroyWindow(hwnd);
		fb_win32.wnd = NULL;
	}
	if(pGlobalState) {
		ID2D1Bitmap_Release(pGlobalState->pBackBufferBitmap);
		ID2D1RenderTarget_Release(pGlobalState->pRenderTarget);
		pGlobalState->Shutdown(pGlobalState);
		if(fb_win32.flags & DRIVER_FULLSCREEN) {
			MONITORINFOEX mInf;
			mInf.cbSize = sizeof(mInf);
			fb_win32.GetMonitorInfo(fb_win32.monitor, (MONITORINFO*)&mInf);
			fb_win32.ChangeDisplaySettingsEx(mInf.szDevice, NULL, NULL, 0, NULL);
		}
		ID2D1Factory_Release(pGlobalState->pD2DFactory);
		FreeLibrary(pGlobalState->hD2D);
		free(pGlobalState->pTempBuffer);
		free(pGlobalState);
	}
}

static 
#ifdef HOST_MINGW
unsigned int
#else
DWORD
#endif
WINAPI D2DRenderThread(void* p)
{
	DBG_TEXT("%s started", 0);
	if(D2DCommonInit()) return 1;
	fb_win32.is_active = TRUE;

	SetEvent((HANDLE)p);
	while(fb_win32.is_running) {
		DWORD ret = MsgWaitForMultipleObjects(0, NULL, TRUE, 10, QS_ALLINPUT);

		if(ret == WAIT_OBJECT_0) {
			fb_hHandleMessages();
		}
		D2DCommonPaint();
	}
	DBG_TEXT("%s exiting", 0);
	D2DCommonShutdown();
	return 0;
}

static int D2DDriverInit(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	DBG_TEXT("%s called with title=%s, res=%dx%d, depth=%d, refresh_rate=%d, flags=%#x", title, w, h, depth, refresh_rate, flags);
	if ((flags & DRIVER_OPENGL) || ((GetVersion() & 0xff) < 6))
		return -1;
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));
	fb_win32.init = &D2DCommonInit;
	fb_win32.exit = &D2DCommonShutdown;
	fb_win32.paint = &D2DCommonPaint;
	fb_win32.thread = &D2DRenderThread;

	return fb_hWin32Init(title, w, h, depth, refresh_rate, flags);
}

typedef struct MiniVector
{
	int* pData;
	int elems;
	int capacity;
} MiniVector;

static void D2DPushToVector(MiniVector* pVector, int elemToAdd)
{
	if(pVector->elems == pVector->capacity)
	{
		int newCapacity = pVector->capacity + 20;
		int* pNewData = realloc(pVector->pData, newCapacity * sizeof(*pNewData));
		if(!pNewData)
		{
			return;
		}
		pVector->pData = pNewData;
		pVector->capacity = newCapacity;
	}
	pVector->pData[pVector->elems++] = elemToAdd;
}

static void D2DEnumOutputModes(IDXGIOutput* pOutput, MiniVector* pDepthModes)
{
	UINT numOutputModes = 0;
	const DXGI_FORMAT* pFormats = THIRTY_TWO_BPP_FORMATS;

	while(*pFormats != DXGI_FORMAT_UNKNOWN)	{
		IDXGIOutput_GetDisplayModeList(pOutput, *pFormats, DXGI_ENUM_MODES_INTERLACED, &numOutputModes, NULL);
		if(numOutputModes != 0) {
			DXGI_MODE_DESC* pModeList = calloc(sizeof(*pModeList), numOutputModes);
			if(pModeList && (!NOTIFY_FAILED_HR(IDXGIOutput_GetDisplayModeList(pOutput, *pFormats, DXGI_ENUM_MODES_INTERLACED, &numOutputModes, pModeList)))) {
				UINT i;
				for(i = 0; i < numOutputModes; ++i) {
					int mode = ((pModeList[i].Width << 16) | pModeList[i].Height);
					DBG_TEXT("%s found mode %dx%d - %fHz", pModeList[i].Width, pModeList[i].Height, ((float)pModeList[i].RefreshRate.Numerator / pModeList[i].RefreshRate.Denominator));
					D2DPushToVector(pDepthModes, mode);
				}
			}
			free(pModeList);
			/* got some (or rather should have) so exit */
			break;
		}
		++pFormats;
	}
}

static int* D2DFetchModes(int depth, int *size)
{
	IDXGIFactory* pFactory = NULL;
	pfnCreateDXGIFactory CreateDXGIFactory = NULL;
	HMODULE hDxgi = NULL;
	UINT adapterIter = 0;
	IDXGIAdapter* pAdapter = NULL;
	MiniVector hardwareModes = {NULL, 0, 0};
	MiniVector softwareModes = {NULL, 0, 0};
	DBG_TEXT("%s called with depth=%d", depth);

	/* What happens here is that we enumerate everything
	// until we have a set of hardware modes
	// We record the software driver modes, but those are
	// only returned if we don't get any hardware ones
	*/
	hDxgi = LoadLibrary("dxgi.dll");
	if (hDxgi != NULL) {
		CreateDXGIFactory = (pfnCreateDXGIFactory)(void*)GetProcAddress(hDxgi, "CreateDXGIFactory");
		if ((CreateDXGIFactory) && (!NOTIFY_FAILED_HR(CreateDXGIFactory(&__fb_IID_IDXGIFactory, (void**)&pFactory)))) {
			while((hardwareModes.elems == 0) && SUCCEEDED(IDXGIFactory_EnumAdapters(pFactory, adapterIter++, &pAdapter))) {
				IDXGIOutput* pOutput = NULL;
				DXGI_ADAPTER_DESC adapterDesc = {};
				if(SUCCEEDED(IDXGIAdapter_GetDesc(pAdapter, &adapterDesc))) {
					/* The 'random' ids are defined here for the software/warp adapter 
					// https://docs.microsoft.com/en-us/windows/win32/direct3ddxgi/d3d10-graphics-programming-guide-dxgi#new-info-about-enumerating-adapters-for-windows-8
					*/
					UINT outputIter = 0;
					MiniVector* pWhichModes = ((adapterDesc.VendorId == 0x1414) && (adapterDesc.DeviceId == 0x8c)) ? &softwareModes : &hardwareModes;
					while((hardwareModes.elems == 0) && SUCCEEDED(IDXGIAdapter_EnumOutputs(pAdapter, outputIter++, &pOutput))) {
						DBG_TEXT("%s - Enumerated %ws output %lu", adapterDesc.Description, outputIter);
						D2DEnumOutputModes(pOutput, pWhichModes);
						IDXGIOutput_Release(pOutput);
					}
				}
				IDXGIAdapter_Release(pAdapter);
			}
			IDXGIFactory_Release(pFactory);
		}
		FreeLibrary(hDxgi);
	}
	if(hardwareModes.pData) {
		*size = hardwareModes.elems;
		free(softwareModes.pData);
		return hardwareModes.pData;
	}
	else {
		*size = softwareModes.elems;
		return softwareModes.pData;
	}
}

#endif /* HOST_CYGWIN */
#endif /* DISABLE_D3D10 */
