/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * io_multikey.c -- Linux multikey function implementation
 *
 * chng: jul/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"
#include "fb_scancodes.h"
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <linux/kd.h>
#include <linux/keyboard.h>
#include <linux/vt.h>

#define KEY_BUFFER_SIZE		16
#define NUM_PAD_KEYS		17


typedef Display *(*XOPENDISPLAY)(char *);
typedef int (*XCLOSEDISPLAY)(Display *);
typedef void (*XQUERYKEYMAP)(Display *, unsigned char *);
typedef int (*XDISPLAYKEYCODES)(Display *, int *, int *);
typedef KeySym (*XKEYCODETOKEYSYM)(Display *, KeyCode, int);

static pid_t main_pid;
static Display *display;
static XOPENDISPLAY fb_XOpenDisplay = NULL;
static XCLOSEDISPLAY fb_XCloseDisplay;
static XQUERYKEYMAP fb_XQueryKeymap;
static XDISPLAYKEYCODES fb_XDisplayKeycodes;
static XKEYCODETOKEYSYM fb_XKeycodeToKeysym;
static int key_fd, key_old_mode, key_leds;

static unsigned char key_state[128], scancode[256];
static unsigned short key_buffer[KEY_BUFFER_SIZE], key_head, key_tail;
static void (*keyboard_handler)(void);
static int (*old_getch)(void);

static const char pad_numlock_ascii[NUM_PAD_KEYS] = "0123456789+-*/\r,.";
static const char pad_ascii[NUM_PAD_KEYS] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '+', '-', '*', '/', '\r', 0, 0 };

static const unsigned char kernel_to_scancode[] = {
	0,				SC_ESCAPE,		SC_1,			SC_2,
	SC_3,			SC_4,			SC_5,			SC_6,
	SC_7,			SC_8,			SC_9,			SC_0,
	SC_MINUS,		SC_EQUALS,		SC_BACKSPACE,	SC_TAB,
	SC_Q,			SC_W,			SC_E,			SC_R,
	SC_T,			SC_Y,			SC_U,			SC_I,
	SC_O,			SC_P,			SC_LEFTBRACKET,	SC_RIGHTBRACKET,
	SC_ENTER,		SC_CONTROL,		SC_A,			SC_S,
	SC_D,			SC_F,			SC_G,			SC_H,
	SC_J,			SC_K,			SC_L,			SC_SEMICOLON,
	SC_QUOTE,		SC_TILDE,		SC_LSHIFT,		SC_BACKSLASH,
	SC_Z,			SC_X,			SC_C,			SC_V,
	SC_B,			SC_N,			SC_M,			SC_COMMA,
	SC_PERIOD,		SC_SLASH,		SC_RSHIFT,		SC_MULTIPLY,
	SC_ALT,			SC_SPACE,		SC_CAPSLOCK,	SC_F1,
	SC_F2,			SC_F3,			SC_F4,			SC_F5,
	SC_F6,			SC_F7,			SC_F8,			SC_F9,
	SC_F10,			SC_NUMLOCK,		SC_SCROLLLOCK,	SC_HOME,
	SC_UP,			SC_PAGEUP,		SC_MINUS,		SC_LEFT,
	0,				SC_RIGHT,		SC_PLUS,		SC_END,
	SC_DOWN,		SC_PAGEDOWN,	SC_0,			SC_DELETE,
	0,				0,				SC_BACKSLASH,	SC_F11,
	SC_F12,			0,				0,				0,
	0,				0,				0,				0,
	SC_ENTER,		SC_CONTROL,		SC_SLASH,		0,
	SC_ALTGR,		0,				SC_HOME,		SC_UP,
	SC_PAGEUP,		SC_LEFT,		SC_RIGHT,		SC_END,
	SC_DOWN,		SC_PAGEDOWN,	SC_INSERT,		SC_DELETE,
	0,				0,				0,				0,
	0,				0,				0,				0,
	0,				0,				0,				0,
	0,				SC_LWIN,		SC_RWIN,		SC_MENU
};

