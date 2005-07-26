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
 * file_tree - ???
 *
 * chng: ...
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FileFree ( void )
{
	int i;

	FB_LOCK();

    for( i = 1; i < (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) {
        FB_FILE *handle = FB_FILE_TO_HANDLE(i);
        if (handle->hooks==NULL && handle->f==NULL) {
			FB_UNLOCK();
			return i;
        }
    }

	FB_UNLOCK();

	return 0;
}
