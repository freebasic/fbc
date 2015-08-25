#define FB_FILE_MODE_BINARY             0
#define FB_FILE_MODE_RANDOM             1
#define FB_FILE_MODE_INPUT              2
#define FB_FILE_MODE_OUTPUT             3
#define FB_FILE_MODE_APPEND             4

#define FB_FILE_ACCESS_ANY              0
#define FB_FILE_ACCESS_READ             1
#define FB_FILE_ACCESS_WRITE            2
#define FB_FILE_ACCESS_READWRITE        3

#define FB_FILE_LOCK_SHARED             0
#define FB_FILE_LOCK_READ               1
#define FB_FILE_LOCK_WRITE              2
#define FB_FILE_LOCK_READWRITE          3

#define FB_FILE_TYPE_NORMAL             0
#define FB_FILE_TYPE_CONSOLE            1
#define FB_FILE_TYPE_ERR                2
#define FB_FILE_TYPE_PIPE               3
#define FB_FILE_TYPE_VFS                4
#define FB_FILE_TYPE_PRINTER            5
#define FB_FILE_TYPE_SERIAL             6

typedef enum _FB_FILE_ENCOD {
	FB_FILE_ENCOD_ASCII,
	FB_FILE_ENCOD_UTF8,
	FB_FILE_ENCOD_UTF16,
	FB_FILE_ENCOD_UTF32
} FB_FILE_ENCOD;

#define FB_FILE_ENCOD_DEFAULT FB_FILE_ENCOD_ASCII


#define FB_FILE_FROM_HANDLE(handle) \
    (((handle) - __fb_ctx.fileTB) + 1 - FB_RESERVED_FILES)
#define FB_FILE_INDEX_VALID(index) \
    ((index)>=1 && ((index)<=(FB_MAX_FILES-FB_RESERVED_FILES)))