const struct
{
	KeySym keysym;
	int scancode;
} fb_keysym_to_scancode[] = {
	{ XK_Escape,		0x01 },	{ XK_F1,			0x3B }, { XK_F2,			0x3C },
	{ XK_F3,			0x3D }, { XK_F4,			0x3E }, { XK_F5,			0x3F },
	{ XK_F6,			0x40 }, { XK_F7,			0x41 },	{ XK_F8,			0x42 },
	{ XK_F9,			0x43 }, { XK_F10,			0x44 }, { XK_F11,			0x57 },
	{ XK_F12,			0x58 }, { XK_Scroll_Lock,	0x46 }, { XK_grave,			0x29 },
	{ XK_quoteleft,		0x29 }, { XK_asciitilde,	0x29 }, { XK_1,				0x02 },
	{ XK_2,				0x03 }, { XK_3,				0x04 }, { XK_4,				0x05 },
	{ XK_5,				0x06 }, { XK_6,				0x07 }, { XK_7,				0x08 },
	{ XK_8,				0x09 }, { XK_9,				0x0A }, { XK_0,				0x0B },
	{ XK_minus,			0x0C }, { XK_equal,			0x0D }, { XK_backslash,		0x2B },
	{ XK_BackSpace,		0x0E }, { XK_Tab,			0x0F }, { XK_q,				0x10 },
	{ XK_w,				0x11 }, { XK_e,				0x12 }, { XK_r,				0x13 },
	{ XK_t,				0x14 }, { XK_y,				0x15 }, { XK_u,				0x16 },
	{ XK_i,				0x17 }, { XK_o,				0x18 }, { XK_p,				0x19 },
	{ XK_bracketleft,	0x1A }, { XK_bracketright,	0x1B }, { XK_Return,		0x1C },
	{ XK_Caps_Lock,		0x3A }, { XK_a,				0x1E }, { XK_s,				0x1F },
	{ XK_d,				0x20 }, { XK_f,				0x21 }, { XK_g,				0x22 },
	{ XK_h,				0x23 }, { XK_j,				0x24 }, { XK_k,				0x25 },
	{ XK_l,				0x26 }, { XK_semicolon,		0x27 }, { XK_apostrophe,	0x28 },
	{ XK_Shift_L,		0x2A }, { XK_z,				0x2C }, { XK_x,				0x2D },
	{ XK_c,				0x2E }, { XK_v,				0x2F }, { XK_b,				0x30 },
	{ XK_n,				0x31 }, { XK_m,				0x32 }, { XK_comma,			0x33 },
	{ XK_period,		0x34 }, { XK_slash,			0x35 }, { XK_Shift_R,		0x36 },
	{ XK_Control_L,		0x1D }, { XK_Meta_L,		0x7D }, { XK_Alt_L,			0x38 },
	{ XK_space,			0x39 }, { XK_Alt_R,			0x38 }, { XK_Meta_R,		0x7E },
	{ XK_Menu,			0x7F }, { XK_Control_R,		0x1D }, { XK_Insert,		0x52 },
	{ XK_Home,			0x47 }, { XK_Prior,			0x49 }, { XK_Delete,		0x53 },
	{ XK_End,			0x4F }, { XK_Next,			0x51 }, { XK_Up,			0x48 },
	{ XK_Left,			0x4B }, { XK_Down,			0x50 }, { XK_Right,			0x4D },
	{ XK_Num_Lock,		0x45 }, { XK_KP_Divide,		0x35 }, { XK_KP_Multiply,	0x37 },
	{ XK_KP_Subtract,	0x4A }, { XK_KP_Home,		0x47 }, { XK_KP_Up,			0x48 },
	{ XK_KP_Prior,		0x49 }, { XK_KP_Add,		0x4E }, { XK_KP_Left,		0x4B },
	{ XK_KP_Begin,		0x4C }, { XK_KP_Right,		0x4D }, { XK_KP_End,		0x4F },
	{ XK_KP_Down,		0x50 }, { XK_KP_Next,		0x51 }, { XK_KP_Enter,		0x1C },
	{ XK_KP_Insert,		0x52 }, { XK_KP_Delete,		0x53 }, { NoSymbol,			0x00 }
};


/*:::::*/
static int keyboard_console_getch(void)
{
	int key = -1;
	
	BG_LOCK();
	
	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_SIZE - 1);
	}
	
	BG_UNLOCK();
	
	return key;
}


