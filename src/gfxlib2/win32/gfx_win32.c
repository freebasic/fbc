/* common win32 routines and drivers list */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"
#include "../../rtlib/win32/fb_private_console.h"
#include <process.h>

#define WM_MOUSEENTER WM_USER

#ifndef WM_XBUTTONDOWN
#define WM_XBUTTONDOWN 523
#define WM_XBUTTONUP 524
#define WM_XBUTTONDBLCLK 525
#endif

#ifndef WM_MOUSEHWHEEL
#define WM_MOUSEHWHEEL 526
#endif

#ifndef MK_XBUTTON1
#define MK_XBUTTON1	32
#define MK_XBUTTON2	64
#endif

#ifndef MONITOR_DEFAULTTONEAREST
#define MONITOR_DEFAULTTONEAREST 0x00000002
#endif

WIN32DRIVER fb_win32;

const GFXDRIVER *__fb_gfx_drivers_list[] = {
#ifndef HOST_CYGWIN
#ifndef DISABLE_D3D10
	&fb_gfxDriverD2D,
#endif /* DISABLE_D3D10 */
	&fb_gfxDriverDirectDraw,
#endif /* HOST_CYGWIN */
	&fb_gfxDriverGDI,
	&fb_gfxDriverOpenGL,
	NULL
};

static const struct { const char *name; FARPROC *proc; } user32_procs[] = {
	{"SetLayeredWindowAttributes", (FARPROC *)&fb_win32.SetLayeredWindowAttributes},
	{"MonitorFromWindow",          (FARPROC *)&fb_win32.MonitorFromWindow         },
	{"MonitorFromPoint",           (FARPROC *)&fb_win32.MonitorFromPoint          },
	{"FlashWindowEx",              (FARPROC *)&fb_win32.FlashWindowEx             },
	{"TrackMouseEvent",            (FARPROC *)&fb_win32.TrackMouseEvent           },
	{"GetMonitorInfoA",            (FARPROC *)&fb_win32.GetMonitorInfo            },
	{"ChangeDisplaySettingsExA",   (FARPROC *)&fb_win32.ChangeDisplaySettingsEx   }
};

static CRITICAL_SECTION update_lock;
static HANDLE handle;
static BOOL screensaver_active, cursor_shown, has_focus = FALSE;
static int last_mouse_buttons, mouse_buttons;
static int mouse_wheel, mouse_hwheel, mouse_x, mouse_y, mouse_on;
static POINT last_mouse_pos;

struct keyconvinfo {
	union {
		void *v;
		WCHAR *w;
		char *a;
	};
	int size;
};
typedef struct keyconvinfo KEYCONVINFO;
static KEYCONVINFO keyconv1 = {{NULL}, 0};
static KEYCONVINFO keyconv2 = {{NULL}, 0};

static void keyconv_clear( KEYCONVINFO *k );
static void keyconv_grow( KEYCONVINFO *k, int nchars, int charsize );

static unsigned int hIntlConvertChar( int key, int source_cp, int dest_cp );

static void fb_hSetMouseClip( void )
{
	RECT rc;
	POINT point;
	GetClientRect(fb_win32.wnd, &rc);
	point.x = rc.left;
	point.y = rc.top;
	ClientToScreen(fb_win32.wnd, &point);
	rc.left = point.x;
	rc.top = point.y;
	point.x = rc.right;
	point.y = rc.bottom;
	ClientToScreen(fb_win32.wnd, &point);
	rc.right = point.x;
	rc.bottom = point.y;
	ClipCursor(&rc);
}

