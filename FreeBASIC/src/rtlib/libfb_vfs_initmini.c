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

#if 0
int fb_DevScrnOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len );
int fb_DevLptOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len );

/* This is required to avoid that the printer gets opened on application
 * start-up.
 */
static int fb_hDevLptClose( struct _FB_FILE *handle )
{
    int res = fb_DevLptOpen( handle, "LPT1:", 5 );
    if( res!=FB_RTERROR_OK )
        return res;
    return handle->hooks->pfnClose( handle );
}

static int fb_hDevLptWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    int res = fb_DevLptOpen( handle, "LPT1:", 5 );
    if( res!=FB_RTERROR_OK )
        return res;
    return handle->hooks->pfnWrite( handle, value, valuelen );
}

static const FB_FILE_HOOKS fb_hooks_dev_lpt_fake = {
    NULL,
    fb_hDevLptClose,
    NULL,
    NULL,
    NULL,
    fb_hDevLptWrite,
    NULL,
    NULL,
    NULL
};

static void close_printer_handle(void)
{
    if( FB_HANDLE_PRINTER->hooks==&fb_hooks_dev_lpt_fake )
        return;
    FB_HANDLE_PRINTER->hooks->pfnClose( FB_HANDLE_PRINTER );
}
#endif

void fb_VfsInitMini(void)
{
    FB_LOCK();

    if ( FB_HANDLE_SCREEN->hooks == NULL ) {
        memset(FB_HANDLE_SCREEN, 0, sizeof(*FB_HANDLE_SCREEN));

        FB_HANDLE_SCREEN->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnOpen( FB_HANDLE_SCREEN, "SCRN:", 5 );
    }

#if 0
    if ( FB_HANDLE_PRINTER->hooks == NULL ) {
        memset(FB_HANDLE_PRINTER, 0, sizeof(*FB_HANDLE_PRINTER));

        FB_HANDLE_PRINTER->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_PRINTER->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_PRINTER->access = FB_FILE_ACCESS_WRITE;

        FB_HANDLE_PRINTER->hooks = &fb_hooks_dev_lpt_fake;
    }

    atexit(close_printer_handle);
#endif

    FB_UNLOCK();
}
