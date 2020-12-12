struct _EVENT {
	int type;
	union {
		struct {			/* keyboard events */
			int scancode;
			int ascii;
		};
		struct {			/* mouse events */
			int x, y;
			int dx, dy;
		};
		int button;
		int z;
		int w;
	};
} FBPACKED;

typedef struct _EVENT EVENT;

#define EVENT_KEY_PRESS				1
#define EVENT_KEY_RELEASE			2
#define EVENT_KEY_REPEAT			3
#define EVENT_MOUSE_MOVE			4
#define EVENT_MOUSE_BUTTON_PRESS	5
#define EVENT_MOUSE_BUTTON_RELEASE	6
#define EVENT_MOUSE_DOUBLE_CLICK	7
#define EVENT_MOUSE_WHEEL			8
#define EVENT_MOUSE_ENTER			9
#define EVENT_MOUSE_EXIT			10
#define EVENT_WINDOW_GOT_FOCUS		11
#define EVENT_WINDOW_LOST_FOCUS		12
#define EVENT_WINDOW_CLOSE			13
#define EVENT_MOUSE_HWHEEL			14

#define MAX_EVENTS					128

#define BUTTON_LEFT					0x1
#define BUTTON_RIGHT					0x2
#define BUTTON_MIDDLE				0x4
#define BUTTON_X1						0x8
#define BUTTON_X2						0x10

/* DOS keyboard scancodes */
#define SC_ESCAPE	0x01
#define SC_1		0x02
#define SC_2		0x03
#define SC_3		0x04
#define SC_4		0x05
#define SC_5		0x06
#define SC_6		0x07
#define SC_7		0x08
#define SC_8		0x09
#define SC_9		0x0A
#define SC_0		0x0B
#define SC_MINUS	0x0C
#define SC_EQUALS	0x0D
#define SC_BACKSPACE	0x0E
#define SC_TAB		0x0F
#define SC_Q		0x10
#define SC_W		0x11
#define SC_E		0x12
#define SC_R		0x13
#define SC_T		0x14
#define SC_Y		0x15
#define SC_U		0x16
#define SC_I		0x17
#define SC_O		0x18
#define SC_P		0x19
#define SC_LEFTBRACKET	0x1A
#define SC_RIGHTBRACKET	0x1B
#define SC_ENTER	0x1C
#define SC_CONTROL	0x1D
#define SC_A		0x1E
#define SC_S		0x1F
#define SC_D		0x20
#define SC_F		0x21
#define SC_G		0x22
#define SC_H		0x23
#define SC_J		0x24
#define SC_K		0x25
#define SC_L		0x26
#define SC_SEMICOLON	0x27
#define SC_QUOTE	0x28
#define SC_TILDE	0x29
#define SC_LSHIFT	0x2A
#define SC_BACKSLASH	0x2B
#define SC_Z		0x2C
#define SC_X		0x2D
#define SC_C		0x2E
#define SC_V		0x2F
#define SC_B		0x30
#define SC_N		0x31
#define SC_M		0x32
#define SC_COMMA	0x33
#define SC_PERIOD	0x34
#define SC_SLASH	0x35
#define SC_RSHIFT	0x36
#define SC_MULTIPLY	0x37
#define SC_ALT		0x38
#define SC_SPACE	0x39
#define SC_CAPSLOCK	0x3A
#define SC_F1		0x3B
#define SC_F2		0x3C
#define SC_F3		0x3D
#define SC_F4		0x3E
#define SC_F5		0x3F
#define SC_F6		0x40
#define SC_F7		0x41
#define SC_F8		0x42
#define SC_F9		0x43
#define SC_F10		0x44
#define SC_NUMLOCK	0x45
#define SC_SCROLLLOCK	0x46
#define SC_HOME		0x47
#define SC_UP		0x48
#define SC_PAGEUP	0x49
#define SC_LEFT		0x4B
#define SC_CLEAR	0x4C
#define SC_RIGHT	0x4D
#define SC_PLUS		0x4E
#define SC_END		0x4F
#define SC_DOWN		0x50
#define SC_PAGEDOWN	0x51
#define SC_INSERT	0x52
#define SC_DELETE	0x53
#define SC_F11		0x57
#define SC_F12		0x58
#define SC_LWIN		0x5B
#define SC_RWIN		0x5C
#define SC_MENU		0x5D
#define SC_ALTGR	0x64

#define KEY_BACKSPACE   8
#define KEY_TAB         '\t'
#define KEY_F1          FB_MAKE_EXT_KEY( ';' )
#define KEY_F2          FB_MAKE_EXT_KEY( '<' )
#define KEY_F3          FB_MAKE_EXT_KEY( '=' )
#define KEY_F4          FB_MAKE_EXT_KEY( '>' )
#define KEY_F5          FB_MAKE_EXT_KEY( '?' )
#define KEY_F6          FB_MAKE_EXT_KEY( '@' )
#define KEY_F7          FB_MAKE_EXT_KEY( 'A' )
#define KEY_F8          FB_MAKE_EXT_KEY( 'B' )
#define KEY_F9          FB_MAKE_EXT_KEY( 'C' )
#define KEY_F10         FB_MAKE_EXT_KEY( 'D' )
#define KEY_F11         FB_MAKE_EXT_KEY( 'E' )
#define KEY_F12         FB_MAKE_EXT_KEY( 'F' )
#define KEY_HOME        FB_MAKE_EXT_KEY( 'G' )
#define KEY_UP          FB_MAKE_EXT_KEY( 'H' )
#define KEY_PAGE_UP     FB_MAKE_EXT_KEY( 'I' )
#define KEY_LEFT        FB_MAKE_EXT_KEY( 'K' )
#define KEY_CLEAR       FB_MAKE_EXT_KEY( 'L' )
#define KEY_RIGHT       FB_MAKE_EXT_KEY( 'M' )
#define KEY_END         FB_MAKE_EXT_KEY( 'O' )
#define KEY_DOWN        FB_MAKE_EXT_KEY( 'P' )
#define KEY_PAGE_DOWN   FB_MAKE_EXT_KEY( 'Q' )
#define KEY_INS         FB_MAKE_EXT_KEY( 'R' )
#define KEY_DEL         FB_MAKE_EXT_KEY( 'S' )
#define KEY_QUIT        FB_MAKE_EXT_KEY( 'k' )

#define QB_EXTK(x)(((unsigned short)(x))<<8|0xff)

