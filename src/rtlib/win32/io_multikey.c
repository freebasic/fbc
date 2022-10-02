/* multikey function for Windows console mode apps */

#include "../fb.h"
#include <windows.h>

const unsigned char __fb_keytable[][3] = {
	{ SC_ESCAPE,    VK_ESCAPE,  0           },  { SC_1,         '1',        0           },
	{ SC_2,         '2',        0           },  { SC_3,         '3',        0           },
	{ SC_4,         '4',        0           },  { SC_5,         '5',        0           },
	{ SC_6,         '6',        0           },  { SC_7,         '7',        0           },
	{ SC_8,         '8',        0           },  { SC_9,         '9',        0           },
	{ SC_0,         '0',        0           },  { SC_MINUS,     0xBD,       VK_SUBTRACT },
	{ SC_EQUALS,    0xBB,       0           },  { SC_BACKSPACE, VK_BACK,    0           },
	{ SC_TAB,       VK_TAB,     0           },  { SC_Q,         'Q',        0           },
	{ SC_W,         'W',        0           },  { SC_E,         'E',        0           },
	{ SC_R,         'R',        0           },  { SC_T,         'T',        0           },
	{ SC_Y,         'Y',        0           },  { SC_U,         'U',        0           },
	{ SC_I,         'I',        0           },  { SC_O,         'O',        0           },
	{ SC_P,         'P',        0           },  { SC_LEFTBRACKET,0xDB,      0           },
	{ SC_RIGHTBRACKET,0xDD,     0           },  { SC_ENTER,     VK_RETURN,  0           },
	{ SC_CONTROL,   VK_CONTROL, 0           },  { SC_A,         'A',        0           },
	{ SC_S,         'S',        0           },  { SC_D,         'D',        0           },
	{ SC_F,         'F',        0           },  { SC_G,         'G',        0           },
	{ SC_H,         'H',        0           },  { SC_J,         'J',        0           },
	{ SC_K,         'K',        0           },  { SC_L,         'L',        0           },
	{ SC_SEMICOLON, 0xBA,       0           },  { SC_QUOTE,     0xDE,       0           },
	{ SC_TILDE,     0xC0,       0           },  { SC_LSHIFT,    VK_SHIFT,   0           },
	{ SC_BACKSLASH, 0xDC,       0           },  { SC_Z,         'Z',        0           },
	{ SC_X,         'X',        0           },  { SC_C,         'C',        0           },
	{ SC_V,         'V',        0           },  { SC_B,         'B',        0           },
	{ SC_N,         'N',        0           },  { SC_M,         'M',        0           },
	{ SC_COMMA,     0xBC,       0           },  { SC_PERIOD,    0xBE,       0           },
	{ SC_SLASH,     0xBF,       VK_DIVIDE   },  { SC_RSHIFT,    VK_SHIFT,   0           },
	{ SC_MULTIPLY,  VK_MULTIPLY,0           },  { SC_ALT,       VK_MENU,    0           },
	{ SC_SPACE,     VK_SPACE,   0           },  { SC_CAPSLOCK,  VK_CAPITAL, 0           },
	{ SC_F1,        VK_F1,      0           },  { SC_F2,        VK_F2,      0           },
	{ SC_F3,        VK_F3,      0           },  { SC_F4,        VK_F4,      0           },
	{ SC_F5,        VK_F5,      0           },  { SC_F6,        VK_F6,      0           },
	{ SC_F7,        VK_F7,      0           },  { SC_F8,        VK_F8,      0           },
	{ SC_F9,        VK_F9,      0           },  { SC_F10,       VK_F10,     0           },
	{ SC_NUMLOCK,   VK_NUMLOCK, 0           },  { SC_SCROLLLOCK,VK_SCROLL,  0           },
	{ SC_HOME,      VK_HOME,    VK_NUMPAD7  },  { SC_UP,        VK_UP,      VK_NUMPAD8  },
	{ SC_PAGEUP,    VK_PRIOR,   VK_NUMPAD9  },  { SC_LEFT,      VK_LEFT,    VK_NUMPAD4  },
	{ SC_CLEAR,     VK_NUMPAD5, 0           },
	{ SC_RIGHT,     VK_RIGHT,   VK_NUMPAD6  },  { SC_PLUS,      VK_ADD,     0           },
	{ SC_END,       VK_END,     VK_NUMPAD1  },  { SC_DOWN,      VK_DOWN,    VK_NUMPAD2  },
	{ SC_PAGEDOWN,  VK_NEXT,    VK_NUMPAD3  },  { SC_INSERT,    VK_INSERT,  VK_NUMPAD0  },
	{ SC_DELETE,    VK_DELETE,  VK_DECIMAL  },  { SC_F11,       VK_F11,     0           },
	{ SC_F12,       VK_F12,     0           },  { SC_LWIN,      VK_LWIN,    0           },
	{ SC_RWIN,      VK_RWIN,    0           },  { SC_MENU,      VK_APPS,    0           },
	{ 0,            0,          0           }
};

static HWND find_window(void)
{
	TCHAR old_title[MAX_PATH];
	TCHAR title[MAX_PATH];
	static HWND hwnd = NULL;

	if (hwnd)
		return hwnd;

	if (GetConsoleTitle(old_title, MAX_PATH)) {
		sprintf(title, "_fb_console_title %f", fb_Timer());
		SetConsoleTitle(title);
		hwnd = FindWindow(NULL, title);
		SetConsoleTitle(old_title);
	}
	return hwnd;
}

int fb_hVirtualToScancode(int vkey)
{
	int i;

	for (i = 0; __fb_keytable[i][0]; i++)
		if ((__fb_keytable[i][2] == vkey) || (__fb_keytable[i][1] == vkey))
			return __fb_keytable[i][0];
	return 0;
}

int fb_ConsoleMultikey( int scancode )
{
	int i;

	if ( find_window() != GetForegroundWindow() )
		return FB_FALSE;

	for( i = 0; __fb_keytable[i][0]; i++ ) {
		if( __fb_keytable[i][0] == scancode ) {
			return ((GetAsyncKeyState(__fb_keytable[i][1]) | GetAsyncKeyState(__fb_keytable[i][2])) & 0x8000) ? FB_TRUE : FB_FALSE;
		}
	}
	return FB_FALSE;
}
