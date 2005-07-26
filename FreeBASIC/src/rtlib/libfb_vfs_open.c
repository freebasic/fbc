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
 *	vfs_open - open file (vfs) functions
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hFileCtx ( int doinit );

/*::::::*/
int fb_FileOpenVfsRawEx( FB_FILE *handle,
                         const char *filename, size_t filename_length,
                         unsigned int mode, unsigned int access,
                         unsigned int lock, int len,
                         FnFileOpen pfnOpen )
{
    int result;

    fb_hFileCtx ( TRUE );

    FB_LOCK();

    if (handle->hooks!=NULL) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* clear handle */
    memset(handle, 0, sizeof(FB_FILE));

    /* specific file/device handles are stored in the member "opaque" */
    handle->mode = mode;
    handle->size = 0;
    handle->type = FB_FILE_TYPE_VFS;
    handle->access = access;
    /* lock mode not supported yet */
    handle->line_length = 0;


    /* reclen */
    switch( handle->mode )
    {
    case FB_FILE_MODE_RANDOM:
    case FB_FILE_MODE_INPUT:
    case FB_FILE_MODE_OUTPUT:
        if( len <= 0 )
            len = 128;
        handle->len = len;
        break;

    default:
        handle->len = 0;
        break;
    }

    if (pfnOpen==NULL) {
        /* unknown protocol! */
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    result = pfnOpen(handle, filename, filename_length);
    assert(result!=FB_RTERROR_OK || handle->hooks!=NULL);

    /* query the file size - only if supported */
    if (result==0 && handle->hooks->pfnSeek!=NULL && handle->hooks->pfnTell!=NULL) {
        switch( mode )
        {
        case FB_FILE_MODE_BINARY:
        case FB_FILE_MODE_RANDOM:
        case FB_FILE_MODE_INPUT:
            result = handle->hooks->pfnSeek(handle, 0, SEEK_END);
            if (result==0) {
                result = handle->hooks->pfnTell(handle, &handle->size);
                handle->hooks->pfnSeek(handle, 0, SEEK_SET);
            }
            break;
        case FB_FILE_MODE_APPEND:
            result = handle->hooks->pfnTell(handle, &handle->size);
            break;
        }
    } else {
        memset(handle, 0, sizeof(FB_FILE));
    }

    FB_UNLOCK();

    return result;
}

/*::::::*/
int fb_FileOpenVfsEx( FB_FILE *handle,
                      FBSTRING *str_filename, unsigned int mode, unsigned int access,
                      unsigned int lock, int len,
                      FnFileOpen pfnOpen )
{
    char *filename;
    size_t filename_length;

	FB_STRLOCK();

	/* copy file name */
    filename_length = FB_STRSIZE( str_filename );
    filename = (char*) alloca( filename_length + 1 );
    fb_hStrCopy( filename, str_filename->data, filename_length );
    filename[filename_length] = 0;

	/* del if temp */
	fb_hStrDelTemp( str_filename );

    FB_STRUNLOCK();

    return fb_FileOpenVfsRawEx(handle, filename, filename_length,
                               mode, access, lock, len, pfnOpen );
}
