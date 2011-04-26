/*
 *	file_hlock - low-level lock and unlock functions for DOS
 *
 *  chng: jan/2005 written [DrV]
 *
 */


#include "fb.h"
#include <io.h>

/*:::::*/
int fb_hFileLock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	int res;
	res = _dos_lock(fileno(f), inipos, size );
	return fb_ErrorSetNum( res == 0? FB_RTERROR_OK: FB_RTERROR_FILEIO );
}

/*:::::*/
int fb_hFileUnlock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	int res;
	res = _dos_unlock(fileno(f), inipos, size);
	return fb_ErrorSetNum( res == 0? FB_RTERROR_OK: FB_RTERROR_FILEIO );
}