static void ToggleFullScreen( EVENT *e )
{
	if (has_focus) {
		e->type = EVENT_MOUSE_EXIT;
		fb_hPostEvent(e);
	}

	if (fb_win32.flags & DRIVER_NO_SWITCH)
		return;

	fb_win32.monitor = fb_win32.MonitorFromWindow ? fb_win32.MonitorFromWindow(fb_win32.wnd, MONITOR_DEFAULTTONEAREST) : NULL;

	if (fb_win32.mouse_clip)
		ClipCursor(NULL);

	fb_win32.exit();
	fb_win32.flags ^= DRIVER_FULLSCREEN;
	if (fb_win32.init()) {
		fb_win32.exit();
		fb_win32.flags ^= DRIVER_FULLSCREEN;
		fb_win32.init();
	}
	fb_hRestorePalette();
	fb_hMemSet(__fb_gfx->dirty, TRUE, fb_win32.h);
	fb_win32.is_active = TRUE;
	has_focus = FALSE;
}

static VOID CALLBACK fb_hTrackMouseTimerProc(
	HWND hWnd, 
	UINT uMsg,
#ifdef _WIN64 
	UINT_PTR idEvent, 
#else
	UINT idEvent,
#endif
	DWORD dwTime
)
{
	POINT pt, rect_pt[2];
	RECT *rect = (RECT *)rect_pt;

	GetClientRect(fb_win32.wnd, rect);
	MapWindowPoints(fb_win32.wnd, NULL, rect_pt, 2);
	GetCursorPos(&pt);
	if ((!PtInRect(rect, pt)) || (WindowFromPoint(pt) != fb_win32.wnd)) {
		KillTimer(fb_win32.wnd, idEvent);
		PostMessage(fb_win32.wnd, WM_MOUSELEAVE, 0, 0);
	}
}

static BOOL WINAPI fb_hTrackMouseEvent(TRACKMOUSEEVENT *e)
{
	if (e->dwFlags == TME_LEAVE)
		return SetTimer(e->hwndTrack, e->dwFlags, 100, fb_hTrackMouseTimerProc);
	return FALSE;
}

