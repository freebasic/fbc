#ifndef __FB_CONSOLE_H__
#define __FB_CONSOLE_H__

#if FB_TAB_WIDTH == 8
#define FB_NATIVE_TAB 1
#endif

#ifndef FB_CONSOLE_MAXPAGES
#define FB_CONSOLE_MAXPAGES 1
#endif

#define FB_COLOR_FG_DEFAULT   0x00000001
#define FB_COLOR_BG_DEFAULT   0x00000002

#define FB_PRINT_NEWLINE      0x00000001
#define FB_PRINT_PAD          0x00000002
#define FB_PRINT_BIN_NEWLINE  0x00000004
#define FB_PRINT_FORCE_ADJUST 0x00000008     /* Enforce position adjustment
                                              * when last character in screen
                                              * buffer gets handles in a special
                                              * way */
#define FB_PRINT_APPEND_SPACE 0x00000010
#define FB_PRINT_ISLAST       0x80000000     /* only for USING */

typedef struct _FB_PRINTUSGCTX {
    int     		chars;
    char 			*ptr;
    FBSTRING		fmtstr;
} FB_PRINTUSGCTX;

/** Small helper function that converts a TEXT new-line to a BINARY new-line.
 *
 * This is required for all the LPRINT functions.
 */
static __inline__ int FB_PRINT_CONVERT_BIN_NEWLINE(int mask)
{
    if( mask & FB_PRINT_NEWLINE ) {
        mask = (mask & ~FB_PRINT_NEWLINE) | FB_PRINT_BIN_NEWLINE;
    }
    return mask;
}

/** masked bits for "high level" flags
 *
 * I.e. flags that are set by the BASIC PRINT command directly.
 */
#define FB_PRINT_HLMASK  0x00000003

#define FB_PRINT_EX(handle, s, len, mask)                             \
    fb_hFilePrintBufferEx( handle, s, len )

#define FB_PRINT(fnum, s, mask)                                       \
    FB_PRINT_EX( FB_FILE_TO_HANDLE(fnum), s, strlen(s), 0 )

#define FB_PRINTWSTR_EX(handle, s, len, mask)                         \
    fb_hFilePrintBufferWstrEx( handle, s, len )

#define FB_PRINTWSTR(fnum, s, mask)                                   \
    FB_PRINTWSTR_EX( FB_FILE_TO_HANDLE(fnum), s, fb_wstr_len(s), 0 )

#define FB_PRINTNUM_EX(handle, val, mask, fmt, type)                          \
    do {                                                                      \
        char buffer[80];                                                      \
        int len;                                                              \
                                                                              \
        if( mask & FB_PRINT_APPEND_SPACE ) {                                  \
            if( mask & FB_PRINT_BIN_NEWLINE )                                 \
                len = sprintf( buffer, fmt type " " FB_BINARY_NEWLINE, val ); \
            else if( mask & FB_PRINT_NEWLINE )                                \
                len = sprintf( buffer, fmt type " " FB_NEWLINE, val );        \
            else                                                              \
                len = sprintf( buffer, fmt type " ", val );                   \
        } else {                                                              \
            if( mask & FB_PRINT_BIN_NEWLINE )                                 \
                len = sprintf( buffer, fmt type FB_BINARY_NEWLINE, val );     \
            else if( mask & FB_PRINT_NEWLINE )                                \
                len = sprintf( buffer, fmt type FB_NEWLINE, val );            \
            else                                                              \
                len = sprintf( buffer, fmt type, val );                       \
        }                                                                     \
                                                                              \
        FB_PRINT_EX( handle, buffer, len, mask );                             \
                                                                              \
        if( mask & FB_PRINT_PAD )                                             \
            fb_PrintPadEx ( handle, mask );                                   \
                                                                              \
    } while (0)

#define FB_PRINTNUM(fnum, val, mask, fmt, type)                       \
    FB_PRINTNUM_EX( FB_FILE_TO_HANDLE(fnum), val, mask, fmt, type )

#define FB_WRITENUM_EX(handle, val, mask, type )                      \
    do {                                                              \
        char buffer[80];									          \
        size_t len;                                                   \
                                                                      \
        if( mask & FB_PRINT_BIN_NEWLINE )           		          \
            len = sprintf( buffer, type FB_BINARY_NEWLINE, val );     \
        else if( mask & FB_PRINT_NEWLINE )           		          \
            len = sprintf( buffer, type FB_NEWLINE, val );            \
        else												          \
            len = sprintf( buffer, type ",", val );                   \
                                                                      \
        fb_hFilePrintBufferEx( handle, buffer, len );	              \
    } while (0)

#define FB_WRITENUM(fnum, val, mask, type) 				    \
    FB_WRITENUM_EX(FB_FILE_TO_HANDLE(fnum), val, mask, type)

struct _FB_FILE;

       int          fb_ConsoleWidth     ( int cols, int rows );
       void         fb_ConsoleClear     ( int mode );

       int          fb_ConsoleLocate    ( int row, int col, int cursor );
       int          fb_ConsoleGetY      ( void );
       int          fb_ConsoleGetX      ( void );
FBCALL void         fb_ConsoleGetSize   ( int *cols, int *rows );
FBCALL void         fb_ConsoleGetXY     ( int *col, int *row );

