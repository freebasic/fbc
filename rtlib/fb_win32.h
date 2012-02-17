/* common Win32 definitions. */

#include <windows.h>
#include <io.h>

#include <malloc.h> /* for _alloca() */

/* These defines let us use the same code for all platforms while still mapping
   to the proper win32 functions. Of those, we prefer to use the non-oldnames
   versions, which is also why we compile with -DNO_OLDNAMES -D_NO_OLDNAMES.
   However, this sort of re-defining should only be used for functions that
   are used more than once, for the others #ifdef should do */
#define snprintf _snprintf
#define strdup(s) _strdup(s)
#define strcasecmp(a, b) _stricmp(a, b)
#define strncasecmp(a, b, n) _strnicmp(a, b, n)
#define alloca(x) _alloca(x)


#define FBCALL __stdcall

/* newline for console/file I/O */
#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

/* newline for printer I/O */
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")

#ifdef HOST_CYGWIN
#define FB_LL_FMTMOD "ll"
#else
#define FB_LL_FMTMOD "I64"
#endif

#ifdef ENABLE_MT
	extern CRITICAL_SECTION __fb_global_mutex;
	extern CRITICAL_SECTION __fb_string_mutex;
	extern CRITICAL_SECTION __fb_mtcore_mutex;
#	define FB_LOCK()             EnterCriticalSection(&__fb_global_mutex)
#	define FB_UNLOCK()           LeaveCriticalSection(&__fb_global_mutex)
#	define FB_STRLOCK()          EnterCriticalSection(&__fb_string_mutex)
#	define FB_STRUNLOCK()        LeaveCriticalSection(&__fb_string_mutex)
#	define FB_MTLOCK()           EnterCriticalSection(&__fb_mtcore_mutex)
#	define FB_MTUNLOCK()         LeaveCriticalSection(&__fb_mtcore_mutex)
#	define FB_TLSENTRY           DWORD
#	define FB_TLSALLOC(key)      key = TlsAlloc( )
#	define FB_TLSFREE(key)       TlsFree( (key) )
#	define FB_TLSSET(key,value)  TlsSetValue( (key), (LPVOID)(value))
#	define FB_TLSGET(key)        TlsGetValue( (key))
#else
#	define FB_LOCK()
#	define FB_UNLOCK()
#	define FB_STRLOCK()
#	define FB_STRUNLOCK()
#	define FB_MTLOCK()
#	define FB_MTUNLOCK()
#	define FB_TLSENTRY           uintptr_t
#	define FB_TLSALLOC(key)      key = NULL
#	define FB_TLSFREE(key)       key = NULL
#	define FB_TLSSET(key,value)  key = (FB_TLSENTRY)value
#	define FB_TLSGET(key)        key
#endif

#define FB_THREADID HANDLE
#define FB_DYLIB HMODULE

typedef struct {
	HANDLE id;
} FBMUTEX;

/* Forward-declared FBCOND type */
struct _FBCOND;
typedef struct _FBCOND FBCOND;

/* MinGW-w64 recognizes -D_FILE_OFFSET_BITS=64, but MinGW does not, so we
   can't be sure that ftello() really maps to the 64bit version...
   so we have to do it manually. */
typedef long long fb_off_t;
#define fseeko(stream, offset, whence) fseeko64(stream, offset, whence)
#define ftello(stream)                 ftello64(stream)