LRESULT CALLBACK fb_hWin32WinProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	BYTE key_state[256];
	TRACKMOUSEEVENT track_e;
	POINT mouse_pos, rect_pt[2];
	RECT *rect = (RECT *)rect_pt;
	PAINTSTRUCT ps;
	EVENT e;
	BOOL is_minimized;
	MINMAXINFO *mmi;

	e.type = 0;

	GetClientRect(fb_win32.wnd, rect);
	MapWindowPoints(fb_win32.wnd, NULL, rect_pt, 2);
	GetCursorPos(&mouse_pos);
	mouse_on = PtInRect(rect, mouse_pos);

	switch (message)
	{
		case WM_ACTIVATE:
			is_minimized = HIWORD(wParam);
			fb_win32.is_active = ((!is_minimized) && (LOWORD(wParam) != WA_INACTIVE));

			/*
				If the window is minimized or inactive, then lower the thread
				priority to avoid a very slow fast-user-switch.
			*/
			if (handle) {
				if(fb_win32.flags & DRIVER_HIGH_PRIORITY)
				{
					if (fb_win32.is_active)
						SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL );
					else
						SetThreadPriority(handle, THREAD_PRIORITY_NORMAL );
				}
			}

			fb_hMemSet(__fb_gfx->key, FALSE, 128);
			mouse_buttons = 0;
			fb_hMemSet(__fb_gfx->dirty, TRUE, fb_win32.h);
			if ((!fb_win32.is_active) && (has_focus)) {
				e.type = EVENT_MOUSE_EXIT;
				fb_hPostEvent(&e);
				has_focus = FALSE;
				KillTimer(fb_win32.wnd, TME_LEAVE);
			}
			if (!((LOWORD(wParam)) && (is_minimized))) {
				e.type = fb_win32.is_active ? EVENT_WINDOW_GOT_FOCUS : EVENT_WINDOW_LOST_FOCUS;
				fb_hPostEvent(&e);
			}
			if ((fb_win32.is_active) && (mouse_on)) {
				message = WM_MOUSEENTER;
				break;
			}
			if (fb_win32.mouse_clip) {
				if (!fb_win32.is_active)
					ClipCursor(NULL);
				else
					fb_hSetMouseClip();
			}
			return 0;

		case WM_SETCURSOR:
			if ((mouse_on) && (!cursor_shown))
				SetCursor(NULL);
			else
				SetCursor(LoadCursor(NULL, IDC_ARROW));
			return TRUE;

		case WM_MOUSEMOVE:
			e.type = EVENT_MOUSE_MOVE;
			mouse_x = e.x = lParam & 0xFFFF;
			mouse_y = e.y = (lParam >> 16) & 0xFFFF;
			if (last_mouse_pos.x == 0xFFFF) {
				e.dx = e.dy = 0;
			}
			else {
				e.dx = mouse_pos.x - last_mouse_pos.x;
				e.dy = mouse_pos.y - last_mouse_pos.y;
			}
			if( __fb_gfx->scanline_size != 1 ) {
				e.y /= __fb_gfx->scanline_size;
				e.dy /= __fb_gfx->scanline_size;
			}
			last_mouse_pos = mouse_pos;
			if (((!e.dx) && (!e.dy)) || (!fb_win32.is_active)) {
				e.type = 0;
			}
			break;

		case WM_MOUSELEAVE:
			if (!fb_win32.is_active)
				break;
			e.type = EVENT_MOUSE_EXIT;
			fb_hPostEvent(&e);
			has_focus = FALSE;
			return 0;

		case WM_LBUTTONDOWN:
		case WM_LBUTTONDBLCLK:
			SetCapture( hWnd );
			mouse_buttons |= BUTTON_LEFT;
			e.type = (message == WM_LBUTTONDOWN ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK);
			e.button = BUTTON_LEFT;
			break;

		case WM_LBUTTONUP:
			mouse_buttons &= ~BUTTON_LEFT;
			if(!mouse_buttons && GetCapture() == hWnd)
				ReleaseCapture();
			e.type = EVENT_MOUSE_BUTTON_RELEASE;
			e.button = BUTTON_LEFT;
			break;

		case WM_RBUTTONDOWN:
		case WM_RBUTTONDBLCLK:
			SetCapture( hWnd );
			mouse_buttons |= BUTTON_RIGHT;
			e.type = (message == WM_RBUTTONDOWN ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK);
			e.button = BUTTON_RIGHT;
			break;

		case WM_RBUTTONUP:
			mouse_buttons &= ~BUTTON_RIGHT;
			if(!mouse_buttons && GetCapture() == hWnd)
				ReleaseCapture();
			e.type = EVENT_MOUSE_BUTTON_RELEASE;
			e.button = BUTTON_RIGHT;
			break;

		case WM_MBUTTONDOWN:
		case WM_MBUTTONDBLCLK:
			SetCapture( hWnd );
			mouse_buttons |= BUTTON_MIDDLE;
			e.type = (message == WM_MBUTTONDOWN ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK);
			e.button = BUTTON_MIDDLE;
			break;

		case WM_MBUTTONUP:
			mouse_buttons &= ~BUTTON_MIDDLE;
			if(!mouse_buttons && GetCapture() == hWnd)
				ReleaseCapture();
			e.type = EVENT_MOUSE_BUTTON_RELEASE;
			e.button = BUTTON_MIDDLE;
			break;

		case WM_XBUTTONDOWN:
		case WM_XBUTTONDBLCLK:
			if (fb_win32.version < 0x500)
				break;
			SetCapture( hWnd );
			last_mouse_buttons = mouse_buttons;
			mouse_buttons |= ((LOWORD(wParam) & MK_XBUTTON1) ? BUTTON_X1 : 0 )
						  | ((LOWORD(wParam) & MK_XBUTTON2) ? BUTTON_X2 : 0 );
			e.type = (message == WM_XBUTTONDOWN ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK);
			e.button = (~last_mouse_buttons & mouse_buttons) & (BUTTON_X1 | BUTTON_X2);
			break;

		case WM_XBUTTONUP:
			if (fb_win32.version < 0x500)
				break;
			last_mouse_buttons = mouse_buttons;
			mouse_buttons &= ~((LOWORD(wParam) & MK_XBUTTON1) ? 0 : BUTTON_X1 )
						  & ~((LOWORD(wParam) & MK_XBUTTON2) ? 0 : BUTTON_X2 );
			if(!mouse_buttons && GetCapture() == hWnd)
				ReleaseCapture();
			e.type = EVENT_MOUSE_BUTTON_RELEASE;
			e.button = (last_mouse_buttons & ~mouse_buttons) & (BUTTON_X1 | BUTTON_X2);
			break;

		case WM_MOUSEWHEEL:
			if (fb_win32.version < 0x40A)
				break;
			if ((signed)wParam > 0)
				mouse_wheel++;
			else
				mouse_wheel--;
			e.type = EVENT_MOUSE_WHEEL;
			e.z = mouse_wheel;
			break;

		case WM_MOUSEHWHEEL:
			if (fb_win32.version < 0x500)
				break;
			if ((signed)wParam > 0)
				mouse_hwheel++;
			else
				mouse_hwheel--;
			e.type = EVENT_MOUSE_HWHEEL;
			e.w = mouse_hwheel;
			break;

		case WM_SIZE:
			if (fb_win32.is_active) {
				if ( wParam == SIZE_MAXIMIZED ) {
					ToggleFullScreen(&e);
					return FALSE;
				}
			}
			break;

		case WM_SYSKEYDOWN:
			if (fb_win32.is_active) {
				if ( (wParam == VK_RETURN) && (lParam & 0x20000000) ) {
					ToggleFullScreen(&e);
					return FALSE;
				}
			}
			/* fall through */

		case WM_KEYDOWN:
		case WM_KEYUP:
			{
				WORD wVkCode = (WORD) wParam;
				WORD wVsCode = (WORD) (( lParam & 0xFF0000 ) >> 16);
				int is_ext_keycode = ( lParam & 0x1000000 )!=0;
				size_t repeat_count = ( lParam & 0xFFFF );
				int is_repeated = (lParam & 0x40000000);
				DWORD dwControlKeyState = 0;
				char chAsciiChar;
				int is_dead_key;
				int key;

				GetKeyboardState(key_state);

				if( (key_state[VK_SHIFT] | key_state[VK_LSHIFT] | key_state[VK_RSHIFT]) & 0x80 )
					dwControlKeyState ^= SHIFT_PRESSED;
				if( (key_state[VK_LCONTROL] | key_state[VK_CONTROL]) & 0x80 )
					dwControlKeyState ^= LEFT_CTRL_PRESSED;
				if( key_state[VK_RCONTROL] & 0x80 )
					dwControlKeyState ^= RIGHT_CTRL_PRESSED;
				if( (key_state[VK_LMENU] | key_state[VK_MENU]) & 0x80 )
					dwControlKeyState ^= LEFT_ALT_PRESSED;
				if( key_state[VK_RMENU] & 0x80 )
					dwControlKeyState ^= RIGHT_ALT_PRESSED;
				if( is_ext_keycode )
					dwControlKeyState |= ENHANCED_KEY;

				is_dead_key = (MapVirtualKey( wVkCode, 2 ) & 0x80000000)!=0;
				if( !is_dead_key ) {
					WORD wKey = 0;
					if( ToAscii( wVkCode, wVsCode, key_state, &wKey, 0 )==1 ) {
						chAsciiChar = (char) wKey;
					} else {
						chAsciiChar = 0;
					}
				} else {
					/* Never use ToAscii when a dead key is used - otherwise
					 * we don't get the combined character (for accents) */
					chAsciiChar = 0;
				}
				key = fb_hConsoleTranslateKey( chAsciiChar,
				                               wVsCode,
				                               wVkCode,
				                               dwControlKeyState,
				                               FALSE );
				if (message == WM_KEYDOWN) {
					if (is_repeated)
						e.type = EVENT_KEY_REPEAT;
					else
						e.type = EVENT_KEY_PRESS;
					if (key > 0xFF) {
						while( repeat_count-- ) {
							fb_hPostKey(key);
						}
					}
				}
				else
					e.type = EVENT_KEY_RELEASE;
				e.scancode = fb_hVirtualToScancode(wVkCode);

				/* Don't return extended keycodes in the ascii field */
				e.ascii = ((key < 0) || (key > 0xFF)) ? 0 : key;

				/* We don't want to enter the menu ... */
				if( wVkCode == VK_F10 || wVkCode == VK_MENU || key == KEY_QUIT )
					return FALSE;
			}
			break;

		case WM_CHAR:
			{
				size_t repeat_count = ( lParam & 0xFFFF );
				int key = (int) wParam;
				if( key < 256 ) {
					int target_cp = FB_GFX_GET_CODEPAGE();
					if( target_cp!=-1 )
						key = hIntlConvertChar( key, CP_ACP, target_cp );

					while( repeat_count-- ) {
						fb_hPostKey(key);
					}
				}
			}

			break;

		case WM_CLOSE:
			fb_hPostKey( KEY_QUIT ); /* ALT + F4 */
			e.type = EVENT_WINDOW_CLOSE;
			fb_hPostEvent(&e);
			return FALSE;

		case WM_PAINT:
			{
				/* set the rows in __fb_gfx->dirty corresponding to the 
				// window update rect as dirty
				 */
				LONG dirtyStartLine, numLines;
				int scanlineShift = __fb_gfx->scanline_size - 1;

				BeginPaint(fb_win32.wnd, &ps);
				dirtyStartLine = ps.rcPaint.top;
				numLines = ps.rcPaint.bottom - dirtyStartLine;

				DBG_ASSERT(scanlineShift == 0 || scanlineShift == 1);
				dirtyStartLine >>= scanlineShift;
				numLines = max(numLines >> scanlineShift, 1);

				fb_hMemSet(__fb_gfx->dirty + dirtyStartLine, TRUE, numLines);

				fb_win32.paint();
				EndPaint(fb_win32.wnd, &ps);
			}
			break;
		
		case WM_DISPLAYCHANGE:
			fb_win32.paint();
			fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);
			break;
		
		case WM_MOVING:
			if (fb_win32.mouse_clip)
				ClipCursor(NULL);
			break;

		case WM_GETMINMAXINFO:
			/* Don't let the window size be truncated to the screen size */
			mmi = (MINMAXINFO *)lParam;
			mmi->ptMaxSize.x      = fb_win32.fullw;
			mmi->ptMaxSize.y      = fb_win32.fullh;
			mmi->ptMinTrackSize.x = fb_win32.fullw;
			mmi->ptMinTrackSize.y = fb_win32.fullh;
			mmi->ptMaxTrackSize.x = fb_win32.fullw;
			mmi->ptMaxTrackSize.y = fb_win32.fullh;
			return 0;
	}

	if ((message == WM_MOUSEMOVE) || (message == WM_MOUSEENTER)) {
		if ((!has_focus) && (fb_win32.is_active)) {
			track_e.cbSize = sizeof(TRACKMOUSEEVENT);
			track_e.dwFlags = TME_LEAVE;
			track_e.hwndTrack = hWnd;
			fb_win32.TrackMouseEvent(&track_e);
			has_focus = TRUE;
			e.type = EVENT_MOUSE_ENTER;
			if (fb_win32.mouse_clip) {
				fb_hSetMouseClip();
			}
		}
	}

	if (e.type)
		fb_hPostEvent(&e);

	if (message == WM_MOUSEENTER)
		return 0;
	else
		return DefWindowProc(hWnd, message, wParam, lParam);
}

