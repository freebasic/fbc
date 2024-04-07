typedef FBSTRING   *(*FB_INKEYPROC)     ( void );
typedef int         (*FB_GETKEYPROC)    ( void );
typedef int         (*FB_KEYHITPROC)    ( void );

FBCALL FBSTRING    *fb_Inkey            ( void );
FBCALL FBSTRING    *fb_InkeyQB          ( void );
FBCALL int          fb_Getkey           ( void );
FBCALL int          fb_KeyHit           ( void );

typedef void        (*FB_CLSPROC)       ( int mode );

FBCALL void         fb_Cls              ( int mode );

typedef unsigned int (*FB_COLORPROC)    ( unsigned int fc, unsigned int bc, int flags );

FBCALL unsigned int fb_Color            ( unsigned int fc, unsigned int bc, int flags );

typedef int         (*FB_LOCATEPROC)    ( int row, int col, int cursor );

FBCALL int          fb_LocateEx         ( int row, int col, int cursor, int *current_pos );
FBCALL int          fb_Locate           ( int row, int col, int cursor, int start, int stop );
FBCALL int          fb_LocateSub        ( int row, int col, int cursor );

typedef void        (*FB_VIEWUPDATEPROC)( void );

FBCALL void         fb_ViewUpdate       ( void );

typedef int         (*FB_WIDTHPROC)     ( int cols, int rows );

FBCALL int          fb_Width            ( int cols, int rows );
FBCALL int          fb_WidthDev         ( FBSTRING *dev, int width );
FBCALL int          fb_WidthFile        ( int fnum, int width );

typedef int         (*FB_GETXPROC)      ( void );
typedef int         (*FB_GETYPROC)      ( void );
typedef void        (*FB_GETXYPROC)     ( int *col, int *row );
typedef void        (*FB_GETSIZEPROC)   ( int *cols, int *rows );

FBCALL int          fb_Pos              ( int dummy );
FBCALL int          fb_GetX             ( void );
FBCALL int          fb_GetY             ( void );
FBCALL void         fb_GetXY            ( int *col, int *row );
FBCALL void         fb_GetSize          ( int *cols, int *rows );

typedef unsigned int (*FB_READXYPROC)   ( int col, int row, int colorflag );
FBCALL unsigned int fb_ReadXY           ( int col, int row, int colorflag );

typedef void        (*FB_PRINTBUFFPROC) ( const void *buffer, size_t len, int mask );
typedef void        (*FB_PRINTBUFFWPROC)( const FB_WCHAR *buffer, size_t len, int mask );

typedef char        *(*FB_READSTRPROC)  ( char *buffer, ssize_t len );
        char        *fb_ReadString      ( char *buffer, ssize_t len, FILE *f );

typedef int         (*FB_LINEINPUTPROC) ( FBSTRING *text, void *dst, ssize_t dst_len,
										  int fillrem, int addquestion, int addnewline );
typedef int         (*FB_LINEINPUTWPROC)( const FB_WCHAR *text, FB_WCHAR *dst,
                                          ssize_t max_chars, int addquestion, int addnewline );
FBCALL int          fb_LineInput        ( FBSTRING *text, void *dst, ssize_t dst_len,
										  int fillrem, int addquestion, int addnewline );
FBCALL int          fb_LineInputWstr    ( const FB_WCHAR *text, FB_WCHAR *dst,
                                          ssize_t max_chars, int addquestion, int addnewline );

FBCALL int          fb_Multikey         ( int scancode );
FBCALL int          fb_GetMouse         ( int *x, int *y, int *z, int *buttons_, int *clip );
FBCALL int          fb_GetMouse64       ( long long *x, long long *y, long long *z, long long *buttons_, long long *clip );
FBCALL int          fb_SetMouse         ( int x, int y, int cursor, int clip );
typedef int         (*FB_MULTIKEYPROC)  ( int scancode );
typedef int         (*FB_GETMOUSEPROC)  ( int *x, int *y, int *z, int *buttons_, int *clip );
typedef int         (*FB_SETMOUSEPROC)  ( int x, int y, int cursor, int clip );

FBCALL int          fb_In               ( unsigned short port );
FBCALL int          fb_Out              ( unsigned short port, unsigned char value );
typedef int         (*FB_INPROC)        ( unsigned short port );
typedef int         (*FB_OUTPROC)       ( unsigned short port, unsigned char value );

FBCALL void         fb_Sleep            ( int msecs );
FBCALL void         fb_SleepQB          ( int secs );
FBCALL void         fb_Delay            ( int msecs );
FBCALL int          fb_SleepEx          ( int msecs, int kind );
typedef void        (*FB_SLEEPPROC)     ( int msecs );

FBCALL int 			fb_IsRedirected		( int is_input );
typedef int         (*FB_ISREDIRPROC)  	( int is_input );

FBCALL int			fb_PageCopy			( int src, int dst );
typedef int         (*FB_PAGECOPYPROC)  ( int src, int dst );

FBCALL int			fb_PageSet			( int active, int visible );
typedef int         (*FB_PAGESETPROC)   ( int active, int visible );

typedef void        (*FB_POSTEVENTPROC) (EVENT *e);

typedef struct FB_HOOKSTB {
    FB_INKEYPROC    		inkeyproc;
    FB_GETKEYPROC   		getkeyproc;
    FB_KEYHITPROC   		keyhitproc;
    FB_CLSPROC      		clsproc;
    FB_COLORPROC    		colorproc;
    FB_LOCATEPROC   		locateproc;
    FB_WIDTHPROC    		widthproc;
    FB_GETXPROC     		getxproc;
    FB_GETYPROC     		getyproc;
    FB_GETXYPROC    		getxyproc;
    FB_GETSIZEPROC  		getsizeproc;
    FB_PRINTBUFFPROC 		printbuffproc;
    FB_PRINTBUFFWPROC 		printbuffwproc;
    FB_READSTRPROC  		readstrproc;
    FB_MULTIKEYPROC 		multikeyproc;
    FB_GETMOUSEPROC 		getmouseproc;
    FB_SETMOUSEPROC 		setmouseproc;
    FB_INPROC       		inproc;
    FB_OUTPROC      		outproc;
    FB_VIEWUPDATEPROC 		viewupdateproc;
    FB_LINEINPUTPROC 		lineinputproc;
    FB_LINEINPUTWPROC 		lineinputwproc;
    FB_READXYPROC   		readxyproc;
    FB_SLEEPPROC    		sleepproc;
    FB_ISREDIRPROC			isredirproc;
    FB_PAGECOPYPROC			pagecopyproc;
    FB_PAGESETPROC			pagesetproc;
    FB_POSTEVENTPROC		posteventproc;
} FB_HOOKSTB;
