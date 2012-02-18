#if defined HOST_DOS
	#define FB_CONSOLE_MAXPAGES 8

	typedef struct _FB_CONSOLE_CTX {
		int           active, visible;
		int           w, h;
		unsigned long phys_addr;
		int           scrollWasOff;
		int           forceInpBufferChanged;
	} FB_CONSOLE_CTX;

	extern FB_CONSOLE_CTX __fb_con;

	int fb_ConsoleLocate_BIOS( int row, int col, int cursor );
	void fb_ConsoleGetXY_BIOS( int *col, int *row );
	unsigned int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag );
	void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows );
	void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows );
	void fb_ConsoleMultikeyInit( void );

#elif defined HOST_UNIX
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

	#define FB_CONSOLE_MAXPAGES 1

	typedef struct FBCONSOLE
	{
		int inited;
		int term_type;
		int h_out, h_in;
		FILE *f_out, *f_in;
		struct termios old_term_out, old_term_in;
		int in_flags, old_in_flags;
		int fg_color, bg_color;
		int cur_x, cur_y;
		int w, h;
		unsigned char *char_buffer, *attr_buffer;
		int has_perm;
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

	int fb_hTermOut(int code, int param1, int param2);
	int fb_hGetCh(int remove);
	int fb_hXTermInitFocus(void);
	void fb_hXTermExitFocus(void);
	int fb_hXTermHasFocus(void);
	int fb_hConsoleGfxMode(void (*gfx_exit)(void), void (*save)(void), void (*restore)(void), void (*key_handler)(int));
	int fb_hInitConsole(void);
	void fb_hExitConsole(void);

#elif defined HOST_WIN32
	#include <windows.h>

	#define FB_CONSOLE_MAXPAGES 4
	typedef void (*fb_FnProcessMouseEvent)(const MOUSE_EVENT_RECORD *pEvent);

	typedef struct _FB_CONSOLE_CTX
	{
		HANDLE 			inHandle, outHandle;
		HANDLE 			pgHandleTb[FB_CONSOLE_MAXPAGES];
		int				active, visible;
		SMALL_RECT 		window;
		int 			setByUser;
		int 			scrollWasOff;
		fb_FnProcessMouseEvent mouseEventHook;
	} FB_CONSOLE_CTX;

	extern FB_CONSOLE_CTX __fb_con;

	int fb_hConsoleTranslateKey( char AsciiChar, WORD wVsCode, WORD wVkCode, DWORD dwControlKeyState, int bEnhancedKeysOnly );
	int fb_hVirtualToScancode( int vkey );
	void fb_InitConsoleWindow( void );
	FBCALL void fb_hRestoreConsoleWindow( void );
	FBCALL void fb_hUpdateConsoleWindow( void );
	FBCALL void fb_hConvertToConsole( int *left, int *top, int *right, int *bottom );
	FBCALL void fb_hConvertFromConsole( int *left, int *top, int *right, int *bottom );
	FBCALL void fb_ConsoleLocateRaw( int row, int col, int cursor );
	FBCALL void fb_ConsoleGetScreenSize( int *cols, int *rows );
	void fb_ConsoleGetMaxWindowSize( int *cols, int *rows );
	void fb_ConsoleGetScreenSizeEx( HANDLE hConsole, int *cols, int *rows );
	int fb_ConsoleGetRawYEx( HANDLE hConsole );
	int fb_ConsoleGetRawXEx( HANDLE hConsole );
	void fb_ConsoleGetRawXYEx( HANDLE hConsole, int *col, int *row );
	void fb_ConsoleLocateRawEx( HANDLE hConsole, int row, int col, int cursor );
	int fb_ConsoleGetColorAttEx( HANDLE hConsole );
	void fb_ConsoleColorEx( HANDLE hConsole, int fc, int bc );
	void fb_ConsoleScrollRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2, int nrows );
	void fb_ConsoleClearViewRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2 );
	void fb_hConsoleGetWindow( int *left, int *top, int *cols, int *rows );
	int fb_ConsoleProcessEvents( void );
	void fb_hConsolePostKey( int key, const KEY_EVENT_RECORD *key_event );
	int fb_hConsoleGetKey( int full );
	int fb_hConsolePeekKey( int full );
	void fb_hConsolePutBackEvents( void );
	HANDLE fb_hConsoleGetHandle( int is_input );
	void fb_hConsoleResetHandles( void );
	int fb_ConsoleGetRawX( void );
	int fb_ConsoleGetRawY( void );
        HANDLE fb_hConsoleCreateBuffer( void );

	#define __fb_in_handle  fb_hConsoleGetHandle( TRUE )
	#define __fb_out_handle fb_hConsoleGetHandle( FALSE )

	#define FB_CON_CORRECT_POSITION()                                    \
		do {                                                         \
			if( __fb_con.scrollWasOff )                          \
				fb_ConsolePrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST ); \
		} while (0)

	#define FB_CONSOLE_WINDOW_EMPTY() \
		((__fb_con.window.Left==__fb_con.window.Right) \
		|| (__fb_con.window.Top==__fb_con.window.Bottom))

#elif defined HOST_XBOX
	#define FB_CONSOLE_MAXPAGES 1
	extern HANDLE __fb_in_handle, __fb_out_handle;

#endif
