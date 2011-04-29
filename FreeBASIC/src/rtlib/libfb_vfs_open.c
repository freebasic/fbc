/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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
#include "fb.h"

/*::::::*/
static fb_off_t hFileGetSize
	(
		FB_FILE *handle
	)
{
	fb_off_t size = 0;

	if( handle->hooks->pfnSeek == NULL || handle->hooks->pfnTell == NULL )
		return size;

	switch( handle->mode )
	{
	case FB_FILE_MODE_BINARY:
	case FB_FILE_MODE_RANDOM:
	case FB_FILE_MODE_INPUT:
		if( handle->hooks->pfnSeek( handle, 0, SEEK_END ) != 0 )
			return -1;

		handle->hooks->pfnTell( handle, &size );

		handle->hooks->pfnSeek( handle, 0, SEEK_SET );
		break;

	case FB_FILE_MODE_APPEND:
		handle->hooks->pfnTell( handle, &size );
		break;
	}

	return size;
}

/*::::::*/
int fb_FileOpenVfsRawEx
	(
		FB_FILE *handle,
        const char *filename,
        size_t filename_length,
        unsigned int mode,
        unsigned int access,
        unsigned int lock,
        int len,
        FB_FILE_ENCOD encoding,
        FnFileOpen pfnOpen
	)
{
    int result;

    FB_LOCK();

    if (handle->hooks!=NULL) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	__fb_ctx.do_file_reset = TRUE;

    /* clear handle */
    memset(handle, 0, sizeof(FB_FILE));

    /* specific file/device handles are stored in the member "opaque" */
    handle->mode 	 = mode;
    handle->encod 	 = encoding;
    handle->size 	 = 0;
    handle->type 	 = FB_FILE_TYPE_VFS;
    handle->access 	 = access;
    handle->lock 	 = lock;      /* lock mode not supported yet */
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

    if (pfnOpen==NULL)
    {
        /* unknown protocol! */
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* assume size won't be calculated by dev::open */
    handle->size = -1;

    result = pfnOpen(handle, filename, filename_length);

    DBG_ASSERT(result!=FB_RTERROR_OK || handle->hooks!=NULL);

    if( result == 0 )
    {
    	/* if size wasn't calculated yet, do it now */
    	if( handle->size == -1 )
    		handle->size = hFileGetSize( handle );
    }
    else
    {
        memset(handle, 0, sizeof(FB_FILE));
    }

    FB_UNLOCK();

    return result;
}

/*::::::*/
int fb_FileOpenVfsEx
	(
		FB_FILE *handle,
        FBSTRING *str_filename,
        unsigned int mode,
        unsigned int access,
        unsigned int lock,
        int len,
        FB_FILE_ENCOD encoding,
        FnFileOpen pfnOpen
	)
{
    char *filename;
    size_t filename_length;

	/* copy file name */
    filename_length = FB_STRSIZE( str_filename );
    filename = (char*) alloca( filename_length + 1 );
    fb_hStrCopy( filename, str_filename->data, filename_length );
    filename[filename_length] = 0;

	/* del if temp */
	fb_hStrDelTemp( str_filename );

    return fb_FileOpenVfsRawEx( handle, filename, filename_length,
                                mode, access, lock, len, encoding, pfnOpen );
}
