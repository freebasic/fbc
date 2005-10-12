/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * file_open - open and core file functions
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *       jul/2005 modified to use the VFS OPEN method
 *       aug/2005 added OPEN hook
 *
 */

#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hFileCtx ( int doinit );

/*:::::*/
static void atexit_cb( void )
{

#ifdef MULTITHREADED
	__fb_io_is_exiting = TRUE;
#endif

	fb_hFileCtx( 0 );

}

extern int __fb_file_handles_cleared;

/*::::: make it accessible for all VFS functions too */
void fb_hFileCtx ( int doinit )
{
	static int inited = 0;

    FB_IO_EXIT_LOCK();

	// initialize?
	if( doinit )
	{
		if( !inited )
		{

        	if( !__fb_file_handles_cleared ) {
            	memset( fb_fileTB, 0, sizeof( FB_FILE ) * FB_MAX_FILES );
            	__fb_file_handles_cleared = TRUE;
        	}

			atexit( &atexit_cb );

			inited = 1;
		}
	}

	// finalize..
	else
	{
		if( inited )
		{
			fb_FileReset( );

			inited = 0;
		}
	}

    FB_IO_EXIT_UNLOCK();
}

/*:::::*/
int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str_filename, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
    int res = 0;
    FBSTRING *filename, str_tmp = { 0 };
    FnFileOpen pfnFileOpen = NULL;

    if( fb_pfnDevOpenHook != NULL )
    {
    	/*
     	 * We have to copy it here because the hook might modify this string
     	 * and FB assumes no var-len string arg will be changed by the rtlib
     	 */
    	filename = &str_tmp;
    	fb_StrAssign( (void *)filename, -1, (void *)str_filename, -1, FALSE );

        /* Call the OPEN hook */
        res = fb_pfnDevOpenHook( filename,
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

        res = fb_FileOpenVfsEx( handle, filename,
                                mode, access,
                                lock, len, pfnFileOpen );
    }
    else
    {
        /* Set error to the error number previously returned by the open
         * hook */
        fb_ErrorSetNum( res );
    }

    if( fb_pfnDevOpenHook != NULL )
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
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

