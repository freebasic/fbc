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

void fb_VfsInit(void);

int fb_FileOpenVfsRawEx( FB_FILE *handle,
                         const char *filename, size_t filename_length,
                         unsigned int mode, unsigned int access,
                         unsigned int lock, int len )
{
    FB_VFS_PROTOCOL *protocol;
    int result;

    /* Initialize VFS on demand */
    fb_VfsInit();

    FB_LOCK();

    if (handle->f!=NULL || handle->hooks!=NULL) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* clear handle */
    memset(handle, 0, sizeof(FB_FILE));

    /* f isn't used in VFS mode (see "opaque") */
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

    for (protocol = fb_protocols;
         protocol!=NULL;
         protocol = protocol->next)
    {
        if (protocol->pfnTestProtocol(handle, filename, filename_length)) {
            break;
        }
    }

    if (protocol==NULL) {
        /* unknown protocol! */
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    result = protocol->pfnOpen(handle, filename, filename_length);
    assert(handle->hooks!=NULL);

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
    }

    FB_UNLOCK();

    return result;
}

int fb_FileOpenVfsEx( FB_FILE *handle,
                      FBSTRING *str_filename, unsigned int mode, unsigned int access,
                      unsigned int lock, int len )
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
                               mode, access, lock, len);
}

/*:::::*/
FBCALL int fb_FileOpenVfs( FBSTRING *str_filename, unsigned int mode, unsigned int access,
						   unsigned int lock, int fnum, int len )
{
    FB_FILE *handle = FB_FILE_TO_HANDLE(fnum);

	/* check if valid */
    if( !FB_FILE_INDEX_VALID(fnum) )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return fb_FileOpenVfsEx( handle, str_filename, mode, access, lock, len );
}

/*:::::*/
FBCALL int fb_FileOpenVfsShort( FBSTRING *str_file_mode,
                                int fnum,
                                FBSTRING *filename,
                                int len,
                                FBSTRING *str_access_mode,
                                FBSTRING *str_lock_mode)
{
    unsigned file_mode = 0;
    int access_mode = -1, lock_mode = -1;
    size_t file_mode_len, access_mode_len, lock_mode_len;

	FB_STRLOCK();

    file_mode_len = FB_STRSIZE( str_file_mode );
    access_mode_len = FB_STRSIZE( str_access_mode );
    lock_mode_len = FB_STRSIZE( str_lock_mode );

    if( file_mode_len != 1 || access_mode_len>2 || lock_mode_len>2 ) {
        FB_STRUNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( strcasecmp(str_file_mode->data, "B")==0 ) {
        file_mode = FB_FILE_MODE_BINARY;
    } else if( strcasecmp(str_file_mode->data, "I")==0 ) {
        file_mode = FB_FILE_MODE_INPUT;
    } else if( strcasecmp(str_file_mode->data, "O")==0 ) {
        file_mode = FB_FILE_MODE_OUTPUT;
    } else if( strcasecmp(str_file_mode->data, "A")==0 ) {
        file_mode = FB_FILE_MODE_APPEND;
    } else if( strcasecmp(str_file_mode->data, "R")==0 ) {
        file_mode = FB_FILE_MODE_RANDOM;
    } else {
        FB_STRUNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( access_mode_len!=0 ) {
        if ( strcasecmp(str_access_mode->data, "R")==0 ) {
            access_mode = FB_FILE_ACCESS_READ;
        } else if ( strcasecmp(str_access_mode->data, "W")==0 ) {
            access_mode = FB_FILE_ACCESS_WRITE;
        } else if ( strcasecmp(str_access_mode->data, "RW")==0 ) {
            access_mode = FB_FILE_ACCESS_READWRITE;
        } else {
            FB_STRUNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( lock_mode_len!=0 ) {
        if ( strcasecmp(str_lock_mode->data, "S")==0 ) {
            lock_mode = FB_FILE_LOCK_SHARED;
        } else if ( strcasecmp(str_lock_mode->data, "R")==0 ) {
            lock_mode = FB_FILE_LOCK_READ;
        } else if ( strcasecmp(str_lock_mode->data, "W")==0 ) {
            lock_mode = FB_FILE_LOCK_WRITE;
        } else if ( strcasecmp(str_lock_mode->data, "RW")==0 ) {
            lock_mode = FB_FILE_LOCK_READWRITE;
        } else {
            FB_STRUNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    FB_STRUNLOCK();

    if( access_mode == -1 ) {
        /* determine the default access mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            access_mode = FB_FILE_ACCESS_READ;
            break;
        case FB_FILE_MODE_OUTPUT:
        case FB_FILE_MODE_APPEND:
            access_mode = FB_FILE_ACCESS_WRITE;
            break;
        default:
            access_mode = FB_FILE_ACCESS_ANY;
            break;
        }
    }

    if( lock_mode == -1 ) {
        /* determine the default lock mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            lock_mode = FB_FILE_LOCK_SHARED;
            break;
        default:
            lock_mode = FB_FILE_LOCK_WRITE;
            break;
        }
    }

    return fb_FileOpenVfs( filename,
                           file_mode,
                           access_mode,
                           lock_mode,
                           fnum,
                           len );
}
