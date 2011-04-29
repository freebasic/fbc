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
 *	file_lock - lock and unlock functions
 *
 * chng: nov/2004 written [v1ctor]
 *       jan/2005 os-dep calls moved to proper dirs [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_FileLockEx( FB_FILE *handle, fb_off_t inipos, fb_off_t endpos )
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
FBCALL int fb_FileLockLarge( int fnum, long long inipos, long long endpos )
{
    return fb_FileLockEx(FB_FILE_TO_HANDLE(fnum), inipos, endpos);
}

/*:::::*/
int fb_FileUnlockEx( FB_FILE *handle, fb_off_t inipos, fb_off_t endpos )
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

/*:::::*/
FBCALL int fb_FileUnlockLarge( int fnum, long long inipos, long long endpos )
{
    if( !FB_FILE_INDEX_VALID(fnum) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    return fb_FileUnlockEx(FB_FILE_TO_HANDLE(fnum), inipos, endpos);
}
