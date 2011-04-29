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
 * file_close - CLOSE function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
int fb_FileCloseEx( FB_FILE *handle )
{
    FB_LOCK();

    if( !FB_HANDLE_USED(handle) ) {
    	FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* close VFS handle */
    DBG_ASSERT(handle->hooks->pfnClose != NULL);
    int result = handle->hooks->pfnClose( handle );
    if (result != 0) {
        FB_UNLOCK();
        return result;
    }

    /* clear structure */
    memset(handle, 0, sizeof(FB_FILE));

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileClose( int fnum )
{
	/* QB quirk: CLOSE w/o arguments closes all files */
	if( fnum == 0 ) {
		fb_FileReset( );
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}
    return fb_FileCloseEx( FB_FILE_TO_HANDLE(fnum) );
}

