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

#ifndef WM_XBUTTONDOWN
#ifdef WM_MOUSELAST
#undef WM_MOUSELAST
#endif
#define WM_XBUTTONDOWN 523
#define WM_XBUTTONUP 524
#define WM_XBUTTONDBLCLK 525
#define WM_MOUSEHWHEEL 526
#define WM_MOUSELAST 527
#endif

#ifndef MK_XBUTTON1
#define MK_XBUTTON1	32
#define MK_XBUTTON2	64
#endif

#define WINDOW_CLASS_PREFIX "fbgfxclass_"

#ifndef LWA_COLORKEY
#define LWA_COLORKEY	0x00000001
#endif

#ifndef MONITOR_DEFAULTTONEAREST
#define MONITOR_DEFAULTTONEAREST 0x00000002
#endif

typedef struct FLASHWINFO {
	UINT cbSize;
	HWND hwnd;
	DWORD dwFlags;
	UINT uCount;
	DWORD dwTimeout;
} FLASHWINFO, *PFLASHWINFO;

typedef BOOL (WINAPI *SETLAYEREDWINDOWATTRIBUTES)(HWND hWnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
typedef HMONITOR (WINAPI *MONITORFROMWINDOW)(HWND hwnd, DWORD dwFlags);
typedef HMONITOR (WINAPI *MONITORFROMPOINT)(POINT pt, DWORD dwFlags);
typedef BOOL (WINAPI *FLASHWINDOWEX)(PFLASHWINFO pwfi);
typedef BOOL (WINAPI *_TRACKMOUSEEVENT)(TRACKMOUSEEVENT *);
typedef BOOL (WINAPI *GETMONITORINFO)(HMONITOR hMonitor, LPMONITORINFO lpmi);
typedef LONG (WINAPI *CHANGEDISPLAYSETTINGSEX)(LPCTSTR lpszDeviceName, LPDEVMODE lpDevMode, HWND hwnd, DWORD dwflags, LPVOID lParam);

typedef struct WIN32DRIVER
{
	int version;
	HINSTANCE hinstance;
	WNDCLASS wndclass;
	HWND wnd;
	PALETTEENTRY palette[256];
	BLITTER *blitter;
	HMONITOR monitor;
	int is_running, is_palette_changed, is_active;
	int w, h, depth, flags, refresh_rate;
	char *window_title;
	char window_class[WINDOW_TITLE_SIZE+sizeof( WINDOW_CLASS_PREFIX )];
	int (*init)(void);
	void (*exit)(void);
	void (*paint)(void);
	void (*thread)(HANDLE running_event);
	int mouse_clip;
	
	/* user32 procs */
	SETLAYEREDWINDOWATTRIBUTES SetLayeredWindowAttributes;
	MONITORFROMWINDOW MonitorFromWindow;
	MONITORFROMPOINT MonitorFromPoint;
	FLASHWINDOWEX FlashWindowEx;
	_TRACKMOUSEEVENT TrackMouseEvent;
	GETMONITORINFO GetMonitorInfo;
	CHANGEDISPLAYSETTINGSEX ChangeDisplaySettingsEx;
} WIN32DRIVER;


extern WIN32DRIVER fb_win32;
#ifndef HOST_CYGWIN
extern GFXDRIVER fb_gfxDriverDirectDraw;
#endif
extern GFXDRIVER fb_gfxDriverGDI;
extern GFXDRIVER fb_gfxDriverOpenGL;


extern LRESULT CALLBACK fb_hWin32WinProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
extern void fb_hHandleMessages(void);
extern int fb_hInitWindow(DWORD style, DWORD ex_style, int x, int y, int w, int h);
extern int fb_hWin32Init(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_hWin32Exit(void);
extern void fb_hWin32Lock(void);
extern void fb_hWin32Unlock(void);
extern void fb_hWin32SetPalette(int index, int r, int g, int b);
extern void fb_hWin32WaitVSync(void);
extern int fb_hWin32GetMouse(int *x, int *y, int *z, int *buttons, int *clip);
extern void fb_hWin32SetMouse(int x, int y, int cursor, int clip);
extern void fb_hWin32SetWindowTitle(char *title);
extern int fb_hWin32SetWindowPos(int x, int y);

/* from the rtlib */
extern const unsigned char __fb_keytable[][3];

#endif
