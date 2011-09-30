/* common DOS definitions. */

#ifndef __FB_DOS_H__
#define __FB_DOS_H__

#define FB_DOS_USE_CONIO

#include <dpmi.h>
#include <dos.h>
#include <go32.h>
#include <pc.h>
#include <sys/farptr.h>
#include <dir.h>

#include <stdio.h>
#include <stdarg.h>
#include <stdint.h>

#ifdef FB_DOS_USE_CONIO
# include <conio.h>
#endif

#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

#define FB_DYLIB void* /* define FB_DYLIB to keep the headers happy. */

typedef struct _FB_DIRCTX
{
	int in_use;
	int attrib;
	struct ffblk f;
} FB_DIRCTX;

typedef long fb_off_t;

typedef struct {
    unsigned long edi;
    unsigned long esi;
    unsigned long ebp;
    unsigned long res;
    unsigned long ebx;
    unsigned long edx;
    unsigned long ecx;
    unsigned long eax;
} __dpmi_regs_d;

#define FB_CONSOLE_MAXPAGES 8

typedef struct _FB_CONSOLE_CTX {
	int				active, visible;
	int 			w, h;
	unsigned long 	phys_addr;
	int 			scrollWasOff;
	int 			forceInpBufferChanged;
} FB_CONSOLE_CTX;

extern FB_CONSOLE_CTX __fb_con;

extern char *__fb_startup_cwd;

typedef int (*FnIntHandler)(unsigned irq_number);

int fb_ConsoleLocate_BIOS( int row, int col, int cursor );
void fb_ConsoleGetXY_BIOS( int *col, int *row );
unsigned int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag );

void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows );
void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows );

void fb_ConsoleMultikeyInit( void );
int fb_hConsoleInputBufferChanged( void );

unsigned long fb_hGetPageAddr( int pg, int cols, int rows );

int fb_isr_set( unsigned irq_number,
                FnIntHandler pfnIntHandler,
                size_t fn_size,
                size_t stack_size );

int fb_isr_reset( unsigned irq_number );

FnIntHandler fb_isr_get( unsigned irq_number );

/* To allow recursive CLI/STI */
int fb_dos_cli( void );
int fb_dos_sti( void );

int fb_dos_lock_data(const void *address, size_t size);
int fb_dos_lock_code(const void *address, size_t size);
int fb_dos_unlock_data(const void *address, size_t size);
int fb_dos_unlock_code(const void *address, size_t size);

#define lock_var(var)           fb_dos_lock_data(   (void *)&(var), sizeof(var) )
#define lock_array(array)       fb_dos_lock_data(   (void *)(array), sizeof(array) )
#define lock_proc(proc)         fb_dos_lock_code(   proc, (unsigned) end_##proc - (unsigned) proc )
#define lock_data(start, end)   fb_dos_lock_data(   (&start), (const char *)(&end) - (const char *)(&start) )
#define lock_code(start, end)   fb_dos_lock_code(   (start), (const char *)(end) - (const char *)(start) )

#define unlock_var(var)         fb_dos_unlock_data( (void *)&(var), sizeof(var) )
#define unlock_array(array)     fb_dos_unlock_data( (void *)(array), sizeof(array) )
#define unlock_proc(proc)       fb_dos_unlock_code( proc, (unsigned) end_##proc - (unsigned) proc )
#define unlock_data(start, end) fb_dos_unlock_data( (&start), (const char *)(&end) - (const char *)(&start) )
#define unlock_code(start, end) fb_dos_unlock_code( (start), (const char *)(end) - (const char *)(start) )

#define END_OF_FUNCTION(proc)               void end_##proc (void) { }
#define END_OF_STATIC_FUNCTION(proc) static void end_##proc (void) { }

void (*__fb_dos_multikey_hook)(int scancode, int flags);

#define KB_PRESS    0x00000001
#define KB_REPEAT   0x00000002
#define KB_SHIFT    0x00000004
#define KB_CTRL     0x00000008
#define KB_ALT      0x00000010
#define KB_CAPSLOCK 0x00000020
#define KB_NUMLOCK  0x00000040
#define KB_EXTENDED 0x00000080

/* farmemset.c */

extern void fb_hFarMemSet ( unsigned short selector, unsigned long dest, unsigned char char_to_set, size_t bytes );
extern void fb_hFarMemSetW( unsigned short selector, unsigned long dest, unsigned short word_to_set, size_t words );


