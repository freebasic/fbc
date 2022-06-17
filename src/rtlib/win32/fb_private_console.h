#include <windows.h>

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
unsigned int fb_ConsoleGetColorAttEx( HANDLE hConsole );
void fb_ConsoleClearViewRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2 );
void fb_hConsoleGetWindow( int *left, int *top, int *cols, int *rows );
int fb_ConsoleProcessEvents( void );
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