void fb_hHandleMessages(void)
{
	MSG message;
	/* Passing NULL as HWND to ensure we process all messages. E.g. we may
	   receive thread messages which we should process too (at least by
	   applying the default message handling to them). This way we won't
	   cause unnecessary delays in default processing of messages such as
	   WindowsKey+R (open cmd.exe). */
	while (PeekMessage(&message, NULL, 0, 0, PM_REMOVE)) {
		TranslateMessage(&message);
		DispatchMessage(&message);
	}
}

int fb_hInitWindow(DWORD style, DWORD ex_style, int x, int y, int w, int h)
{
	fb_win32.fullw = w;
	fb_win32.fullh = h;

	fb_win32.wnd = CreateWindowEx(ex_style, fb_win32.window_class, fb_win32.window_title, style,
		x, y, w, h, HWND_DESKTOP, NULL, fb_win32.hinstance, NULL);
	if (!fb_win32.wnd)
		return -1;

	if (fb_win32.flags & DRIVER_ALWAYS_ON_TOP)
		SetWindowPos(fb_win32.wnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOSENDCHANGING);

	SetForegroundWindow(fb_win32.wnd);
	return 0;
}

int fb_hWin32Init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	OSVERSIONINFO info;
	HMODULE module;
	HANDLE events[2];
	long result;
	int i;

	info.dwOSVersionInfoSize = sizeof(info);
	GetVersionEx(&info);
	fb_win32.version = (info.dwMajorVersion << 8) | info.dwMinorVersion;

	module = GetModuleHandle("USER32");
	for (i = 0; i < ((int)sizeof(user32_procs)) / ((int)sizeof(user32_procs[0])); i++) {
		*user32_procs[i].proc = GetProcAddress(module, user32_procs[i].name);
	}

	if (fb_win32.MonitorFromPoint) {
		POINT pt;
		GetCursorPos(&pt);
		fb_win32.monitor = fb_win32.MonitorFromPoint(pt, MONITOR_DEFAULTTONEAREST);
	} else {
		fb_win32.monitor = NULL;
	}

	cursor_shown = TRUE;
	last_mouse_pos.x = 0xFFFF;
	fb_win32.mouse_clip = FALSE;

	if (!fb_win32.TrackMouseEvent) {
		fb_win32.TrackMouseEvent = fb_hTrackMouseEvent;
	}

	SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, &screensaver_active, 0);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, FALSE, NULL, 0);

	fb_win32.hinstance = (HINSTANCE)GetModuleHandle(NULL);
	fb_win32.window_title = title;

	/* Make a unique name for the window class, by encoding the address of the global context into it,
	   so that the window class won't be re-used by other instances of gfxlib2 (e.g. from DLLs). */
	snprintf( fb_win32.window_class, WINDOW_CLASS_SIZE-1, "%s%p", WINDOW_CLASS_PREFIX, &fb_win32 );
	fb_win32.window_class[WINDOW_CLASS_SIZE-1] = '\0';

	fb_win32.w = w;
	fb_win32.h = h;
	fb_win32.depth = depth;
	fb_win32.flags = flags;
	fb_win32.refresh_rate = refresh_rate;
	fb_win32.wndclass.lpfnWndProc = fb_hWin32WinProc;
	fb_win32.wndclass.lpszClassName = fb_win32.window_class;
	fb_win32.wndclass.hInstance = fb_win32.hinstance;
	fb_win32.wndclass.hCursor = LoadCursor(0, IDC_ARROW);
	fb_win32.wndclass.hIcon = LoadIcon(fb_win32.hinstance, "FB_PROGRAM_ICON");
	if (!fb_win32.wndclass.hIcon)
		fb_win32.wndclass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	fb_win32.wndclass.style = CS_DBLCLKS | ((flags & DRIVER_OPENGL) ? 0 : CS_VREDRAW | CS_HREDRAW);
	RegisterClass(&fb_win32.wndclass);

	mouse_buttons = mouse_wheel = 0;
	fb_win32.is_running = TRUE;

	keyconv_clear( &keyconv1 );
	keyconv_clear( &keyconv2 );

	if (fb_win32.thread != NULL) {
		InitializeCriticalSection(&update_lock);

		events[0] = CreateEvent( NULL, FALSE, FALSE, NULL );
		if( events[0] == NULL ) {
			return -1;
		}

#ifdef HOST_MINGW
		/* Note: _beginthreadex()'s last parameter cannot be NULL,
		   or else the function fails on Windows 9x */
		unsigned int thrdaddr;
		events[1] = (HANDLE)_beginthreadex( NULL, 0, fb_win32.thread, events[0], 0, &thrdaddr );
#else
		DWORD dwThreadId;
		events[1] = CreateThread( NULL, 0, fb_win32.thread, events[0], 0, &dwThreadId );
#endif
		if( events[1] == NULL ) {
			CloseHandle(events[0]);
			return -1;
		}

		result = WaitForMultipleObjects(2, events, FALSE, INFINITE);
		CloseHandle(events[0]);
		handle = events[1];
		if (result != WAIT_OBJECT_0)
			return -1;

		if(flags & DRIVER_HIGH_PRIORITY)
			SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL);
	} else {
		handle = NULL;
	}

	return 0;
}

