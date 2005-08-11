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
 *	dev_file_eof - detects EOF for file device
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

void fb_DevScrnFillInput( DEV_SCRN_INFO *info )
{
    FBSTRING *str;
    size_t len;

    FB_STRLOCK();

    str = fb_Inkey( );
    len = FB_STRSIZE( str );
    DBG_ASSERT(len <= sizeof(info->buffer));
    memcpy(info->buffer, str->data, len);

    fb_hStrDelTemp( str );

    FB_STRUNLOCK();

    info->length = len;
}

/*:::::*/
int fb_DevScrnEof( struct _FB_FILE *handle )
{
    DEV_SCRN_INFO *info;
    int       got_data;

    FB_LOCK();
    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;
    got_data = info->length!=0;
    FB_UNLOCK();
    if( !got_data ) {
        FB_LOCK();
        fb_DevScrnFillInput( info );
        got_data = info->length!=0;
        FB_UNLOCK();
    }
	return !got_data;
}


