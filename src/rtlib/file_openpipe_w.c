/* open PIPE (wide string) */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenPipe_W ( FB_WCHAR *str, unsigned int mode,
                               unsigned int access, unsigned int lock,
                               int fnum, int len, const char *encoding )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

  /* linux/windows split here */
#if defined HOST_WIN32                                //windows
    return fb_FileOpenVfsEx_W( FB_FILE_TO_HANDLE(fnum),
                             str,
                             mode,
                             access,
                             lock,
                             len,
                             fb_hFileStrToEncoding( encoding ),
                             fb_DevPipeOpen_W );

#else                                                 //linux
    char *filename;
    ssize_t bytes;
    size_t filename_length;

    filename_length = fb_wstr_Len( str );
    filename = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                              str,
                              filename_length,
                              NULL,
                              &bytes );

    if ( filename != NULL )
    {
        return fb_FileOpenVfsRawEx( FB_FILE_TO_HANDLE(fnum), filename, bytes,
                                    mode, access, lock, len, 
                                    fb_hFileStrToEncoding( encoding ),
                                    fb_DevPipeOpen );
        free( filename );
    }
    else
    {
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }  
#endif
}