void fb_hWin32Exit(void)
{
	if (!fb_win32.is_running)
		return;

	fb_win32.is_running = FALSE;

	if (__fb_gfx->lock_count != 0) {
		__fb_gfx->lock_count = 0;
		__fb_gfx->driver->unlock();
	}

	if (handle) {
		WaitForSingleObject(handle, INFINITE);
		CloseHandle( handle );
		handle = NULL;
		DeleteCriticalSection(&update_lock);
	}

	keyconv_clear( &keyconv1 );
	keyconv_clear( &keyconv2 );

	fb_win32.exit();

	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, screensaver_active, NULL, 0);
	UnregisterClass(fb_win32.window_class, fb_win32.hinstance);

	if (fb_win32.mouse_clip) {
		ClipCursor(NULL);
		fb_win32.mouse_clip = FALSE;
	}
}

void fb_hWin32Lock(void)
{
	EnterCriticalSection(&update_lock);
}

void fb_hWin32Unlock(void)
{
	LeaveCriticalSection(&update_lock);
}

void fb_hWin32SetPalette(int index, int r, int g, int b)
{
	fb_win32.palette[index].peRed = r;
	fb_win32.palette[index].peGreen = g;
	fb_win32.palette[index].peBlue = b;
	fb_win32.palette[index].peFlags = PC_NOCOLLAPSE;
	fb_win32.is_palette_changed = TRUE;
}

