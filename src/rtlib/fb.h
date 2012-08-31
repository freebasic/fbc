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

/* Key code from char */
#define FB_MAKE_KEY(ch)     ((int) ((unsigned) (unsigned char) (ch)))

/* Macro to calculate an extended key code for a character.
   This macro is used to build the integer value of a two-byte key code
   returned by SCRN: (and INKEY$). */
#define FB_MAKE_EXT_KEY(ch) \
	((int) ((((unsigned) (unsigned char) (ch)) << 8) + \
	        (unsigned) (unsigned char) (FB_EXT_CHAR)))

#define MIN(a,b)		((a) < (b) ? (a) : (b))
#define MAX(a,b)		((a) > (b) ? (a) : (b))
#define MID(a,b,c)		MIN(MAX((a), (b)), (c))

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

#if defined ENABLE_MT && !defined HOST_DOS && !defined HOST_XBOX
	FBCALL void fb_Lock( void );
	FBCALL void fb_Unlock( void );
	FBCALL void fb_StrLock( void );
	FBCALL void fb_StrUnlock( void );
	#define FB_LOCK()      fb_Lock()
	#define FB_UNLOCK()    fb_Unlock()
	#define FB_STRLOCK()   fb_StrLock()
	#define FB_STRUNLOCK() fb_StrUnlock()
#else
	#define FB_LOCK()
	#define FB_UNLOCK()
	#define FB_STRLOCK()
	#define FB_STRUNLOCK()
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

void                fb_hListInit            ( FB_LIST *list, void *table, int elem_size, int size );
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
#include "fb_hook.h"
#include "fb_oop.h"

/* DOS keyboard scancodes */
#define SC_ESCAPE	0x01
#define SC_1		0x02
#define SC_2		0x03
#define SC_3		0x04
#define SC_4		0x05
#define SC_5		0x06
#define SC_6		0x07
#define SC_7		0x08
#define SC_8		0x09
#define SC_9		0x0A
#define SC_0		0x0B
#define SC_MINUS	0x0C
#define SC_EQUALS	0x0D
#define SC_BACKSPACE	0x0E
#define SC_TAB		0x0F
#define SC_Q		0x10
#define SC_W		0x11
#define SC_E		0x12
#define SC_R		0x13
#define SC_T		0x14
#define SC_Y		0x15
#define SC_U		0x16
#define SC_I		0x17
#define SC_O		0x18
#define SC_P		0x19
#define SC_LEFTBRACKET	0x1A
#define SC_RIGHTBRACKET	0x1B
#define SC_ENTER	0x1C
#define SC_CONTROL	0x1D
#define SC_A		0x1E
#define SC_S		0x1F
#define SC_D		0x20
#define SC_F		0x21
#define SC_G		0x22
#define SC_H		0x23
#define SC_J		0x24
#define SC_K		0x25
#define SC_L		0x26
#define SC_SEMICOLON	0x27
#define SC_QUOTE	0x28
#define SC_TILDE	0x29
#define SC_LSHIFT	0x2A
#define SC_BACKSLASH	0x2B
#define SC_Z		0x2C
#define SC_X		0x2D
#define SC_C		0x2E
#define SC_V		0x2F
#define SC_B		0x30
#define SC_N		0x31
#define SC_M		0x32
#define SC_COMMA	0x33
#define SC_PERIOD	0x34
#define SC_SLASH	0x35
#define SC_RSHIFT	0x36
#define SC_MULTIPLY	0x37
#define SC_ALT		0x38
#define SC_SPACE	0x39
#define SC_CAPSLOCK	0x3A
#define SC_F1		0x3B
#define SC_F2		0x3C
#define SC_F3		0x3D
#define SC_F4		0x3E
#define SC_F5		0x3F
#define SC_F6		0x40
#define SC_F7		0x41
#define SC_F8		0x42
#define SC_F9		0x43
#define SC_F10		0x44
#define SC_NUMLOCK	0x45
#define SC_SCROLLLOCK	0x46
#define SC_HOME		0x47
#define SC_UP		0x48
#define SC_PAGEUP	0x49
#define SC_LEFT		0x4B
#define SC_RIGHT	0x4D
#define SC_PLUS		0x4E
#define SC_END		0x4F
#define SC_DOWN		0x50
#define SC_PAGEDOWN	0x51
#define SC_INSERT	0x52
#define SC_DELETE	0x53
#define SC_F11		0x57
#define SC_F12		0x58
#define SC_LWIN		0x5B
#define SC_RWIN		0x5C
#define SC_MENU		0x5D
#define SC_ALTGR	0x64

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
	FB_HOOKSTB      hooks;
	FB_FILE         fileTB[FB_MAX_FILES];
	int             do_file_reset;
	int             lang;
} FB_RTLIB_CTX;

extern FB_RTLIB_CTX __fb_ctx;

#endif /*__FB_H__*/
