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
 * win32.c -- common win32 routines and drivers list
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"


WIN32DRIVER fb_win32;

const GFXDRIVER *fb_gfx_driver_list[] = {
	&fb_gfxDriverDirectDraw,
	&fb_gfxDriverGDI,
	&fb_gfxDriverOpenGL,
	NULL
};

const unsigned char fb_keytable[][3] = {
	{ SC_ESCAPE,	VK_ESCAPE,	0		},	{ SC_1,		'1',		0		},
	{ SC_2,		'2',		0		},	{ SC_3,		'3',		0		},
	{ SC_4,		'4',		0		},	{ SC_5,		'5',		0		},
	{ SC_6,		'6',		0		},	{ SC_7,		'7',		0		},
	{ SC_8,		'8',		0		},	{ SC_9,		'9',		0		},
	{ SC_0,		'0',		0		},	{ SC_MINUS,	0xBD,		VK_SUBTRACT	},
	{ SC_EQUALS,	0xBB,		0		},	{ SC_BACKSPACE,	VK_BACK,	0		},
	{ SC_TAB,	VK_TAB,		0		},	{ SC_Q,		'Q',		0		},
	{ SC_W,		'W',		0		},	{ SC_E, 	'E',		0		},
	{ SC_R,		'R',		0		},	{ SC_T,		'T',		0		},
	{ SC_Y,		'Y',		0		},	{ SC_U,		'U',		0		},
	{ SC_I,		'I',		0		},	{ SC_O,		'O',		0		},
	{ SC_P,		'P',		0		},	{ SC_LEFTBRACKET,0xDB,		0		},
	{ SC_RIGHTBRACKET,0xDD,		0		},	{ SC_ENTER,	VK_RETURN,	0		},
	{ SC_CONTROL, 	VK_CONTROL,	0		},	{ SC_A,		'A',		0		},
	{ SC_S,		'S',		0		},	{ SC_D,		'D',		0		},
	{ SC_F,		'F',		0		},	{ SC_G,		'G',		0		},
	{ SC_H,		'H',		0		},	{ SC_J,		'J',		0		},
	{ SC_K,		'K',		0		},	{ SC_L,		'L',		0		},
	{ SC_SEMICOLON,	0xBA,		0		},	{ SC_QUOTE,	0xDE,		0		},
	{ SC_TILDE,	0xC0,		0		},	{ SC_LSHIFT,	VK_SHIFT,	0		},
	{ SC_BACKSLASH,	0xDC,		0		},	{ SC_Z,		'Z',		0		},
	{ SC_X,		'X',		0		},	{ SC_C,		'C',		0		},
	{ SC_V,		'V',		0		},	{ SC_B,		'B',		0		},
	{ SC_N,		'N',		0		},	{ SC_M,		'M',		0		},
	{ SC_COMMA,	0xBC,		0		},	{ SC_PERIOD,	0xBE,		0		},
	{ SC_SLASH,	0xBF,		VK_DIVIDE	},	{ SC_RSHIFT,	VK_SHIFT,	0		},
	{ SC_MULTIPLY,	VK_MULTIPLY,	0		},	{ SC_ALT,	VK_MENU,	0		},
	{ SC_SPACE,	VK_SPACE,	0		},	{ SC_CAPSLOCK,	VK_CAPITAL,	0		},
	{ SC_F1,	VK_F1,		0		},	{ SC_F2,	VK_F2,		0		},
	{ SC_F3,	VK_F3,		0		},	{ SC_F4,	VK_F4,		0		},
	{ SC_F5,	VK_F5,		0		},	{ SC_F6,	VK_F6,		0		},
	{ SC_F7,	VK_F7,		0		},	{ SC_F8,	VK_F8,		0		},
	{ SC_F9,	VK_F9,		0		},	{ SC_F10,	VK_F10,		0		},
	{ SC_NUMLOCK,	VK_NUMLOCK,	0		},	{ SC_SCROLLLOCK,VK_SCROLL,	0		},
	{ SC_HOME,	VK_HOME,	VK_NUMPAD7	},	{ SC_UP,	VK_UP,		VK_NUMPAD8	},
	{ SC_PAGEUP,	VK_PRIOR,	VK_NUMPAD9	},	{ SC_LEFT,	VK_LEFT,	VK_NUMPAD4	},
	{ SC_RIGHT,	VK_RIGHT,	VK_NUMPAD6	},	{ SC_PLUS,	VK_ADD,		0		},
	{ SC_END,	VK_END,		VK_NUMPAD1	},	{ SC_DOWN,	VK_DOWN,	VK_NUMPAD2	},
	{ SC_PAGEDOWN,	VK_NEXT,	VK_NUMPAD3	},	{ SC_INSERT,	VK_INSERT,	VK_NUMPAD0	},
	{ SC_DELETE,	VK_DELETE,	VK_DECIMAL	},	{ SC_F11,	VK_F11,		0		},
	{ SC_F12,	VK_F12,		0		},	{ SC_LWIN,	VK_LWIN,	0		},
	{ SC_RWIN,	VK_RWIN,	0		},	{ SC_MENU,	VK_APPS,	0		},
	{ 0,		0,		0		}
};


