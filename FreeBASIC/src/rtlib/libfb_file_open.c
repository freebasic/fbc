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
    FnFileOpen pfnFileOpen = NULL;
    if( fb_pfnDevOpenHook!=NULL ) {
        int res;
        FBSTRING str_tmp;

        /* Create temporary string WITHOUT(!) FB_TEMPSTRBIT set */
        FB_STRLOCK();

        if( fb_hStrRealloc( &str_tmp, FB_STRSIZE( str_filename ), FALSE )==NULL ) {
            FB_STRUNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
        }

        fb_hStrCopy( str_tmp.data,
                     str_filename->data,
                     FB_STRSIZE( str_filename ) );

        FB_STRUNLOCK();

        /* Call the OPEN hook */
        res = fb_pfnDevOpenHook( &str_tmp,
                                 mode,
                                 access,
                                 lock,
                                 len,
                                 &pfnFileOpen );

        /* Release temporary string */
        FB_STRLOCK();

        fb_StrAssign( str_filename, -1, &str_tmp, -1, FALSE );
        if( str_tmp.data )
            free( str_tmp.data );

        FB_STRUNLOCK();

        /* Set error to returned error number */
        if( res!=0 )
            return fb_ErrorSetNum( res );

        if( pfnFileOpen==NULL ) {
            /* Defaults to "normal" FILE OPEN function */
            pfnFileOpen = fb_DevFileOpen;
        }
    } else {
        pfnFileOpen = fb_DevFileOpen;
    }
    return fb_FileOpenVfsEx( handle, str_filename,
                             mode, access,
                             lock, len, pfnFileOpen );
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

