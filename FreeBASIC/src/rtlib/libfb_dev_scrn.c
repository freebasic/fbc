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
#include "fb.h"

void fb_DevScrnInit_Screen( void );

static FB_FILE_HOOKS hooks_dev_scrn = {
    fb_DevScrnEof,
    fb_DevScrnClose,
    NULL,
    NULL,
    fb_DevScrnRead,
    fb_DevScrnReadWstr,
    fb_DevScrnWrite,
    fb_DevScrnWriteWstr,
    NULL,
    NULL,
    fb_DevScrnReadLine,
    fb_DevScrnReadLineWstr
};

int fb_DevScrnOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FB_LOCK();

    if (handle!=FB_HANDLE_SCREEN)
    {
        DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) FB_HANDLE_SCREEN->opaque;
        handle->hooks = &hooks_dev_scrn;
        handle->opaque = info;
        handle->redirection_to = FB_HANDLE_SCREEN;

    }
    else if( handle->hooks != &hooks_dev_scrn )
    {
    	if( handle->hooks == NULL )
    		fb_DevScrnInit_Screen( );
    	handle->hooks = &hooks_dev_scrn;
        handle->type = FB_FILE_TYPE_CONSOLE;
    }

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

void fb_DevScrnInit( void )
{
    if ( FB_HANDLE_SCREEN->hooks == NULL )
    {
        FB_LOCK();

        memset(FB_HANDLE_SCREEN, 0, sizeof(*FB_HANDLE_SCREEN));

        FB_HANDLE_SCREEN->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_SCREEN->encod = FB_FILE_ENCOD_DEFAULT;
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnOpen( FB_HANDLE_SCREEN, NULL, 0 );

        FB_UNLOCK();
    }
    else if( FB_HANDLE_SCREEN->hooks != &hooks_dev_scrn )
    {
		FB_HANDLE_SCREEN->hooks = &hooks_dev_scrn;
	}
}
