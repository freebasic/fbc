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
 * io_widthfile.c -- set the with for files
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <ctype.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_WidthFile( int fnum, int width )
{
    int cur = width;
    FB_FILE *handle;

    FB_LOCK();

    handle = FB_HANDLE_DEREF(FB_FILE_TO_HANDLE(fnum));

    if( handle==NULL ) {
        /* invalid file handle */
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle->hooks==NULL ) {
        /* not opened yet */
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle==FB_HANDLE_SCREEN ) {
        /* SCREEN device */
        if( width!=0 ) {
            fb_Width( width, 0 );
        }
        cur = FB_HANDLE_SCREEN->width;

    } else {
        if( width!=0 ) {
            handle->width = width;
            if( handle->hooks->pfnSetWidth!=NULL )
                handle->hooks->pfnSetWidth( handle, width );
        }
        cur = handle->width;
    }

	FB_UNLOCK();

    if( width==0 ) {
        return cur;
    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