FBCALL unsigned int fb_ConsoleReadXY    ( int col, int row, int colorflag );
       int          fb_ConsoleColor     ( int fc, int bc, int flags );
       int          fb_ConsoleGetColorAtt( void );

FBCALL int          fb_ConsoleView      ( int toprow, int botrow );
       int          fb_ConsoleViewEx    ( int toprow, int botrow, int set_cursor );
       void         fb_ConsoleGetView   ( int *toprow, int *botrow );
       int          fb_ConsoleGetMaxRow ( void );
       void         fb_ConsoleViewUpdate( void );

       void         fb_ConsoleScroll    ( int nrows );

       int          fb_ConsoleGetkey    ( void );
       FBSTRING    *fb_ConsoleInkey     ( void );
       int          fb_ConsoleKeyHit    ( void );

       int          fb_ConsoleMultikey  ( int scancode );
       int          fb_ConsoleGetMouse  ( int *x, int *y, int *z, int *buttons_, int *clip );
       int          fb_ConsoleSetMouse  ( int x, int y, int cursor, int clip );

       void         fb_ConsolePrintBuffer( const char *buffer, int mask );
       void         fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask );
       void         fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask );
       void         fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t len,
       											 int mask );

       char        *fb_ConsoleReadStr   ( char *buffer, int len );

       int          fb_ConsoleGetTopRow ( void );
       int          fb_ConsoleGetBotRow ( void );
       void         fb_ConsoleSetTopBotRows( int top, int bot );

       void         fb_ConsoleSleep     ( int msecs );

       int 			fb_ConsoleIsRedirected( int is_input );

       int			fb_ConsolePageCopy	( int src, int dst );
       int			fb_ConsolePageSet	( int active, int visible );

       void         fb_ConReadLineEx    ( FBSTRING *dst, int soft_cursor );
FBCALL FBSTRING    *fb_ConReadLine      ( int soft_cursor );

	   int 			fb_ConsoleLineInput	( FBSTRING *text, void *dst, int dst_len,
	   									  int fillrem, int addquestion, int addnewline );
       int          fb_ConsoleLineInputWstr ( const FB_WCHAR *text, FB_WCHAR *dst,
       										  int max_chars, int addquestion,
       										  int addnewline );

FBCALL void         fb_PrintPad         ( int fnum, int mask );
       void         fb_PrintPadEx       ( struct _FB_FILE *handle, int mask );
FBCALL void 		fb_PrintPadWstr		( int fnum, int mask );
	   void 		fb_PrintPadWstrEx 	( struct _FB_FILE *handle, int mask );

FBCALL void         fb_PrintVoid        ( int fnum, int mask );
       void         fb_PrintVoidEx      ( struct _FB_FILE *handle, int mask );
FBCALL void 		fb_PrintVoidWstr	( int fnum, int mask );
	   void 		fb_PrintVoidWstrEx  ( struct _FB_FILE *handle, int mask );

FBCALL void         fb_PrintByte        ( int fnum, char val, int mask );
FBCALL void         fb_PrintUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_PrintShort       ( int fnum, short val, int mask );
FBCALL void         fb_PrintUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_PrintInt         ( int fnum, int val, int mask );
FBCALL void         fb_PrintUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_PrintSingle      ( int fnum, float val, int mask );
FBCALL void         fb_PrintDouble      ( int fnum, double val, int mask );
FBCALL void         fb_PrintString      ( int fnum, FBSTRING *s, int mask );
FBCALL void 		fb_PrintWstr 		( int fnum, const FB_WCHAR *s, int mask );
       void         fb_PrintStringEx    ( struct _FB_FILE *handle, FBSTRING *s, int mask );
       void 		fb_PrintWstrEx 		( struct _FB_FILE *handle, const FB_WCHAR *s,
       									  int mask );
FBCALL void         fb_PrintFixString   ( int fnum, const char *s, int mask );
       void         fb_PrintFixStringEx ( struct _FB_FILE *handle, const char *s, int mask );

FBCALL void         fb_PrintBuffer      ( const char *s, int mask );
FBCALL void         fb_PrintBufferEx    ( const void *buffer, size_t len, int mask );
FBCALL void 		fb_PrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask );

FBCALL void         fb_PrintTab         ( int fnum, int newcol );
FBCALL void         fb_PrintSPC         ( int fnum, int n );

FBCALL void         fb_WriteVoid        ( int fnum, int mask );
FBCALL void         fb_WriteByte        ( int fnum, char val, int mask );
FBCALL void         fb_WriteUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_WriteShort       ( int fnum, short val, int mask );
FBCALL void         fb_WriteUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_WriteInt         ( int fnum, int val, int mask );
FBCALL void         fb_WriteUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_WriteSingle      ( int fnum, float val, int mask );
FBCALL void         fb_WriteDouble      ( int fnum, double val, int mask );
FBCALL void         fb_WriteString      ( int fnum, FBSTRING *s, int mask );
FBCALL void         fb_WriteFixString   ( int fnum, char *s, int mask );
FBCALL void 		fb_WriteWstr 		( int fnum, FB_WCHAR *s, int mask );

#endif /* __FB_CONSOLE_H__ */
