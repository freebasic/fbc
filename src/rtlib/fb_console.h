    typedef struct _fb_Rect {
        int Left, Top, Right, Bottom;
    } fb_Rect;

    typedef struct _fb_Coord {
        int X, Y;
    } fb_Coord;

    struct _fb_ConHooks;

    typedef void (*fb_fnHookConScroll)( struct _fb_ConHooks *handle, int x1, int y1, int x2, int y2, int rows );
    typedef int  (*fb_fnHookConWrite )( struct _fb_ConHooks *handle, const void *buffer, size_t length );

    typedef struct _fb_ConHooks {
        void                     *Opaque;

        fb_fnHookConScroll        Scroll;
        fb_fnHookConWrite         Write;

        fb_Rect                   Border;
        fb_Coord                  Coord;
    } fb_ConHooks;

    static __inline__
        int fb_hConCheckScroll( fb_ConHooks *handle )
    {
        fb_Rect *pBorder = &handle->Border;
        fb_Coord *pCoord = &handle->Coord;
        if( pBorder->Bottom!=-1 ) {
            if( pCoord->Y > pBorder->Bottom ) {
                int nRows = pCoord->Y - pBorder->Bottom;
                handle->Scroll( handle,
                                pBorder->Left,
                                pBorder->Top,
                                pBorder->Right,
                                pBorder->Bottom,
                                nRows );
                return TRUE;
            }
        }
        return FALSE;
    }

       void         fb_ConPrintRaw      ( fb_ConHooks *handle, const char *pachText, size_t TextLength );
       void         fb_ConPrintRawWstr  ( fb_ConHooks *handle, const FB_WCHAR *pachText, size_t TextLength );
       void         fb_ConPrintTTY      ( fb_ConHooks *handle, const char *pachText, size_t TextLength, int is_text_mode );
       void         fb_ConPrintTTYWstr  ( fb_ConHooks *handle, const FB_WCHAR *pachText, size_t TextLength, int is_text_mode );

       int          fb_ConsoleWidth     ( int cols, int rows );
       void         fb_ConsoleClear     ( int mode );

       int          fb_ConsoleLocate    ( int row, int col, int cursor );
       int          fb_ConsoleGetY      ( void );
       int          fb_ConsoleGetX      ( void );
FBCALL void         fb_ConsoleGetSize   ( int *cols, int *rows );
FBCALL void         fb_ConsoleGetXY     ( int *col, int *row );

FBCALL unsigned int fb_ConsoleReadXY    ( int col, int row, int colorflag );
       unsigned int fb_ConsoleColor     ( unsigned int fc, unsigned int bc, int flags );
       unsigned int fb_ConsoleGetColorAtt( void );

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
       void         fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask );

       char        *fb_ConsoleReadStr   ( char *buffer, ssize_t len );

       int          fb_ConsoleGetTopRow ( void );
       int          fb_ConsoleGetBotRow ( void );
       void         fb_ConsoleSetTopBotRows( int top, int bot );

       void         fb_ConsoleSleep     ( int msecs );

       int          fb_ConsoleIsRedirected( int is_input );

       int          fb_ConsolePageCopy  ( int src, int dst );
       int          fb_ConsolePageSet   ( int active, int visible );

FBCALL FBSTRING    *fb_ConReadLine      ( int soft_cursor );

FBCALL int          fb_ConsoleInput     ( FBSTRING *text, int addquestion, int addnewline );
       int          fb_ConsoleLineInput ( FBSTRING *text, void *dst, ssize_t dst_len, int fillrem, int addquestion, int addnewline );
       int          fb_ConsoleLineInputWstr( const FB_WCHAR *text, FB_WCHAR *dst, ssize_t max_chars, int addquestion, int addnewline );

       int          fb_hConsoleInputBufferChanged( void );
