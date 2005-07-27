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
 *	file_lock - lock and unlock functions
 *
 * chng: nov/2004 written [v1ctor]
 *       jan/2005 os-dep calls moved to proper dirs [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_FileLockEx( FB_FILE *handle, unsigned int inipos, unsigned int endpos )
{
	int		res;

	if( inipos < 1 || endpos <= inipos )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

    /* convert to 0 based file i/o */
    --inipos;
    if( handle->mode == FB_FILE_MODE_RANDOM ) {
        inipos = handle->len * inipos;
        endpos = inipos + handle->len;
    } else {
        --endpos;
    }

    if( handle->hooks->pfnLock != NULL) {
        res = handle->hooks->pfnLock( handle, inipos-1, endpos - inipos );
    } else {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FileLock( int fnum, unsigned int inipos, unsigned int endpos )
{
    return fb_FileLockEx(FB_FILE_TO_HANDLE(fnum), inipos, endpos);
}

/*:::::*/
int fb_FileUnlockEx( FB_FILE *handle, unsigned int inipos, unsigned int endpos )
{
	int 	res;

	if( inipos < 1 || endpos <= inipos )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

    /* convert to 0 based file i/o */
    --inipos;
    if( handle->mode == FB_FILE_MODE_RANDOM ) {
        inipos = handle->len * inipos;
        endpos = inipos + handle->len;
    } else {
        --endpos;
    }

    if( handle->hooks != NULL ) {
        if (handle->hooks->pfnUnlock!=NULL) {
            res = handle->hooks->pfnUnlock( handle, inipos, endpos - inipos );
        } else {
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

    } else {
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FileUnlock( int fnum, unsigned int inipos, unsigned int endpos )
{
    if( !FB_FILE_INDEX_VALID(fnum) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    return fb_FileUnlockEx(FB_FILE_TO_HANDLE(fnum), inipos, endpos);
}

