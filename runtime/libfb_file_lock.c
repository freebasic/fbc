/* lock and unlock functions */

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
