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

FnDevOpenHook fb_pfnDevOpenHook = NULL;

#ifdef MULTITHREADED
int __fb_is_exiting = FALSE;
#endif

/*:::::*/
static void fb_hFileExit( void )
{

#ifdef MULTITHREADED
	__fb_is_exiting = TRUE;
#endif

	fb_hFileCtx( 0 );

}

extern int __fb_file_handles_cleared;

/*::::: make it accessible for all VFS functions too */
void fb_hFileCtx ( int doinit )
{
	static int inited = 0;

    FB_LOCK();
	//
	if( doinit )
	{
		if( inited )
			return;

        if( !__fb_file_handles_cleared ) {
            memset( fb_fileTB, 0, sizeof( FB_FILE ) * FB_MAX_FILES );
            __fb_file_handles_cleared = TRUE;
        }
		atexit( &fb_hFileExit );

		inited = 1;
	}
	//
	else
	{
		if( !inited )
			return;

		fb_FileReset( );

		inited = 0;
	}
    FB_UNLOCK();
}

/*:::::*/
int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str_filename, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
    int res = 0;
    FBSTRING str_tmp = { 0 };
    FnFileOpen pfnFileOpen = NULL;

    /* Create a modifiable string.
     *
     * We have to copy it here because the hook might modify this string
     * but this is an error when the string passed to OPEN is a temporary
     * string created from static data (temp. decriptor, static data).
     *
     * This could be avoided if we'd have a string handle with a separate
     * FLAGS member where we'd be able to store some kind of STATIC_DATA
     * flag so that a call to fb_StrAssign wouldn't try to free this static
     * data which is always a bad idea.
     */
    FB_STRLOCK();
    if( fb_hStrRealloc( &str_tmp, FB_STRSIZE( str_filename ), FALSE )==NULL ) {
        FB_STRUNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
    }
    fb_hStrCopy( str_tmp.data,
                 str_filename->data,
                 FB_STRSIZE( str_filename ) );
    fb_hStrDelTemp( str_filename );
    FB_STRUNLOCK();

    if( fb_pfnDevOpenHook!=NULL ) {
        /* Call the OPEN hook */
        res = fb_pfnDevOpenHook( &str_tmp,
                                 mode,
                                 access,
                                 lock,
                                 len,
                                 &pfnFileOpen );
    }

    if( res==0 ) {
        if( pfnFileOpen==NULL ) {
            /* Defaults to "normal" FILE OPEN function */
            pfnFileOpen = fb_DevFileOpen;
        }

        res = fb_FileOpenVfsEx( handle, &str_tmp,
                                mode, access,
                                lock, len, pfnFileOpen );
    } else {
        /* Set error to the error number previously returned by the open
         * hook */
        fb_ErrorSetNum( res );
    }

    /* Release temporary string */
    FB_STRLOCK();
    if( str_tmp.data )
        free( str_tmp.data );
    FB_STRUNLOCK();

    return res;
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

