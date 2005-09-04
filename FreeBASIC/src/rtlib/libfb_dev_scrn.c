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
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_DevScrnInit_Screen( void );

static FB_FILE_HOOKS fb_hooks_dev_scrn = {
    fb_DevScrnEof,
    fb_DevScrnClose,
    NULL,
    NULL,
    fb_DevScrnRead,
    fb_DevScrnWrite,
    NULL,
    NULL,
    fb_DevScrnReadLine
};

int fb_DevScrnOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FB_LOCK();

    if (handle!=FB_HANDLE_SCREEN)
    {
        DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) FB_HANDLE_SCREEN->opaque;
        handle->hooks = &fb_hooks_dev_scrn;
        handle->opaque = info;
        handle->redirection_to = FB_HANDLE_SCREEN;

    }
    else if( handle->hooks != &fb_hooks_dev_scrn )
    {
    	if( handle->hooks == NULL )
    		fb_DevScrnInit_Screen( );
    	handle->hooks = &fb_hooks_dev_scrn;
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
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnOpen( FB_HANDLE_SCREEN, NULL, 0 );

        FB_UNLOCK();
    }
    else if( FB_HANDLE_SCREEN->hooks != &fb_hooks_dev_scrn )
    {
		FB_HANDLE_SCREEN->hooks = &fb_hooks_dev_scrn;
	}
}
