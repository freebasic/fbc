#include <stdbool.h>

#define INIT_CONSOLE 1
#define INIT_X11     2

#define TERM_GENERIC 0
#define TERM_XTERM   1
#define TERM_ETERM   2

#define SEQ_LOCATE        0   /* "cm" - move cursor */
#define SEQ_HOME          1   /* "ho" - home cursor */
#define SEQ_SCROLL_REGION 2   /* "cs" - set scrolling region */
#define SEQ_CLS           3   /* "cl" - clear whole screen */
#define SEQ_CLEOL         4   /* "ce" - clear until end of line */
#define SEQ_WINDOW_SIZE   5   /* "WS" - set terminal window size */
#define SEQ_BEEP          6   /* "bl" - beep */
#define SEQ_FG_COLOR      7   /* "AF" - set foreground color */
#define SEQ_BG_COLOR      8   /* "AB" - set background color */
#define SEQ_RESET_COLOR   9   /* "me" - turn off all attributes */
#define SEQ_BRIGHT_COLOR  10  /* "md" - turn on bold (bright) attribute */
#define SEQ_SCROLL        11  /* "SF" - scroll forward */
#define SEQ_SHOW_CURSOR   12  /* "ve" - make cursor visible */
#define SEQ_HIDE_CURSOR   13  /* "vi" - make cursor invisible */
#define SEQ_DEL_CHAR      14  /* "dc" - delete character at cursor position */
#define SEQ_INIT_KEYPAD   15  /* "ks" - enable keypad keys */
#define SEQ_EXIT_KEYPAD   16  /* "ke" - disable keypad keys */
#define SEQ_MAX           17
#define SEQ_EXTRA         100
#ifdef HOST_LINUX
	#define SEQ_INIT_CHARSET  100  /* xxxx - inits PC 437 characters set */
	#define SEQ_EXIT_CHARSET  101  /* xxxx - exits PC 437 characters set */
	#define SEQ_QUERY_CURSOR  102  /* xxxx - query cursor position (not in termcap) */
	#define SEQ_QUERY_WINDOW  103  /* xxxx - query terminal window size (not in termcap) */
	#define SEQ_INIT_XMOUSE   104  /* xxxx - enable X11 mouse */
	#define SEQ_EXIT_XMOUSE   105  /* xxxx - disable X11 mouse */
	#define SEQ_EXIT_GFX_MODE 106  /* xxxx - cleanup after console gfx mode */
#endif
#define SEQ_SET_COLOR_EX  107  /* xxxx - extended set color */

typedef struct FBCONSOLE
{
	int inited;
	int term_type;
	int h_in;
	FILE *f_in;
	struct termios old_term_out, old_term_in;
	int old_in_flags;
	bool saved_old_term_out;
	bool saved_old_term_in;
	bool saved_old_in_flags;
	unsigned int fg_color, bg_color;
	int cur_x, cur_y;
	int w, h;
	unsigned char *char_buffer, *attr_buffer;
#if defined HOST_LINUX && (defined HOST_X86 || defined HOST_X86_64)
	int has_perm;
#endif
	int scroll_region_changed;
	char *seq[SEQ_MAX];
	int (*keyboard_getch)(void);
	int (*keyboard_init)(void);
	void (*keyboard_exit)(void);
	void (*keyboard_handler)(void);
	int (*mouse_init)(void);
	void (*mouse_exit)(void);
	void (*mouse_handler)(void);
	void (*mouse_update)(int cb, int cx, int cy);
	void (*gfx_exit)(void);
} FBCONSOLE;

extern FBCONSOLE __fb_con;

void fb_hRecheckCursorPos( void );
void fb_hRecheckConsoleSize( int requery_cursorpos );
int fb_hTermOut(int code, int param1, int param2);
void fb_hAddCh( int k );
int fb_hGetCh(int remove);
int fb_hXTermInitFocus(void);
void fb_hXTermExitFocus(void);
int fb_hXTermHasFocus(void);
int fb_hConsoleGfxMode
	(
		void (*gfx_exit)(void),
		void (*save)(void),
		void (*restore)(void),
		void (*key_handler)(int, int, int, int)
	);
int fb_hInitConsole(void);
void fb_hExitConsole(void);
void fb_hStartBgThread( void );
