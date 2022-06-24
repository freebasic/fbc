/* Linux multikey function implementation */

#include "../fb.h"
#include "../unix/fb_private_console.h"
#include <sys/ioctl.h>
#include <signal.h>
#include <linux/kd.h>
#include <linux/keyboard.h>
#include <linux/vt.h>

#define KEY_BUFFER_SIZE		16
#define NUM_PAD_KEYS		17

static int keyboard_init(void);
static void keyboard_exit(void);

#ifndef DISABLE_X11
#include "../fb_private_hdynload.h"
#include "../unix/fb_private_scancodes_x11.h"

typedef struct {
    XOPENDISPLAY OpenDisplay;
    XCLOSEDISPLAY CloseDisplay;
    XQUERYKEYMAP QueryKeymap;
    XDISPLAYKEYCODES DisplayKeycodes;
    XGETKEYBOARDMAPPING GetKeyboardMapping;
    XFREE Free;
} X_FUNCS;

static Display *display;
static FB_DYLIB xlib = NULL;
static X_FUNCS X = { NULL, NULL, NULL, NULL, NULL, NULL };
#endif

static pid_t main_pid;
static int key_fd, key_old_mode, key_leds;
static unsigned char key_state[128];
static unsigned short key_buffer[KEY_BUFFER_SIZE], key_head, key_tail;
static int (*old_getch)(void);
static void (*gfx_save)(void);
static void (*gfx_restore)(void);
static void (*gfx_key_handler)(int, int, int, int);

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
	SC_CLEAR,		SC_RIGHT,		SC_PLUS,		SC_END,
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

static void keyboard_console_handler(void)
{
	unsigned char buffer[128], scancode;
	int pressed, repeated, num_bytes, i, key, extended;
	int vt, orig_vt;
	struct kbentry entry;
	struct vt_stat vt_state;

	num_bytes = read(key_fd, &buffer, sizeof(buffer));
	if (num_bytes > 0) {
		for (i = 0; i < num_bytes; i++) {
			scancode = kernel_to_scancode[buffer[i] & 0x7F];
			pressed = (buffer[i] & 0x80) ^ 0x80;
			repeated = pressed && key_state[scancode];
			key_state[scancode] = pressed;

			/* Since we took over keyboard control, we have to map our keypresses to ascii
			 * in order to report them in our own keyboard buffer */

			extended = 0;
			switch (scancode) {
			case SC_CAPSLOCK:   if (pressed) key_leds ^= LED_CAP; break;
			case SC_NUMLOCK:    if (pressed) key_leds ^= LED_NUM; break;
			case SC_SCROLLLOCK: if (pressed) key_leds ^= LED_SCR; break;
			default:
				extended = fb_hScancodeToExtendedKey( scancode );
				break;
			}

			/* Fill in kbentry struct for KDGKBENT query */
			entry.kb_table = 0; /* modifier table */
			if (key_state[SC_LSHIFT] || key_state[SC_RSHIFT])
				entry.kb_table |= 0x1;
			if (key_state[SC_ALTGR])
				entry.kb_table |= 0x2;
			if (key_state[SC_CONTROL])
				entry.kb_table |= 0x4;
			if (key_state[SC_ALT])
				entry.kb_table |= 0x8;
			entry.kb_index = scancode; /* keycode */
			ioctl(key_fd, KDGKBENT, &entry);

			if (scancode == SC_BACKSPACE)
				key = 8;
			else if (entry.kb_value == K_NOSUCHMAP)
				key = 0;
			else {
				key = KVAL(entry.kb_value);
				switch (KTYP(entry.kb_value)) {
					case KT_LETTER:
						if (key_leds & LED_CAP)
							key ^= 0x20;
						break;
					case KT_LATIN:
					case KT_ASCII:
						break;
					case KT_PAD:
						if (key < NUM_PAD_KEYS) {
							if (key_leds & LED_NUM)
								key = pad_numlock_ascii[key];
							else
								key = pad_ascii[key];
						}
						else
							key = 0;
						break;
					case KT_SPEC:
						if (scancode == SC_ENTER)
							key = '\r';
						break;
					case KT_CONS:
						vt = key + 1;
						if( pressed && (ioctl(key_fd, VT_GETSTATE, &vt_state) >= 0) ) {
							orig_vt = vt_state.v_active;
							if (vt != orig_vt) {
								if (__fb_con.gfx_exit) {
									gfx_save();
									ioctl(key_fd, KDSETMODE, KD_TEXT);
								}
								ioctl(key_fd, VT_ACTIVATE, vt);
								ioctl(key_fd, VT_WAITACTIVE, vt);
								while (ioctl(key_fd, VT_WAITACTIVE, orig_vt) < 0)
								    usleep(50000);
								if (__fb_con.gfx_exit) {
									ioctl(key_fd, KDSETMODE, KD_GRAPHICS);
									gfx_restore();
								}
								memset(key_state, FALSE, 128);
							} else {
								key_state[scancode] = FALSE;
							}
							extended = 0;
						}

					/* fallthrough */
					default:
						key = 0;
						break;
				}
			}

			if( extended )
				key = extended;

			if( pressed && key ) {
				key_buffer[key_tail] = key;
				if (((key_tail + 1) & (KEY_BUFFER_SIZE - 1)) == key_head)
					key_head = (key_head + 1) & (KEY_BUFFER_SIZE - 1);
				key_tail = (key_tail + 1) & (KEY_BUFFER_SIZE - 1);
			}

			if( gfx_key_handler )
				gfx_key_handler( pressed, repeated, scancode, key );
		}
	}

	/* CTRL + C */
	if( key_state[SC_CONTROL] && key_state[SC_C] )
		kill(main_pid, SIGINT);
}