/*:::::*/
static void keyboard_console_handler(void)
{
	unsigned char buffer[128], scancode;
	int num_bytes, i, ascii, extended = 0;
	struct kbentry entry;
	
	num_bytes = read(key_fd, &buffer, sizeof(buffer));
	if (num_bytes > 0) {
		for (i = 0; i < num_bytes; i++) {
			scancode = kernel_to_scancode[buffer[i] & 0x7F];
			if (buffer[i] & 0x80)
				key_state[scancode] = FALSE;
			else {
				key_state[scancode] = TRUE;
				
				/* Since we took over keyboard control, we have to map our keypresses to ascii
				 * in order to report them in our own keyboard buffer */
				
				switch (scancode) {
					case SC_CAPSLOCK:	key_leds ^= LED_CAP; break;
					case SC_NUMLOCK:	key_leds ^= LED_NUM; break;
					case SC_SCROLLLOCK:	key_leds ^= LED_SCR; break;
					case SC_UP:			extended = 'H'; break;
					case SC_DOWN:		extended = 'P'; break;
					case SC_LEFT:		extended = 'K'; break;
					case SC_RIGHT:		extended = 'M'; break;
					case SC_INSERT:		extended = 'R'; break;
					case SC_DELETE:		extended = 'S'; break;
					case SC_HOME:		extended = 'G'; break;
					case SC_END:		extended = 'O'; break;
					case SC_PAGEUP:		extended = 'I'; break;
					case SC_PAGEDOWN:	extended = 'Q'; break;
					case SC_F1:			extended = ';'; break;
					case SC_F2:			extended = '<'; break;
					case SC_F3:			extended = '='; break;
					case SC_F4:			extended = '>'; break;
					case SC_F5:			extended = '?'; break;
					case SC_F6:			extended = '@'; break;
					case SC_F7:			extended = 'A'; break;
					case SC_F8:			extended = 'B'; break;
					case SC_F9:			extended = 'C'; break;
					case SC_F10:		extended = 'D'; break;
					default:			extended = 0; break;
				}
				
				entry.kb_table = 0;
                if (key_state[SC_LSHIFT] || key_state[SC_RSHIFT])
                	entry.kb_table |= 0x1;
                if (key_state[SC_ALTGR])
                	entry.kb_table |= 0x2;
                if (key_state[SC_CONTROL])
                	entry.kb_table |= 0x4;
                if (key_state[SC_ALT])
                	entry.kb_table |= 0x8;

                entry.kb_index = scancode;
                ioctl(key_fd, KDGKBENT, &entry);
                if (scancode == SC_BACKSPACE)
                	ascii = 8;
                else if (entry.kb_value == K_NOSUCHMAP)
                	ascii = 0;
                else {
                	ascii = KVAL(entry.kb_value);
	                switch (KTYP(entry.kb_value)) {
						case KT_LETTER:
							if (key_leds & LED_CAP)
								ascii ^= 0x20;
							break;
						case KT_LATIN:
						case KT_ASCII:
							break;
						case KT_PAD:
							if (ascii < NUM_PAD_KEYS) {
								if (key_leds & LED_NUM)
									ascii = pad_numlock_ascii[ascii];
								else
									ascii = pad_ascii[ascii];
							}
							else
								ascii = 0;
							break;
						case KT_SPEC:
							if (scancode == SC_ENTER)
								ascii = '\r';
							break;
						case KT_CONS:
							ioctl(key_fd, VT_ACTIVATE, ascii + 1);
							memset(key_state, FALSE, 128);
							/* fallthrough */
 						default:
							ascii = 0;
							break;
	                }
				}
				if (extended)
					ascii = 0x100 | extended;
				if (ascii) {
					key_buffer[key_tail] = ascii;
					if (((key_tail + 1) & (KEY_BUFFER_SIZE - 1)) == key_head)
						key_head = (key_head + 1) & (KEY_BUFFER_SIZE - 1);
					key_tail = (key_tail + 1) & (KEY_BUFFER_SIZE - 1);
                }
			}
		}
	}
	if (key_state[0x1D] & key_state[0x2E])
		kill(main_pid, SIGINT);
}


