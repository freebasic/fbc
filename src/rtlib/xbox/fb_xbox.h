#include <hal/xbox.h>
#include <hal/fileio.h>

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

/* WinNT constants - !!!FIXME!!! these belong in openxdk headers */
#define Executive 0
#define KernelMode 0
#define UserMode 1

/* These functions are not present in the OpenXDK's headers */
int swprintf(wchar_t *wcs, size_t maxlen, const wchar_t *format, ...);
double wcstod(const wchar_t*, wchar_t**);
unsigned long wcstoul(const wchar_t *, wchar_t **, int);
unsigned long long  wcstoull(const wchar_t * __restrict__, wchar_t ** __restrict__, int);
