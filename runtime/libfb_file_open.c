/*
 * file_open - open and core file functions
 *
 * chng: oct/2004 written [v1ctor]
 *       jul/2005 modified to use the VFS OPEN method
 *       aug/2005 added OPEN hook
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str_filename, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
    int res = 0;
    FBSTRING *filename, str_tmp = { 0 };
    FnFileOpen pfnFileOpen = NULL;

    if( __fb_ctx.pfnDevOpenHook != NULL )
    {
    	/*
     	 * We have to copy it here because the hook might modify this string
     	 * and FB assumes no var-len string arg will be changed by the rtlib
     	 */
    	filename = &str_tmp;
    	fb_StrAssign( (void *)filename, -1, (void *)str_filename, -1, FALSE );

        /* Call the OPEN hook */
        res = __fb_ctx.pfnDevOpenHook( filename,
                                 mode,
                                 access,
                                 lock,
                                 len,
                                 &pfnFileOpen );

    }
    else
    	filename = str_filename;

    if( res == 0 )
    {
        if( pfnFileOpen == NULL )
        {
            /* Defaults to "normal" FILE OPEN function */
            pfnFileOpen = fb_DevFileOpen;
        }

        res = fb_FileOpenVfsEx( handle,
        						filename,
                                mode,
                                access,
                                lock,
                                len,
                                FB_FILE_ENCOD_DEFAULT,
                                pfnFileOpen );
    }
    else
    {
        /* Set error to the error number previously returned by the open
         * hook */
        fb_ErrorSetNum( res );
    }

    if( __fb_ctx.pfnDevOpenHook != NULL )
    {
    	/* Release temporary string */
    	fb_StrDelete( &str_tmp );
    }

    return res;
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

