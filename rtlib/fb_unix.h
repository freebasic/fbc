/* unix base target-specific header */

#include <stdio.h>
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

/* Relying on -D_FILE_OFFSET_BITS=64 to transparently remap to off64_t */
#if !defined _FILE_OFFSET_BITS || _FILE_OFFSET_BITS != 64
#error Expected _FILE_OFFSET_BITS=64
#endif
typedef off_t fb_off_t;