/*:::::*/
static void keyboard_x11_handler(void)
{
	unsigned char keymap[32];
	int i;

	fb_XQueryKeymap(display, keymap);
	memset(key_state, FALSE, 128);
	for (i = 0; i < 256; i++) {
		if (keymap[i / 8] & (1 << (i & 0x7)))
			key_state[scancode[i]] = TRUE;
	}
}


/*:::::*/
static int keyboard_init(void)
{
	void *lib;
	int keycode_min, keycode_max, i, j;
	KeySym keysym;
	
	main_pid = getpid();
	old_getch = fb_con.keyboard_getch;
	
	if(fb_con.inited == INIT_CONSOLE) {
		key_fd = dup(fb_con.h_in);
		if ((ioctl(key_fd, KDGKBMODE, &key_old_mode) < 0) || (ioctl(key_fd, KDSKBMODE, K_MEDIUMRAW) < 0)) {
			close(key_fd);
			return -1;
		}
		keyboard_handler = keyboard_console_handler;
		fb_con.keyboard_getch = keyboard_console_getch;
		key_head = key_tail = 0;
		ioctl(key_fd, KDGETLED, &key_leds);
	}
	else {
		if (!fb_XOpenDisplay) {
			if (!(lib = dlopen(NULL, RTLD_LAZY)))
				return -1;
			if (!dlsym(lib, "XOpenDisplay")) {
				dlclose(lib);
				if (!(lib = dlopen("libX11.so", RTLD_LAZY)))
					return -1;
			}
			fb_XOpenDisplay = (XOPENDISPLAY)dlsym(lib, "XOpenDisplay");
			fb_XCloseDisplay = (XCLOSEDISPLAY)dlsym(lib, "XCloseDisplay");
			fb_XQueryKeymap = (XQUERYKEYMAP)dlsym(lib, "XQueryKeymap");
			fb_XDisplayKeycodes = (XDISPLAYKEYCODES)dlsym(lib, "XDisplayKeycodes");
			fb_XKeycodeToKeysym = (XKEYCODETOKEYSYM)dlsym(lib, "XKeycodeToKeysym");
			if ((!fb_XOpenDisplay) || (!fb_XCloseDisplay) || (!fb_XQueryKeymap) || (!fb_XDisplayKeycodes) || (!fb_XKeycodeToKeysym)) {
				fb_XOpenDisplay = NULL;
				return -1;
			}
		}
		display = fb_XOpenDisplay(NULL);
		if (!display)
			return -1;
	
		fb_XDisplayKeycodes(display, &keycode_min, &keycode_max);
		if (keycode_min < 0) keycode_min = 0;
		if (keycode_max > 255) keycode_max = 255;
		
		for (i = keycode_min; i <= keycode_max; i++) {
			keysym = fb_XKeycodeToKeysym(display, i, 0);
			if (keysym != NoSymbol) {
				for (j = 0; (fb_keysym_to_scancode[j].scancode) && (fb_keysym_to_scancode[j].keysym != keysym); j++)
					;
				scancode[i] = fb_keysym_to_scancode[j].scancode;
			}
		}
		
		keyboard_handler = keyboard_x11_handler;
	}
	
	return 0;
}


/*:::::*/
static void keyboard_exit(void)
{
	if (fb_con.inited == INIT_CONSOLE) {
		ioctl(key_fd, KDSKBMODE, key_old_mode);
		close(key_fd);
	}
	else {
		fb_XCloseDisplay(display);
	}
	fb_con.keyboard_getch = old_getch;
	fb_con.keyboard_handler = NULL;
}



/*:::::*/
int fb_ConsoleMultikey(int scancode)
{
	int res;
	
	if (!fb_con.inited)
		return FALSE;
	pthread_mutex_lock(&fb_con.bg_mutex);
	if (!fb_con.keyboard_handler) {
		if (!keyboard_init()) {
			fb_con.keyboard_init = keyboard_init;
			fb_con.keyboard_exit = keyboard_exit;
			fb_con.keyboard_handler = keyboard_handler;
		}
	}
	res = key_state[scancode & 0x7F];
	pthread_mutex_unlock(&fb_con.bg_mutex);
	
	return res;
}