#define FB_INDEX_IS_SPECIAL(index) \
    (((index) < 1) && (((index) > (-FB_RESERVED_FILES))

#define FB_HANDLE_IS_SCREEN(handle) \
    ((handle)!=NULL && FB_HANDLE_DEREF(handle)==FB_HANDLE_SCREEN)

#define FB_HANDLE_USED(handle) \
    ((handle)!=NULL && ((handle)->hooks!=NULL))

#define FB_HANDLE_SCREEN    __fb_ctx.fileTB
#define FB_HANDLE_PRINTER   (__fb_ctx.fileTB+1)

struct _FB_FILE;

typedef int (*FnFileSetWidth)       ( struct _FB_FILE *handle, int new_width );
typedef int (*FnFileTest)           ( struct _FB_FILE *handle, const char *filename,
                                      size_t filename_len );
typedef int (*FnFileOpen)           ( struct _FB_FILE *handle, const char *filename,
                                      size_t filename_len );
typedef int (*FnFileEof)            ( struct _FB_FILE *handle );
typedef int (*FnFileClose)          ( struct _FB_FILE *handle );
typedef int (*FnFileSeek)           ( struct _FB_FILE *handle, fb_off_t offset, int whence );
typedef int (*FnFileTell)           ( struct _FB_FILE *handle, fb_off_t *pOffset );
typedef int (*FnFileRead)           ( struct _FB_FILE *handle, void *value,
                                      size_t *pValuelen );
typedef int (*FnFileReadWstr)       ( struct _FB_FILE *handle, FB_WCHAR *value,
                                      size_t *pValuelen );
typedef int (*FnFileWrite)          ( struct _FB_FILE *handle, const void *value,
                                      size_t valuelen );
typedef int (*FnFileWriteWstr)      ( struct _FB_FILE *handle, const FB_WCHAR *value,
                                      size_t valuelen );
typedef int (*FnFileLock)           ( struct _FB_FILE *handle, fb_off_t position,
                                      fb_off_t size );
typedef int (*FnFileUnlock)         ( struct _FB_FILE *handle, fb_off_t position,
                                      fb_off_t size );
typedef int (*FnFileReadLine)       ( struct _FB_FILE *handle, FBSTRING *dst );
typedef int (*FnFileReadLineWstr)   ( struct _FB_FILE *handle, FB_WCHAR *dst, ssize_t dst_chars );
typedef int (*FnFileFlush)          ( struct _FB_FILE *handle );

typedef struct _FB_FILE_HOOKS {
    FnFileEof           pfnEof;
    FnFileClose         pfnClose;
    FnFileSeek          pfnSeek;
    FnFileTell          pfnTell;
    FnFileRead          pfnRead;
    FnFileReadWstr      pfnReadWstr;
    FnFileWrite         pfnWrite;
    FnFileWriteWstr     pfnWriteWstr;
    FnFileLock          pfnLock;
    FnFileUnlock        pfnUnlock;
    FnFileReadLine      pfnReadLine;
    FnFileReadLineWstr  pfnReadLineWstr;
    FnFileSetWidth      pfnSetWidth;
    FnFileFlush         pfnFlush;
} FB_FILE_HOOKS;

typedef struct _FB_FILE {
    int             mode;
    int             len;
    FB_FILE_ENCOD   encod;
    fb_off_t        size;
    int             type;
    int             access;
    int             lock;
    unsigned        line_length;
    unsigned        width;

    /* for a device-independent put back feature */
    char            putback_buffer[4];
    size_t          putback_size;

    FB_FILE_HOOKS   *hooks;
    /* an i/o handler might store additional (handler specific) data here */
    void 			*opaque;
    /* used when opening SCRN: to create an redirection handle */
    struct _FB_FILE *redirection_to;
} FB_FILE;

typedef struct {
    FB_FILE			*handle;
    int      		status;
    FBSTRING 		str;
    int     		index;
} FB_INPUTCTX;


#define FB_FILE_TO_HANDLE_VALID( index ) \
	((FB_FILE *)(__fb_ctx.fileTB + (index) - 1 + FB_RESERVED_FILES))

#define FB_FILE_TO_HANDLE( index )                      \
	( (index) == 0?                                 \
	  ((FB_FILE *)FB_HANDLE_SCREEN) :               \
	  ( (index) == -1?                              \
	        ((FB_FILE *)FB_HANDLE_PRINTER) :        \
	        ( FB_FILE_INDEX_VALID( (index) )?       \
	          FB_FILE_TO_HANDLE_VALID( (index) ) :  \
	          ((FB_FILE *)(NULL))                   \
	        )                                       \
	  )                                             \
	)

static __inline__ FB_FILE *FB_HANDLE_DEREF( FB_FILE *handle )
{
	if( handle != NULL ) {
		FB_LOCK();
		while( handle->redirection_to != NULL ) {
			handle = handle->redirection_to;
		}
		FB_UNLOCK();
	}
	return handle;
}

       int          fb_FilePutData      ( int fnum, fb_off_t pos, const void *data,
                                          size_t length, int adjust_rec_pos,
                                          int checknewline );
       int          fb_FilePutDataEx    ( FB_FILE *handle, fb_off_t pos, const void *data,
                                          size_t length, int adjust_rec_pos,
                                          int checknewline, int isunicode );
       int          fb_FileGetData      ( int fnum, fb_off_t pos, void *data,
                                          size_t length, int adjust_rec_pos );
       int          fb_FileGetDataEx    ( FB_FILE *handle, fb_off_t pos, void *data,
                                          size_t length, size_t *bytesread,
                                          int adjust_rec_pos, int isunicode );

       int          fb_FileOpenVfsRawEx ( FB_FILE *handle, const char *filename,
                                          size_t filename_length,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len, FB_FILE_ENCOD encoding,
                                          FnFileOpen pfnOpen );
       int          fb_FileOpenVfsEx    ( FB_FILE *handle, FBSTRING *str_filename,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len, FB_FILE_ENCOD encoding,
                                          FnFileOpen pfnOpen );
FBCALL int          fb_FileOpenCons     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenErr      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenPipe     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenScrn     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );

FBCALL int          fb_FileOpenLpt      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );

FBCALL int          fb_FileOpenCom      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );

FBCALL int fb_FileOpenQB
	(
		FBSTRING *str,
		unsigned int mode,
		unsigned int access,
		unsigned int lock,
		int fnum,
		int len
	);

