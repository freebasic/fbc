/* open LPTx */

#include "fb.h"

static void close_printer_handle(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL )
        return;
    FB_HANDLE_PRINTER->hooks->pfnClose( FB_HANDLE_PRINTER );
}

#if defined( HOST_WIN32 )
static const char *pszPrinterDev = "LPT:EMU=TTY";
#elif defined( HOST_LINUX )
static const char *pszPrinterDev = "LPT:";
#else
static const char *pszPrinterDev = "LPT1:";
#endif

int fb_LPrintInit(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL) {
        int res = fb_FileOpenVfsRawEx( FB_HANDLE_PRINTER,
                                       pszPrinterDev,
                                       strlen(pszPrinterDev),
                                       FB_FILE_MODE_APPEND,
                                       FB_FILE_ACCESS_WRITE,
                                       FB_FILE_LOCK_READWRITE,
                                       0,
                                       FB_FILE_ENCOD_DEFAULT,
                                       fb_DevLptOpen );
        if( res==FB_RTERROR_OK ) {
            atexit(close_printer_handle);
        }
        return res;
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileOpenLpt ( FBSTRING *str_filename, unsigned int mode,
                            unsigned int access, unsigned int lock,
                            int fnum, int len, const char *encoding )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
                             str_filename,
                             mode,
                             access,
                             lock,
                             len,
                             fb_hFileStrToEncoding( encoding ),
                             fb_DevLptOpen );

}