#ifndef DISABLE_X11
static void keyboard_x11_handler(void)
{
	unsigned char keymap[32];
	int i;

	if (!fb_hXTermHasFocus())
		return;
	X.QueryKeymap(display, keymap);
	memset(key_state, FALSE, 128);
	for (i = 0; i < 256; i++) {
		if (keymap[i / 8] & (1 << (i & 0x7)))
			key_state[fb_x11keycode_to_scancode[i]] = TRUE;
	}
}
#endif

static int keyboard_init(void)
{
	struct termios term;
	memset( &term, 0, sizeof( term ) );

	main_pid = getpid();
	old_getch = __fb_con.keyboard_getch;

	if(__fb_con.inited == INIT_CONSOLE) {
		key_fd = dup(__fb_con.h_in);

		term.c_iflag = 0;
		term.c_cflag = CS8;
		term.c_lflag = 0;
		term.c_cc[VMIN] = 0;
		term.c_cc[VTIME] = 0;

		if ((ioctl(key_fd, KDGKBMODE, &key_old_mode) < 0) ||
		    (tcsetattr(key_fd, TCSANOW, &term) < 0) ||
		    (ioctl(key_fd, KDSKBMODE, K_MEDIUMRAW) < 0)) {
			close(key_fd);
			return -1;
		}
		__fb_con.keyboard_handler = keyboard_console_handler;
		__fb_con.keyboard_getch = keyboard_console_getch;
		key_head = key_tail = 0;
		ioctl(key_fd, KDGETLED, &key_leds);
	}

#ifndef DISABLE_X11
	else {
		const char *const funcs[] = {
			"XOpenDisplay", "XCloseDisplay", "XQueryKeymap", "XDisplayKeycodes", "XGetKeyboardMapping", "XFree", NULL
		};

		xlib = fb_hDynLoad("libX11.so", funcs, (void **)&X);
		if (!xlib)
			return -1;

		display = X.OpenDisplay(NULL);
		if (!display)
			return -1;

		fb_hInitX11KeycodeToScancodeTb( display, X.DisplayKeycodes, X.GetKeyboardMapping, X.Free );

		fb_hXTermInitFocus();
		__fb_con.keyboard_handler = keyboard_x11_handler;
	}
#endif

	__fb_con.keyboard_init = keyboard_init;
	__fb_con.keyboard_exit = keyboard_exit;

	return 0;
}

static void keyboard_exit(void)
{
	if (__fb_con.inited == INIT_CONSOLE) {
		ioctl(key_fd, KDSKBMODE, key_old_mode);
		close(key_fd);
		key_fd = -1;
	}
#ifndef DISABLE_X11
	else if (__fb_con.inited == INIT_X11) {
		X.CloseDisplay(display);
		fb_hDynUnload(&xlib);
		fb_hXTermExitFocus();
	}
#endif
	__fb_con.keyboard_getch = old_getch;
	__fb_con.keyboard_handler = NULL;
	__fb_con.keyboard_exit = NULL;
}

int fb_ConsoleMultikey(int scancode)
{
	int res;

	if (!__fb_con.inited)
		return FB_FALSE;

	BG_LOCK();

	fb_hStartBgThread( );

	if ((!__fb_con.keyboard_handler) && (!keyboard_init())) {
		/* Let the handler execute at least once to fill in states */
		BG_UNLOCK();
		usleep(50000);
		BG_LOCK();
	}

	res = key_state[scancode & 0x7F] ? FB_TRUE : FB_FALSE;

	BG_UNLOCK();

	return res;
}

int fb_hConsoleGfxMode
	(
		void (*gfx_exit)(void),
		void (*save)(void),
		void (*restore)(void),
		void (*key_handler)(int, int, int, int)
	)
{
	BG_LOCK();

	fb_hStartBgThread( );

	__fb_con.gfx_exit = gfx_exit;
	if (gfx_exit) {
		FB_LOCK( );
		__fb_ctx.hooks.multikeyproc = NULL;
		__fb_ctx.hooks.inkeyproc = NULL;
		__fb_ctx.hooks.getkeyproc = NULL;
		__fb_ctx.hooks.keyhitproc = NULL;
		__fb_ctx.hooks.sleepproc = NULL;
		FB_UNLOCK( );
		gfx_save = save;
		gfx_restore = restore;
		gfx_key_handler = key_handler;
		if (keyboard_init()) {
			BG_UNLOCK();
			return -1;
		}
		ioctl(key_fd, KDSETMODE, KD_GRAPHICS);
	} else {
		if (key_fd >= 0) {
			ioctl(key_fd, KDSETMODE, KD_TEXT);
			keyboard_exit();
			fb_hTermOut(SEQ_EXIT_GFX_MODE, 0, 0);
		}
	}

	BG_UNLOCK();

	return 0;
}
