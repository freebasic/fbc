/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * fb_win32.h -- common Win32 definitions.
 *
 * chng: jun/2005 written [lillo]
 *
 */

#ifndef __FB_WIN32_H__
#define __FB_WIN32_H__

#if defined(NOSTDCALL)
# define FBCALL __cdecl
#else
# define FBCALL __stdcall
#endif

#ifdef TARGET_WIN32
/* don't include liboldname */
#define _NO_OLDNAMES 1
#endif

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <io.h>

#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

#ifdef TARGET_CYGWIN
#define FB_LL_FMTMOD "ll"
#else
#define FB_LL_FMTMOD "I64"
#endif

typedef struct _FB_DIRCTX
{
	int in_use;
    int attrib;
#ifdef TARGET_CYGWIN
    WIN32_FIND_DATA data;
    HANDLE handle;
#else
	struct _finddata_t data;
    long handle;
#endif
} FB_DIRCTX;

#ifdef TARGET_CYGWIN
typedef _off64_t fb_off_t;
#else
typedef off64_t fb_off_t;
#endif

#ifdef MULTITHREADED
extern CRITICAL_SECTION __fb_global_mutex;
extern CRITICAL_SECTION __fb_string_mutex;
# define FB_LOCK()					EnterCriticalSection(&__fb_global_mutex)
# define FB_UNLOCK()				LeaveCriticalSection(&__fb_global_mutex)
# define FB_STRLOCK()				EnterCriticalSection(&__fb_string_mutex)
# define FB_STRUNLOCK()				LeaveCriticalSection(&__fb_string_mutex)
# define FB_TLSENTRY				DWORD
# define FB_TLSALLOC(key) 			key = TlsAlloc( )
# define FB_TLSFREE(key)			TlsFree( (key) )
# define FB_TLSSET(key,value)		TlsSetValue( (key), (LPVOID)(value))
# define FB_TLSGET(key)				TlsGetValue( (key))
#endif

#define FB_THREADID HANDLE

struct _FBSTRING;
typedef void (*fb_FnProcessMouseEvent)(const MOUSE_EVENT_RECORD *pEvent);

#define __fb_in_handle fb_hConsoleGetHandle( TRUE )
#define __fb_out_handle fb_hConsoleGetHandle( FALSE )
extern const unsigned char __fb_keytable[][3];
extern SMALL_RECT __fb_srConsoleWindow;
extern fb_FnProcessMouseEvent __fb_MouseEventHook;
extern int __fb_ConsoleSetByUser;
extern int __fb_ScrollWasOff;

#define FB_CON_CORRECT_POSITION() \
    do { \
        if( __fb_ScrollWasOff ) \
            fb_ConsolePrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST ); \
    } while (0)

       int fb_hConsoleTranslateKey      ( char AsciiChar,
                                          WORD wVsCode,
                                          WORD wVkCode,
                                          DWORD dwControlKeyState,
                                          int bEnhancedKeysOnly );

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

#define FB_CONSOLE_WINDOW_EMPTY() \
    ((__fb_srConsoleWindow.Left==__fb_srConsoleWindow.Right) \
    || (__fb_srConsoleWindow.Top==__fb_srConsoleWindow.Bottom))

       char *fb_hGetLocaleInfo          ( LCID Locale, LCTYPE LCType,
                                          char *pszBuffer, size_t uiSize );
       struct _FBSTRING *fb_hIntlConvertString  ( struct _FBSTRING *source,
                                          int source_cp, int dest_cp );

#endif