void fb_hWin32WaitVSync(void)
{
	Sleep(1000 / (__fb_gfx->refresh_rate ? __fb_gfx->refresh_rate : 60));
}

int fb_hWin32GetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	if ((!fb_win32.is_active) || (!mouse_on))
		return -1;

	if (x) *x = mouse_x;
	if (y) *y = mouse_y;
	if (z) *z = mouse_wheel;
	if (buttons) *buttons = mouse_buttons;
	if (clip) *clip = fb_win32.mouse_clip;

	return 0;
}

void fb_hWin32SetMouse(int x, int y, int cursor, int clip)
{
	POINT point;

	if (x != (int)0x80000000 || y != (int)0x80000000) {
		if (x == (int)0x80000000) {
			x = mouse_x;
		}
		else if (y == (int)0x80000000) {
			y = mouse_y;
		}

		x = MID(0, x, fb_win32.w - 1);
		y = MID(0, y, fb_win32.h - 1);

		mouse_on = TRUE;
		mouse_x = x;
		mouse_y = y;

		point.x = x;
		point.y = y;
		if (!(fb_win32.flags & DRIVER_FULLSCREEN))
			ClientToScreen(fb_win32.wnd, &point);
		SetCursorPos(point.x, point.y);
	}

	if ((cursor == 0) && (cursor_shown)) {
		cursor_shown = FALSE;
		PostMessage(fb_win32.wnd, WM_SETCURSOR, 0, 0);
	}
	else if ((cursor > 0) && (!cursor_shown)) {
		cursor_shown = TRUE;
		PostMessage(fb_win32.wnd, WM_SETCURSOR, 0, 0);
	}

	if (clip == 0) {
		fb_win32.mouse_clip = FALSE;
		ClipCursor(NULL);
	}
	else if (clip > 0) {
		fb_win32.mouse_clip = TRUE;
		fb_hSetMouseClip();
	}
}

