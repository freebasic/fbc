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
 * chng: jan/2005 written [lillo]
 *
 */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"


static int driver_init(char *title, int w, int h, int depth, int flags);


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
	fb_hWin32SetWindowTitle	/* void (*set_window_title)(char *title); */
};


static const unsigned char keytable[][3] = {
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

static BITMAPINFO *bitmap_info;
static HDC hdc;
static RECT rect;
static unsigned char *buffer;


/*:::::*/
static void gdi_paint(void)
{
	unsigned char *source = (fb_win32.blitter ? buffer : fb_mode->framebuffer);
	
	StretchDIBits(hdc, 0, 0, fb_win32.w, fb_win32.h, 0, 0, fb_win32.w, fb_win32.h,
	      source, bitmap_info, DIB_RGB_COLORS, SRCCOPY);
}


/*:::::*/
static int gdi_init(void)
{
	WNDCLASS wndclass;
	
	bitmap_info = NULL;
	buffer = NULL;
	
	if (fb_win32.fullscreen)
		return -1;
	fb_hMemSet(&wndclass, 0, sizeof(wndclass));
	wndclass.lpfnWndProc = fb_hWin32WinProc;
	wndclass.lpszClassName = fb_win32.window_class;
	wndclass.hInstance = fb_win32.hinstance;
	wndclass.style = CS_VREDRAW | CS_HREDRAW | CS_OWNDC;
	wndclass.hCursor = LoadCursor(0, IDC_ARROW);
	RegisterClass(&wndclass);
	
	rect.left = rect.top = 0;
	rect.right = fb_win32.w - 1;
	rect.bottom = fb_win32.h - 1;
	AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, 0);
	rect.right -= (rect.left + 1);
	rect.bottom -= (rect.top + 1);
	fb_win32.wnd = CreateWindow(fb_win32.window_class, fb_win32.window_title,
			   (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME & ~WS_MAXIMIZEBOX) | WS_VISIBLE,
			   (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1,
			   (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1,
			   rect.right, rect.bottom, 0, 0, 0, 0);
	if (!fb_win32.wnd)
		return -1;
	
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
	
	if (fb_win32.depth == 16) {
		fb_win32.blitter = fb_hGetBlitter(15, FALSE);
		if (!fb_win32.blitter)
			return -1;
		buffer = malloc(((fb_win32.w + 1) & ~1) * fb_win32.h * 2);
		if (!buffer)
			return -1;
	}
	
	SetForegroundWindow(fb_win32.wnd);
	hdc = GetDC(fb_win32.wnd);
	

	return 0;
}


/*:::::*/
static void gdi_exit(void)
{
	if (buffer)
		free(buffer);
	if (bitmap_info)
		free(bitmap_info);
	if (fb_win32.wnd)
		DestroyWindow(fb_win32.wnd);
}


/*:::::*/
static void gdi_thread(HANDLE running_event)
{
	MSG message;
	int i, y, h;
	unsigned char *source, keystate[256];
	
	if (gdi_init())
		goto error;
	
	SetEvent(running_event);
	fb_win32.is_active = TRUE;
	
	while (fb_win32.is_running)
	{
		fb_hWin32Lock();
		
		if (fb_win32.is_active) {
			if (fb_win32.is_palette_changed) {
				/* Can't use fb_hMemCpy as structure layout is different :( */
				for (i = 0; i < 256; i++) {
					bitmap_info->bmiColors[i].rgbRed = fb_win32.palette[i].peRed;
					bitmap_info->bmiColors[i].rgbGreen = fb_win32.palette[i].peGreen;
					bitmap_info->bmiColors[i].rgbBlue = fb_win32.palette[i].peBlue;
				}
			}
			if (fb_win32.blitter) {
				fb_win32.blitter(buffer, (fb_mode->pitch + 3) & ~3);
				source = buffer;
			}
			else
				source = fb_mode->framebuffer;
			for (i = 0; i < fb_win32.h; i++) {
				if (fb_mode->dirty[i]) {
					for (y = i, h = 0; (fb_mode->dirty[i]) && (i < fb_win32.h); h++, i++)
						;
					StretchDIBits(hdc, 0, y, fb_win32.w, h, 0, fb_win32.h - y - h, fb_win32.w, h,
						      source, bitmap_info, DIB_RGB_COLORS, SRCCOPY);
				}
			}
			fb_hMemSet(fb_mode->dirty, FALSE, fb_win32.h);
		}
		
		GetKeyboardState(keystate);
		for (i = 0; i < keytable[i][0]; i++) {
			if (keytable[i][2])
				fb_mode->key[keytable[i][0]] = ((keystate[keytable[i][1]] & 0x80) |
								(keystate[keytable[i][2]] & 0x80)) ? TRUE : FALSE;
			else
				fb_mode->key[keytable[i][0]] = (keystate[keytable[i][1]] & 0x80) ? TRUE : FALSE;
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
	gdi_exit();
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int flags)
{
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));
	fb_win32.init = gdi_init;
	fb_win32.exit = gdi_exit;
	fb_win32.paint = gdi_paint;
	fb_win32.thread = gdi_thread;
	fb_hWin32Init(title, w, h, depth, flags);
}
