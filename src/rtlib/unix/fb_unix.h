#include <unistd.h>
#include <termios.h>

#define FBCALL

/* newline for console/file I/O */
#define FB_NEWLINE "\n"
#define FB_NEWLINE_WSTR _LC("\n")

/* newline for printer I/O */
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")

#define FB_LL_FMTMOD "ll"

#define FB_CONSOLE_MAXPAGES 1

/* Relying on -D_FILE_OFFSET_BITS=64 to transparently remap to off64_t */
#if !defined _FILE_OFFSET_BITS || _FILE_OFFSET_BITS != 64
#error Expected _FILE_OFFSET_BITS=64
#endif
typedef off_t fb_off_t;

FBCALL void fb_BgLock( void );
FBCALL void fb_BgUnlock( void );
#define BG_LOCK()   fb_BgLock()
#define BG_UNLOCK() fb_BgUnlock()

/* Global variable for disabling hard-coded VT100 escape sequences in
   fb_hTermOut(). */
extern int __fb_enable_vt100_escapes;
