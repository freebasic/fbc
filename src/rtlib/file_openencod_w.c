/* UTF-encoded file open function */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenEncod_W
	(
		FB_WCHAR *str,
		unsigned int mode,
		unsigned int access,
		unsigned int lock,
		int fnum,
		int len,
		const char *encoding
	)
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_FILE_ENCOD encod = fb_hFileStrToEncoding( encoding );


  /* linux/windows split here */
#if defined HOST_WIN32                                //windows
    return fb_FileOpenVfsEx_W( FB_FILE_TO_HANDLE(fnum), str, mode,
                               access, lock, len, encod,
                              (encod == FB_FILE_ENCOD_ASCII?
                               fb_DevFileOpen_W :
                               fb_DevFileOpenEncod_W) );

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
                                    encod,
                                   (encod == FB_FILE_ENCOD_ASCII?
                                    fb_DevFileOpen :
                                    fb_DevFileOpenEncod) );
      free( filename );
    }
    else
    {
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }  
#endif
}
