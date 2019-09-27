       unsigned int fb_CpuDetect        ( void );
FBCALL void         fb_Init             ( int argc, char **argv, int lang );
FBCALL void         fb_End              ( int errlevel );
FBCALL void 		fb_RtInit 			( void );
	   void 		fb_RtExit 			( void );
FBCALL void         fb_InitSignals      ( void );

FBCALL void         fb_MemSwap          ( unsigned char *dst, unsigned char *src, ssize_t bytes );
FBCALL void         fb_StrSwap          ( void *str1, ssize_t size1, int fillrem1,
                                          void *str2, ssize_t size2, int fillrem2 );
FBCALL void         fb_WstrSwap         ( FB_WCHAR *str1, ssize_t size1, FB_WCHAR *str2, ssize_t size2 );
FBCALL void         fb_MemCopyClear     ( unsigned char *dst, ssize_t dstlen,
                                          unsigned char *src, ssize_t srclen );

       void         fb_hInit            ( void );
       void         fb_hEnd             ( int errlevel );

FBCALL void         fb_Beep             ( void );

FBCALL FBSTRING    *fb_Command          ( int argc );
FBCALL FB_WCHAR    *fb_Command_W        ( int argc );
FBCALL FBSTRING    *fb_GetEnviron       ( FBSTRING *varname );
FBCALL FB_WCHAR    *fb_GetEnviron_W     ( FB_WCHAR *varname );
FBCALL int          fb_SetEnviron       ( FBSTRING *str );
FBCALL int          fb_SetEnviron_W     ( FB_WCHAR *str );
FBCALL FBSTRING    *fb_CurDir           ( void );
FBCALL FB_WCHAR    *fb_CurDir_W         ( void );     
FBCALL FBSTRING    *fb_ExePath          ( void );
FBCALL FB_WCHAR    *fb_ExePath_W        ( void );     
FBCALL int          fb_Shell            ( FBSTRING *program );
FBCALL int          fb_Shell_W          ( FB_WCHAR *program );
       int          fb_hShell           ( char *program );
       int          fb_hShell_W         ( FB_WCHAR *program );
FBCALL int          fb_Run              ( FBSTRING *program, FBSTRING *args );
FBCALL int          fb_Run_W            ( FB_WCHAR *program, FB_WCHAR *args );
FBCALL int          fb_Chain            ( FBSTRING *program );
FBCALL int          fb_Chain_W          ( FB_WCHAR *program );
FBCALL int          fb_Exec             ( FBSTRING *program, FBSTRING *args );
FBCALL int          fb_Exec_W           ( FB_WCHAR *program, FB_WCHAR *args );
FBCALL int          fb_ExecEx           ( FBSTRING *program, FBSTRING *args, int do_wait );
FBCALL int          fb_ExecEx_W         ( FB_WCHAR *program, FB_WCHAR *args, int do_wait );
       int          fb_hParseArgs       ( char *dst, const char *src, ssize_t length );

FBCALL size_t       fb_GetMemAvail      ( int mode );

FBCALL void        *fb_DylibLoad        ( FBSTRING *library );
FBCALL void        *fb_DylibLoad_W      ( FB_WCHAR *library );
FBCALL void        *fb_DylibSymbol      ( void *library, FBSTRING *symbol );
FBCALL void 	   *fb_DylibSymbolByOrd ( void *library, short int symbol );
FBCALL void         fb_DylibFree        ( void *library );

       char        *fb_hGetShortPath    ( char *src, char *dst, ssize_t maxlen );
       FB_WCHAR    *fb_hGetShortPath_W  ( FB_WCHAR *src, FB_WCHAR *dst, ssize_t maxlen );

       ssize_t      fb_hGetCurrentDir   ( char *dst, ssize_t maxlen );
       ssize_t      fb_hGetCurrentDir_W ( FB_WCHAR *dst, ssize_t maxlen );
       char        *fb_hGetExePath      ( char *dst, ssize_t maxlen );
       char        *fb_hGetExePath_W    ( FB_WCHAR *dst, ssize_t maxlen );
       char        *fb_hGetExeName      ( char *dst, ssize_t maxlen );

       int          fb_hIn              ( unsigned short port );
       int          fb_hOut             ( unsigned short port, unsigned char value );
FBCALL int          fb_Wait             ( unsigned short port, int val_and, int val_xor);

       void         fb_hRtInit          ( void );
       void         fb_hRtExit          ( void );
