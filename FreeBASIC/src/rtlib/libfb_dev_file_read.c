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

/*:::::*/
int fb_DevFileRead( struct _FB_FILE *handle, void* value, size_t *pLength )
{
    FILE *fp;
    size_t rlen, length;
    char *pachData = (char*) value;

    FB_LOCK();

    DBG_ASSERT(pLength!=NULL);
    length = *pLength;

    fp = (FILE*) handle->opaque;
    if( fp==stdout || fp==stderr )
        fp = stdin;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* do read */
	rlen = fread( pachData, 1, length, fp );
	if( rlen != length )
    {
		/* fill with nulls if at eof */
        memset( pachData + rlen, 0, length - rlen );
    }

    *pLength = rlen;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
