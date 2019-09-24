/* rename function for wide strings */

#include "fb.h"
#include <errno.h>

/*:::::*/
FBCALL int fb_Rename_W( FB_WCHAR *old_name, FB_WCHAR *new_name )
{
	int res = 0, err = 0;

	if(( old_name != NULL ) && ( new_name != NULL))
	{

  /* linux/windows split here */
#if defined HOST_WIN32                                //windows
		res = _wrename( old_name, new_name);
		err = errno;

#else                                                 //linux
        char *old_filename;
        char *new_filename;
        ssize_t bytes;
        size_t filename_length;

        filename_length = fb_wstr_Len( old_name );
        old_filename = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                                  old_name,
                                  filename_length,
                                  NULL,
                                  &bytes );

        filename_length = fb_wstr_Len( new_name );
        new_filename = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                                  new_name,
                                  filename_length,
                                  NULL,
                                  &bytes );

        if (( old_filename != NULL ) && ( new_filename != NULL))
        {
            res = rename( old_filename, new_filename );
            err = errno;
          free( old_filename );
          free( new_filename );
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