static CRITICAL_SECTION update_lock;
static HANDLE handle;
static BOOL screensaver_active, cursor_shown;
static UINT msg_cursor;
static int mouse_buttons, mouse_wheel;


/*:::::*/
LRESULT CALLBACK fb_hWin32WinProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int result;
	char key_state[256];
	WORD key = 0;
	
	if (message == msg_cursor) {
		ShowCursor(wParam);
		return 0;
	}

	switch (message)
	{
		case WM_ACTIVATEAPP:
			fb_win32.is_active = (int)wParam;
			fb_hMemSet(fb_mode->key, FALSE, 128);
			mouse_buttons = mouse_wheel = 0;
			fb_hMemSet(fb_mode->dirty, TRUE, fb_win32.h);
			break;
		
		case WM_LBUTTONDOWN:
			mouse_buttons |= 0x1;
			break;
		
		case WM_LBUTTONUP:
			mouse_buttons &= ~0x1;
			break;
		
		case WM_RBUTTONDOWN:
			mouse_buttons |= 0x2;
			break;
		
		case WM_RBUTTONUP:
			mouse_buttons &= ~0x2;
			break;
		
		case WM_MBUTTONDOWN:
			mouse_buttons |= 0x4;
			break;
		
		case WM_MBUTTONUP:
			mouse_buttons &= ~0x4;
			break;
		
		case WM_MOUSEWHEEL:
			if ((signed)wParam > 0)
				mouse_wheel++;
			else
				mouse_wheel--;
			break;
		
		case WM_SIZE:
		case WM_SYSKEYDOWN:
			if (((message == WM_SIZE) && (wParam == SIZE_MAXIMIZED)) ||
			    ((message == WM_SYSKEYDOWN) && (wParam == VK_RETURN) && (lParam & 0x20000000))) {
				fb_win32.exit();
				fb_win32.fullscreen ^= TRUE;
				if (fb_win32.init()) {
					fb_win32.exit();
					fb_win32.fullscreen ^= TRUE;
					fb_win32.init();
				}
				fb_hRestorePalette();
				fb_hMemSet(fb_mode->dirty, TRUE, fb_win32.h);
				fb_win32.is_active = TRUE;
			}
			return 0;

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
			if (key)
				fb_hPostKey(key);
			return 0;

		case WM_CLOSE:
			fb_hPostKey(KEY_QUIT);
			return 0;

		case WM_PAINT:
			fb_win32.paint();
			break;
	}

	return DefWindowProc(hWnd, message, wParam, lParam);
}


