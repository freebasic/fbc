#ifndef __FB_H__
#define __FB_H__

/* Must be included before any system headers due to certain #defines */
#include "fb_config.h"

/* Minimum headers needed for fb.h alone, more in system-specific sections
   below. These can be relied upon and don't need to be #included again. */
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#define FB_TRUE (-1)
#define FB_FALSE 0

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
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

#if FB_TAB_WIDTH == 8
#define FB_NATIVE_TAB 1
#endif

/* Screen width/height returned by default when native console function failed.
   This is required when an applications output is redirected. */
#define FB_SCRN_DEFAULT_WIDTH  80
#define FB_SCRN_DEFAULT_HEIGHT 25

/* Default colors for console color() function */
#define FB_COLOR_FG_DEFAULT   0x1
#define FB_COLOR_BG_DEFAULT   0x2

/* Number of reserved file handles. 0: SCRN, 1: LPT1 */
#define FB_RESERVED_FILES     2

/* Maximum number of file handles. */
#define FB_MAX_FILES          (FB_RESERVED_FILES + 255)

/* File buffer size (for buffered read?). */
#define FB_FILE_BUFSIZE       8192

/* Max length to allocated for a temporary buffer on stack */
#define FB_LOCALBUFF_MAXLEN   32768

#ifndef HOST_WIN32
	/* Maximum path length for Non-Win32 targets. For Win32 targets, this
	   value will be set automatically by windows.h. */
	#define MAX_PATH    1024
#endif

/* Convert char to int without sign-extension. */
#define FB_CHAR_TO_INT(ch)  ((int) ((unsigned) (unsigned char) (ch)))

/* Build an extended 2 byte key code like those returned by getkey()
   (inkey() returns a string like &hFF &h49 [page up key code],
    getkey() returns the same but in a little-endian integer: &h49FF
    where &hFF is the FB_EXT_CHAR  */
#define FB_MAKE_EXT_KEY(ch) \
	((int) ((((unsigned) (unsigned char) (ch)) << 8) + \
	        (unsigned) (unsigned char) (FB_EXT_CHAR)))

#define MIN(a,b)		((a) < (b) ? (a) : (b))
#define MAX(a,b)		((a) > (b) ? (a) : (b))
#define MID(a,b,c)		MIN(MAX((a), (b)), (c))
#define CINT(x)			((x) > 0.0 ? (int)(x) + 0.5 : (int)(x - 0.5))

#define SWAP(a,b)		((a) ^= (b), (b) ^= (a), (a) ^= (b))

#if defined HOST_DOS
	#include "dos/fb_dos.h"
#elif defined HOST_UNIX
	#include "unix/fb_unix.h"
#elif defined HOST_WIN32
	#include "win32/fb_win32.h"
#elif defined HOST_XBOX
	#include "xbox/fb_xbox.h"
#endif

#if defined HOST_SOLARIS
	#undef alloca
	#define alloca(x) __builtin_alloca(x)
#endif

#if defined ENABLE_MT && !defined HOST_DOS && !defined HOST_XBOX
	FBCALL void fb_Lock( void );
	FBCALL void fb_Unlock( void );
	FBCALL void fb_StrLock( void );
	FBCALL void fb_StrUnlock( void );
	FBCALL void fb_GraphicsLock  ( void );
	FBCALL void fb_GraphicsUnlock( void );
	#define FB_LOCK()      fb_Lock()
	#define FB_UNLOCK()    fb_Unlock()
	#define FB_STRLOCK()   fb_StrLock()
	#define FB_STRUNLOCK() fb_StrUnlock()
	#define FB_GRAPHICS_LOCK()   fb_GraphicsLock()
	#define FB_GRAPHICS_UNLOCK() fb_GraphicsUnlock()
#else
	#define FB_LOCK()
	#define FB_UNLOCK()
	#define FB_STRLOCK()
	#define FB_STRUNLOCK()
	#define FB_GRAPHICS_LOCK()
	#define FB_GRAPHICS_UNLOCK()
#endif

