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

#if defined HOST_ANDROID
// __ANDROID_API__ is always defined in newer NDKs, older ones need this header
#include <android/api-level.h>
// Defining _FILE_OFFSET_BITS=64 used to be a no-op until NDK r15. 64-bit offset support in 32-bit targets
// was added to various libc functions over many Android releases, stdio.h mostly in API 24 (Android 7.0).
// See https://android.googlesource.com/platform/bionic/+/refs/heads/main/docs/32-bit-abi.md
// (but note it claims ftello/fseeko didn't exist before API 24, actually they did in older NDKs.)
// On 32-bit targets:
// Older NDK declare ftello/fseeko, and off_t always as a long so ftello/fseeko are 32-bit.
// Newer NDK declare 32-bit ftello/fseeko if _FILE_OFFSET_BITS != 64,
//  64-bit ftello/fseeko if _FILE_OFFSET_BITS == 64 &&  __ANDROID_API__ >= 24,
//  and neither if _FILE_OFFSET_BITS == 64 &&  __ANDROID_API__ < 24.
#if __ANDROID_API__ < 24
#define fseeko(stream, offset, whence) fseek(stream, offset, whence)
#define ftello(stream)                 ftell(stream)
#endif
#endif

FBCALL void fb_BgLock( void );
FBCALL void fb_BgUnlock( void );
#define BG_LOCK()   fb_BgLock()
#define BG_UNLOCK() fb_BgUnlock()

/* Global variable for disabling hard-coded VT100 escape sequences in
   fb_hTermOut(). */
extern int __fb_enable_vt100_escapes;
