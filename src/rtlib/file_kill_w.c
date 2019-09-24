/* kill function (wide string) */

#include "fb.h"
#include <errno.h>

/*:::::*/
FBCALL int fb_FileKill_W( FB_WCHAR *wstr )
{
	int res = 0, err = 0;

	if( wstr != NULL )
	{

  /* linux/windows split here */
#if defined HOST_WIN32                                //windows
		res = _wremove( wstr );
		err = errno;

#else
        char *filename;
        ssize_t bytes;
        size_t filename_length;

        filename_length = fb_wstr_Len( wstr );
        filename = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                                  wstr,
                                  filename_length,
                                  NULL,
                                  &bytes );

        if ( filename != NULL )
        {
            res = remove( filename );
            err = errno;
          free( filename );
        }
#endif
	}

	
	if ( res == 0 )
	{
		res = FB_RTERROR_OK;
	}
	else
	{
		switch (err)                                   
		{
		case ENOENT:
			res = FB_RTERROR_FILENOTFOUND;
			break;
		case EACCES:
			res = FB_RTERROR_FILEIO;
			break;
		case EPERM:
			res = FB_RTERROR_NOPRIVILEGES;
			break;
		default:
			res = FB_RTERROR_ILLEGALFUNCTIONCALL;
			break;
		}
	}

	return fb_ErrorSetNum( res );
}