/*:::::*/
int fb_hWin32Init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	HANDLE events[2];
	long result;

	msg_cursor = RegisterWindowMessage("FB mouse cursor");
	cursor_shown = TRUE;
	
	fb_win32.hinstance = (HINSTANCE)GetModuleHandle(NULL);
	fb_win32.window_title = title;
	strcpy( fb_win32.window_class, WINDOW_CLASS_PREFIX );
	strcat( fb_win32.window_class, fb_win32.window_title );
	fb_win32.w = w;
	fb_win32.h = h;
	fb_win32.depth = depth;
	fb_win32.fullscreen = (flags & DRIVER_FULLSCREEN) ? TRUE : FALSE;
	fb_win32.refresh_rate = refresh_rate;
	fb_win32.wndclass.lpfnWndProc = fb_hWin32WinProc;
	fb_win32.wndclass.lpszClassName = fb_win32.window_class;
	fb_win32.wndclass.hInstance = fb_win32.hinstance;
	fb_win32.wndclass.hCursor = LoadCursor(0, IDC_ARROW);
	fb_win32.wndclass.hIcon = LoadIcon(fb_win32.hinstance, "FB_PROGRAM_ICON");
	if (!fb_win32.wndclass.hIcon)
		fb_win32.wndclass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	fb_win32.wndclass.style = CS_VREDRAW | CS_HREDRAW | CS_OWNDC;
	RegisterClass(&fb_win32.wndclass);

	fb_win32.is_running = TRUE;

	InitializeCriticalSection(&update_lock);
	fb_win32.vsync_event = CreateEvent(NULL, FALSE, FALSE, NULL);
	events[0] = CreateEvent(NULL, FALSE, FALSE, NULL);
	events[1] = (HANDLE)_beginthread(fb_win32.thread, 0, events[0]);
	result = WaitForMultipleObjects(2, events, FALSE, INFINITE);
	CloseHandle(events[0]);
	handle = events[1];
	if (result != WAIT_OBJECT_0) {
		DeleteCriticalSection(&update_lock);
		return -1;
	}
	
	if (!(flags & DRIVER_OPENGL))
		SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL);

	SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, &screensaver_active, 0);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, FALSE, NULL, 0);
	
	return 0;
}


/*:::::*/
void fb_hWin32Exit(void)
{
	if (!fb_win32.is_running)
		return;
	fb_win32.is_running = FALSE;
	WaitForSingleObject(handle, INFINITE);
	CloseHandle(fb_win32.vsync_event);
	DeleteCriticalSection(&update_lock);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, screensaver_active, NULL, 0);
	UnregisterClass(fb_win32.window_class, fb_win32.hinstance);
}


/*:::::*/
void fb_hWin32Lock(void)
{
	EnterCriticalSection(&update_lock);
}


/*:::::*/
void fb_hWin32Unlock(void)
{
	LeaveCriticalSection(&update_lock);
}


/*:::::*/
void fb_hWin32SetPalette(int index, int r, int g, int b)
{
	fb_win32.palette[index].peRed = r;
	fb_win32.palette[index].peGreen = g;
	fb_win32.palette[index].peBlue = b;
	fb_win32.palette[index].peFlags = PC_NOCOLLAPSE;
	fb_win32.is_palette_changed = TRUE;
}


/*:::::*/
void fb_hWin32WaitVSync(void)
{
	WaitForSingleObject(fb_win32.vsync_event, 1000/60);
}


/*:::::*/
int fb_hWin32GetMouse(int *x, int *y, int *z, int *buttons)
{
	POINT point;
	
	if (!fb_win32.is_active)
		return -1;
	
	GetCursorPos(&point);
	
	if (fb_win32.fullscreen) {
		*x = MID(0, point.x, fb_win32.w - 1);
		*y = MID(0, point.y, fb_win32.h - 1);
	}
	else {
		ScreenToClient(fb_win32.wnd, &point);
		if ((point.x < 0) || (point.x >= fb_win32.w) || (point.y < 0) || (point.y >= fb_win32.h)) {
			mouse_buttons = 0;
			return -1;
		}
		else {
			*x = point.x;
			*y = point.y;
		}
	}
	*z = mouse_wheel;
	*buttons = mouse_buttons;
	
	return 0;
}


/*:::::*/
void fb_hWin32SetMouse(int x, int y, int cursor)
{
	POINT point;
	
	if (x >= 0) {
		point.x = MID(0, x, fb_win32.w - 1);
		point.y = MID(0, y, fb_win32.h - 1);
		if (!fb_win32.fullscreen)
			ClientToScreen(fb_win32.wnd, &point);
		SetCursorPos(point.x, point.y);
	}
	
	if ((cursor == 0) && (cursor_shown)) {
		PostMessage(fb_win32.wnd, msg_cursor, FALSE, 0);
		cursor_shown = FALSE;
	}
	else if ((cursor > 0) && (!cursor_shown)) {
		PostMessage(fb_win32.wnd, msg_cursor, TRUE, 0);
		cursor_shown = TRUE;
	}
}


/*:::::*/
void fb_hWin32SetWindowTitle(char *title)
{
	SetWindowText(fb_win32.wnd, title);
}
