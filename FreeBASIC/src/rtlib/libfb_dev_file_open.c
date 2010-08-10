/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

int fb_hDevFileSeekStart
	(
		FILE *fp,
		int mode,
		FB_FILE_ENCOD encod,
		int seek_zero
	);

long fb_DevFileGetSize
	(
		FILE *fp,
		int mode,
		FB_FILE_ENCOD encod,
		int seek_back
	);

static FB_FILE_HOOKS hooks_dev_file = {
    fb_DevFileEof,
    fb_DevFileClose,
    fb_DevFileSeek,
    fb_DevFileTell,
    fb_DevFileRead,
    fb_DevFileReadWstr,
    fb_DevFileWrite,
    fb_DevFileWriteWstr,
    fb_DevFileLock,
    fb_DevFileUnlock,
    fb_DevFileReadLine,
    fb_DevFileReadLineWstr,
    NULL,
    fb_DevFileFlush
};


/*:::::*/
int fb_DevFileOpen
	(
		struct _FB_FILE *handle,
		const char *filename,
		size_t fname_len
	)
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

    handle->hooks = &hooks_dev_file;

    openmask = NULL;
    switch( handle->mode )
    {
    case FB_FILE_MODE_APPEND:
        /* will create the file if it doesn't exist */
        openmask = "ab";
        break;

    case FB_FILE_MODE_INPUT:
        /* will fail if file doesn't exist */
        openmask = "rt";
        break;

    case FB_FILE_MODE_OUTPUT:
        /* will create the file if it doesn't exist */
        openmask = "wb";
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
            /* w+ would erase the contents */
            openmask = "r+b";
            break;
        }
    }

    if( openmask == NULL )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    handle->size = -1;

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

    /* special case, fseek() is unreliable in text-mode, so the file size
       must be calculated in binary mode - bin mode can't be used for text
       input because newlines must be converted, and EOF char (27) handled */
    case FB_FILE_MODE_INPUT:
        /* try opening in binary mode */
        if( (fp = fopen( fname, "rb" )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        /* calc file size */
        handle->size = fb_DevFileGetSize( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );
        if( handle->size == -1 )
        {
        	fclose( fp );
            FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

        /* now reopen it in text-mode */
        if( (fp = freopen( fname, openmask, fp )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }

        /* skip BOM, if any */
        fb_hDevFileSeekStart( fp, FB_FILE_MODE_INPUT, handle->encod, FALSE );

        break;

    default:
        /* try opening */
        if( (fp = fopen( fname, openmask )) == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
    }

	if( handle->size == -1 )
	{
        /* calc file size */
        handle->size = fb_DevFileGetSize( fp, handle->mode, handle->encod, TRUE );
        if( handle->size == -1 )
        {
        	fclose( fp );
            FB_UNLOCK();
        	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
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
