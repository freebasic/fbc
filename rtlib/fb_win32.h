/* common Win32 definitions. */

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

/* MinGW-w64 recognizes -D_FILE_OFFSET_BITS=64, but MinGW does not, so we
   can't be sure that ftello() really maps to the 64bit version...
   so we have to do it manually. */
typedef long long fb_off_t;
#define fseeko(stream, offset, whence) fseeko64(stream, offset, whence)
#define ftello(stream)                 ftello64(stream)

#define FB_COLOR_BLACK    (0)
#define FB_COLOR_BLUE     (FOREGROUND_BLUE)
#define FB_COLOR_GREEN    (FOREGROUND_GREEN)
#define FB_COLOR_CYAN     (FOREGROUND_GREEN|FOREGROUND_BLUE)
#define FB_COLOR_RED      (FOREGROUND_RED)
#define FB_COLOR_MAGENTA  (FOREGROUND_RED|FOREGROUND_BLUE)
#define FB_COLOR_BROWN    (FOREGROUND_RED|FOREGROUND_GREEN)
#define FB_COLOR_WHITE    (FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE)
#define FB_COLOR_GREY     (FOREGROUND_INTENSITY)
#define FB_COLOR_LBLUE    (FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_LGREEN   (FOREGROUND_GREEN|FOREGROUND_INTENSITY)
#define FB_COLOR_LCYAN    (FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_LRED     (FOREGROUND_RED|FOREGROUND_INTENSITY)
#define FB_COLOR_LMAGENTA (FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_INTENSITY)
#define FB_COLOR_YELLOW   (FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_INTENSITY)
#define FB_COLOR_BWHITE   (FOREGROUND_RED|FOREGROUND_GREEN|FOREGROUND_BLUE|FOREGROUND_INTENSITY)