FBCALL int          fb_FileFree         ( void );
FBCALL int          fb_FileOpen         ( FBSTRING *str, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len );
FBCALL int          fb_FileOpenEncod    ( FBSTRING *str, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
       int          fb_FileOpenEx       ( FB_FILE *handle, FBSTRING *str,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len );
FBCALL int          fb_FileOpenShort    ( FBSTRING *str_file_mode, int fnum,
                                          FBSTRING *filename, int len,
                                          FBSTRING *str_access_mode,
                                          FBSTRING *str_lock_mode);
       int          fb_FileCloseEx      ( FB_FILE *handle );
FBCALL int          fb_FileClose        ( int fnum );
FBCALL int          fb_FileCloseAll     ( void );

FBCALL int          fb_FilePut          ( int fnum, int pos, void* value, size_t valuelen );
FBCALL int          fb_FilePutLarge     ( int fnum, long long pos, void *value, size_t valuelen );
       int          fb_FilePutEx        ( FB_FILE *handle, fb_off_t pos, void* value, size_t valuelen );
FBCALL int          fb_FilePutStr       ( int fnum, int pos, void *str, ssize_t str_len );
FBCALL int          fb_FilePutStrLarge  ( int fnum, long long pos, void *str, ssize_t str_len );
       int          fb_FilePutStrEx     ( FB_FILE *handle, fb_off_t pos, void *str, ssize_t str_len );
FBCALL int          fb_FilePutArray     ( int fnum, int pos, FBARRAY *src );
FBCALL int          fb_FilePutArrayLarge( int fnum, long long pos, FBARRAY *src );

FBCALL int          fb_FileGet          ( int fnum, int pos, void* value, size_t valuelen );
FBCALL int          fb_FileGetLarge     ( int fnum, long long pos, void *dst, size_t chars );
FBCALL int          fb_FileGetIOB       ( int fnum, int pos, void *dst, size_t chars, size_t *bytesread );
FBCALL int          fb_FileGetLargeIOB  ( int fnum, long long pos, void *dst, size_t chars, size_t *bytesread );
       int          fb_FileGetEx        ( FB_FILE *handle, fb_off_t pos, void* value, size_t valuelen );
FBCALL int          fb_FileGetStr       ( int fnum, int pos, void *str, ssize_t str_len );
FBCALL int          fb_FileGetStrLarge  ( int fnum, long long pos, void *str, ssize_t str_len );
FBCALL int          fb_FileGetStrIOB    ( int fnum, int pos, void *str, ssize_t str_len, size_t *bytesread );
FBCALL int          fb_FileGetStrLargeIOB( int fnum, long long pos, void *str, ssize_t str_len, size_t *bytesread );
       int          fb_FileGetStrEx     ( FB_FILE *handle, fb_off_t pos, void *str, ssize_t str_len, size_t *bytesread );
FBCALL int          fb_FileGetArray     ( int fnum, int pos, FBARRAY *dst );
FBCALL int          fb_FileGetArrayLarge( int fnum, long long pos, FBARRAY *dst );
FBCALL int          fb_FileGetArrayIOB  ( int fnum, int pos, FBARRAY *dst, size_t *bytesread );
FBCALL int          fb_FileGetArrayLargeIOB( int fnum, long long pos, FBARRAY *dst, size_t *bytesread );

FBCALL int          fb_FileEof          ( int fnum );
       int          fb_FileEofEx        ( FB_FILE *handle );
FBCALL long long    fb_FileTell         ( int fnum );
       fb_off_t     fb_FileTellEx       ( FB_FILE *handle );
FBCALL int          fb_FileSeek         ( int fnum, int newpos );
FBCALL int          fb_FileSeekLarge    ( int fnum, long long newpos );
       int          fb_FileSeekEx       ( FB_FILE *handle, fb_off_t newpos );
FBCALL long long    fb_FileLocation     ( int fnum );
       fb_off_t     fb_FileLocationEx   ( FB_FILE *handle );
FBCALL int          fb_FileKill         ( FBSTRING *str );
FBCALL void         fb_FileReset        ( void );
FBCALL void         fb_FileResetEx      ( int streamno );
       int          fb_hFileResetEx     ( int streamno );
FBCALL long long    fb_FileSize         ( int fnum );
       fb_off_t     fb_FileSizeEx       ( FB_FILE *handle );
FBCALL int          fb_FilePutBack      ( int fnum, const void *data, size_t length );
FBCALL int          fb_FilePutBackWstr  ( int fnum, const FB_WCHAR *src, size_t chars );
       int          fb_FilePutBackEx    ( FB_FILE *handle, const void *data, size_t length );
       int          fb_FilePutBackWstrEx( FB_FILE *handle, const FB_WCHAR *src, size_t chars );

FBCALL int          fb_FileInput        ( int fnum );
FBCALL FBSTRING    *fb_FileStrInput     ( ssize_t bytes, int fnum );
FBCALL FB_WCHAR    *fb_FileWstrInput    ( ssize_t chars, int fnum );
FBCALL int          fb_FileLineInput    ( int fnum, void *dst, ssize_t dst_len, int fillrem );
FBCALL int          fb_FileLineInputWstr( int fnum, FB_WCHAR *dst, ssize_t max_chars );

FBCALL int          fb_InputBool        ( char *dst );
FBCALL int          fb_InputByte        ( char *dst );
FBCALL int          fb_InputUbyte       ( unsigned char *dst );
FBCALL int          fb_InputShort       ( short *dst );
FBCALL int          fb_InputUshort      ( unsigned short *dst );
FBCALL int          fb_InputInt         ( int *dst );
FBCALL int          fb_InputUint        ( unsigned int *dst );
FBCALL int          fb_InputLongint     ( long long *dst );
FBCALL int          fb_InputUlongint    ( unsigned long long *dst );
FBCALL int          fb_InputSingle      ( float *dst );
FBCALL int          fb_InputDouble      ( double *dst );
FBCALL int          fb_InputString      ( void *dst, ssize_t strlen, int fillrem );
FBCALL int          fb_InputWstr        ( FB_WCHAR *str, ssize_t length );

FBCALL int          fb_FileLock         ( int fnum, unsigned int inipos, unsigned int endpos );
FBCALL int          fb_FileLockLarge    ( int fnum, long long inipos, long long endpos );
FBCALL int          fb_FileUnlock       ( int fnum, unsigned int inipos, unsigned int endpos );
FBCALL int          fb_FileUnlockLarge  ( int fnum, long long inipos, long long endpos );

       int          fb_hFilePrintBuffer ( int fnum, const char *buffer );
       int          fb_hFilePrintBufferWstr ( int fnum, const FB_WCHAR *buffer );
       int          fb_hFilePrintBufferEx( FB_FILE *handle, const void *buffer, size_t len );
       int          fb_hFilePrintBufferWstrEx( FB_FILE *handle, const FB_WCHAR *buffer, size_t len );

       int          fb_hFileLock        ( FILE *f, fb_off_t inipos, fb_off_t size );
       int          fb_hFileUnlock      ( FILE *f, fb_off_t inipos, fb_off_t size );
       void         fb_hConvertPath     ( char *path );

       FB_FILE_ENCOD fb_hFileStrToEncoding( const char *encoding );

FBCALL int          fb_SetPos           ( FB_FILE *handle, int line_length );

       int          fb_FileInputNextToken( char *buffer, ssize_t maxlen, int isstring, int *isfp );
       void         fb_FileInputNextTokenWstr( FB_WCHAR *buffer, ssize_t max_chars, int is_string );

FBCALL FBSTRING    *fb_Dir              ( FBSTRING *filespec, int attrib, int *out_attrib );
FBCALL FBSTRING    *fb_Dir64            ( FBSTRING *filespec, int attrib, long long *outattrib );
FBCALL FBSTRING    *fb_DirNext          ( int *outattrib );
FBCALL FBSTRING    *fb_DirNext64        ( long long *outattrib );

 /* Maximum length that can safely be parsed as INTEGER */
#define FB_INPUT_MAXINTLEN 9

 /* Maximum length that can safely be parsed as LONGINT */
#define FB_INPUT_MAXLONGLEN 18

 /* Maximum length of a DOUBLE printed in FB ("-1.345678901234567e+100") */
#define FB_INPUT_MAXDBLLEN (1 + 17 + 1 + 1 + 3)

 /* Maximum length that can represent a LONGINT ("&B" + 64 digits) */
#define FB_INPUT_MAXLONGBINLEN (2 + 64)

 /* Numeric input max buffer length (max numeric length + delimiter) */
#define FB_INPUT_MAXNUMERICLEN (FB_INPUT_MAXLONGBINLEN+1)

 /* String input max buffer length */
#define FB_INPUT_MAXSTRINGLEN 4096


/**************************************************************************************************
 * UTF Encoding
 **************************************************************************************************/

extern const UTF_8 __fb_utf8_bmarkTb[7];

       void         fb_hCharToUTF8      ( const char *src, ssize_t chars, char *dst, ssize_t *bytes );
       char        *fb_CharToUTF        ( FB_FILE_ENCOD encod, const char *src, ssize_t chars, char *dst, ssize_t *bytes );
       char        *fb_WCharToUTF       ( FB_FILE_ENCOD encod, const FB_WCHAR *src, ssize_t chars, char *dst, ssize_t *bytes );
       ssize_t      fb_hFileRead_UTFToChar( FILE *fp, FB_FILE_ENCOD encod, char *dst, ssize_t max_chars );
       ssize_t      fb_hFileRead_UTFToWchar( FILE *fp, FB_FILE_ENCOD encod, FB_WCHAR *dst, ssize_t max_chars );

/**************************************************************************************************
 * VB-compatible functions
 **************************************************************************************************/

#define FB_FILE_ATTR_MODE_INPUT         1
#define FB_FILE_ATTR_MODE_OUTPUT        2
#define FB_FILE_ATTR_MODE_RANDOM        4
#define FB_FILE_ATTR_MODE_APPEND        8
#define FB_FILE_ATTR_MODE_BINARY        32

#define FB_FILE_ATTR_MODE     1
#define FB_FILE_ATTR_HANDLE   2
#define FB_FILE_ATTR_ENCODING 3

FBCALL int          fb_FileCopy         ( const char *source, const char *destination );
FBCALL int          fb_CrtFileCopy      ( const char *source, const char *destination );