#define FB_COLOR_BLACK 		(0)
#define FB_COLOR_BLUE   	(FOREGROUND_BLUE)
#define FB_COLOR_GREEN     	(FOREGROUND_GREEN)
#define FB_COLOR_CYAN   	(FOREGROUND_GREEN|FOREGROUND_BLUE)
#define FB_COLOR_RED       	(FOREGROUND_RED)
#define FB_COLOR_MAGENTA   	(FOREGROUND_RED|FOREGROUND_BLUE)
#define FB_COLOR_BROWN     	(FOREGROUND_RED|FOREGROUND_GREEN)
#define FB_COLOR_WHITE     	(FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE)
#define FB_COLOR_GREY   	(FOREGROUND_INTENSITY)
#define FB_COLOR_LBLUE     	(FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_LGREEN    	(FOREGROUND_GREEN|FOREGROUND_INTENSITY)
#define FB_COLOR_LCYAN     	(FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_LRED   	(FOREGROUND_RED|FOREGROUND_INTENSITY)
#define FB_COLOR_LMAGENTA  	(FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_YELLOW    	(FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY)
#define FB_COLOR_BWHITE    	(FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY)

struct _FBSTRING;
typedef void (*fb_FnProcessMouseEvent)(const MOUSE_EVENT_RECORD *pEvent);

#define FB_CONSOLE_MAXPAGES 4

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

#define __fb_in_handle fb_hConsoleGetHandle( TRUE )
#define __fb_out_handle fb_hConsoleGetHandle( FALSE )

#define FB_CON_CORRECT_POSITION() \
    do { \
        if( __fb_con.scrollWasOff ) \
            fb_ConsolePrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST ); \
    } while (0)

       int fb_hConsoleTranslateKey      ( char AsciiChar,
                                          WORD wVsCode,
                                          WORD wVkCode,
                                          DWORD dwControlKeyState,
                                          int bEnhancedKeysOnly );

	   int fb_hVirtualToScancode(int vkey);

FBCALL void fb_hRestoreConsoleWindow    ( void );
FBCALL void fb_hUpdateConsoleWindow     ( void );
FBCALL void fb_hConvertToConsole        ( int *left, int *top, int *right, int *bottom );
FBCALL void fb_hConvertFromConsole      ( int *left, int *top, int *right, int *bottom );
FBCALL void fb_ConsoleLocateRaw         ( int row, int col, int cursor );
FBCALL void fb_ConsoleGetScreenSize     ( int *cols, int *rows );
       void fb_ConsoleGetMaxWindowSize  ( int *cols, int *rows );

       void fb_ConsoleGetScreenSizeEx   ( HANDLE hConsole, int *cols, int *rows );
       int  fb_ConsoleGetRawYEx         ( HANDLE hConsole );
       int  fb_ConsoleGetRawXEx         ( HANDLE hConsole );
       void fb_ConsoleGetRawXYEx        ( HANDLE hConsole, int *col, int *row );
       void fb_ConsoleLocateRawEx       ( HANDLE hConsole, int row, int col, int cursor );
       int  fb_ConsoleGetColorAttEx     ( HANDLE hConsole );
       void fb_ConsoleColorEx           ( HANDLE hConsole, int fc, int bc );
       void fb_ConsoleScrollRawEx       ( HANDLE hConsole, int x1, int y1, int x2, int y2, int nrows );
       void fb_ConsoleClearViewRawEx    ( HANDLE hConsole, int x1, int y1, int x2, int y2 );
       void fb_hConsoleGetWindow        ( int *left, int *top, int *cols, int *rows );

       int  fb_ConsoleProcessEvents     ( void );
       void fb_hConsolePostKey          ( int key, const KEY_EVENT_RECORD *key_event );
       int  fb_hConsoleGetKey           ( int full );
       int  fb_hConsolePeekKey          ( int full );
       void fb_hConsolePutBackEvents    ( void );

       HANDLE fb_hConsoleGetHandle		( int is_input );
       void   fb_hConsoleResetHandles	( void );

#define FB_CONSOLE_WINDOW_EMPTY() \
    ((__fb_con.window.Left==__fb_con.window.Right) \
    || (__fb_con.window.Top==__fb_con.window.Bottom))

       char *fb_hGetLocaleInfo          ( LCID Locale, LCTYPE LCType,
                                          char *pszBuffer, size_t uiSize );
       struct _FBSTRING *fb_hIntlConvertString  ( struct _FBSTRING *source,
                                          int source_cp, int dest_cp );
