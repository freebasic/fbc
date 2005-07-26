/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hFileCtx ( int doinit );

#ifdef MULTITHREADED
int __fb_is_exiting = FALSE;
#endif

/* don't use the coldnames symbols */
#ifdef WIN32
#undef popen
#define popen(c,m) _popen(c,m)
#undef pclose
#define pclose(f) _pclose(f)
#endif

/*:::::*/
static void fb_hFileExit( void )
{

#ifdef MULTITHREADED
	__fb_is_exiting = TRUE;
#endif

	fb_hFileCtx( 0 );

}

/*::::: make it accessible for all VFS functions too */
void fb_hFileCtx ( int doinit )
{
	static int inited = 0;

	//
	if( doinit )
	{
		if( inited )
			return;

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
}

/*:::::*/
int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
    return fb_FileOpenVfsEx( handle,
                             str, mode, access,
                             lock, len, fb_DevFileOpen );
}

/*:::::*/
FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
						unsigned int lock, int fnum, int len )
{
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

