       /* CONS */
       int          fb_DevConsOpen          ( FB_FILE *handle, const char *filename, size_t filename_len );

       /* ERR */
       int          fb_DevErrOpen           ( FB_FILE *handle, const char *filename, size_t filename_len );

       /* FILE */
       void         fb_hSetFileBufSize      ( FILE *fp );
       int          fb_DevFileOpen          ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevFileClose         ( FB_FILE *handle );
       int          fb_DevFileEof           ( FB_FILE *handle );

       int          fb_DevFileLock          ( FB_FILE *handle, fb_off_t position, fb_off_t size );
       int          fb_DevFileRead          ( FB_FILE *handle, void *value, size_t *pLength );
       int          fb_DevFileReadWstr      ( FB_FILE *handle, FB_WCHAR *dst, size_t *pchars );
       int          fb_DevFileReadLine      ( FB_FILE *handle, FBSTRING *dst );
       int          fb_DevFileReadLineWstr  ( FB_FILE *handle, FB_WCHAR *dst, ssize_t dst_chars );
       int          fb_DevFileSeek          ( FB_FILE *handle, fb_off_t offset, int whence );
       int          fb_hDevFileSeekStart    ( FILE *fp, int mode, FB_FILE_ENCOD encod, int seek_zero );
       fb_off_t     fb_DevFileGetSize       ( FILE *fp, int mode, FB_FILE_ENCOD encod, int seek_back );
       int          fb_DevFileTell          ( FB_FILE *handle, fb_off_t *pOffset );
       int          fb_DevFileUnlock        ( FB_FILE *handle, fb_off_t position, fb_off_t size );
       int          fb_DevFileWrite         ( FB_FILE *handle, const void *value, size_t valuelen );
       int          fb_DevFileWriteWstr     ( FB_FILE *handle, const FB_WCHAR *value, size_t valuelen );
       int          fb_DevFileFlush         ( FB_FILE *handle );

       typedef char* (*fb_FnDevReadString)  ( char *buffer, size_t count, FILE *fp );
       int          fb_DevFileReadLineDumb  ( FILE *fp, FBSTRING *dst, fb_FnDevReadString pfnReadString );

       /* ENCOD */
       int          fb_DevFileOpenEncod     ( FB_FILE *handle, const char *filename, size_t fname_len );
       int          fb_DevFileOpenUTF       ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevFileReadEncod     ( FB_FILE *handle, void *dst, size_t *max_chars );
       int          fb_DevFileReadEncodWstr ( FB_FILE *handle, FB_WCHAR *dst, size_t *max_chars );
       int          fb_DevFileReadLineEncod ( FB_FILE *handle, FBSTRING *dst );
       int          fb_DevFileReadLineEncodWstr( FB_FILE *handle, FB_WCHAR *dst, ssize_t max_chars );
       int          fb_DevFileWriteEncod    ( FB_FILE *handle, const void* buffer, size_t chars );
       int          fb_DevFileWriteEncodWstr( FB_FILE *handle, const FB_WCHAR* buffer, size_t len );

       /* PIPE */
       int          fb_DevPipeOpen          ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevPipeClose         ( FB_FILE *handle );

       /* SCRN */
typedef struct {
	char            buffer[16];
	unsigned        length;
} DEV_SCRN_INFO;

       void         fb_DevScrnInit              ( void );
       void         fb_DevScrnInit_Screen       ( void );
       void         fb_DevScrnUpdateWidth       ( void );
       void         fb_DevScrnMaybeUpdateWidth  ( void );
       void         fb_DevScrnEnd               ( FB_FILE *handle );
       void         fb_DevScrnInit_NoOpen       ( void );
       void         fb_DevScrnInit_Write        ( void );
       void         fb_DevScrnInit_WriteWstr    ( void );
       void         fb_DevScrnInit_Read         ( void );
       void         fb_DevScrnInit_ReadWstr     ( void );
       void         fb_DevScrnInit_ReadLine     ( void );
       void         fb_DevScrnInit_ReadLineWstr ( void );

       int          fb_DevScrnOpen          ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevScrnClose         ( FB_FILE *handle );
       int          fb_DevScrnEof           ( FB_FILE *handle );
       int          fb_DevScrnRead          ( FB_FILE *handle, void* value, size_t *pLength );
       int          fb_DevScrnReadWstr      ( FB_FILE *handle, FB_WCHAR *dst, size_t *pchars );
       int          fb_DevScrnWrite         ( FB_FILE *handle, const void* value, size_t valuelen );
       int          fb_DevScrnWriteWstr     ( FB_FILE *handle, const FB_WCHAR* value, size_t valuelen );
       int          fb_DevScrnReadLine      ( FB_FILE *handle, FBSTRING *dst );
       int          fb_DevScrnReadLineWstr  ( FB_FILE *handle, FB_WCHAR *dst, ssize_t dst_chars );
       void         fb_DevScrnFillInput     ( DEV_SCRN_INFO *info );

       /* STDIO */
       int          fb_DevStdIoClose        ( FB_FILE *handle );

       /* LPT */
       int          fb_DevLptOpen           ( FB_FILE *handle, const char *filename, size_t filename_len );

       /* COM */
       int          fb_DevComOpen           ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevComTestProtocol   ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevComTestProtocolEx ( FB_FILE *handle, const char *filename, size_t filename_len, size_t *pPort );
