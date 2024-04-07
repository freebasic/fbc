/* common win32 internal definitions */

#ifndef __FB_GFX_WIN32_H__
#define __FB_GFX_WIN32_H__

#include <windows.h>

/* see also fb_win32.window_class setup in fb_hWin32Init() */
#define WINDOW_CLASS_PREFIX "fbgfxclass_"
#define WINDOW_CLASS_SIZE (sizeof( WINDOW_CLASS_PREFIX ) + (sizeof( void * ) * 2))

/* This must match the original FLASHWINFO from the Win32 headers.
   MinGW-w64 declares it *all* the time, while MinGW does it only if the
   proper _WIN32_WINNT was set, but we do not want to do that. And since we
   cannot check for a struct using #ifdef, we have to use our own renamed
   version of it. */
typedef struct {
	UINT cbSize;
	HWND hwnd;
	DWORD dwFlags;
	UINT uCount;
	DWORD dwTimeout;
} FB_FLASHWINFO, *PFB_FLASHWINFO;

typedef BOOL (WINAPI *SETLAYEREDWINDOWATTRIBUTES)(HWND hWnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
typedef HMONITOR (WINAPI *MONITORFROMWINDOW)(HWND hwnd, DWORD dwFlags);
typedef HMONITOR (WINAPI *MONITORFROMPOINT)(POINT pt, DWORD dwFlags);
typedef BOOL (WINAPI *FLASHWINDOWEX)(PFB_FLASHWINFO pwfi);
typedef BOOL (WINAPI *_TRACKMOUSEEVENT)(TRACKMOUSEEVENT *);
typedef BOOL (WINAPI *GETMONITORINFO)(HMONITOR hMonitor, LPMONITORINFO lpmi);
typedef LONG (WINAPI *CHANGEDISPLAYSETTINGSEX)(LPCTSTR lpszDeviceName, LPDEVMODE lpDevMode, HWND hwnd, DWORD dwflags, LPVOID lParam);

typedef struct {
	int version;
	HINSTANCE hinstance;
	WNDCLASS wndclass;
	HWND wnd;
	int fullw, fullh; /* width/height including non-client area */
	PALETTEENTRY palette[256];
	BLITTER *blitter;
	HMONITOR monitor;
	int is_running, is_palette_changed, is_active;
	int w, h, depth, flags, refresh_rate;
	char *window_title;
	char window_class[WINDOW_CLASS_SIZE];
	int (*init)(void);
	void (*exit)(void);
	void (*paint)(void);
#ifdef HOST_MINGW
	unsigned int WINAPI (*thread)( void *param );
#else
	DWORD WINAPI (*thread)( LPVOID param );
#endif
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
extern const GFXDRIVER fb_gfxDriverD2D;
extern const GFXDRIVER fb_gfxDriverDirectDraw;
#endif
extern const GFXDRIVER fb_gfxDriverGDI;
extern const GFXDRIVER fb_gfxDriverOpenGL;

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
