#define FBCALL __stdcall

/* newline for console/file I/O */
#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

/* newline for printer I/O */
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")
#define FB_LL_FMTMOD "ll"
#define FB_CONSOLE_MAXPAGES 1
#define FB_DYLIB HANDLE

typedef long fb_off_t;
#define fseeko(stream, offset, whence) fseek(stream, offset, whence)
#define ftello(stream)                 ftell(stream)

