/* common XBOX definitions. */

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

#define FB_LOCK()
#define FB_UNLOCK()
#define FB_STRLOCK()
#define FB_STRUNLOCK()
#define FB_THREADID HANDLE
#define FB_DYLIB HANDLE
/* Fake unimplemented FBMUTEX type */
struct _FBMUTEX;
typedef struct _FBMUTEX FBMUTEX;
/* Fake unimplemented FBCOND type */
struct _FBCOND;
typedef struct _FBCOND FBCOND;
typedef long fb_off_t;
#define fseeko(stream, offset, whence) fseek(stream, offset, whence)
#define ftello(stream)                 ftell(stream)

/* WinNT constants - !!!FIXME!!! these belong in openxdk headers */
#define Executive 0
#define KernelMode 0
#define UserMode 1

extern HANDLE __fb_in_handle, __fb_out_handle;
