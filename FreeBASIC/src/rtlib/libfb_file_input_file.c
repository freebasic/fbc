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
 * file_input - input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FileInput( int fnum )
{
    FB_FILE *handle = NULL;
    FBSTRING s;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );

	FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if( handle==NULL ) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( res == FB_RTERROR_OK ) {
        FB_TLSSET( fb_inpctx.handle, handle);
        FB_TLSSET( fb_inpctx.status, 0);

        s.data = (char *)FB_TLSGET( fb_inpctx.s.data );
        s.len  = (int)FB_TLSGET( fb_inpctx.s.len );
        s.size = (int)FB_TLSGET( fb_inpctx.s.size );
        fb_StrDelete( &s );

        FB_TLSSET( fb_inpctx.s.data, 0 );
        FB_TLSSET( fb_inpctx.s.len, 0 );
        FB_TLSSET( fb_inpctx.s.size, 0 );
    }

	FB_UNLOCK();

	return res;
}
