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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

static FB_FILE_HOOKS fb_hooks_dev_file = {
    fb_DevFileEof,
    fb_DevFileClose,
    fb_DevFileSeek,
    fb_DevFileTell,
    fb_DevFileRead,
    fb_DevFileWrite,
    fb_DevFileWriteWstr,
    fb_DevFileLock,
    fb_DevFileUnlock,
    fb_DevFileReadLine,
    NULL,
    fb_DevFileFlush
};

int fb_DevFileOpen( struct _FB_FILE *handle, const char *filename, size_t fname_len )
{
    FILE *fp = NULL;
    char *openmask;
    char *fname;

    FB_LOCK();

    fname = (char*) alloca(fname_len + 1);
    memcpy(fname, filename, fname_len);
    fname[fname_len] = 0;

    /* Convert directory separators to whatever the current platform supports */
    fb_hConvertPath( fname, fname_len );

    handle->hooks = &fb_hooks_dev_file;

    openmask = NULL;
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        openmask = "at";				/* will create the file if it doesn't exist */
        break;

    case FB_FILE_MODE_INPUT:
        openmask = "rt";				/* will fail if file doesn't exist */
        break;

    case FB_FILE_MODE_OUTPUT:
        openmask = "wt";       			/* will create the file if it doesn't exist */
        break;

    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:

        switch( handle->access )
        {
        case FB_FILE_ACCESS_WRITE:
            openmask = "wb";
            break;
        case FB_FILE_ACCESS_READ:
            openmask = "rb";
            break;
        default:
            openmask = "r+b";  			/* w+ would erase the contents */
            break;
        }
    }

    if( openmask == NULL )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    switch (handle->mode)
    {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            /* if file was not found and in READ/WRITE (or ANY) mode,
             * create it */
            if( handle->access == FB_FILE_ACCESS_ANY
                || handle->access == FB_FILE_ACCESS_READWRITE )
            {
                fp = fopen( fname,  "w+b" );

                /* if file could not be created and in ANY mode, try opening as read-only */
                if( (fp == NULL) && (handle->access==FB_FILE_ACCESS_ANY) ) {
                    fp = fopen( fname,  "rb" );
                    if (fp != NULL) {
                        // don't forget to set the effective access mode ...
                        handle->access = FB_FILE_ACCESS_READ;
                    }
                }
            }

            if( fp == NULL )
            {
                FB_UNLOCK();
                return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
            }
        }
        break;

    default:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
    }

    /* change the default buffer size */
    setvbuf( fp, NULL, _IOFBF, FB_FILE_BUFSIZE );

    handle->opaque = fp;
    if (handle->access == FB_FILE_ACCESS_ANY)
        handle->access = FB_FILE_ACCESS_READWRITE;

    /* We just need this for TAB(n) and SPC(n) */
    if( strcasecmp( fname, "CON" )==0 )
        handle->type = FB_FILE_TYPE_CONSOLE;

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
