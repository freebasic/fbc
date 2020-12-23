#define FB_PRINT_NEWLINE      0x00000001
#define FB_PRINT_PAD          0x00000002
#define FB_PRINT_BIN_NEWLINE  0x00000004
#define FB_PRINT_FORCE_ADJUST 0x00000008     /* Enforce position adjustment
                                              * when last character in screen
                                              * buffer gets handles in a special
                                              * way */
#define FB_PRINT_APPEND_SPACE 0x00000010
#define FB_PRINT_ISLAST       0x80000000     /* only for USING */

/* Small helper function that converts the TEXT new-line flag to the BINARY
   new-line flag. This is used by all the LPRINT functions, to allow them to
   use the same public API like the normal PRINT functions. */
static __inline__ int FB_PRINT_CONVERT_BIN_NEWLINE(int mask)
{
    if( mask & FB_PRINT_NEWLINE ) {
        mask = (mask & ~FB_PRINT_NEWLINE) | FB_PRINT_BIN_NEWLINE;
    }
    return mask;
}

/* masked bits for "high level" flags, i.e. flags that are set by the
   BASIC PRINT command directly. */
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
        size_t len;                                                           \
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

FBCALL void         fb_PrintBuffer      ( const char *s, int mask );
FBCALL void         fb_PrintBufferEx    ( const void *buffer, size_t len, int mask );
FBCALL void         fb_PrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask );

FBCALL void         fb_PrintPad         ( int fnum, int mask );
       void         fb_PrintPadEx       ( FB_FILE *handle, int mask );
FBCALL void         fb_PrintPadWstr     ( int fnum, int mask );
       void         fb_PrintPadWstrEx   ( FB_FILE *handle, int mask );

FBCALL void         fb_PrintVoid        ( int fnum, int mask );
       void         fb_PrintVoidEx      ( FB_FILE *handle, int mask );
FBCALL void         fb_PrintVoidWstr    ( int fnum, int mask );
       void         fb_PrintVoidWstrEx  ( FB_FILE *handle, int mask );

FBCALL void         fb_PrintBool        ( int fnum, char val, int mask );
FBCALL void         fb_PrintByte        ( int fnum, signed char val, int mask );
FBCALL void         fb_PrintUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_PrintShort       ( int fnum, short val, int mask );
FBCALL void         fb_PrintUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_PrintInt         ( int fnum, int val, int mask );
FBCALL void         fb_PrintUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_PrintLongint     ( int fnum, long long val, int mask );
FBCALL void         fb_PrintULongint    ( int fnum, unsigned long long val, int mask );
FBCALL void         fb_PrintSingle      ( int fnum, float val, int mask );
FBCALL void         fb_PrintDouble      ( int fnum, double val, int mask );
FBCALL void         fb_PrintString      ( int fnum, FBSTRING *s, int mask );
       void         fb_PrintStringEx    ( FB_FILE *handle, FBSTRING *s, int mask );
FBCALL void         fb_PrintWstr        ( int fnum, const FB_WCHAR *s, int mask );
       void         fb_PrintWstrEx      ( FB_FILE *handle, const FB_WCHAR *s, int mask );
FBCALL void         fb_PrintFixString   ( int fnum, const char *s, int mask );
       void         fb_PrintFixStringEx ( FB_FILE *handle, const char *s, int mask );

FBCALL int          fb_LPos             ( int printer_index );
       int          fb_LPrintInit       ( void );
FBCALL void         fb_LPrintVoid       ( int fnum, int mask );
FBCALL void         fb_LPrintBool       ( int fnum, char val, int mask );
FBCALL void         fb_LPrintByte       ( int fnum, signed char val, int mask );
FBCALL void         fb_LPrintUByte      ( int fnum, unsigned char val, int mask );
FBCALL void         fb_LPrintShort      ( int fnum, short val, int mask );
FBCALL void         fb_LPrintUShort     ( int fnum, unsigned short val, int mask );
FBCALL void         fb_LPrintInt        ( int fnum, int val, int mask );
FBCALL void         fb_LPrintUInt       ( int fnum, unsigned int val, int mask );
FBCALL void         fb_LPrintLongint    ( int fnum, long long val, int mask );
FBCALL void         fb_LPrintULongint   ( int fnum, unsigned long long val, int mask );
FBCALL void         fb_LPrintSingle     ( int fnum, float val, int mask );
FBCALL void         fb_LPrintDouble     ( int fnum, double val, int mask );
FBCALL void         fb_LPrintString     ( int fnum, FBSTRING *s, int mask );
FBCALL void         fb_LPrintWstr       ( int fnum, const FB_WCHAR *s, int mask );

FBCALL void         fb_PrintTab         ( int fnum, int newcol );
FBCALL void         fb_PrintSPC         ( int fnum, ssize_t n );

FBCALL void         fb_WriteVoid        ( int fnum, int mask );
FBCALL void         fb_WriteBool        ( int fnum, char val, int mask );
FBCALL void         fb_WriteByte        ( int fnum, signed char val, int mask );
FBCALL void         fb_WriteUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_WriteShort       ( int fnum, short val, int mask );
FBCALL void         fb_WriteUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_WriteInt         ( int fnum, int val, int mask );
FBCALL void         fb_WriteUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_WriteLongint     ( int fnum, long long val, int mask );
FBCALL void         fb_WriteULongint    ( int fnum, unsigned long long val, int mask );
FBCALL void         fb_WriteSingle      ( int fnum, float val, int mask );
FBCALL void         fb_WriteDouble      ( int fnum, double val, int mask );
FBCALL void         fb_WriteString      ( int fnum, FBSTRING *s, int mask );
FBCALL void         fb_WriteWstr        ( int fnum, FB_WCHAR *s, int mask );
FBCALL void         fb_WriteFixString   ( int fnum, char *s, int mask );

FBCALL int          fb_PrintUsingInit   ( FBSTRING *fmtstr );
FBCALL int          fb_PrintUsingStr    ( int fnum, FBSTRING *s, int mask );
FBCALL int          fb_PrintUsingWstr   ( int fnum, FB_WCHAR *s, int mask );
FBCALL int          fb_PrintUsingSingle ( int fnum, float value_f, int mask );
FBCALL int          fb_PrintUsingDouble ( int fnum, double value, int mask );
FBCALL int          fb_PrintUsingLongint( int fnum, long long val_ll, int mask );
FBCALL int          fb_PrintUsingULongint( int fnum, unsigned long long value_ull, int mask );
FBCALL int          fb_PrintUsingEnd    ( int fnum );

FBCALL int          fb_LPrintUsingInit  ( FBSTRING *fmtstr );
