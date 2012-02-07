FBCALL void         fb_Init             ( int argc, char **argv, int lang );
FBCALL void         fb_End              ( int errlevel );
FBCALL void 		fb_RtInit 			( void );
	   void 		fb_RtExit 			( void );
FBCALL void         fb_InitSignals      ( void );

FBCALL void         fb_MemSwap          ( unsigned char *dst, unsigned char *src, int bytes );
FBCALL void         fb_StrSwap          ( void *str1, int size1, int fillrem1,
                                          void *str2, int size2, int fillrem2 );

       void         fb_hInit            ( void );
       void         fb_hEnd             ( int errlevel );

FBCALL void         fb_Beep             ( void );

FBCALL FBSTRING    *fb_Command          ( int argc );
FBCALL FBSTRING    *fb_CurDir           ( void );
FBCALL FBSTRING    *fb_ExePath          ( void );
FBCALL int          fb_Shell            ( FBSTRING *program );
FBCALL int          fb_Run              ( FBSTRING *program, FBSTRING *args );
FBCALL int          fb_Chain            ( FBSTRING *program );
FBCALL int          fb_Exec             ( FBSTRING *program, FBSTRING *args );
FBCALL int 			fb_ExecEx 			( FBSTRING *program, FBSTRING *args, int do_wait );

       int          fb_hParseArgs       ( char * dst, const char *src, int length );

FBCALL void        *fb_DylibLoad        ( FBSTRING *library );
FBCALL void        *fb_DylibSymbol      ( void *library, FBSTRING *symbol );
FBCALL void 	   *fb_DylibSymbolByOrd ( void *library, short int symbol );
FBCALL void         fb_DylibFree        ( void *library );

       FB_DYLIB     fb_hDynLoad         (const char *libname, const char **funcname, void **funcptr);
       int          fb_hDynLoadAlso     (FB_DYLIB lib, const char **funcname, void **funcptr, int count);
       void         fb_hDynUnload       (FB_DYLIB *lib);

       char        *fb_hGetShortPath    ( char *src, char *dst, int maxlen );

       int          fb_hGetCurrentDir   ( char *dst, int maxlen );
       char        *fb_hGetExePath      ( char *dst, int maxlen );
       char        *fb_hGetExeName      ( char *dst, int maxlen );

       int          fb_hIn              ( unsigned short port );
       int          fb_hOut             ( unsigned short port, unsigned char value );
FBCALL int          fb_Wait             ( unsigned short port, int and, int xor);
