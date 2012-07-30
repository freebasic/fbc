#define FBCALL

/* newline for console/file I/O */
#define FB_NEWLINE "\r\n"
#define FB_NEWLINE_WSTR _LC("\r\n")

/* newline for printer I/O */
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")

#define FB_LL_FMTMOD "ll"

#define FB_CONSOLE_MAXPAGES 8

#define FB_DYLIB void*

/* In DJGPP we don't use fseeko() at all, the DJGPP semi-2.04 setup used for
   FB doesn't even seem to have it. */
typedef long fb_off_t;
#define fseeko(stream, offset, whence) fseek(stream, offset, whence)
#define ftello(stream)                 ftell(stream)

#define FB_COLOR_BLACK     (0)
#define FB_COLOR_BLUE      (1)
#define FB_COLOR_GREEN     (2)
#define FB_COLOR_CYAN      (3)
#define FB_COLOR_RED       (4)
#define FB_COLOR_MAGENTA   (5)
#define FB_COLOR_BROWN     (6)
#define FB_COLOR_WHITE     (7)
#define FB_COLOR_GREY      (8)
#define FB_COLOR_LBLUE     (9)
#define FB_COLOR_LGREEN    (10)
#define FB_COLOR_LCYAN     (11)
#define FB_COLOR_LRED      (12)
#define FB_COLOR_LMAGENTA  (13)
#define FB_COLOR_YELLOW    (14)
#define FB_COLOR_BWHITE    (15)

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

extern char *__fb_startup_cwd;

typedef int (*FnIntHandler)(unsigned irq_number);

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

/* multikey() declarations also used by gfxlib2 */
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

void fb_hFarMemSet ( unsigned short selector, unsigned long dest, unsigned char char_to_set, size_t bytes );
void fb_hFarMemSetW( unsigned short selector, unsigned long dest, unsigned short word_to_set, size_t words );