/* CPU-dependent macros and inline functions */
#ifdef HOST_X86
    static __inline__ int FB_MEMCMP( const void *p1, const void *p2, size_t len )
    {
        int res;
        if( len==0 )
            return 0;
        __asm volatile (
               " pushl %%esi      \n"
               " pushl %%edi      \n"
               " repe             \n"
               " cmpsb            \n"
               " je 0f            \n"
               " movl $1, %%ecx   \n"
               " ja 0f            \n"
               " neg %%ecx        \n"
               "0:                \n"
               " popl %%edi       \n"
               " popl %%esi       \n"
               : "=c" (res)
               : "c" (len), "S" (p1), "D" (p2)
              );
        return res;
    }

    static __inline__ void *FB_MEMCPY( void *dest, const void *src, size_t n )
    {
        __asm volatile (
               " pushl %%ecx      \n"
               " pushl %%esi      \n"
               " pushl %%edi      \n"
               " pushl %%ecx      \n"
               " shrl $2,%%ecx    \n"
               " rep              \n"
               " movsd            \n"
               " popl %%ecx       \n"
               " andl $3,%%ecx    \n"
               " rep              \n"
               " movsb            \n"
               " popl %%edi       \n"
               " popl %%esi       \n"
               " popl %%ecx       \n"
               :
               : "c" (n), "S" (src), "D" (dest)
              );
        return dest;
    }

    /** Same as FB_MEMCPY but returns position after destination string.
     */
    static __inline__ void *FB_MEMCPYX( void *dest, const void *src, size_t n )
    {
        __asm volatile (
               " pushl %%ecx      \n"
               " pushl %%esi      \n"
               " pushl %%ecx      \n"
               " shrl $2,%%ecx    \n"
               " rep              \n"
               " movsd            \n"
               " popl %%ecx       \n"
               " andl $3,%%ecx    \n"
               " rep              \n"
               " movsb            \n"
               " popl %%esi       \n"
               " popl %%ecx       \n"
               : "=D" (dest)
               : "c" (n), "S" (src), "D" (dest)
              );
        return dest;
    }

    static __inline__ const void *FB_MEMCHR( const void *s, int c, size_t n )
    {
        const void *dst;
        if( n==0 )
            return NULL;
        __asm volatile (
               " pushl %%ecx            \n"
               " pushf                  \n"
               " cld                    \n"
               " repne                  \n"
               " scasb                  \n"
               " jne 0f                 \n"
               " dec %%edi              \n"
               " jmp 1f                 \n"
               "0:                      \n"
               " xorl %%edi, %%edi      \n"
               "1:                      \n"
               " popf                   \n"
               " popl %%ecx             \n"
               : "=D" (dst)
               : "c" (n), "a" (c), "D" (s)
              );
        return dst;
    }

    /** Searches for the first ocurrence of a character unequal to c.
     */
    static __inline__ size_t FB_MEMLEN( const void *s, int c, size_t n )
    {
        size_t len;
        if( n==0 )
            return 0;
        __asm volatile (
               " pushl %%edi            \n"
               " pushf                  \n"
               " std                    \n"  /* DF = 1 -> from hi to lo */
               " repe                   \n"
               " scasb                  \n"
               " je 0f                  \n"
               " inc %%ecx              \n"
               "0:                      \n"
               " popf                   \n"
               " popl %%edi             \n"
               : "=c" (len)
               : "c" (n), "a" (c), "D" ((const char*) s + n - 1)
              );
        return len;
    }

	#define RORW(num, bits) __asm__ __volatile__("rorw %1, %0" : "=m"(num) : "c"(bits) : "memory")
	#define RORW1(num)      __asm__ __volatile__("rorw $1, %0" : "=m"(bit) : : "memory");
#else
	/* We use memcmp from C because the compiler might replace this by a built-in
	 * function which will definately be faster than our own implementation in C. */
	#define FB_MEMCMP(p1, p2, len) memcmp( p1, p2, len )
	#define FB_MEMCPY( dest, src, n ) memcpy(dest, src, n)
	#define FB_MEMCHR( s, c, n ) memchr( s, c, n )

	/* We have to wrap memcpy here because our MEMCPYX should return the position
	* after the destination string. */
	static __inline__ void *FB_MEMCPYX( void *dest, const void *src, size_t n )
	{
		memcpy(dest, src, n);
		return ((char *)dest)+n;
	}

	static __inline__ size_t FB_MEMLEN( const void *s, int c, size_t n )
	{
		const char *pachData = (const char*) s;
		while (n--) {
			if( pachData[n]!=(char)c )
				return n+1;
		}
		return 0;
	}

	#define RORW(num, bits) num = ( (num) >> (bits) ) | (num << (16 - bits) )
	#define RORW1(num)      RORW(num, 1)
#endif

#ifdef DEBUG
	#include <assert.h>
	#define DBG_ASSERT(e) assert(e)
#else
	#define DBG_ASSERT(e) ((void)0)
#endif

#define fb_hSign( x ) (((x) < 0) ? -1 : 1)

/* internal lists */
typedef struct _FB_LISTELEM {
    struct _FB_LISTELEM    *prev;
    struct _FB_LISTELEM    *next;
} FB_LISTELEM;

typedef struct _FB_LIST {
    int                cnt;      /* Number of used elements */
    FB_LISTELEM        *head;    /* First used element */
    FB_LISTELEM        *tail;    /* Last used element */
    FB_LISTELEM        *fhead;   /* First free element */
} FB_LIST;

void                fb_hListInit            ( FB_LIST *list, void *table, size_t elem_size, size_t size );
FB_LISTELEM        *fb_hListAllocElem       ( FB_LIST *list );
void                fb_hListFreeElem        ( FB_LIST *list, FB_LISTELEM *elem );
void                fb_hListDynInit         ( FB_LIST *list );
void                fb_hListDynElemAdd      ( FB_LIST *list, FB_LISTELEM *elem );
void                fb_hListDynElemRemove   ( FB_LIST *list, FB_LISTELEM *elem );

#include "fb_unicode.h"
#include "fb_error.h"
#include "fb_string.h"
#include "fb_array.h"
#include "fb_system.h"
#include "fb_math.h"
#include "fb_data.h"
#include "fb_console.h"
#include "fb_file.h"
#include "fb_print.h"
#include "fb_device.h"
#include "fb_serial.h"
#include "fb_printer.h"
#include "fb_datetime.h"
#include "fb_thread.h"
#include "fb_event.h"
#include "fb_hook.h"
#include "fb_oop.h"
#include "fb_legacy.h"

FBSTRING *fb_hMakeInkeyStr( int ch );
int fb_hScancodeToExtendedKey( int scancode );

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
	char           *errmsg;
	FB_HOOKSTB      hooks;
	FB_FILE         fileTB[FB_MAX_FILES];
	int             do_file_reset;
	int             lang;
	void          (*exit_gfxlib2)(void);
} FB_RTLIB_CTX;

extern FB_RTLIB_CTX __fb_ctx;

#endif /*__FB_H__*/