/**************************************************************************************************
 * VB-compatible functions
 **************************************************************************************************/

    /** Locale information not provided by DOS but that are useful too.
     */
typedef struct _FB_LOCALE_INFOS {
	int country_code;
    const char *apszNamesMonthLong[12];
    const char *apszNamesMonthShort[12];
    const char *apszNamesWeekdayLong[7];
    const char *apszNamesWeekdayShort[7];
} FB_LOCALE_INFOS;

/** Array of locale informations.
 *
 * The last entry contains a country_code of -1.
 */
extern const FB_LOCALE_INFOS __fb_locale_infos[];
extern const size_t          __fb_locale_info_count;

struct _DOS_COUNTRY_INFO_GENERAL {
	unsigned char   info_id;
	unsigned short  size_data;
	unsigned short  country_id;
	unsigned short  code_page;
	unsigned short  date_format;
	char            curr_symbol_string[5];
	char            thousands_sep[2];
	char            decimal_sep[2];
	char            date_sep[2];
	char            time_sep[2];
	unsigned char   currency_format;
	unsigned char   curr_frac_digits;
	unsigned char   time_format;
	unsigned long   far_ptr_case_map_routine;
	char            data_list_sep[2];
	char            reserved[10];
} __attribute__((packed));

typedef struct _DOS_COUNTRY_INFO_GENERAL DOS_COUNTRY_INFO_GENERAL;

int fb_hIntlGetInfo( DOS_COUNTRY_INFO_GENERAL *pInfo );

/**************************************************************************************************
 * Threading
 **************************************************************************************************/

extern void fb_ThreadingExit( void );

typedef struct _FB_DOS_THREAD FB_DOS_THREAD;

typedef struct _FBMUTEX {
	unsigned int locked;
	int lock_count;
	FB_DOS_THREAD *owner;
} FBMUTEX;

typedef volatile unsigned int FB_DOS_SPINLOCK;

/* TLS flags */
#define FB_DOS_TLS_INUSE	0x00000001

/* thread-local storage */
typedef struct _FB_DOS_TLS {
	void *value;
	unsigned int flags;
} FB_DOS_TLS;

/* internal DOS thread data */
struct _FB_DOS_THREAD {
	FB_DOS_THREAD *prev;
	FB_DOS_THREAD *next;

	/* stack */
	void *stack;

	/* thread-local storage */
	FB_DOS_TLS *tls;
	int tls_max;
	int tls_count;
	FBMUTEX *tls_mutex;

};

extern FB_DOS_THREAD __fb_idle_thread;
extern FB_DOS_THREAD __fb_main_thread;
extern FB_DOS_THREAD *__fb_curr_thread;

/* thread-local storage */
typedef int FB_DOS_TLS_KEY;
#define FB_DOS_INVALID_TLS_KEY ((FB_DOS_TLS_KEY)~0)

extern FB_DOS_TLS_KEY fb_hTlsAlloc( void );
extern void fb_hTlsFree( FB_DOS_TLS_KEY key );
extern void *fb_hTlsGet( FB_DOS_TLS_KEY key );
extern void fb_hTlsSet( FB_DOS_TLS_KEY key, void *value );

typedef FB_DOS_TLS_KEY FB_TLSENTRY;
typedef FB_DOS_THREAD *FB_THREADID;

extern FBMUTEX __fb_thread_mutex;

#ifdef ENABLE_MT
extern FBMUTEX __fb_global_mutex;
extern FBMUTEX __fb_string_mutex;

extern void fb_hMutexLock( FBMUTEX *mutex );
extern void fb_hMutexUnlock( FBMUTEX *mutex );

# define FB_LOCK()					fb_hMutexLock( &__fb_global_mutex )
# define FB_UNLOCK()				fb_hMutexUnlock( &__fb_global_mutex )
# define FB_STRLOCK()				fb_hMutexLock( &__fb_string_mutex )
# define FB_STRUNLOCK()				fb_hMutexUnlock( &__fb_string_mutex )
# define FB_TLSALLOC(key) 			key = fb_hTlsAlloc( )
# define FB_TLSFREE(key)			fb_hTlsFree( (key) )
# define FB_TLSSET(key,value)		fb_hTlsSet( (key), (void *)(value) )
# define FB_TLSGET(key)				fb_hTlsGet( (key) )
#endif

#endif