void fb_hWin32SetWindowTitle(char *title)
{
	if (__fb_gfx->lock_count != 0)
		LeaveCriticalSection(&update_lock);
	fb_win32.window_title = title;
	SetWindowText(fb_win32.wnd, title);
	if (__fb_gfx->lock_count != 0)
		EnterCriticalSection(&update_lock);
}

int fb_hWin32SetWindowPos(int x, int y)
{
	if (fb_win32.flags & DRIVER_FULLSCREEN)
		return 0;

	if( (x == (int)0x80000000) && (y == (int)0x80000000) ) {
		/* Querying window position */
		RECT rc;
		if( GetWindowRect( fb_win32.wnd, &rc ) ) {
			x = rc.left;
			y = rc.top;
			return (x & 0xFFFF) | (y << 16);
		}
	} else {
		/* Setting window position */
		SetWindowPos( fb_win32.wnd, HWND_TOP, x, y, 0, 0,
			SWP_ASYNCWINDOWPOS | SWP_NOOWNERZORDER | SWP_NOSIZE | SWP_NOZORDER );
	}

	return 0;
}

void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
	DEVMODE cur;

	EnumDisplaySettings(NULL,ENUM_CURRENT_SETTINGS,&cur);
	*width = cur.dmPelsWidth;
	*height = cur.dmPelsHeight;
	*depth = cur.dmBitsPerPel;
	*refresh = cur.dmDisplayFrequency;
	
}

