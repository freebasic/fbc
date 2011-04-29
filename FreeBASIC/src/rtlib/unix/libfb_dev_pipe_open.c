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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

static FB_FILE_HOOKS hooks_dev_pipe = {
    fb_DevFileEof,
    fb_DevPipeClose,
    NULL,
    NULL,
    fb_DevFileRead,
    fb_DevFileReadWstr,
    fb_DevFileWrite,
    fb_DevFileWriteWstr,
    NULL,
    NULL,
    fb_DevFileReadLine,
    fb_DevFileReadLineWstr
};

int fb_DevPipeOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    FILE *fp = NULL;
    char openmask[16];
    const char *fname;
    size_t str_len;

    FB_LOCK();

    fname = filename;
    str_len = filename_len;

    handle->hooks = &hooks_dev_pipe;

    openmask[0] = 0;

    switch( handle->mode )
    {
    case FB_FILE_MODE_INPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_READ;
        
        if( handle->access != FB_FILE_ACCESS_READ )
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

        strcpy( openmask, "r" );
        break;

    case FB_FILE_MODE_OUTPUT:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_WRITE;

        if( handle->access != FB_FILE_ACCESS_WRITE )
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        
        strcpy( openmask, "w" );
        break;

    case FB_FILE_MODE_BINARY:
        if ( handle->access == FB_FILE_ACCESS_ANY)
            handle->access = FB_FILE_ACCESS_WRITE;
        
		strcpy( openmask, (handle->access == FB_FILE_ACCESS_WRITE? "wb" : "rb") );

        break;
    
    default:
    	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( res == FB_RTERROR_OK ) 
    {
        /* try to open/create pipe */
        if( (fp = popen( fname, openmask )) == NULL )
        {
            res = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
        handle->opaque = fp;
        handle->type = FB_FILE_TYPE_PIPE;
    }

    FB_UNLOCK();

	return res;
}

