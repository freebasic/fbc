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
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_DevFileEof( struct _FB_FILE *handle )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return FB_TRUE;
	}

    switch( handle->mode )
    {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
        if( ftell( fp ) >= handle->size ) {
            FB_UNLOCK();
            return FB_TRUE;
        } else {
            FB_UNLOCK();
            return FB_FALSE;
        }
    }

    if( feof( fp ) ) {
        res = FB_TRUE;
    } else if( handle->mode==FB_FILE_MODE_INPUT ) {
        int has_size = handle->hooks->pfnTell!=NULL && handle->hooks->pfnSeek!=NULL;
        if( has_size && (ftell( fp ) >= handle->size) )  {
            res = FB_TRUE;
        } else {
            res = FB_FALSE;
        }
    } else {
        res = FB_FALSE;
    }
	FB_UNLOCK();

	return res;
}
