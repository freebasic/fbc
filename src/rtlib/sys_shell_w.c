/* SHELL command (wide string) */

#include "fb.h"

FBCALL int fb_Shell_W( FB_WCHAR *program )
{
	int errcode = -1;

    if (fb_wstr_Len(program) != 0)
    {
#ifdef HOST_WIN32
	errcode = fb_hShell_W( program );
#else
    char *pathname;
    ssize_t bytes;
    size_t pathname_length;

    pathname_length = fb_wstr_Len( program );
    pathname = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                              program,
                              pathname_length,
                              NULL,
                              &bytes );

    if ( pathname != NULL )
    {
        errcode = fb_hShell( pathname );
        free( pathname );
    }
#endif
	}

	return errcode;
}
