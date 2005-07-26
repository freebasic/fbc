/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2005 Mark Junker (mjscod@gmx.de)
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
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

#ifndef TARGET_XBOX

#if defined(WIN32) || defined(__WIN32__)
#undef pclose
#define pclose(f) _pclose(f)
#endif

/*:::::*/
int fb_DevPipeClose( struct _FB_FILE *handle )
{
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp != NULL ) {
        pclose( fp );
    }

	handle->opaque = NULL;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

#else

int fb_DevPipeClose( struct _FB_FILE *handle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

#endif