ssize_t fb_hGetWindowHandle(void)
{
	return (ssize_t)fb_win32.wnd;
}

ssize_t fb_hGetDisplayHandle(void)
{
	return 0;
}

static void keyconv_clear( KEYCONVINFO *k )
{
	if( k->v ) {
		free(k->v);
		k->v = NULL;
	}
	k->size = 0;
}

static void keyconv_grow( KEYCONVINFO *k, int nchars, int charsize )
{
	void * p = realloc( k->v, (nchars+1) * charsize );
	if( p ) {
		k->v = p;
		k->size = nchars;
	}
	if( k->v )
	{
		if( charsize == 2 )
			k->a[0] = 0;
		else
			k->w[0] = 0;
	}
}

static unsigned int hIntlConvertChar( int key, int source_cp, int dest_cp )
{
	/*
		Do key translation between code pages (from WM_CHAR message).

		keyconv1 and keyconv2 are allocated as needed, and cleaned
		up in the exit routine.  Ideally we would know the max buffer sizes
		needed but docs for WideCharToMultiByte/MultiByteToWideChar 
		indicate that the safe (only?) thing to do is call them twice 
		getting the size needed from the first call.  Seems excessive 
		when we know we are always converting only one character. (jeffm)
	*/

	char ch[2] = {
		(char) key,
		0
	};
	int length1, length2;

	if( !key )
		return 0;

	/* convert source (key) to wide character */
	length1 = MultiByteToWideChar( source_cp, 0,
									(LPCSTR)ch, 1,
									NULL, 0 );

	if( length1 > keyconv1.size )
		keyconv_grow( &keyconv1, length1, sizeof(WCHAR) );

	if(!keyconv1.w)
		return 0;

	length1 = MultiByteToWideChar( source_cp, 0,
							(LPCSTR)ch, 1,
							keyconv1.w, keyconv1.size );

	keyconv1.w[length1] = 0;

	/* convert wide character to code page character */
	length2 = WideCharToMultiByte( dest_cp, 0,
									(LPCWSTR)keyconv1.w, length1,
									(LPSTR)NULL, 0,
									NULL, NULL );

	if( length2 > keyconv2.size )
		keyconv_grow( &keyconv2, length2, sizeof(char) );

	if(!keyconv2.a)
		return 0;

	length2 = WideCharToMultiByte( dest_cp, 0,
		(LPCWSTR)keyconv1.w, length1,
		(LPSTR)keyconv2.a, keyconv2.size,
		NULL,NULL );

	keyconv2.a[length2] = 0;

	return keyconv2.a[0];
}
