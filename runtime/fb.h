#ifndef __FB_H__
#define __FB_H__

#if HAVE_CONFIG_H
#include <config.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define FB_TRUE -1
#define FB_FALSE 0
#ifndef FALSE
#define FALSE    0
#endif
#ifndef TRUE
#define TRUE    1
#endif
#ifndef NULL
#define NULL     0
#endif

/* Defines the ASCII code that indicates a two-byte key code.
   A two-byte key code will be returned by GET on SCRN: or INKEY$. */
#define FB_EXT_CHAR           ((char)255)

/* Maximum number of temporary string descriptors. */
#define FB_STR_TMPDESCRIPTORS 256

/* Maximum number of array dimensions. */
#define FB_MAXDIMENSIONS      8

/* Maximum number of temporary array descriptors. */
#define FB_ARRAY_TMPDESCRIPTORS (FB_STR_TMPDESCRIPTORS / 4)

/* The padding width (for PRINT ,). */
#define FB_TAB_WIDTH          14

/* Screen width/height returned by default when native console function failed.
   This is required when an applications output is redirected. */
#define FB_SCRN_DEFAULT_WIDTH  80
#define FB_SCRN_DEFAULT_HEIGHT 25

/* Number of reserved file handles. 0: SCRN, 1: LPT1 */
#define FB_RESERVED_FILES     2

/* Maximum number of file handles. */
#define FB_MAX_FILES          (FB_RESERVED_FILES + 255)

/* File buffer size (for buffered read?). */
#define FB_FILE_BUFSIZE       8192

/* Max length to allocated for a temporary buffer on stack */
#define FB_LOCALBUFF_MAXLEN   32768

#ifndef HOST_WINDOWS
	/* Maximum path length for Non-Win32 targets. For Win32 targets, this
	   value will be set automatically by windows.h. */
	#define MAX_PATH    1024
#endif

/* Convert char to int without sign-extension. */
#define FB_CHAR_TO_INT(ch)  ((int) ((unsigned) (unsigned char) (ch)))

/* Key code from char */
#define FB_MAKE_KEY(ch)     ((int) ((unsigned) (unsigned char) (ch)))

/* Macro to calculate an extended key code for a character.
   This macro is used to build the integer value of a two-byte key code
   returned by SCRN: (and INKEY$). */
#define FB_MAKE_EXT_KEY(ch) \
	((int) ((((unsigned) (unsigned char) (ch)) << 8) + \
	        (unsigned) (unsigned char) (FB_EXT_CHAR)))

/* Check for extended key codes; true for every value created with
   FB_MAKE_EXT_KEY(ch). */
#define FB_IS_EXT_KEY(k) \
	((int) (((((unsigned) (k)) & 0xFF) == FB_EXT_CHAR) && \
	        (((k) & 0xFF00) != 0)))

#if defined(HOST_WINDOWS)
	#include "fb_win32.h"
#elif defined(HOST_LINUX)
	#include "fb_unix.h"
	#include "fb_linux.h"
#elif defined(HOST_DOS)
	#include "fb_dos.h"
#elif defined(HOST_XBOX)
	#include "fb_xbox.h"
#elif defined(HOST_FREEBSD)
	#include "fb_unix.h"
#elif defined(HOST_SOLARIS)
	#include "fb_unix.h"
#elif defined(HOST_DARWIN)
	#include "fb_unix.h"
#elif defined(HOST_OPENBSD)
	#include "fb_unix.h"
#elif defined(HOST_NETBSD)
	#include "fb_unix.h"
#else
	#error Unexpected target
#endif

/* Implementation of the missing lib C functions */
#include "fb_config.h"

/* CPU-dependent macros and inline functions */
#ifdef HOST_X86
	#include "fb_x86.h"
#else
	#include "fb_port.h"
#endif

/* Unicode definitions */
#include "fb_unicode.h"

#ifndef FBCALL
	#define FBCALL
#endif

#ifndef FB_LOCK
	#define FB_LOCK()
#endif
#ifndef FB_UNLOCK
	#define FB_UNLOCK()
#endif

#ifndef FB_TLSENTRY
	/* A thread local storage slot */
	#define FB_TLSENTRY uintptr_t
#endif
#ifndef FB_TLSALLOC
	#define FB_TLSALLOC(key) key = NULL
#endif
#ifndef FB_TLSFREE
	#define FB_TLSFREE(key) key = NULL
#endif
#ifndef FB_TLSSET
	#define FB_TLSSET(key,value) key = (FB_TLSENTRY)value
#endif
#ifndef FB_TLSGET
	#define FB_TLSGET(key) key
#endif
#ifndef FB_THREADID
	#define FB_THREADID int
#endif

#ifndef FB_BINARY_NEWLINE
	/* The "NEW LINE" string required for printer I/O.
	   The printer always requires both CR and LF. */
	#define FB_BINARY_NEWLINE "\r\n"
	#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")
#endif

#ifndef FB_NEWLINE
	/* The "NEW LINE" character used for all I/O.
	   This is LF here because FB relies on the C RTL which only knows
	   LF as line-end character. */
	#define FB_NEWLINE "\n"
	#define FB_NEWLINE_WSTR _LC("\n")
#endif

#ifndef FB_LL_FMTMOD
	/* LONG LONG format modifier for the *printf functions. */
	#define FB_LL_FMTMOD "ll"
#endif

#ifdef DEBUG
	#include <assert.h>
	#define DBG_ASSERT(e) assert(e)
#else
	#define DBG_ASSERT(e) ((void)0)
#endif

#include "fb_intern.h"
#include "fb_error.h"
#include "fb_string.h"
#include "fb_array.h"
#include "fb_system.h"
#include "fb_math.h"
#include "fb_data.h"
#include "fb_console.h"
#include "fb_file.h"
#include "fb_device.h"
#include "fb_serial.h"
#include "fb_printer.h"
#include "fb_datetime.h"
#include "fb_thread.h"
#include "fb_hook.h"

/* This should match fbc's lang enum */
enum FB_LANG {
	FB_LANG_FB,
	FB_LANG_FB_DEPRECATED,
	FB_LANG_FB_FBLITE,
	FB_LANG_QB,
	FB_LANGS
};

typedef struct FB_RTLIB_CTX_ {
	int             argc;
	char          **argv;
	FBSTRING        null_desc;
	char           *error_msg;
	FnDevOpenHook   pfnDevOpenHook;
	FB_HOOKSTB      hooks;
	FB_TLSENTRY     tls_ctxtb[FB_TLSKEYS];
	FB_FILE         fileTB[FB_MAX_FILES];
	int             do_file_reset;
	int             lang;
} FB_RTLIB_CTX;

extern FB_RTLIB_CTX __fb_ctx;

#ifdef __cplusplus
}
#endif

#endif /*__FB_H__*/
